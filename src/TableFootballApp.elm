module TableFootballApp exposing (handleCommand, handleEvent, project)

import WriteModel as Write exposing (Model)
import ReadModel as Read exposing (Model)
import Player as Write exposing (Player)
import Team as Write exposing (Team)
import ReadPlayer as Read exposing (Player, newPlayer)
import ReadTeam as Read exposing (Team, newTeam)
import Commands exposing (Command(..))
import Events exposing (Event(..))
import Uuid exposing (uuidGenerator)
import Random.Pcg exposing (generate)


handleCommand : Command -> Write.Model -> Cmd Event
handleCommand command model =
    case command of
        CreatePlayer playerName ->
            generate (PlayerWasCreated playerName) uuidGenerator

        CreateTeam teamName ->
            generate (TeamWasCreated teamName) uuidGenerator

        CreateTournament tournamentname rounds ->
            Cmd.none

        AddPlayerToTeam player team ->
            Cmd.none

        AddTeamToTournament team tournament ->
            Cmd.none


handleEvent : Event -> Write.Model -> Write.Model
handleEvent event model =
    case event of
        TeamWasCreated teamName teamId ->
            { model | teams = (Write.Team teamId teamName Nothing Nothing) :: model.teams }

        PlayerWasCreated playerName playerId ->
            { model | players = (Write.Player playerId playerName) :: model.players }

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

        TeamWasAddedToTournament team tournament ->
            model

        GameStarted team1 team2 ->
            model

        GoalScored player ->
            model

        GameFinished ->
            model
