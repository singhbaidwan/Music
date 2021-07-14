//
//  SearchResultResponse.swift
//  Music
//
//  Created by Dalveer singh on 14/07/21.
//

import Foundation
struct SearchResultResponse:Codable{
    let albums:SearchResultAlbumResponse
    let artists:SearchResultArtistsResponse
    let playlists:SearchResultPlaylistsResponse
    let tracks:SearchResultTracksResponse
}
struct SearchResultAlbumResponse:Codable{
    let items:[Album]
}
struct SearchResultArtistsResponse:Codable{
    let items:[Artist]
}
struct SearchResultPlaylistsResponse:Codable{
    let items:[Playlist]
}
struct SearchResultTracksResponse:Codable{
    let items:[AudioTrack]
}
//{
//    albums =     {
//        href = "https://api.spotify.com/v1/search?query=Sidhu+moosewala&type=album&offset=0&limit=3";
//        items =         (
//                        {
//                "album_type" = album;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/4PULA4EFzYTrxYvOVlwpiQ";
//                        };
//                        href = "https://api.spotify.com/v1/artists/4PULA4EFzYTrxYvOVlwpiQ";
//                        id = 4PULA4EFzYTrxYvOVlwpiQ;
//                        name = "Sidhu Moose Wala";
//                        type = artist;
//                        uri = "spotify:artist:4PULA4EFzYTrxYvOVlwpiQ";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//
//    tracks =     {
//        href = "https://api.spotify.com/v1/search?query=Sidhu+moosewala&type=track&offset=0&limit=3";
//        items =         (
//                        {
//                album =                 {
//                    "album_type" = album;
//                    artists =                     (
//                                                {
//                            "external_urls" =                             {
//                                spotify = "https://open.spotify.com/artist/4PULA4EFzYTrxYvOVlwpiQ";
//                            };
//                            href = "https://api.spotify.com/v1/artists/4PULA4EFzYTrxYvOVlwpiQ";
//                            id = 4PULA4EFzYTrxYvOVlwpiQ;
//                            name = "Sidhu Moose Wala";
//                            type = artist;
//                            uri = "spotify:artist:4PULA4EFzYTrxYvOVlwpiQ";
//                        }
//                    );
//                    "available_markets" =                     (
//                        AD,
//                        AE,

//                    );
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/album/45ZIondgVoMB84MQQaUo9T";
//                    };
//                    href = "https://api.spotify.com/v1/albums/45ZIondgVoMB84MQQaUo9T";
//                    id = 45ZIondgVoMB84MQQaUo9T;
//                    images =                     (
//                                                {
//                            height = 640;
//                            url = "https://i.scdn.co/image/ab67616d0000b2731d1cc2e40d533d7bcebf5dae";
//                            width = 640;
//                        },
//                                                {
//                            height = 300;
//                            url = "https://i.scdn.co/image/ab67616d00001e021d1cc2e40d533d7bcebf5dae";
//                            width = 300;
//                        },
//                                                {
//                            height = 64;
//                            url = "https://i.scdn.co/image/ab67616d000048511d1cc2e40d533d7bcebf5dae";
//                            width = 64;
//                        }
//                    );
//                    name = Moosetape;
//                    "release_date" = "2021-05-15";
//                    "release_date_precision" = day;
//                    "total_tracks" = 32;
//                    type = album;
//                    uri = "spotify:album:45ZIondgVoMB84MQQaUo9T";
//                };
//
//    };
//}
