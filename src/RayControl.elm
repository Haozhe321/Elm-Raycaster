module RayControl exposing(resolve)

import List.Extra
import Types exposing (..)
import Vectors exposing (..)


resolve : Walls -> List Line -> List Line
resolve walls rays =
    rays 
        |> List.filterMap(cutRay walls)

{- for a given ray, check against all the lines for point of intercept and return the line with the 
nearest intercept -}
cutRay : Walls -> Line -> Maybe Line
cutRay walls ray = 
    walls 
        |> List.filterMap(intercept ray)
        |> List.Extra.minimumBy(.t1)
        |> changeInterceptToLine(ray)

changeInterceptToLine : Line -> Maybe Intercept -> Maybe Line
changeInterceptToLine ray intercept = 
    case intercept of
        Nothing ->
            Nothing
        Just intercept ->
            Just {start = {x = ray.start.x, y = ray.start.y},
                end = {x = intercept.x, y = intercept.y}}

-- Given 2 lines, find their point of interception
intercept : Line -> Line -> Maybe Intercept
intercept ray line =
    let 
        -- RAY in parametric: Point + Direction*T1
        r_px = ray.start.x
        r_py = ray.start.y
        r_dx = ray.end.x - ray.start.x
        r_dy = ray.end.y - ray.start.y

        -- SEGMENT in parametric: Point + Direction*T2
        s_px = line.start.x
        s_py = line.start.y
        s_dx = line.end.x - line.start.x
        s_dy = line.end.y - line.start.y

        r_mag = sqrt (r_dx * r_dx + r_dy * r_dy)
        s_mag = sqrt (s_dx * s_dx + s_dy * s_dy)

        t2 = (r_dx*(s_py-r_py) + r_dy*(r_px-s_px))/(s_dx*r_dy - s_dy*r_dx)
        t1 = (s_px+s_dx*t2-r_px)/r_dx
    
    in 
        if r_dx/r_mag==s_dx/s_mag && r_dy/r_mag==s_dy/s_mag then 
            Nothing
        else if t1 < 0 then
            Nothing
        else if t2 < 0 || t2 > 1 then 
            Nothing
        else
            Just { x = r_px + r_dx * t1
            , y = r_py + r_dy * t1
            , t1 = t1
            }