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
import List.Extra

root : Walls -> Int -> Mouse.Position -> Html msg
root walls keyPresses position =
    let
        renderCandidates = [drawRays position walls, draw position walls drawFunkyLight, drawFromPointToCorners position walls]
        renderCandidate =  case List.Extra.getAt (keyPresses % (List.length renderCandidates)) renderCandidates of
                                        Just x -> x
                                        _ -> drawRays position walls
    in svg
        [ width (toString borderWidth)
        , height (toString borderHeight)
        ]
        -- Note that the later elements in the list will be drawn on top.
        [ renderCandidate
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

drawFromPointToCorners : Mouse.Position -> Walls -> Svg msg
drawFromPointToCorners position walls = 
    draw position walls (drawLine "red")

drawRays : Mouse.Position -> Walls -> Svg msg
drawRays position walls =
    draw position walls drawLight

drawWalls : Walls -> Svg msg
drawWalls walls =
    drawLine "black" walls
