module TableFootballApp exposing (handleCommand, handleEvent, project)

import Model exposing (Model)
import WriteModel as Write exposing (Model, teams, getTeam)
import ReadModel as Read exposing (Model, Players, playerIsInTeam)
import Player as Write exposing (Player, PlayerId)
import Team as Write exposing (Team, createTeam, hasBothPlayers, containsPlayer, whenPlayerAdded)
import TeamCommandHandlers exposing (addPlayer)
import ReadPlayer as Read exposing (Player, newPlayer)
import ReadTeam as Read exposing (Team, newTeam, whenPlayerAdded)
import Commands exposing (Command(..))
import Events exposing (Event(..))
import CommandError exposing (CommandError)
import Uuid exposing (uuidGenerator)
import Random.Pcg exposing (generate)
import AllDict exposing (insert, update)
import Result exposing (toMaybe)


handleCommand : Command -> Model.Model -> Result CommandError (Cmd Event)
handleCommand command model =
    case command of
        CreatePlayer playerName ->
            Ok (generate (PlayerWasCreated playerName) uuidGenerator)

        CreateTeam teamName ->
            Ok (generate (TeamWasCreated teamName) uuidGenerator)

        AddPlayerToTeam playerId teamId ->
            let
                maybeTeam =
                    getTeam teamId (teams model.writeModel)
            in
                case maybeTeam of
                    Nothing ->
                        Err "I am not able to retrieve the selected Team"

                    Just team ->
                        addPlayer team playerId (playerIsInTeam model.readModel)

        CreateTournament tournamentname rounds ->
            Ok Cmd.none


whenPlayerAddedToTeam : PlayerId -> Maybe Write.Team -> Maybe Write.Team
whenPlayerAddedToTeam playerId maybeTeam =
    case maybeTeam of
        Nothing ->
            Nothing

        Just team ->
            Just (Write.whenPlayerAdded team playerId)


handleEvent : Event -> Write.Model -> Write.Model
handleEvent event model =
    case event of
        PlayerWasCreated playerName playerId ->
            { model | players = insert playerId (Write.Player playerId playerName) model.players }

        TeamWasCreated teamName teamId ->
            { model | teams = insert teamId (createTeam teamId teamName) model.teams }

        PlayerWasAddedToTeam playerId teamId ->
            { model | teams = update teamId (whenPlayerAddedToTeam playerId) model.teams }

        TournamentWasCreated tournamentName rounds ->
            model

        GameStarted team1 team2 ->
            model

        GoalScored player ->
            model

        GameFinished ->
            model


addPlayerToReadTeam : Read.Player -> Maybe Read.Team -> Maybe Read.Team
addPlayerToReadTeam player maybeTeam =
    case maybeTeam of
        Nothing ->
            Nothing

        Just team ->
            Just (Read.whenPlayerAdded team player)


project : Event -> Read.Model -> Read.Model
project event model =
    case event of
        TeamWasCreated teamName teamId ->
            { model | teams = insert teamId (newTeam teamId teamName) model.teams }

        PlayerWasCreated playerName playerId ->
            { model | players = insert playerId (newPlayer playerId playerName) model.players }

        PlayerWasAddedToTeam playerId teamId ->
            let
                maybePlayer =
                    AllDict.get playerId model.players
            in
                case maybePlayer of
                    Nothing ->
                        model

                    Just player ->
                        { model | teams = update teamId (addPlayerToReadTeam player) model.teams }

        TournamentWasCreated tournamentName rounds ->
            model

        GameStarted team1 team2 ->
            model

        GoalScored player ->
            model

        GameFinished ->
            model
