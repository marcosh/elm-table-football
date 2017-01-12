module Model exposing (Model)

import WriteModel as Write exposing (Model)
import ReadModel as Read exposing (Model)


type alias Model =
    { writeModel : Write.Model
    , readModel : Read.Model
    }
