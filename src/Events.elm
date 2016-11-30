module Events exposing (..)

import Team exposing (..)
import Player exposing (..)
import Tournament exposing (..)


type Event
    = TeamWasCreated TeamName
    | PlayerWasCreated PlayerName
    | PlayerWasAddedToTeam Player Team
    | TournamentWasCreated TournamentName Rounds
    | TeamWasAddedToTournament Team Tournament
    | GameStarted Team Team
    | GoalScored Player
    | GameFinished
