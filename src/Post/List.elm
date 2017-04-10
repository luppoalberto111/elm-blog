module Post.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import RemoteData exposing (..)
import Msgs exposing (Msg)
import Models exposing (Post)


createPostEntry : Post -> Html Msg
createPostEntry post =
    section [ class "post-excerpt" ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ h1 []
                    [ a [ href ("#post/" ++ post.id) ]
                        [ text post.title ]
                    ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ text post.content ]
            ]
        ]


view : WebData (List Post) -> Html Msg
view response =
    case response of
        RemoteData.NotAsked ->
            text "---"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success posts ->
            div [] (List.map createPostEntry posts)

        RemoteData.Failure error ->
            text (toString error)
