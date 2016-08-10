import Html exposing (Html, div, h1, img, text, pre, hr)
import Html.Attributes exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

main : Program Never
main =
  beginnerProgram { model = model, view = view, update = update }

type Msg = ToggleLight

type alias Model =
    {
        on: Bool
    }

model : Model
model =
    { on = True }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleLight -> { model | on = not model.on }

view : Model -> Html Msg
view model =
    div [ style [ ("background", if model.on then "blue" else "black" )
               , ("width", "10vw")
               , ("height", "10vw")
               ]
        , onClick ToggleLight ] []
