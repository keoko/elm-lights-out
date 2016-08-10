import Html exposing (Html, div, h1, img, text, pre, hr)
import Html.Attributes exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

main : Program Never
main =
  beginnerProgram { model = model, view = view, update = update }

type Msg = ToggleLight

type alias Model = { lights: List Bool }

model : Model
model =
    { lights = [ True, False, True, True, True, False ] }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleLight -> { model | lights = List.map not model.lights }


viewBox : Bool -> Html Msg
viewBox lightOn =
    div [ style [ ("background", if lightOn then "blue" else "black" )
                , ("width", "10vw")
                , ("height", "10vw")
                , ("margin", "0.1vw")
                ]

        , onClick ToggleLight ] []

view : Model -> Html Msg
view model =
    div [] ( List.map viewBox model.lights )
