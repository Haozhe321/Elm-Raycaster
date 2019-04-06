module Vectors exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }

type alias Line =
    { start : Position
    , end : Position
    }


start : Line -> Position
start =
    .start


end : Line -> Position
end = 
    .end
