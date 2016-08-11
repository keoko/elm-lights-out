# Notes

## Todo
- test to toggle adjacent lights
- toggle adjacent lights 
- control logic when the game ends
- random toggled lights at app init
- server


## Why this compile :|
```
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



viewBox : Html Msg
viewBox =
    div [ style [ ("background", if model.on then "blue" else "black" )
                , ("width", "10vw")
                , ("height", "10vw")
                , ("margin", "0.1vw")
                ]

        , onClick ToggleLight ] []

view : Model -> Html Msg
view model =
    div [] [ viewBox
           , viewBox
           , viewBox
           ]
``` 

## why model is visible inside funtions if it's not passed as argument
## how to add logs without adding let expressions
## adding HTML elements is not easy in some cases