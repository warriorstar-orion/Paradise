from prototype_tracker import *

ALL_RECIPES = [
    Recipe(
        name="BACON",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/raw_bacon"
            )
        ],
    ),
    Recipe(
        name="BBQRIBS",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
        ],
    ),
    Recipe(
        name="BERRY_PANCAKE",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cookiedough"
            )
        ],
    ),
    Recipe(
        name="BIRDSTEAK",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat/chicken"
            )
        ],
    ),
    Recipe(
        name="CHOC_CHIP_PANCAKE",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cookiedough"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/choc_pile"
            ),
        ],
    ),
    Recipe(
        name="CUTLET",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/rawcutlet"
            )
        ],
    ),
    Recipe(
        name="FISH_SKEWER",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonmeat"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonmeat"
            ),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
        ],
    ),
    Recipe(
        name="FISHFINGERS",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/carpmeat"
            ),
        ],
    ),
    Recipe(
        name="FRIEDEGG",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg")
        ],
    ),
    Recipe(
        name="GOLIATH",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/monstermeat/goliath",
            )
        ],
    ),
    Recipe(
        name="GRILLEDCHEESE",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/breadslice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/breadslice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cheesewedge"
            ),
        ],
    ),
    Recipe(
        name="HUMAN_KEBAB",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat/human"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat/human"
            ),
        ],
    ),
    Recipe(
        name="MEATKEB",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
        ],
    ),
    Recipe(
        name="MEATSTEAK",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat")
        ],
    ),
    Recipe(
        name="OMELETTE",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cheesewedge"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cheesewedge"
            ),
        ],
    ),
    Recipe(
        name="PANCAKE",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cookiedough"
            )
        ],
    ),
    Recipe(
        name="PICOSS_KEBAB",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/carpmeat"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/carpmeat"
            ),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
        ],
    ),
    Recipe(
        name="ROFFLEWAFFLES",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/dough"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/dough"),
        ],
    ),
    Recipe(
        name="SALMONSTEAK",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonmeat"
            )
        ],
    ),
    Recipe(
        name="SAUSAGE",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meatball"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cutlet"
            ),
        ],
    ),
    Recipe(
        name="SHRIMP_SKEWER",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/shrimp"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/shrimp"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/shrimp"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/shrimp"
            ),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
        ],
    ),
    Recipe(
        name="SUSHI_EBI",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiled_shrimp"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_IKURA",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/fish_eggs/salmon"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_INARI",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/fried_tofu"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_MASAGO",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/fish_eggs/goldfish"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_SAKE",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonmeat"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_SMOKED_SALMON",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonsteak"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_TAI",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/catfishmeat"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_TAMAGO",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_TOBIKO",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/fish_eggs/shark"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_TOBIKO_EGG",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/sushi_tobiko"
            ),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_UNAGI",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/fish/electric_eel"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SYNTIKEBAB",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/meat/syntiflesh",
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/meat/syntiflesh",
            ),
        ],
    ),
    Recipe(
        name="SYNTISTEAK",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/meat/syntiflesh",
            )
        ],
    ),
    Recipe(
        name="SYNTITELEBACON",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/meat/syntiflesh",
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/assembly/signaler"
            ),
        ],
    ),
    Recipe(
        name="TELEBACON",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/assembly/signaler"
            ),
        ],
    ),
    Recipe(
        name="TOFUKEBAB",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/tofu"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/tofu"),
        ],
    ),
    Recipe(
        name="WAFFLES",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/dough"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/dough"),
        ],
    ),
    Recipe(
        name="WINGFANGCHU",
        container=CookingContainer.GRILL,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/monstermeat/xenomeat",
            )
        ],
    ),
    Recipe(
        name="BACON",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/raw_bacon"
            )
        ],
    ),
    Recipe(
        name="BBQRIBS",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
        ],
    ),
    Recipe(
        name="BERRY_PANCAKE",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cookiedough"
            )
        ],
    ),
    Recipe(
        name="BIRDSTEAK",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat/chicken"
            )
        ],
    ),
    Recipe(
        name="CHOC_CHIP_PANCAKE",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cookiedough"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/choc_pile"
            ),
        ],
    ),
    Recipe(
        name="CUTLET",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/rawcutlet"
            )
        ],
    ),
    Recipe(
        name="FISH_SKEWER",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonmeat"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonmeat"
            ),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
        ],
    ),
    Recipe(
        name="FISHFINGERS",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/carpmeat"
            ),
        ],
    ),
    Recipe(
        name="FRIEDEGG",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg")
        ],
    ),
    Recipe(
        name="GOLIATH",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/monstermeat/goliath",
            )
        ],
    ),
    Recipe(
        name="GRILLEDCHEESE",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/breadslice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/breadslice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cheesewedge"
            ),
        ],
    ),
    Recipe(
        name="HUMAN_KEBAB",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat/human"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat/human"
            ),
        ],
    ),
    Recipe(
        name="MEATKEB",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
        ],
    ),
    Recipe(
        name="MEATSTEAK",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat")
        ],
    ),
    Recipe(
        name="OMELETTE",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cheesewedge"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cheesewedge"
            ),
        ],
    ),
    Recipe(
        name="PANCAKE",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cookiedough"
            )
        ],
    ),
    Recipe(
        name="PICOSS_KEBAB",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/carpmeat"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/carpmeat"
            ),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
        ],
    ),
    Recipe(
        name="ROFFLEWAFFLES",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/dough"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/dough"),
        ],
    ),
    Recipe(
        name="SALMONSTEAK",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonmeat"
            )
        ],
    ),
    Recipe(
        name="SAUSAGE",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meatball"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/cutlet"
            ),
        ],
    ),
    Recipe(
        name="SHRIMP_SKEWER",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/shrimp"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/shrimp"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/shrimp"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/shrimp"
            ),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
        ],
    ),
    Recipe(
        name="SUSHI_EBI",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiled_shrimp"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_IKURA",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/fish_eggs/salmon"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_INARI",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/fried_tofu"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_MASAGO",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/fish_eggs/goldfish"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_SAKE",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonmeat"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_SMOKED_SALMON",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/salmonsteak"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_TAI",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/catfishmeat"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_TAMAGO",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_TOBIKO",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/fish_eggs/shark"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_TOBIKO_EGG",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/sushi_tobiko"
            ),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/egg"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SUSHI_UNAGI",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/fish/electric_eel"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/boiledrice"
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/seaweed"
            ),
        ],
    ),
    Recipe(
        name="SYNTIKEBAB",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/meat/syntiflesh",
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/meat/syntiflesh",
            ),
        ],
    ),
    Recipe(
        name="SYNTISTEAK",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/meat/syntiflesh",
            )
        ],
    ),
    Recipe(
        name="SYNTITELEBACON",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/meat/syntiflesh",
            ),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/assembly/signaler"
            ),
        ],
    ),
    Recipe(
        name="TELEBACON",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/meat"),
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/assembly/signaler"
            ),
        ],
    ),
    Recipe(
        name="TOFUKEBAB",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/stack/rods"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/tofu"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/tofu"),
        ],
    ),
    Recipe(
        name="WAFFLES",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/dough"),
            RecipeStep(kind=RecipeStepKind.CWJ_ADD_ITEM, target="/obj/item/food/dough"),
        ],
    ),
    Recipe(
        name="WINGFANGCHU",
        container=CookingContainer.OVEN,
        steps=[
            RecipeStep(
                kind=RecipeStepKind.CWJ_ADD_ITEM,
                target="/obj/item/food/monstermeat/xenomeat",
            )
        ],
    ),
]
