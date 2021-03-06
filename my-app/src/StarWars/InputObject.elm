-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module StarWars.InputObject exposing (Greeting, GreetingOptionalFields, GreetingOptions, GreetingOptionsOptionalFields, GreetingRequiredFields, buildGreeting, buildGreetingOptions, encodeGreeting, encodeGreetingOptions)

import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import StarWars.Enum.Language
import StarWars.Interface
import StarWars.Object
import StarWars.Scalar
import StarWars.ScalarCodecs
import StarWars.Union


buildGreeting : GreetingRequiredFields -> (GreetingOptionalFields -> GreetingOptionalFields) -> Greeting
buildGreeting required fillOptionals =
    let
        optionals =
            fillOptionals
                { language = Absent, options = Absent }
    in
    { language = optionals.language, name = required.name, options = optionals.options }


type alias GreetingRequiredFields =
    { name : String }


type alias GreetingOptionalFields =
    { language : OptionalArgument StarWars.Enum.Language.Language
    , options : OptionalArgument GreetingOptions
    }


{-| Type for the Greeting input object.
-}
type alias Greeting =
    { language : OptionalArgument StarWars.Enum.Language.Language
    , name : String
    , options : OptionalArgument GreetingOptions
    }


{-| Encode a Greeting into a value that can be used as an argument.
-}
encodeGreeting : Greeting -> Value
encodeGreeting input =
    Encode.maybeObject
        [ ( "language", Encode.enum StarWars.Enum.Language.toString |> Encode.optional input.language ), ( "name", Encode.string input.name |> Just ), ( "options", encodeGreetingOptions |> Encode.optional input.options ) ]


buildGreetingOptions : (GreetingOptionsOptionalFields -> GreetingOptionsOptionalFields) -> GreetingOptions
buildGreetingOptions fillOptionals =
    let
        optionals =
            fillOptionals
                { prefix = Absent }
    in
    { prefix = optionals.prefix }


type alias GreetingOptionsOptionalFields =
    { prefix : OptionalArgument String }


{-| Type for the GreetingOptions input object.
-}
type alias GreetingOptions =
    { prefix : OptionalArgument String }


{-| Encode a GreetingOptions into a value that can be used as an argument.
-}
encodeGreetingOptions : GreetingOptions -> Value
encodeGreetingOptions input =
    Encode.maybeObject
        [ ( "prefix", Encode.string |> Encode.optional input.prefix ) ]
