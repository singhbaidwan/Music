//
//  NewReleasesResponse.swift
//  Music
//
//  Created by Dalveer singh on 10/07/21.
//

import Foundation

struct NewReleasesResponse:Codable{
    let albums:AlbumsResponse
}
struct AlbumsResponse:Codable{
    let items:[Album]
}
struct Album:Codable{
    let album_type:String
    let artists:[Artist]
    let available_markets:[String]
    let id:String
    let images:[APIImage]
    let name:String
    let release_date:String
    let total_tracks:Int
}



//albums =     {
//    href = "https://api.spotify.com/v1/browse/new-releases?offset=0&limit=2";
//    items =         (
//                    {
//            "album_type" = single;
//            artists =                 (
//                                    {
//                    "external_urls" =                         {
//                        spotify = "https://open.spotify.com/artist/5FxD8fkQZ6KcsSYupDVoSO";
//                    };
//                    href = "https://api.spotify.com/v1/artists/5FxD8fkQZ6KcsSYupDVoSO";
//                    id = 5FxD8fkQZ6KcsSYupDVoSO;
//                    name = "Omar Apollo";
//                    type = artist;
//                    uri = "spotify:artist:5FxD8fkQZ6KcsSYupDVoSO";
//                }
//            );
//            "available_markets" =                 (
//                AD,
//                AE,
//                AG,
//                AL,
//            );
//            "external_urls" =                 {
//                spotify = "https://open.spotify.com/album/1nETLIyhtk8GjuqyfOt1G7";
//            };
//            href = "https://api.spotify.com/v1/albums/1nETLIyhtk8GjuqyfOt1G7";
//            id = 1nETLIyhtk8GjuqyfOt1G7;
//            images =                 (
//                                    {
//                    height = 640;
//                    url = "https://i.scdn.co/image/ab67616d0000b2733906cc71c9ba58425e035587";
//                    width = 640;
//                },
//                                    {
//                    height = 300;
//                    url = "https://i.scdn.co/image/ab67616d00001e023906cc71c9ba58425e035587";
//                    width = 300;
//                },
//                                    {
//                    height = 64;
//                    url = "https://i.scdn.co/image/ab67616d000048513906cc71c9ba58425e035587";
//                    width = 64;
//                }
//            );
//            name = "Go Away";
//            "release_date" = "2021-07-08";
//            "release_date_precision" = day;
//            "total_tracks" = 1;
//            type = album;
//            uri = "spotify:album:1nETLIyhtk8GjuqyfOt1G7";
//        },
//
//};
//}
