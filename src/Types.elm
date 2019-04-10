module Types exposing (Walls, Model, Msg(..))

import Keyboard
import Mouse
import Vectors exposing (..)


type alias Walls =
    List Line


type alias Model =
    { walls : Walls
    , mouse : Maybe Mouse.Position
    , keyPresses : Int
    }


type Msg =
    Mouse Mouse.Position
    | KeyPressed Keyboard.KeyCode
