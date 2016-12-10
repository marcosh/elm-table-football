module Commands exposing (..)

import Player exposing (..)
import Team exposing (..)
import Tournament exposing (..)


type Command
    = CreatePlayer PlayerName
    | CreateTeam TeamName
    | AddPlayerToTeam PlayerId TeamId
    | CreateTournament TournamentName Rounds
