module AllDictExtra exposing (..)

import AllDict exposing (..)


resultUpdate : k -> (Maybe v -> Result e (Maybe v)) -> AllDict k v comparable -> Result e (AllDict k v comparable)
resultUpdate k alter dict =
    let
        maybeValue =
            get k dict

        resultMaybeValue =
            alter maybeValue
    in
        case resultMaybeValue of
            Err error ->
                Err error

            Ok maybeValue ->
                Ok (update k (\v -> maybeValue) dict)
