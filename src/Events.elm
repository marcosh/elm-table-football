module Events exposing (..)

import Team exposing (..)
import Player exposing (..)
import Tournament exposing (..)


type Event
    = TeamWasCreated TeamName TeamId
    | PlayerWasCreated PlayerName PlayerId
    | PlayerWasAddedToTeam PlayerId TeamId
    | TournamentWasCreated TournamentName Rounds
    | GameStarted Team Team
    | GoalScored Player
    | GameFinished
