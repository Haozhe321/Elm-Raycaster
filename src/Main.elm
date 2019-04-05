module Main exposing (main)

import Html

main : Program Never Types.Model Types.Msg
main =
    Html.program
        { init = ( model, Cmd msg )
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
