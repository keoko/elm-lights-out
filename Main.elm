import Html exposing (Html, div, table, tr, td, text)
import Html.Attributes exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import List exposing (repeat)
--import Debug exposing (log)
import List.Split exposing (chunksOfLeft)

main : Program Never
main =
  beginnerProgram { model = model, view = view, update = update }

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



adjacentLights : Int -> Lights -> List Int
adjacentLights index lights =
    [ 0, 1]


toggleLightAndAdjacents : Int -> Lights -> Lights
toggleLightAndAdjacents index lights =
    let
        adjacents = (adjacentLights index lights)
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
viewBox index lightOn =
    td [ style [ ("background", if lightOn then "blue" else "black" )
                , ("width", "10vw")
                , ("height", "10vw")
                , ("margin", "0.1vw")
                ]

        , onClick <| ToggleLight index ] []


viewRow : Lights -> Html Msg
viewRow row =
    tr [] ( List.indexedMap viewBox row )


view : Model -> Html Msg
view model =
    let
        chunks = chunksOfLeft rows model.lights
    in
        table []
            (List.map viewRow chunks)
