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
        renderCandidates = [drawRays position walls "white", draw position walls drawFunkyLight, drawFromPointToCorners position walls "red"]
        renderCandidate =  case List.Extra.getAt (keyPresses % (List.length renderCandidates)) renderCandidates of
                                        Just x -> x
                                        _ -> drawRays position walls "white"
    in svg
        [ width (toString borderWidth)
        , height (toString borderHeight)
        ]
        -- Note that the later elements in the list will be drawn on top.
        [ drawBackgroundCanvas "black"
        , renderCandidate
        , drawWalls walls "grey"
        , drawCursor position
        ]

drawCursor : Mouse.Position -> Svg msg
drawCursor position =
    circle
        [ cx (toString position.x)
        , cy (toString position.y)
        , r "3"
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

drawFromPointToCorners : Mouse.Position -> Walls -> String -> Svg msg
drawFromPointToCorners position walls lineColor = 
    draw position walls (drawLine lineColor)

drawRays : Mouse.Position -> Walls -> String -> Svg msg
drawRays position walls color =
    draw position walls (\lines -> drawLight lines color)

drawWalls : Walls -> String -> Svg msg
drawWalls walls color =
    drawLine color walls

drawBackgroundCanvas : String -> Svg msg
drawBackgroundCanvas color = 
    let 
        getXY point = toString point.x ++ "," ++ toString point.y
        polyPoints = [{x = 0, y = 0}
                        , {x = borderWidth, y = 0}
                        , {x = borderWidth, y = borderHeight}
                        , {x = 0, y = borderHeight}]
        pointsStr =  polyPoints
                        |> List.map getXY
                        |> String.join " "
    in 
        polygon
            [fill color
            , stroke color
            , points pointsStr]
            []
