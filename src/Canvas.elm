module Canvas exposing (root)

import Html exposing (Html)
import Mouse
import Vectors exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Utils exposing (borderHeight, borderWidth)
import Types exposing (..)
import RayControl exposing (..)

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

replaceLineStartWithMousePosition: Mouse.Position -> Line -> Line
replaceLineStartWithMousePosition position line = 
    let 
        mouse_x = position.x
        mouse_y = position.y
        start = line.start
    in
        {line | start = { start | x = (toFloat mouse_x), y = (toFloat mouse_y) } }    

drawFromPointToCorners : Mouse.Position -> Walls -> Svg msg
drawFromPointToCorners position walls = 
    walls
        |> List.map(replaceLineStartWithMousePosition position) --form a ray from all corners to the cursor position
        |> RayControl.resolve(walls)
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