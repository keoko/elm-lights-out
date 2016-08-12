module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import LightsOut exposing (adjacentLights, columns)

all : Test
all =
    describe "AdjacentLights Suite"
        [ test "First Row, First Light" <|
            \() ->
                Expect.equal [2, (columns + 1)] <| adjacentLights 1
        , test "first row, second light" <|
            \() ->
                Expect.equal [1,3, (columns + 2)] <| adjacentLights 2
        , test "first row, last light" <|
            \() ->
                Expect.equal [(columns-1), (columns + columns)] <| adjacentLights columns
        ]
