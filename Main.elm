import Html exposing (Html, div, h1, img, text, pre, hr)
import Html.Attributes exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import List exposing (repeat)
import Debug exposing (log)

main : Program Never
main =
  beginnerProgram { model = model, view = view, update = update }

type Msg = ToggleLight Int

type alias Model = { lights: List Bool }

rows : Int
rows = 4

model : Model
model =
    { lights = [ True, False, False, False ] }



toggleLightAndAdjacents : Int -> List Bool -> List Bool
toggleLightAndAdjacents index lights = 
    let
        isLightOrAdjacent i = i == index || i == (index-1) || i == (index+1)
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
    div [ style [ ("background", if lightOn then "blue" else "black" )
                , ("width", "10vw")
                , ("height", "10vw")
                , ("margin", "0.1vw")
                ]

        , onClick <| ToggleLight index ] []

view : Model -> Html Msg
view model =
    div [] ( List.indexedMap viewBox model.lights )
