from dataclasses import dataclass, field
from pathlib import Path

from avulto import DMM, DME, DMI, Path as p

PARADISE_ROOT = Path("D:/ExternalRepos/third_party/Paradise/")


@dataclass
class RecipeDetails:
    original_path: p
    product_type: p
    reagents: dict
    food_items: list
    produce_items: list
    added_items: list = field(default_factory=list)


REAGENTS = {}


def codegen_python_prototype(recipe: RecipeDetails, cooking_container: str) -> str:
    result_lines = []
    recipe_name = recipe.original_path.stem.upper()

    steps = []
    for food_item in recipe.food_items:
        steps.append(
            f"RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target='{food_item}')"
        )
    step_string = "[" + "\n,".join(steps) + "]"

    result_lines.append(
        f"Recipe(name='{recipe_name}', container={cooking_container}, steps={step_string})"
    )

    return "".join(result_lines)


def codegen_grill_recipe(recipe: RecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{recipe.original_path.stem}")
    result_lines.append(
        f"\tcooking_container = /obj/item/reagent_containers/cooking/grill_grate"
    )
    result_lines.append(f"\tproduct_type = {recipe.product_type}")
    result_lines.append(f"\tsteps = list(")
    for food_item in recipe.food_items:
        result_lines.append(f"\t\tCWJ_ADD_ITEM({food_item}),")
    for produce_item in recipe.produce_items:
        result_lines.append(f"\t\tCWJ_ADD_PRODUCE({produce_item}),")
    for name, amount in recipe.reagents.items():
        result_lines.append(f'\t\tCWJ_ADD_REAGENT("{name}", {amount}),')
    result_lines.append(
        f"\t\tCWJ_USE_GRILL(J_MED, {max(10, 10 * (int(0.5 * (len(recipe.food_items) + len(recipe.produce_items)))))} SECONDS),"
    )
    result_lines.append(f"\t)")
    return "\n".join(result_lines)


def codegen_oven_recipe(recipe: RecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{recipe.original_path.stem}")
    result_lines.append(
        f"\tcooking_container = /obj/item/reagent_containers/cooking/oven"
    )
    result_lines.append(f"\tproduct_type = {recipe.product_type}")
    result_lines.append(f"\tsteps = list(")
    for food_item in recipe.food_items:
        result_lines.append(f"\t\tCWJ_ADD_ITEM({food_item}),")
    for produce_item in recipe.produce_items:
        result_lines.append(f"\t\tCWJ_ADD_PRODUCE({produce_item}),")
    for name, amount in recipe.reagents.items():
        result_lines.append(f'\t\tCWJ_ADD_REAGENT("{name}", {amount}),')
    result_lines.append(
        f"\t\tCWJ_USE_OVEN(J_MED, {max(10, 10 * (int(0.5 * (len(recipe.food_items) + len(recipe.produce_items)))))} SECONDS),"
    )
    result_lines.append(f"\t)")
    return "\n".join(result_lines)


def codegen_crafting_recipe(recipe: RecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{recipe.original_path.stem}")
    result_lines.append(
        f"\tcooking_container = /obj/item/reagent_containers/cooking/board"
    )
    result_lines.append(f"\tproduct_type = {recipe.product_type}")
    result_lines.append(f"\tsteps = list(")
    for food_item in recipe.food_items:
        result_lines.append(f"\t\tCWJ_ADD_ITEM({food_item}),")
    for food_item in recipe.added_items:
        result_lines.append(f"\t\tCWJ_ADD_ITEM({food_item}),")
    for produce_item in recipe.produce_items:
        result_lines.append(f"\t\tCWJ_ADD_PRODUCE({produce_item}),")
    for name, amount in recipe.reagents.items():
        result_lines.append(f'\t\tCWJ_ADD_REAGENT("{name}", {amount}),')
    result_lines.append(f"\t)")

    return "\n".join(result_lines)


def process_crafting_recipes(dme: DME) -> list[RecipeDetails]:
    recipes = list()
    for pth in dme.subtypesof("/datum/crafting_recipe"):
        td = dme.types[pth]
        recipe_category = td.var_decl("category").const_val
        if recipe_category != "Foods":
            continue

        items = td.var_decl("reqs").const_val
        result_list = td.var_decl("result").const_val
        results = [x for x in result_list.keys()]
        if len(results) > 1:
            raise RuntimeError(f"Ugh: {pth}")

        result = results[0]

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
            raise RuntimeError(f"no product type for {pth}")
        recipe = RecipeDetails(
            original_path=pth,
            product_type=product_type,
            reagents=reagent_items,
            food_items=food_items,
            produce_items=produce_items,
        )
        recipes.append(recipe)

    return recipes


dme = DME.from_file(PARADISE_ROOT / "paradise.dme", parse_procs=True)

for reagent in dme.subtypesof("/datum/reagent"):
    td = dme.types[reagent]
    REAGENTS[reagent] = td.var_decl("id").const_val


grill_recipes = process_recipes(dme, "/datum/recipe/grill")
oven_recipes = process_recipes(dme, "/datum/recipe/oven")
crafting_recipes = process_crafting_recipes(dme)


with open("code/modules/cooking/recipes/stable/cooking_grill_recipes.dm", "w") as f:
    for recipe in grill_recipes:
        f.write("\n")
        f.write(codegen_grill_recipe(recipe))
        f.write("\n")

with open("code/modules/cooking/recipes/stable/cooking_oven_recipes.dm", "w") as f:
    for recipe in oven_recipes:
        f.write("\n")
        f.write(codegen_oven_recipe(recipe))
        f.write("\n")

with open("code/modules/cooking/recipes/stable/cutting_board_recipes.dm", "w") as f:
    for recipe in crafting_recipes:
        f.write("\n")
        f.write(codegen_crafting_recipe(recipe))
        f.write("\n")

# with open("prototype_recipes.py", "w") as f:
#     f.write("from prototype_tracker import *\n")
#     f.write("ALL_RECIPES = [")
#     for recipe in grill_recipes:
#         f.write(
#             "\n\t" + codegen_python_prototype(recipe, "CookingContainer.GRILL") + ","
#         )
#     for recipe in grill_recipes:
#         f.write(
#             "\n\t" + codegen_python_prototype(recipe, "CookingContainer.OVEN") + ","
#         )

#     f.write("]")
