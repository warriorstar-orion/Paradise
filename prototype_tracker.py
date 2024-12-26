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
    CWJ_START = 1
    CWJ_ADD_ITEM = 2
    CWJ_ADD_REAGENT = 3
    CWJ_USE_ITEM = 4
    CWJ_USE_TOOL = 5
    CWJ_ADD_PRODUCE = 6
    CWJ_USE_STOVE = 7
    CWJ_USE_GRILL = 8
    CWJ_USE_OVEN = 9
    CWJ_USE_OTHER = 10

    CWJ_ADD_ITEM_OPTIONAL = 200
    CWJ_ADD_REAGENT_OPTIONAL = 300
    CWJ_USE_ITEM_OPTIONAL = 400
    CWJ_USE_TOOL_OPTIONAL = 500
    CWJ_ADD_PRODUCE_OPTIONAL = 600
    CWJ_USE_STOVE_OPTIONAL = 700
    CWJ_USE_GRILL_OPTIONAL = 800
    CWJ_USE_OVEN_OPTIONAL = 900
    CWJ_OTHER_OPTIONAL = 1000

    CWJ_BEGIN_EXCLUSIVE_OPTIONS = 10000
    CWJ_END_EXCLUSIVE_OPTIONS = 20000
    CWJ_BEGIN_OPTION_CHAIN = 30000
    CWJ_END_OPTION_CHAIN = 40000


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
