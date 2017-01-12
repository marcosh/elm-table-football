module Model exposing (Model, init, readModel, writeModel)

import WriteModel as Write exposing (Model, init)
import ReadModel as Read exposing (Model, init)


type alias Model =
    { writeModel : Write.Model
    , readModel : Read.Model
    }


init : Model
init =
    Model Write.init Read.init


readModel : Model -> Read.Model
readModel model =
    model.readModel


writeModel : Model -> Write.Model
writeModel model =
    model.writeModel
