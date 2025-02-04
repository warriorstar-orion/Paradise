from dataclasses import dataclass, field
from pathlib import Path
import io

from avulto import DME, Path as p

REAGENTS = {}

HIDDEN_FROM_CATALOG = {
    p("/datum/recipe/grill/human_kebab"),
}


@dataclass
class RecipeDetails:
    original_path: p
    product_type: p
    reagents: dict
    food_items: list
    produce_items: list
    added_items: list = field(default_factory=list)
    subcategory: str = ""
    byproduct: p = None
    product_name: str = ""


@dataclass
class ConvertedRecipe:
    recipe: RecipeDetails
    container: p
    cooker_step_name: str = ""
    hide_from_catalog: bool = False
    writer: io.TextIOWrapper | None = None
    cooker_temp: str = ""
    cooker_time: int = 0

    def codegen_text(self):
        result_lines = []
        result_lines.append(f"/datum/cooking/recipe/{self.recipe.original_path.stem}")
        result_lines.append(f"\tcooking_container = {self.container}")
        result_lines.append(f"\tproduct_type = {self.recipe.product_type}")
        result_lines.append("\tsteps = list(")

        for food_item in self.recipe.food_items:
            result_lines.append(f"\t\tPCWJ_ADD_ITEM({food_item}),")
        for produce_item in self.recipe.produce_items:
            result_lines.append(f"\t\tPCWJ_ADD_PRODUCE({produce_item}),")
        for name, amount in self.recipe.reagents.items():
            result_lines.append(f'\t\tPCWJ_ADD_REAGENT("{name}", {amount}),')

        if self.cooker_step_name:
            args = []
            if self.cooker_temp:
                args.append(self.cooker_temp)
            if self.cooker_time:
                args.append(f"{self.cooker_time} SECONDS")
            args_str = ", ".join(args)
            result_lines.append(f"\t\t{self.cooker_step_name}({args_str}),")
        result_lines.append("\t)")

        if self.hide_from_catalog:
            result_lines.append("\tappear_in_default_catalog = FALSE")

        return "\n".join(result_lines)


def process_crafting_recipes(dme: DME) -> list[RecipeDetails]:
    recipes = []
    for pth in dme.subtypesof("/datum/crafting_recipe"):
        td = dme.types[pth]
        recipe_category = td.var_decl("category").const_val
        if recipe_category != "Foods":
            continue

        subcategory = td.var_decl("subcategory").const_val

        items = td.var_decl("reqs").const_val
        result_list = td.var_decl("result").const_val
        results = [x for x in result_list.keys()]
        if len(results) > 1:
            raise RuntimeError(f"Ugh: {pth}")

        result = results[0]
        result_td = dme.types[result]
        result_name = result_td.var_decl("name").const_val

        added_items = list()
        added_foods = list()
        added_produce = list()
        reagents = dict()

        for item in items.keys():
            amount = items[item]
            if item.child_of("/obj/item/food/grown") or item.child_of(
                "/obj/item/grown"
            ):
                for _ in range(amount):
                    added_produce.append(item)
            elif item.child_of("/obj/item/food"):
                for _ in range(amount):
                    added_foods.append(item)
            elif item.child_of("/datum/reagent"):
                reagent_id = REAGENTS[item]
                reagents[reagent_id] = amount
            else:
                for _ in range(amount):
                    added_items.append(item)

        recipes.append(
            RecipeDetails(
                original_path=pth,
                product_type=result,
                reagents=reagents,
                food_items=added_foods,
                produce_items=added_produce,
                added_items=added_items,
                subcategory=subcategory,
                byproduct=None,
                product_name=result_name,
            )
        )

    return recipes


def process_recipes(dme: DME, base_type: str) -> list[RecipeDetails]:
    recipes = list()

    for pth in dme.subtypesof(base_type):
        td = dme.types[pth]
        items = td.var_decl("items").const_val
        food_items = list()
        produce_items = list()
        reagent_items = dict()
        if items:
            for item in items:
                if item.child_of("/obj/item/food/grown") or item.child_of(
                    "/obj/item/grown"
                ):
                    produce_items.append(item)
                else:
                    food_items.append(item)
        reagents = td.var_decl("reagents").const_val
        if reagents:
            for name in reagents.keys():
                reagent_items[name] = reagents[name]
        product_type = td.var_decl("result").const_val
        if not product_type:
            print(f"no product type for {pth}")
            continue
        byproduct = td.var_decl("byproduct").const_val
        recipe = RecipeDetails(
            original_path=pth,
            product_type=product_type,
            reagents=reagent_items,
            food_items=food_items,
            produce_items=produce_items,
            byproduct=byproduct,
        )
        recipes.append(recipe)

    return recipes


grill_writer = open(
    "code/modules/cooking/recipes/grill_recipes.dm", "w", encoding="utf-8"
)
board_writer = open(
    "code/modules/cooking/recipes/cutting_board_recipes.dm", "w", encoding="utf-8"
)
mixer_writer = open(
    "code/modules/cooking/recipes/ice_cream_mixer_recipes.dm", "w", encoding="utf-8"
)
bowl_writer = open(
    "code/modules/cooking/recipes/mixing_bowl_recipes.dm", "w", encoding="utf-8"
)
oven_writer = open(
    "code/modules/cooking/recipes/oven_recipes.dm", "w", encoding="utf-8"
)
sushi_mat_writer = open(
    "code/modules/cooking/recipes/sushi_mat_recipes.dm", "w", encoding="utf-8"
)
stove_writer = open(
    "code/modules/cooking/recipes/stove_recipes.dm", "w", encoding="utf-8"
)


def default_cooktime(recipe: RecipeDetails) -> int:
    return max(
        10, 10 * (int(0.5 * (len(recipe.food_items) + len(recipe.produce_items))))
    )


def convert_recipe_type(recipe: RecipeDetails) -> ConvertedRecipe | None:
    default_time = default_cooktime(recipe)
    default_temp = "J_MED"

    if recipe.original_path.child_of("/datum/recipe/grill"):
        return ConvertedRecipe(
            recipe,
            container=p("/obj/item/reagent_containers/cooking/grill_grate"),
            cooker_step_name="PCWJ_USE_GRILL",
            writer=grill_writer,
            cooker_temp=default_temp,
            cooker_time=default_time,
        )
    if recipe.original_path.child_of("/datum/recipe/oven"):
        return ConvertedRecipe(
            recipe,
            container=p("/obj/item/reagent_containers/cooking/oven"),
            cooker_step_name="PCWJ_USE_OVEN",
            writer=oven_writer,
            cooker_temp=default_temp,
            cooker_time=default_time,
        )

    if recipe.product_type.child_of("/obj/item/food/frozen"):
        return ConvertedRecipe(
            recipe,
            container=p("/obj/item/reagent_containers/cooking/icecream_bowl"),
            cooker_step_name="PCWJ_USE_ICE_CREAM_MIXER",
            writer=mixer_writer,
            cooker_time=default_time,
        )

    if recipe.product_type.child_of("/obj/item/food/burger"):
        for idx, item in enumerate(recipe.food_items):
            if item == p("/obj/item/food/meat") or item == p(
                "/obj/item/food/meat/syntiflesh"
            ):
                recipe.food_items[idx] = p("/obj/item/food/meat/patty")

        return ConvertedRecipe(
            recipe,
            container=p("/obj/item/reagent_containers/cooking/board"),
            writer=board_writer,
            cooker_temp=default_temp,
            cooker_time=default_time,
        )

    if recipe.product_type.child_of("/obj/item/food/salad"):
        return ConvertedRecipe(
            recipe,
            container=p("/obj/item/reagent_containers/cooking/bowl"),
            writer=bowl_writer,
        )

    if "sandwich" in recipe.product_name:
        return ConvertedRecipe(
            recipe,
            container=p("/obj/item/reagent_containers/cooking/board"),
            writer=board_writer,
        )

    if "sushi" in recipe.subcategory.lower() or "sushi" in recipe.product_name:
        return ConvertedRecipe(
            recipe,
            container=p("/obj/item/reagent_containers/cooking/sushimat"),
            writer=sushi_mat_writer,
        )

    if recipe.product_type.child_of("/obj/item/food/soup"):
        return ConvertedRecipe(
            recipe,
            container=p("/obj/item/reagent_containers/cooking/pot"),
            writer=stove_writer,
            cooker_time=20,
            cooker_temp="J_MED",
            cooker_step_name="PCWJ_USE_STOVE",
        )


dme = DME.from_file("paradise.dme", parse_procs=True)
all_foods = dme.subtypesof("/obj/item/food")
seen_foods = set()

for reagent in dme.subtypesof("/datum/reagent"):
    td = dme.types[reagent]
    REAGENTS[reagent] = td.var_decl("id").const_val

CONVERTED_RECIPES: list[RecipeDetails] = []

for subpath in (
    "/datum/recipe/grill",
    "/datum/recipe/oven",
    "/datum/recipe/microwave",
    "/datum/recipe/candy",
):
    CONVERTED_RECIPES += process_recipes(dme, subpath)

CONVERTED_RECIPES += process_crafting_recipes(dme)


def make_stovetop_pan(converted: ConvertedRecipe):
    converted.writer = stove_writer
    converted.container = p("/obj/item/reagent_containers/cooking/pan")
    converted.cooker_step_name = "PCWJ_USE_STOVE"
    converted.cooker_time = default_cooktime(converted.recipe)


RECIPE_COOKER_TRANSFORMS = {p("/datum/recipe/grill/friedegg"): make_stovetop_pan}

for recipe in CONVERTED_RECIPES:
    converted = convert_recipe_type(recipe)
    if not converted:
        continue

    if recipe.original_path in RECIPE_COOKER_TRANSFORMS:
        RECIPE_COOKER_TRANSFORMS[recipe.original_path](converted)

    if recipe.original_path in HIDDEN_FROM_CATALOG:
        converted.hide_from_catalog = True

    if converted.writer:
        converted.writer.write(converted.codegen_text())
        converted.writer.write("\n")
        converted.writer.write("\n")
        if recipe.product_type:
            seen_foods.add(recipe.product_type)

grill_writer.close()
board_writer.close()
mixer_writer.close()
bowl_writer.close()
oven_writer.close()
sushi_mat_writer.close()
stove_writer.close()

unseen_foods = set(all_foods) - seen_foods
print("unseen foods:")
for food in sorted(unseen_foods):
    print(f"- {food}")
