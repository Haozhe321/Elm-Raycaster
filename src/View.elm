module View exposing (root)

import Html exposing (..)
import Types exposing (..)
import Canvas


root : Model -> Html msg
root model =
    div []
        [ case model.mouse of
            Just position ->
                Canvas.root model.walls position

            _ ->
                Html.text "Cursor here"
        ]