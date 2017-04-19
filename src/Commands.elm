module Commands
    exposing
        ( fetchLatestsPosts
        , fetchPostArchive
        , fetchPost
        )

import Http
import RemoteData
import Msgs exposing (Msg)
import Models exposing (PostId)
import Utils
import Decoders
    exposing
        ( postListDecoder
        , postDecoder
        )


fetchLatestsPosts : Cmd Msg
fetchLatestsPosts =
    Http.get fetchLatestsPostsUrl postListDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchLatestPosts


fetchLatestsPostsUrl : String
fetchLatestsPostsUrl =
    {- Time.now `andThen` (\time -> "data/latest.json?" ++ time) -}
    "data/latest.json?"


fetchPost : PostId -> Cmd Msg
fetchPost postId =
    Http.get (fetchPostUrl postId) postDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPost


fetchPostUrl : PostId -> String
fetchPostUrl postId =
    let
        dateString =
            List.head (String.split "-" postId)
                |> Maybe.withDefault "0"

        year =
            Utils.stringDateToYear dateString

        month =
            Utils.stringDateToMonth dateString
    in
        "data/" ++ year ++ "/" ++ month ++ "/" ++ postId ++ ".json"


fetchPostArchive : Cmd Msg
fetchPostArchive =
    Http.get fetchPostArchiveUrl postListDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPostArchive


fetchPostArchiveUrl : String
fetchPostArchiveUrl =
    "data/archive.json?"
