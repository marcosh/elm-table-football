module TableFootballUI exposing (..)

import TableFootballApp as App exposing (handleCommand, handleEvent, project)
import CommandError exposing (CommandError)
import Model as Domain exposing (Model, init, writeModel, readModel)
import ReadModel as Read exposing (Model, players, teams)
import Html exposing (Html, Attribute, div, input, button, text)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (value, style)
import Commands exposing (Command)
import Events exposing (Event)
import ReadPlayer as Read exposing (Player)
import ReadTeam as Read exposing (Team, teamPlayers)
import Player exposing (PlayerId)
import Team exposing (TeamId)
import Uuid exposing (Uuid)
import Css exposing (asPairs, backgroundColor, Color, rgb)
import AllDict exposing (values)


type alias Model =
    { domainModel : Domain.Model
    , inputPlayer : String
    , inputTeam : String
    , selectedPlayer : Maybe PlayerId
    , selectedTeam : Maybe TeamId
    , addPlayerToTeamMessage : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model (Domain.init) "" "" Nothing Nothing "", Cmd.none )


type Msg
    = {- AppCommand (Command)
         |
      -}
      AppEvent (Event)
    | PlayerInputReceived String
    | CreatePlayer
    | TeamInputReceived String
    | CreateTeam
    | PlayerSelected PlayerId
    | TeamSelected TeamId
    | AddPlayerToTeam


domainCommander : Command -> Model -> (CommandError -> Model -> Model) -> ( Model, Cmd Msg )
domainCommander command model errorHandler =
    case handleCommand command model.domainModel of
        Err message ->
            ( errorHandler message model, Cmd.none )

        Ok cmdEvent ->
            ( model, Cmd.map AppEvent cmdEvent )


noErrorHandling : CommandError -> Model -> Model
noErrorHandling message model =
    model


addPlayerToTeamMessageHandling : CommandError -> Model -> Model
addPlayerToTeamMessageHandling message model =
    { model | addPlayerToTeamMessage = message }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        {- AppCommand command ->
           ( model, Cmd.map AppEvent (handleCommand command model.writeModel) )
        -}
        AppEvent event ->
            ( { model | domainModel = Domain.Model (handleEvent event (writeModel model.domainModel)) (project event (readModel model.domainModel)) }, Cmd.none )

        PlayerInputReceived input ->
            ( { model | inputPlayer = input }, Cmd.none )

        CreatePlayer ->
            domainCommander (Commands.CreatePlayer model.inputPlayer) { model | inputPlayer = "" } noErrorHandling

        TeamInputReceived input ->
            ( { model | inputTeam = input }, Cmd.none )

        CreateTeam ->
            domainCommander (Commands.CreateTeam model.inputTeam) { model | inputTeam = "" } noErrorHandling

        PlayerSelected playerId ->
            let
                selectedPlayer =
                    case model.selectedPlayer of
                        Just id ->
                            if id == playerId then
                                Nothing
                            else
                                Just playerId

                        _ ->
                            Just playerId
            in
                ( { model | selectedPlayer = selectedPlayer }, Cmd.none )

        TeamSelected teamId ->
            let
                selectedTeam =
                    case model.selectedTeam of
                        Just id ->
                            if id == teamId then
                                Nothing
                            else
                                Just teamId

                        _ ->
                            Just teamId
            in
                ( { model | selectedTeam = selectedTeam }, Cmd.none )

        AddPlayerToTeam ->
            case ( model.selectedPlayer, model.selectedTeam ) of
                ( Just playerId, Just teamId ) ->
                    domainCommander (Commands.AddPlayerToTeam playerId teamId)
                        { model | selectedPlayer = Nothing, selectedTeam = Nothing }
                        addPlayerToTeamMessageHandling

                ( Just playerId, Nothing ) ->
                    ( { model | addPlayerToTeamMessage = "Please select a team" }, Cmd.none )

                ( Nothing, Just teamId ) ->
                    ( { model | addPlayerToTeamMessage = "Please select a player" }, Cmd.none )

                ( Nothing, Nothing ) ->
                    ( { model | addPlayerToTeamMessage = "Please select a team and a player" }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input [ onInput PlayerInputReceived, value model.inputPlayer ] []
            , button [ onClick CreatePlayer ] [ text "Create Player" ]
            , div [] (List.map (showPlayer model.selectedPlayer) (AllDict.values (players (readModel model.domainModel))))
            ]
        , div []
            [ input [ onInput TeamInputReceived, value model.inputTeam ] []
            , button [ onClick CreateTeam ] [ text "Create Team" ]
            , div [] (List.map (showTeam model.selectedTeam) (AllDict.values (teams (readModel model.domainModel))))
            ]
        , div []
            [ button [ onClick AddPlayerToTeam ] [ text "Add Player To Team" ]
            , div [] [ text model.addPlayerToTeamMessage ]
            ]
        ]


showPlayer : Maybe PlayerId -> Read.Player -> Html Msg
showPlayer selectedPlayer player =
    div [ onClick (PlayerSelected player.id), playerStyle selectedPlayer player ] [ text player.name ]


playerStyle : Maybe PlayerId -> Read.Player -> Attribute Msg
playerStyle selectedPlayer player =
    style (asPairs [ backgroundColor (selectedColor selectedPlayer player.id) ])


showTeam : Maybe TeamId -> Read.Team -> Html Msg
showTeam selectedTeam team =
    div [ onClick (TeamSelected team.id), style (asPairs [ backgroundColor (selectedColor selectedTeam team.id) ]) ]
        [ text team.name
        , showTeamPlayers team
        ]


showTeamPlayers : Read.Team -> Html Msg
showTeamPlayers team =
    div []
        (List.map (\player -> div [] [ text player.name ])
            (teamPlayers team)
        )


selectedColor : Maybe Uuid -> Uuid -> Css.Color
selectedColor selectedId currentId =
    case selectedId of
        Just id ->
            if id == currentId then
                rgb 237 212 0
            else
                rgb 255 255 255

        _ ->
            rgb 255 255 255
