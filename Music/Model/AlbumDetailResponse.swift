//
//  AlbumDetailResponse.swift
//  Music
//
//  Created by Dalveer singh on 12/07/21.
//

import Foundation

struct AlbumDetailResponse:Codable{
    let album_type:String
    let artists:[Artist]
    let available_markets:[String]
    let external_urls:[String:String]
    let id:String
    let images:[APIImage]
    let label:String
    let name:String
    let tracks:TracksResponse
}

struct TracksResponse:Codable{
    let items:[AudioTrack]
}

//{
//    "album_type" = single;
//    artists =     (
//                {
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/artist/5FxD8fkQZ6KcsSYupDVoSO";
//            };
//            href = "https://api.spotify.com/v1/artists/5FxD8fkQZ6KcsSYupDVoSO";
//            id = 5FxD8fkQZ6KcsSYupDVoSO;
//            name = "Omar Apollo";
//            type = artist;
//            uri = "spotify:artist:5FxD8fkQZ6KcsSYupDVoSO";
//        }
//    );
//    "available_markets" =     (
//        AD,
//    );
//    copyrights =     (
//                {
//            text = "\U00a9 2021 Omar Apollo under exclusive license to Warner Records Inc.";
//            type = C;
//        },
//                {
//            text = "\U2117 2021 Omar Apollo under exclusive license to Warner Records Inc.";
//            type = P;
//        }
//    );
//    "external_ids" =     {
//        upc = 054391920867;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/album/1nETLIyhtk8GjuqyfOt1G7";
//    };
//    genres =     (
//    );
//    href = "https://api.spotify.com/v1/albums/1nETLIyhtk8GjuqyfOt1G7";
//    id = 1nETLIyhtk8GjuqyfOt1G7;
//    images =     (
//                {
//            height = 640;
//            url = "https://i.scdn.co/image/ab67616d0000b2733906cc71c9ba58425e035587";
//            width = 640;
//        },
//                {
//            height = 300;
//            url = "https://i.scdn.co/image/ab67616d00001e023906cc71c9ba58425e035587";
//            width = 300;
//        },
//                {
//            height = 64;
//            url = "https://i.scdn.co/image/ab67616d000048513906cc71c9ba58425e035587";
//            width = 64;
//        }
//    );
//    label = "Warner Records";
//    name = "Go Away";
//    popularity = 47;
//    "release_date" = "2021-07-08";
//    "release_date_precision" = day;
//    "total_tracks" = 1;
//    tracks =     {
//        href = "https://api.spotify.com/v1/albums/1nETLIyhtk8GjuqyfOt1G7/tracks?offset=0&limit=50";
//        items =         (
//                        {
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/5FxD8fkQZ6KcsSYupDVoSO";
//                        };
//                        href = "https://api.spotify.com/v1/artists/5FxD8fkQZ6KcsSYupDVoSO";
//                        id = 5FxD8fkQZ6KcsSYupDVoSO;
//                        name = "Omar Apollo";
//                        type = artist;
//                        uri = "spotify:artist:5FxD8fkQZ6KcsSYupDVoSO";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                );
//                "disc_number" = 1;
//                "duration_ms" = 206883;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/6BXHCHzw706smnLQdCIDUy";
//                };
//                href = "https://api.spotify.com/v1/tracks/6BXHCHzw706smnLQdCIDUy";
//                id = 6BXHCHzw706smnLQdCIDUy;
//                "is_local" = 0;
//                name = "Go Away";
//                "preview_url" = "https://p.scdn.co/mp3-preview/749fe9c95db10e43b1d1b3a0e852500f54bdc837?cid=1a28cbf77da14285bc2fdddf30cd21d1";
//                "track_number" = 1;
//                type = track;
//                uri = "spotify:track:6BXHCHzw706smnLQdCIDUy";
//            }
//        );
//        limit = 50;
//        next = "<null>";
//        offset = 0;
//        previous = "<null>";
//        total = 1;
//    };
//    type = album;
//    uri = "spotify:album:1nETLIyhtk8GjuqyfOt1G7";
//}
