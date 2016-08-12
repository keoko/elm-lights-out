module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import LightsOut exposing (adjacentLights, columns)

all : Test
all =
    describe "AdjacentLights Suite"
        [ test "first Row, first Column" <|
            \() ->
                Expect.equal [(1,0), (0,1)] <| adjacentLights (0,0)
        , test "first row, second column" <|
            \() ->
                Expect.equal [(0,0), (2,0), (1,1) ] <| adjacentLights (1,0)
        , test "first row, last light" <|
            \() ->
                Expect.equal [(columns-2,0), (columns-1,1)] <| adjacentLights (columns-1,0)
        , test "second Row, first Column" <|
            \() ->
                Expect.equal [(1,1), (0,0), (0,2)] <| adjacentLights (0,1)
        , test "second row, second column" <|
            \() ->
                Expect.equal [(0,1),(2,1),(1,0),(1,2)] <| adjacentLights (1,1)
        , test "second row, last light" <|
            \() ->
                Expect.equal [(columns-2,1), (columns-1,0), (columns-1,2)] <| adjacentLights (columns-1,1)
        --, test "last Row, first Column" <|
            --\() ->
                --Expect.equal [(0, rows - 2), (1,row - 1)] <| adjacentLights (0,rows - 1)
        --, test "last row, second column" <|
            --\() ->
                --Expect.equal [(0,1),(2,1),(1,0),(1,2)] <| adjacentLights (1,rows - 1)
        --, test "last row, last light" <|
            --\() ->
                --Expect.equal [(columns-2,1), (columns-1,0), (columns - 1,2)] <| adjacentLights (columns-1,rows-1)
        ]
