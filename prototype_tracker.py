from dataclasses import dataclass, field
from enum import Enum


class CookingContainer(Enum):
    UNKNOWN = 0
    GRILL = 1
    PAN = 2
    BOWL = 3
    AF_BASKET = 4
    OVEN = 5


class RecipeStepKind(Enum):
    PCWJ_START = 1
    PCWJ_ADD_ITEM = 2
    PCWJ_ADD_REAGENT = 3
    PCWJ_USE_ITEM = 4
    PCWJ_USE_TOOL = 5
    PCWJ_ADD_PRODUCE = 6
    PCWJ_USE_STOVE = 7
    PCWJ_USE_GRILL = 8
    PCWJ_USE_OVEN = 9
    PCWJ_USE_OTHER = 10

    PCWJ_ADD_ITEM_OPTIONAL = 200
    PCWJ_ADD_REAGENT_OPTIONAL = 300
    PCWJ_USE_ITEM_OPTIONAL = 400
    PCWJ_USE_TOOL_OPTIONAL = 500
    PCWJ_ADD_PRODUCE_OPTIONAL = 600
    PCWJ_USE_STOVE_OPTIONAL = 700
    PCWJ_USE_GRILL_OPTIONAL = 800
    PCWJ_USE_OVEN_OPTIONAL = 900
    PCWJ_OTHER_OPTIONAL = 1000

    PCWJ_BEGIN_EXCLUSIVE_OPTIONS = 10000
    PCWJ_END_EXCLUSIVE_OPTIONS = 20000
    PCWJ_BEGIN_OPTION_CHAIN = 30000
    PCWJ_END_OPTION_CHAIN = 40000


@dataclass
class RecipeStep:
    kind: RecipeStepKind
    target: str
    options: field(default_factory=dict)


@dataclass
class Recipe:
    name: str
    container: CookingContainer
    steps: list[RecipeStep]
    product_type: str


class RecipeTracker:
    pass
