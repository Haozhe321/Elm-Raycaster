module Vectors exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }


-- type alias Vector =
--     { length : Float
--     , angle : Float
--     }


type alias Line =
    { start : Position
    , end : Position
    }


start : Line -> Position
start =
    .start


-- end : Line -> Position
-- end line =
--     let
--         ( dx, dy ) =
--             fromPolar ( line.vector.length, line.vector.angle )
--     in
--         { x = line.position.x + dx
--         , y = line.position.y + dy
--         }

end : Line -> Position
end = 
    .end
