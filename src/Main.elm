module Main exposing (main)

{-| The entry-point for the raycaster.

@docs main
-}

import Html
import Types
import View exposing (root)
import State exposing (..)

{-| Start the program running.
-}
main : Program Never Types.Model Types.Msg
main =
    Html.program
        { init = ( State.initialModel, State.initialCmd )
        , update = State.update
        , subscriptions = State.subscriptions
        , view = View.root
        }
