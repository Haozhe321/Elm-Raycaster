module LineTransformer exposing (..)

{-| Module for transforming a list of lines(rays) into a List of Svg msg

-}

import Vectors exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)

drawLight : List Line -> Svg msg
drawLight listOfRays =
        listOfRays
            |> zipRays
            |> List.map (\(l1, l2) -> drawPoly(l1, l2) "gold")
            |> g[]
--        drawPolyColorShift zippedRays 0 40 40

drawFunkyLight : List Line -> Svg msg
drawFunkyLight listOfRays =
    listOfRays
        |> zipRays
        |> drawPolyColorShift 255 127 0 20 25 40
        |> g []


zipRays : List Line -> List (Line, Line)
zipRays listOfRays =
    let
        getAngle : Line -> Float
        getAngle line = atan2 (line.end.y - line.start.y) (line.end.x - line.start.x)
        -- We first sort the given lines by their end point (around the clock) so we avoid drawing overlapping segments.
        sortedRays : List Line
        sortedRays = List.sortBy getAngle listOfRays
        sortedRaysShiftByOne = case sortedRays of
             x::xs-> xs ++ [x]
             x -> x
    in
        -- Then we capture the each adjacent lines to draw a triangle
        List.map2 (,) sortedRays sortedRaysShiftByOne


-- Helper function to transform a list of pair lines into polygons color shifted
drawPolyColorShift :  Int -> Int -> Int -> Int -> Int -> Int ->(List (Line,Line))-> List (Svg msg)
drawPolyColorShift startRed startGreen startBlue redInc greenInc blueInc zippedRays =
    let
        getRgbVal n = toString (n % 256)
        rgb = "rgb(" ++ String.join "," (List.map getRgbVal [startRed, startGreen, startBlue]) ++ ")"
    in
        case zippedRays of
        x :: xs -> (drawPoly x rgb) :: drawPolyColorShift (startRed + redInc) (startGreen + greenInc) (startBlue + blueInc) redInc greenInc blueInc xs
        _ -> []

-- Draw a polygon(triangle) given two lines and a color
drawPoly : (Line, Line) -> String -> Svg msg
drawPoly (l1, l2) color =
    let
        getXY point = toString point.x ++ "," ++ toString point.y
        polyPoints = [Vectors.start l1
                    , Vectors.end l1
                    , Vectors.end l2]
        pointsStr =  polyPoints
                        |> List.map getXY
                        |> String.join " "
    in
        polygon
            [fill color
            , stroke color
            , points pointsStr]
            []

drawLine : String -> List(Line) -> Svg msg
drawLine color lline =
    let
        lineStart line =
            Vectors.start line

        lineEnd line =
            Vectors.end line
        drawSingleLine start end=
            Svg.line
                        [ x1 (toString start.x)
                        , y1 (toString start.y)
                        , x2 (toString end.x)
                        , y2 (toString end.y)
                        , stroke color
                        , strokeWidth "1"
                        , strokeLinecap "round"
                        ]
                        []
    in
        lline
            |> List.map (\(line)-> drawSingleLine (lineStart line) (lineEnd line))
            |> g[]

