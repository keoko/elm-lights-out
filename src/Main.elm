import Html.App exposing (program)
import LightsOut

main : Program Never
main =
  program { init = LightsOut.init
          , view = LightsOut.view
          , update = LightsOut.update
          , subscriptions = LightsOut.subscriptions
          }

