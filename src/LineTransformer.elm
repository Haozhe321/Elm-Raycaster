module LineTransformer exposing (..)

{-| Module for transforming a list of lines(rays) into a List of Svg msg

-}

import Vectors exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)

drawLight : List Line -> List (Svg msg)
drawLight listOfRays =
    let
        getAngle : Line -> Float
        getAngle line = atan2 (line.end.y - line.start.y) (line.end.x - line.start.x)
        -- We first sort the given lines by their end point (around the clock) so we avoid drawing overlapping segments.
        sortedRays : List Line
        -- TODO: Check if this is giving the wrong sorted order (check getAngle)
        sortedRays = List.sortBy getAngle listOfRays
        sortedRaysShiftByOne = case sortedRays of
             x::xs-> xs ++ [x]
             x -> x
        -- Then we capture the each adjacent lines to draw a triangle
        zippedRays = List.map2 (,) sortedRays sortedRaysShiftByOne
    in
--        zippedRays |> List.map (\(l1, l2) -> drawPoly(l1, l2) "gold")
        drawPolyColorShift zippedRays 0 40 40

-- Helper function to transform a list of pair lines into polygons color shifted by (Hardcoded) 4 red
drawPolyColorShift : (List (Line,Line)) -> Int -> Int -> Int -> List (Svg msg)
drawPolyColorShift zippedRays red green blue =
    let
        getRgbVal n = toString (n % 256)
        rgb = "rgb(" ++ String.join "," (List.map getRgbVal [red, green, blue]) ++ ")"
    in
        case zippedRays of
        x :: xs -> (drawPoly x rgb) :: drawPolyColorShift xs (red + 4) (green) (blue)
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
