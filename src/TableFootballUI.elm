module TableFootballUI exposing (..)

import TableFootballApp as App exposing (handleCommand, handleEvent, project)
import WriteModel as Write exposing (Model, init)
import ReadModel as Read exposing (Model, init, players, teams)
import Html exposing (Html, div, input, button, text)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (value, style)
import Commands exposing (Command)
import Events exposing (Event)
import ReadPlayer as Read exposing (Player)
import ReadTeam as Read exposing (Team)
import Player exposing (PlayerId)
import Team exposing (TeamId)
import Uuid exposing (Uuid)
import Css exposing (asPairs, backgroundColor, Color, rgb)


type alias Model =
    { writeModel : Write.Model
    , readModel : Read.Model
    , inputPlayer : String
    , inputTeam : String
    , selectedPlayer : Maybe PlayerId
    , selectedTeam : Maybe TeamId
    }


init : ( Model, Cmd Msg )
init =
    ( Model (Write.init) (Read.init) "" "" Nothing Nothing, Cmd.none )


type Msg
    = AppCommand (Command)
    | AppEvent (Event)
    | PlayerInputReceived String
    | CreatePlayer
    | TeamInputReceived String
    | CreateTeam
    | PlayerSelected PlayerId
    | TeamSelected TeamId


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AppCommand command ->
            ( model, Cmd.map AppEvent (handleCommand command model.writeModel) )

        AppEvent event ->
            ( { model | writeModel = handleEvent event model.writeModel, readModel = project event model.readModel }, Cmd.none )

        PlayerInputReceived input ->
            ( { model | inputPlayer = input }, Cmd.none )

        CreatePlayer ->
            ( { model | inputPlayer = "" }, Cmd.map AppEvent (handleCommand (Commands.CreatePlayer model.inputPlayer) model.writeModel) )

        TeamInputReceived input ->
            ( { model | inputTeam = input }, Cmd.none )

        CreateTeam ->
            ( { model | inputTeam = "" }, Cmd.map AppEvent (handleCommand (Commands.CreateTeam model.inputTeam) model.writeModel) )

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


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ input [ onInput PlayerInputReceived, value model.inputPlayer ] []
            , button [ onClick CreatePlayer ] [ text "Create Player" ]
            , div [] (List.map (showPlayer model.selectedPlayer) (players model.readModel))
            ]
        , div []
            [ input [ onInput TeamInputReceived, value model.inputTeam ] []
            , button [ onClick CreateTeam ] [ text "Create Team" ]
            , div [] (List.map (showTeam model.selectedTeam) (teams model.readModel))
            ]
        ]


showPlayer : Maybe PlayerId -> Read.Player -> Html Msg
showPlayer selectedPlayer player =
    div [ onClick (PlayerSelected player.id), style (asPairs [ backgroundColor (selectedColor selectedPlayer player.id) ]) ] [ text player.name ]


showTeam : Maybe TeamId -> Read.Team -> Html Msg
showTeam selectedTeam team =
    div [ onClick (TeamSelected team.id), style (asPairs [ backgroundColor (selectedColor selectedTeam team.id) ]) ] [ text team.name ]


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
