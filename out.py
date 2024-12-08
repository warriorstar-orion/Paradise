# coding: utf-8
from avulto import DMM, DME, DMI, Path as p
dme = DME.from_file("C:/ExternalRepos/third_party/Paradise/paradise.dme", parse_procs=True)
from dataclasses import dataclass
@dataclass
class GrillRecipeDetails:
    final_path: p
    name: str
    product_type: p
    reagents: dict
    food_items: list
    produce_items: list
    
grill_recipes = list()
@dataclass
class GrillRecipeDetails:
    name: str
    product_type: p
    reagents: dict
    food_items: list
    produce_items: list
    
for pth in dme.subtypesof("/datum/recipe/grill"):
    td = dme.types[pth]
    items = td.val_decl("items").const_val
    food_items = list()
    produce_items = list()
    for item in items:
        if item.child_of('/obj/item/food/grown'):
            produce_items.add(item)
        elif item.child_of('/obj/item/food'):
            food_items.add(item)
    name = td.val_decl("name").const_val
    grill_recipe = GrillRecipeDetails(name=name, product_type=p("/"), reagents=dict(), food_items=food_items, produce_items=produce_items)
    grill_recipes.append(grill_recipe)
    
for pth in dme.subtypesof("/datum/recipe/grill"):
    td = dme.types[pth]
    items = td.var_decl("items").const_val
    food_items = list()
    produce_items = list()
    for item in items:
        if item.child_of('/obj/item/food/grown'):
            produce_items.add(item)
        elif item.child_of('/obj/item/food'):
            food_items.add(item)
    name = td.var_decl("name").const_val
    grill_recipe = GrillRecipeDetails(name=name, product_type=p("/"), reagents=dict(), food_items=food_items, produce_items=produce_items)
    grill_recipes.append(grill_recipe)
    
grill_recipes = list()

for pth in dme.subtypesof("/datum/recipe/grill"):
    td = dme.types[pth]
    items = td.var_decl("items").const_val
    food_items = list()
    produce_items = list()
    for item in items:
        if item.child_of('/obj/item/food/grown'):
            produce_items.append(item)
        elif item.child_of('/obj/item/food'):
            food_items.append(item)
    name = td.var_decl("name").const_val
    grill_recipe = GrillRecipeDetails(name=name, product_type=p("/"), reagents=dict(), food_items=food_items, produce_items=produce_items)
    grill_recipes.append(grill_recipe)
    
@dataclass
class GrillRecipeDetails:
    original_path: p
    product_type: p
    reagents: dict
    food_items: list
    produce_items: list
    
grill_recipes = list()

for pth in dme.subtypesof("/datum/recipe/grill"):
    td = dme.types[pth]
    items = td.var_decl("items").const_val
    food_items = list()
    produce_items = list()
    for item in items:
        if item.child_of('/obj/item/food/grown'):
            produce_items.append(item)
        elif item.child_of('/obj/item/food'):
            food_items.append(item)
    grill_recipe = GrillRecipeDetails(original_path=pth, product_type=td.var_decl("result").const_val, reagents=dict(), food_items=food_items, produce_items=produce_items)
    grill_recipes.append(grill_recipe)
    
grill_recipes
grill_recipes = list()

for pth in dme.subtypesof("/datum/recipe/grill"):
    td = dme.types[pth]
    items = td.var_decl("items").const_val
    food_items = list()
    produce_items = list()
    for item in items:
        if item.child_of('/obj/item/food/grown'):
            produce_items.append(item)
        else:
            food_items.append(item)
    grill_recipe = GrillRecipeDetails(original_path=pth, product_type=td.var_decl("result").const_val, reagents=dict(), food_items=food_items, produce_items=produce_items)
    grill_recipes.append(grill_recipe)
    
def to_dm(grill_recipe: GrillRecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{grill_recipe.original_path.stem")
def to_dm(grill_recipe: GrillRecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{grill_recipe.original_path.stem}")
    result_lines.append(f"\tcooking_container = GRILL")
    result_lines.append(f"\tproduct_type = {grill_recipe.product_type}")
    result_lines.append(f"\tstep_builder = list(")
    for food_item in grill_recipe.food_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_ITEM, {food_item}),")
    for produce_item in grill_recipe.produce_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_PRODUCE, {produce_item}),")
    result_lines.append(f"\t\tlist(CWJ_USE_GRILL, J_MED, {int(0.5 * (len(grill_recipe.food_items) + len(grill_recipe.produce_items)))} SECONDS)")
    result_lines.append(f"\t)")
    
def to_dm(grill_recipe: GrillRecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{grill_recipe.original_path.stem}")
    result_lines.append(f"\tcooking_container = GRILL")
    result_lines.append(f"\tproduct_type = {grill_recipe.product_type}")
    result_lines.append(f"\tstep_builder = list(")
    for food_item in grill_recipe.food_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_ITEM, {food_item}),")
    for produce_item in grill_recipe.produce_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_PRODUCE, {produce_item}),")
    result_lines.append(f"\t\tlist(CWJ_USE_GRILL, J_MED, {int(0.5 * (len(grill_recipe.food_items) + len(grill_recipe.produce_items)))} SECONDS)")
    result_lines.append(f"\t)")
    
def to_dm(grill_recipe: GrillRecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{grill_recipe.original_path.stem}")
    result_lines.append(f"\tcooking_container = GRILL")
    result_lines.append(f"\tproduct_type = {grill_recipe.product_type}")
    result_lines.append(f"\tstep_builder = list(")
    for food_item in grill_recipe.food_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_ITEM, {food_item}),")
    for produce_item in grill_recipe.produce_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_PRODUCE, {produce_item}),")
    result_lines.append(f"\t\tlist(CWJ_USE_GRILL, J_MED, {int(0.5 * (len(grill_recipe.food_items) + len(grill_recipe.produce_items)))} SECONDS)")
    result_lines.append(f"\t)")
    return "\n".join(result_lines)
    
to_dm(grill_recipes[0])
print(to_dm(grill_recipes[0]))
def to_dm(grill_recipe: GrillRecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{grill_recipe.original_path.stem}")
    result_lines.append(f"\tcooking_container = GRILL")
    result_lines.append(f"\tproduct_type = {grill_recipe.product_type}")
    result_lines.append(f"\tstep_builder = list(")
    for food_item in grill_recipe.food_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_ITEM, {food_item}),")
    for produce_item in grill_recipe.produce_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_PRODUCE, {produce_item}),")
    result_lines.append(f"\t\tlist(CWJ_USE_GRILL, J_MED, {max(10, (int(0.5 * (len(grill_recipe.food_items) + len(grill_recipe.produce_items))))} SECONDS)")
    result_lines.append(f"\t)")
    return "\n".join(result_lines)
def to_dm(grill_recipe: GrillRecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{grill_recipe.original_path.stem}")
    result_lines.append(f"\tcooking_container = GRILL")
    result_lines.append(f"\tproduct_type = {grill_recipe.product_type}")
    result_lines.append(f"\tstep_builder = list(")
    for food_item in grill_recipe.food_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_ITEM, {food_item}),")
    for produce_item in grill_recipe.produce_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_PRODUCE, {produce_item}),")
    result_lines.append(f"\t\tlist(CWJ_USE_GRILL, J_MED, {max(10, (int(0.5 * (len(grill_recipe.food_items) + len(grill_recipe.produce_items)))))} SECONDS)")
    result_lines.append(f"\t)")
    return "\n".join(result_lines)
    
print(to_dm(grill_recipes[0]))
with open('cooking_grill_recipes.dm', 'w') as f:
    for grill_recipe in grill_recipes:
        f.write("\n")
        f.write(to_dm(grill_recipe))
        f.write("\n")
def to_dm(grill_recipe: GrillRecipeDetails) -> str:
    result_lines = []
    result_lines.append(f"/datum/cooking/recipe/{grill_recipe.original_path.stem}")
    result_lines.append(f"\tcooking_container = GRILL")
    result_lines.append(f"\tproduct_type = {grill_recipe.product_type}")
    result_lines.append(f"\tstep_builder = list(")
    for food_item in grill_recipe.food_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_ITEM, {food_item}),")
    for produce_item in grill_recipe.produce_items:
        result_lines.append(f"\t\tlist(CWJ_ADD_PRODUCE, {produce_item}),")
    result_lines.append(f"\t\tlist(CWJ_USE_GRILL, J_MED, {max(10, 10 * (int(0.5 * (len(grill_recipe.food_items) + len(grill_recipe.produce_items)))))} SECONDS)")
    result_lines.append(f"\t)")
    return "\n".join(result_lines)
    
with open('cooking_grill_recipes.dm', 'w') as f:
    for grill_recipe in grill_recipes:
        f.write("\n")
        f.write(to_dm(grill_recipe))
        f.write("\n")
        
get_ipython().run_line_magic('save', '')
