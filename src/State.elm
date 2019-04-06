module State exposing (initialCmd, initialModel, subscriptions, update)

import Mouse
import Platform.Cmd as Cmd
import Platform.Sub as Sub
import Types exposing (..)
import Utils exposing (borderHeight, borderWidth)

initialModel : Model
initialModel =
    { walls =
        [ -- Border
          { start = { x = 0, y = 0 }, end = { x = borderWidth, y = 0 } }
        , { start = { x = borderWidth, y = 0 }, end = { x = borderWidth, y = borderHeight } }
        , { start = { x = borderWidth, y = borderHeight }, end = { x = 0, y = borderHeight } }
        , { start = { x = 0, y = borderHeight }, end = { x = 0, y = 0 } }
        , -- Polygon #1
          { start = { x = 100, y = 150 }, end = { x = 120, y = 50 } }
        , { start = { x = 120, y = 50 }, end = { x = 200, y = 80 } }
        , { start = { x = 200, y = 80 }, end = { x = 140, y = 210 } }
        , { start = { x = 140, y = 210 }, end = { x = 100, y = 150 } }
        , -- Polygon #2
          { start = { x = 100, y = 200 }, end = { x = 120, y = 250 } }
        , { start = { x = 120, y = 250 }, end = { x = 60, y = 300 } }
        , { start = { x = 60, y = 300 }, end = { x = 100, y = 200 } }
        , -- Polygon #3
          { start = { x = 200, y = 260 }, end = { x = 220, y = 150 } }
        , { start = { x = 220, y = 150 }, end = { x = 300, y = 200 } }
        , { start = { x = 300, y = 200 }, end = { x = 350, y = 320 } }
        , { start = { x = 350, y = 320 }, end = { x = 200, y = 260 } }
        , -- Polygon #4
          { start = { x = 340, y = 60 }, end = { x = 360, y = 40 } }
        , { start = { x = 360, y = 40 }, end = { x = 370, y = 70 } }
        , { start = { x = 370, y = 70 }, end = { x = 340, y = 60 } }
        , -- Polygon #5
          { start = { x = 450, y = 190 }, end = { x = 560, y = 170 } }
        , { start = { x = 560, y = 170 }, end = { x = 540, y = 270 } }
        , { start = { x = 540, y = 270 }, end = { x = 430, y = 290 } }
        , { start = { x = 430, y = 290 }, end = { x = 450, y = 190 } }
        , -- Polygon #6
          { start = { x = 400, y = 95 }, end = { x = 580, y = 50 } }
        , { start = { x = 580, y = 50 }, end = { x = 480, y = 150 } }
        , { start = { x = 480, y = 150 }, end = { x = 400, y = 95 } }
        ]
    , mouse = Nothing
    }


initialCmd : Cmd Msg
initialCmd =
    Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mouse mouse ->
            ( { model | mouse = Just mouse }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Mouse.moves Mouse
