module TeamCommandHandlers exposing (..)

import Team exposing (Team, id, hasBothPlayers, containsPlayer)
import Player exposing (PlayerId)
import CommandError exposing (CommandError)
import Events exposing (Event(..))
import Task exposing (perform, succeed)


addPlayer : Team -> PlayerId -> Result CommandError (Cmd Event)
addPlayer team playerId =
    if hasBothPlayers team then
        Err "The team has already two players"
    else if containsPlayer team playerId then
        Err "The player is already in the team"
    else
        Ok (perform (\a -> a) (succeed (PlayerWasAddedToTeam playerId (id team))))
