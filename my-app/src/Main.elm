module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Graphql.Http
import Graphql.Operation exposing (RootQuery)
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Html exposing (Html, div, h1, img, node, text)
import Html.Attributes as HA exposing (src)
import StarWars.Object
import StarWars.Object.Human as Human
import StarWars.Query as Query
import StarWars.Scalar exposing (Id(..))


query : SelectionSet (Maybe Human) RootQuery
query =
    Query.human { id = Id "1001" } humanSelection


type alias Human =
    { name : String
    , homePlanet : Maybe String
    }


humanSelection : SelectionSet Human StarWars.Object.Human
humanSelection =
    SelectionSet.map2 Human
        Human.name
        Human.homePlanet


makeRequest : Cmd Msg
makeRequest =
    query
        |> Graphql.Http.queryRequest "https://elm-graphql.herokuapp.com"
        |> Graphql.Http.send GotResponse



---- MODEL ----


type alias Model =
    { name : String
    , homePlanet : Maybe String
    }


init : ( Model, Cmd Msg )
init =
    ( { name = "quatsch"
      , homePlanet = Just "mit soße"
      }
    , makeRequest
    )



---- UPDATE ----


type Msg
    = GotResponse (Result (Graphql.Http.Error (Maybe Human)) (Maybe Human))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotResponse (Ok maybeHuman) ->
            case maybeHuman of
                Just human ->
                    ( { model
                        | name = human.name
                        , homePlanet =
                            human.homePlanet
                      }
                    , Cmd.none
                    )

                Nothing ->
                    ( { name = "", homePlanet = Just "" }, Cmd.none )

        GotResponse (Err maybeHuman) ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ text <| model.name ++ " " ++ Maybe.withDefault "kein planet" model.homePlanet ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
