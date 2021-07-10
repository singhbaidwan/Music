//
//  RecommendationReponse.swift
//  Music
//
//  Created by Dalveer singh on 11/07/21.
//

import Foundation

struct RecommendationReponse:Codable{
    let tracks:[AudioTrack]
}





//{
//
//    tracks =     (
//                {
//            album =             {
//                "album_type" = ALBUM;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/5Mhs3Eu8lU6sRCtRYsmABV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/5Mhs3Eu8lU6sRCtRYsmABV";
//                        id = 5Mhs3Eu8lU6sRCtRYsmABV;
//                        name = "Black Flag";
//                        type = artist;
//                        uri = "spotify:artist:5Mhs3Eu8lU6sRCtRYsmABV";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/36bEg6FTBaZGLg9ngJZIU6";
//                };
//                href = "https://api.spotify.com/v1/albums/36bEg6FTBaZGLg9ngJZIU6";
//                id = 36bEg6FTBaZGLg9ngJZIU6;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b27367a1610b21721a06ed7d378e";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e0267a1610b21721a06ed7d378e";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d0000485167a1610b21721a06ed7d378e";
//                        width = 64;
//                    }
//                );
//                name = "The Phantom Of The Opera";
//                "release_date" = "1987-01-01";
//                "release_date_precision" = day;
//                "total_tracks" = 21;
//                type = album;
//                uri = "spotify:album:36bEg6FTBaZGLg9ngJZIU6";
//            };
//            artists =             (
//                                {
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/artist/4aP1lp10BRYZO658B2NwkG";
//                    };
//                    href = "https://api.spotify.com/v1/artists/4aP1lp10BRYZO658B2NwkG";
//                    id = 4aP1lp10BRYZO658B2NwkG;
//                    name = "Andrew Lloyd Webber";
//                    type = artist;
//                    uri = "spotify:artist:4aP1lp10BRYZO658B2NwkG";
//                },
//                                {
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/artist/3LfD2yRlfHAtTryX8rFp25";
//                    };
//                    href = "https://api.spotify.com/v1/artists/3LfD2yRlfHAtTryX8rFp25";
//                    id = 3LfD2yRlfHAtTryX8rFp25;
//                    name = "Phantom Of The Opera Original London Cast";
//                    type = artist;
//                    uri = "spotify:artist:3LfD2yRlfHAtTryX8rFp25";
//                },
//                                {
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/artist/3Oju6zkuJzum4svKeVhKiK";
//                    };
//                    href = "https://api.spotify.com/v1/artists/3Oju6zkuJzum4svKeVhKiK";
//                    id = 3Oju6zkuJzum4svKeVhKiK;
//                    name = "Rosemary Ashe";
//                    type = artist;
//                    uri = "spotify:artist:3Oju6zkuJzum4svKeVhKiK";
//                }
//            );
//            "available_markets" =             (
//                AD,
//                AE
//            );
//            "disc_number" = 1;
//            "duration_ms" = 186493;
//            explicit = 0;
//            "external_ids" =             {
//                isrc = GBALG8700012;
//            };
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/track/50yxhOQupboMoF1xgzLza3";
//            };
//            href = "https://api.spotify.com/v1/tracks/50yxhOQupboMoF1xgzLza3";
//            id = 50yxhOQupboMoF1xgzLza3;
//            "is_local" = 0;
//            name = "Poor Fool, He Makes Me Laugh";
//            popularity = 31;
//            "preview_url" = "<null>";
//            "track_number" = 11;
//            type = track;
//            uri = "spotify:track:50yxhOQupboMoF1xgzLza3";
//        }
//    );
//}
