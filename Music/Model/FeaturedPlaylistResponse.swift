//
//  FeaturedPlaylistResponse.swift
//  Music
//
//  Created by Dalveer singh on 10/07/21.
//

import Foundation

struct FeaturedPlaylistResponse:Codable{
    let playlists:PlaylistResponse
}
struct PlaylistResponse:Codable{
    let items:[Playlist]
}


struct PlaylistOwner:Codable{
    let display_name:String
    let external_urls:[String:String]
    let id:String
}

//{
//    message = "Pilihan Editor";
//    playlists =     {
//        href = "https://api.spotify.com/v1/browse/featured-playlists?timestamp=2021-07-10T18%3A09%3A11&offset=0&limit=2";
//        items =         (
//                        {
//                collaborative = 0;
//                description = "Let your worries and cares slip away...";
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/playlist/37i9dQZF1DWU0ScTcjJBdj";
//                };
//                href = "https://api.spotify.com/v1/playlists/37i9dQZF1DWU0ScTcjJBdj";
//                id = 37i9dQZF1DWU0ScTcjJBdj;
//                images =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://i.scdn.co/image/ab67706f000000031932c7ea794e72d82b10692c";
//                        width = "<null>";
//                    }
//                );
//                name = "Relax & Unwind";
//                owner =                 {
//                    "display_name" = Spotify;
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/user/spotify";
//                    };
//                    href = "https://api.spotify.com/v1/users/spotify";
//                    id = spotify;
//                    type = user;
//                    uri = "spotify:user:spotify";
//                };
//                "primary_color" = "<null>";
//                public = "<null>";
//                "snapshot_id" = MTYyNDg5NDI3MywwMDAwMDA3NDAwMDAwMTdhNTMzZWY5NDgwMDAwMDE3MzQ5YzY0NGU3;
//                tracks =                 {
//                    href = "https://api.spotify.com/v1/playlists/37i9dQZF1DWU0ScTcjJBdj/tracks";
//                    total = 105;
//                };
//                type = playlist;
//                uri = "spotify:playlist:37i9dQZF1DWU0ScTcjJBdj";
//            },
//                        {
//                collaborative = 0;
//                description = "Welcome the weekend with these happy hits.";
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/playlist/37i9dQZF1DWTwbZHrJRIgD";
//                };
//                href = "https://api.spotify.com/v1/playlists/37i9dQZF1DWTwbZHrJRIgD";
//                id = 37i9dQZF1DWTwbZHrJRIgD;
//                images =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://i.scdn.co/image/ab67706f00000003fa91482f7acfc15e9194fdad";
//                        width = "<null>";
//                    }
//                );
//                name = "Happy Weekend";
//                owner =                 {
//                    "display_name" = Spotify;
//                    "external_urls" =                     {
//                        spotify = "https://open.spotify.com/user/spotify";
//                    };
//                    href = "https://api.spotify.com/v1/users/spotify";
//                    id = spotify;
//                    type = user;
//                    uri = "spotify:user:spotify";
//                };
//                "primary_color" = "<null>";
//                public = "<null>";
//                "snapshot_id" = MTYyNDM0NzM4MCwwMDAwMDAyNTAwMDAwMTdhMzJhNjA5NmUwMDAwMDE3OWFkNGY1ZjYy;
//                tracks =                 {
//                    href = "https://api.spotify.com/v1/playlists/37i9dQZF1DWTwbZHrJRIgD/tracks";
//                    total = 50;
//                };
//                type = playlist;
//                uri = "spotify:playlist:37i9dQZF1DWTwbZHrJRIgD";
//            }
//        );
//        limit = 2;
//        next = "https://api.spotify.com/v1/browse/featured-playlists?timestamp=2021-07-10T18%3A09%3A11&offset=2&limit=2";
//        offset = 0;
//        previous = "<null>";
//        total = 11;
//    };
//}
