import Html.App exposing (beginnerProgram)
import LightsOut

main : Program Never
main =
  beginnerProgram { model = LightsOut.model, view = LightsOut.view, update = LightsOut.update }

