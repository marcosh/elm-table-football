module Commands exposing (..)

import Player exposing (..)
import Team exposing (..)
import Tournament exposing (..)


type Command
    = CreatePlayer PlayerName
    | CreateTeam TeamName
    | CreateTournament TournamentName Rounds
    | AddPlayerToTeam Player Team
    | AddTeamToTournament Team Tournament
