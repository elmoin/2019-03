-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module StarWars.Interface exposing (Character(..))


type Character
    = Character



Query: {
    hello: String,
    world: String!
}

Mutation: {
    addHuman(name: String!): Bool,
    stuff: [String]!
}
