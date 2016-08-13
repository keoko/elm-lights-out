module LightsOut exposing (adjacentLights, model, view, update, rows, columns)

import Html exposing (Html, div, table, tr, td, text, button, strong)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (repeat)
import Debug exposing (log)
import List.Split exposing (chunksOfLeft)
import Random exposing (initialSeed, Seed, Generator, generate)

type Msg = ToggleLight Point
    | RePlay

type alias Model =
    { lights : Lights
    , seed : Seed
    }

type alias Lights = List Bool

type alias Point = (Int, Int)

rows : Int
rows = 3

columns : Int
columns = 3


model : Model
model =
    let
        seed = initialSeed 1000
    in
        randomLights seed


randomLights : Seed -> Model
randomLights seed =
    let
        numLights = rows * columns
        (lights, seed) = Random.step (Random.list numLights Random.bool) seed
    in
        { lights = lights
        , seed = seed
        }


adjacentLights : Point -> List (Int,Int)
adjacentLights (columnIndex, rowIndex) =
    let
        left = (columnIndex - 1, rowIndex)
        right = (columnIndex + 1, rowIndex)
        up = (columnIndex, rowIndex - 1)
        down = (columnIndex, rowIndex + 1)
        pointWithinBoundaries (c,r) = r >= 0 && r < rows && c >= 0 && c < columns
    in
        List.filter pointWithinBoundaries [left, right, up, down]


indexToPoint : Int -> Point
indexToPoint index =
    let
        row = index // columns
        column = index `rem` columns
    in
        (column, row)


pointToIndex : Point -> Int
pointToIndex (column, row) =
    column + row * columns


toggleLightAndAdjacents : Point -> Lights -> Lights
toggleLightAndAdjacents (columnIndex, rowIndex) lights =
    let
        index = pointToIndex (columnIndex, rowIndex)
        adjacents = adjacentLights (columnIndex, rowIndex)
        isLightOrAdjacent i = i == index || List.member (indexToPoint i) adjacents
        l = log "adjacents" adjacents
        l' = log "member" <| List.member (columnIndex, rowIndex) adjacents
    in
        List.indexedMap (\i l -> if isLightOrAdjacent i then not l else l) lights


isGameOver : Model -> Bool
isGameOver model =
    List.all ((==) True) model.lights

update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleLight (columnIndex, rowIndex) ->
            let
                lights' = toggleLightAndAdjacents (columnIndex, rowIndex) model.lights
                l = log "toggle:" (lights', columnIndex, rowIndex)
            in
                { model | lights = lights' }

        RePlay ->
            randomLights model.seed

viewLight : Point -> Bool -> Html Msg
viewLight (columnIndex, rowIndex) lightOn =
    td [ style [ ("background", if lightOn then "blue" else "black" )
                , ("width", "10vw")
                , ("height", "10vw")
                , ("margin", "0.1vw")
                ]

        , onClick <| ToggleLight (columnIndex, rowIndex) ] []


viewRow : Int -> Lights -> Html Msg
viewRow rowIndex rowLights =
    tr [] ( List.indexedMap (\columnIndex lights -> viewLight (columnIndex, rowIndex) lights) rowLights )


viewLights : Model -> Html Msg
viewLights model =
    let
        chunks = chunksOfLeft rows model.lights
    in
        table []
            (List.indexedMap viewRow chunks)


view : Model -> Html Msg
view model =
    div []
        [ viewLights model
          , if isGameOver model then
               div [] [ strong [] [text "Congratulations! Click the button to replay."]
                      , button [ onClick RePlay ] [ text "replay" ]
                      ]
            else
               div [] [ text "Do you want to restart?"
                      , button [ onClick RePlay ] [ text "restart" ]
                      ]
        ]
