import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)

main =
    view "todo"

view model =
    div [style [ ("background", "blue")
               , ("width", "10vw")
               , ("height", "10vw")
               ]
        ] []
