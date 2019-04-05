module Main exposing (main)

{-| Entry point for the app

@docs main
-}

import Svg exposing (..)
import Svg.Attributes exposing (..)

import Html
import Platform.Cmd as Cmd
import Mouse
-- Build World State

type alias Model =
     {
      mouseInput : Maybe Mouse.Position,
      mouseHistory : List Mouse.Position
     }

type Msg =
    MouseXY Mouse.Position

empty_model : (Model, Cmd msg)
empty_model = ({
                mouseInput = Nothing,
                mouseHistory = []
                }, Cmd.none)

make_circle position =
    let
        x_str = toString position.x
        y_str = toString position.y
    in
        circle [cx x_str, cy y_str, r "20", fill "blue"] []

view : Model -> Html.Html msg
view model =
    case model.mouseInput of
        Just position ->
            let
                x_str = toString position.x
                y_str = toString position.y
            in svg
                [width "800", height "800"]
                (
                [
                    circle [cx "600", cy "620", r "200", fill "green"] [],
                    make_circle position
                ] ++
                List.map (\position -> make_circle position) model.mouseHistory
                )
        _ -> Html.text"Loading."

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseXY mouse ->
            ( { model | mouseInput = Just mouse
                        , mouseHistory = List.take 10 (mouse :: model.mouseHistory)}
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Mouse.moves MouseXY

{-| Start the program running.
-}
main : Program Never Model Msg
main =
    Html.program
        { init = empty_model
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
