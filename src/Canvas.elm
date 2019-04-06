module Canvas exposing (root)

import Html exposing (Html)
import Mouse
import Vectors exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Utils exposing (borderHeight, borderWidth)
import Types exposing (..)

root : Walls -> Mouse.Position -> Html msg
root walls position =
    svg
        [ width (toString borderWidth)
        , height (toString borderHeight)
        ]
        [ drawWalls walls
        , drawCursor position
        , drawLineToCursor position
        ]


drawCursor : Mouse.Position -> Svg msg
drawCursor position =
    circle
        [ cx (toString position.x)
        , cy (toString position.y)
        , r "5"
        , fill "red"
        ]
        []

drawLineToCursor : Mouse.Position -> Svg msg
drawLineToCursor position = 
    Svg.line[
          x1 (toString (borderWidth / 2))
        , y1 (toString (borderHeight / 2))
        , x2 (toString position.x)
        , y2 (toString position.y)
        , stroke "red"
        , strokeWidth "1"
        , strokeLinecap "round"
    ]
    []

drawWalls : Walls -> Svg msg
drawWalls walls =
    g []
        (List.map drawLine walls)


drawLine : Line -> Svg msg
drawLine line =
    let
        lineStart =
            Vectors.start line

        lineEnd =
            Vectors.end line
    in
        Svg.line
            [ x1 (toString lineStart.x)
            , y1 (toString lineStart.y)
            , x2 (toString lineEnd.x)
            , y2 (toString lineEnd.y)
            , stroke "black"
            , strokeWidth "2"
            , strokeLinecap "round"
            ]
            []