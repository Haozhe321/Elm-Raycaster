module State exposing (..)

import Mouse
import Platform.Cmd as Cmd
import Platform.Sub as Sub
import Types exposing (..)


initialModel : Model
initialModel =
    { walls =
        [ { position = { x = 0, y = 0 }, vector = { length = 600, angle = degrees 0 } }
        , { position = { x = 0, y = 600 }, vector = { length = 600, angle = degrees 0 } }
        , { position = { x = 0, y = 0 }, vector = { length = 600, angle = degrees 90 } }
        , { position = { x = 600, y = 0 }, vector = { length = 600, angle = degrees 90 } }
        , { position = { x = 200, y = 300 }, vector = { length = 170, angle = degrees 15 } }
        , { position = { x = 220, y = 400 }, vector = { length = 50, angle = degrees 290 } }
        , { position = { x = 100, y = 480 }, vector = { length = 150, angle = degrees 250 } }
        , { position = { x = 450, y = 200 }, vector = { length = 120, angle = degrees 35 } }
        , { position = { x = 370, y = 60 }, vector = { length = 300, angle = degrees 70 } }
        , { position = { x = 100, y = 150 }, vector = { length = 200, angle = degrees 30 } }
        , { position = { x = 300, y = 300 }, vector = { length = 100, angle = degrees 90 } }
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
