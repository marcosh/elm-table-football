module TableFootballApp exposing (CommandError, handleCommand, handleEvent, project)

import WriteModel as Write exposing (Model)
import ReadModel as Read exposing (Model)
import Player as Write exposing (Player)
import Team as Write exposing (Team, createTeam)
import ReadPlayer as Read exposing (Player, newPlayer)
import ReadTeam as Read exposing (Team, newTeam)
import Commands exposing (Command(..))
import Events exposing (Event(..))
import Uuid exposing (uuidGenerator)
import Random.Pcg exposing (generate)


type alias CommandError =
    String


handleCommand : Command -> Write.Model -> Result CommandError (Cmd Event)
handleCommand command model =
    case command of
        CreatePlayer playerName ->
            Ok (generate (PlayerWasCreated playerName) uuidGenerator)

        CreateTeam teamName ->
            Ok (generate (TeamWasCreated teamName) uuidGenerator)

        AddPlayerToTeam player team ->
            Ok Cmd.none

        CreateTournament tournamentname rounds ->
            Ok Cmd.none


handleEvent : Event -> Write.Model -> Write.Model
handleEvent event model =
    case event of
        TeamWasCreated teamName teamId ->
            { model | teams = (createTeam teamId teamName) :: model.teams }

        PlayerWasCreated playerName playerId ->
            { model | players = (Write.Player playerId playerName) :: model.players }

        PlayerWasAddedToTeam player team ->
            model

        TournamentWasCreated tournamentName rounds ->
            model

        GameStarted team1 team2 ->
            model

        GoalScored player ->
            model

        GameFinished ->
            model


project : Event -> Read.Model -> Read.Model
project event model =
    case event of
        TeamWasCreated teamName teamId ->
            { model | teams = (newTeam teamId teamName) :: model.teams }

        PlayerWasCreated playerName playerId ->
            { model | players = (newPlayer playerId playerName) :: model.players }

        PlayerWasAddedToTeam player team ->
            model

        TournamentWasCreated tournamentName rounds ->
            model

        GameStarted team1 team2 ->
            model

        GoalScored player ->
            model

        GameFinished ->
            model
