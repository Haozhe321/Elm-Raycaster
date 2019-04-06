module Vectors exposing (..)


type alias Position =
    { x : Float
    , y : Float
    }

type alias Intercept = 
    { x : Float
    , y : Float
    , t1 : Float
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
