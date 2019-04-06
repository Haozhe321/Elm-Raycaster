module Vectors exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }


type alias Vector =
    { length : Float
    , angle : Float
    }


type alias Line =
    { position : Position
    , vector : Vector
    }


start : Line -> Position
start =
    .position


end : Line -> Position
end line =
    let
        ( dx, dy ) =
            fromPolar ( line.vector.length, line.vector.angle )
    in
        { x = line.position.x + dx
        , y = line.position.y + dy
        }
        