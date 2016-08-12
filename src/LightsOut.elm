module LightsOut exposing (adjacentLights, model, view, update, rows, columns)

import Html exposing (Html, div, table, tr, td, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List exposing (repeat)
--import Debug exposing (log)
import List.Split exposing (chunksOfLeft)

type Msg = ToggleLight Int

type alias Model = { lights: Lights }

type alias Lights = List Bool

rows : Int
rows = 4

columns : Int
columns = 4

model : Model
model =
    { lights = repeat (columns * 4) True }


adjacentLights : Int -> List Int
adjacentLights index =
    let
        left = index - 1
        right = index + 1
        up = index - columns
        down = index + columns
    in
        List.filter (\x -> x >= 0 && x <= (rows * columns))[left, right, up, down]

toggleLightAndAdjacents : Int -> Lights -> Lights
toggleLightAndAdjacents index lights =
    let
        adjacents = adjacentLights index
        isLightOrAdjacent i = i == index || List.member i adjacents
    in
        List.indexedMap (\ i l -> if isLightOrAdjacent i then not l else l) lights


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleLight index ->
            let
                lights' = toggleLightAndAdjacents index model.lights
            in
                { model | lights = lights' }


viewBox : Int -> Bool -> Html Msg
viewBox rowIndex lightOn =
    td [ style [ ("background", if lightOn then "blue" else "black" )
                , ("width", "10vw")
                , ("height", "10vw")
                , ("margin", "0.1vw")
                ]

        , onClick <| ToggleLight index ] []


viewRow : Lights -> Html Msg
viewRow rowIndex rowlights =
    tr [] ( List.indexedMap (viewBox rowIndex) rowLights )


view : Model -> Html Msg
view model =
    let
        chunks = chunksOfLeft rows model.lights
    in
        table []
            (List.map viewRow chunks)
