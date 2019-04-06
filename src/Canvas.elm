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
        , drawFromPointToCorners position walls
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

replaceLineEndWithMousePosition: Mouse.Position -> Line -> Line
replaceLineEndWithMousePosition position line = 
    let 
        mouse_x = position.x
        mouse_y = position.y
        end = line.end
    in
        {line | end = { end | x = (toFloat mouse_x), y = (toFloat mouse_y) } }    

drawFromPointToCorners : Mouse.Position -> Walls -> Svg msg
drawFromPointToCorners position walls = 
    walls
    |> List.map(replaceLineEndWithMousePosition position)
    |> List.map(drawLine "red")
    |> g[]

drawWalls : Walls -> Svg msg
drawWalls walls =
    g []
        (List.map (drawLine "black") walls)


drawLine : String -> Line -> Svg msg
drawLine color line =
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
            , stroke color
            , strokeWidth "1"
            , strokeLinecap "round"
            ]
            []