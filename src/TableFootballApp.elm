module TableFootballApp exposing (..)

import Tournament exposing (..)
import Player exposing (..)
import Commands exposing (Command(..))
import Events exposing (Event(..))
import Uuid exposing (uuidGenerator)
import Random.Pcg exposing (generate)


type alias Model =
    { players : List Player
    , tournament : Maybe Tournament
    }


handleCommand : Command -> Model -> Cmd Event
handleCommand command model =
    case command of
        CreatePlayer playerName ->
            generate (PlayerWasCreated playerName) uuidGenerator

        CreateTeam teamName ->
            Cmd.none

        CreateTournament tournamentname rounds ->
            Cmd.none

        AddPlayerToTeam player team ->
            Cmd.none

        AddTeamToTournament team tournament ->
            Cmd.none


handleEvent : Event -> Model -> Model
handleEvent event model =
    case event of
        TeamWasCreated teamName ->
            model

        PlayerWasCreated playerName playerId ->
            { model | players = (Player playerId playerName) :: model.players }

        PlayerWasAddedToTeam player team ->
            model

        TournamentWasCreated tournamentName rounds ->
            model

        TeamWasAddedToTournament team tournament ->
            model

        GameStarted team1 team2 ->
            model

        GoalScored player ->
            model

        GameFinished ->
            model
