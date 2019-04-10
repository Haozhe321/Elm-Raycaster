module Canvas exposing (root)

import Html exposing (Html)
import Mouse
import Vectors exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Utils exposing (borderHeight, borderWidth)
import Types exposing (..)
import RayControl exposing (..)
import LineTransformer exposing (..)

root : Walls -> Mouse.Position -> Html msg
root walls position =
    svg
        [ width (toString borderWidth)
        , height (toString borderHeight)
        ]
        -- Note that the later elements in the list will be drawn on top.
        [ drawRays position walls
--        , draw position walls drawFunkyLight
--        , drawFromPointToCorners position walls
        , drawWalls walls
        , drawCursor position
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

draw : Mouse.Position -> Walls -> (List Line -> Svg msg) -> Svg msg
draw position walls drawer =
    walls
        |> List.map(replaceLineStartWithMousePosition position)
        |> RayControl.resolve(walls)
        |> drawer

-- TODO: Create higher order function to abstract out the common part of both the below drawers
drawFromPointToCorners : Mouse.Position -> Walls -> Svg msg
drawFromPointToCorners position walls = 
    draw position walls (drawLine "red")

drawRays : Mouse.Position -> Walls -> Svg msg
drawRays position walls =
    draw position walls drawLight

drawWalls : Walls -> Svg msg
drawWalls walls =
    drawLine "black" walls
