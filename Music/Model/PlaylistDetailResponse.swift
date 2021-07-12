//
//  PlaylistDetailResponse.swift
//  Music
//
//  Created by Dalveer singh on 12/07/21.
//

import Foundation

struct PlaylistDetailResponse:Codable{
    let description:String
    let external_urls:[String:String]
    let id:String
    let images:[APIImage]
    let name:String
    let tracks:PlaylistTracksResponse
}

struct PlaylistTracksResponse:Codable{
    let items:[PlaylistItem]
}

struct PlaylistItem:Codable{
    let track:AudioTrack
}
//{
//    collaborative = 0;
//    description = "The world's biggest dance hits. Featuring new music from Peggy Gou, Icona Pop, VIZE & more!";
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/playlist/37i9dQZF1DX4dyzvuaRJ0n";
//    };
//    followers =     {
//        href = "<null>";
//        total = 5844374;
//    };
//    href = "https://api.spotify.com/v1/playlists/37i9dQZF1DX4dyzvuaRJ0n";
//    id = 37i9dQZF1DX4dyzvuaRJ0n;
//    images =     (
//                {
//            height = "<null>";
//            url = "https://i.scdn.co/image/ab67706f00000003ca322cfa99b801e5c9d3dd38";
//            width = "<null>";
//        }
//    );
//    name = mint;
//    owner =     {
//        "display_name" = Spotify;
//        "external_urls" =         {
//            spotify = "https://open.spotify.com/user/spotify";
//        };
//        href = "https://api.spotify.com/v1/users/spotify";
//        id = spotify;
//        type = user;
//        uri = "spotify:user:spotify";
//    };
//    "primary_color" = "#ffffff";
//    public = 1;
//    "snapshot_id" = MTYyNTk1OTA1NywwMDAwMDQ5YjAwMDAwMTdhOTJiNjQ5YTYwMDAwMDE3YTkyYjVlZDgx;
//    tracks =     {
//        href = "https://api.spotify.com/v1/playlists/37i9dQZF1DX4dyzvuaRJ0n/tracks?offset=0&limit=100";
//        items =
//{
//               "added_at": "2014-09-01T04:21:28Z",
//               "added_by": {
//                   "external_urls": {
//                       "spotify": "http://open.spotify.com/user/spotify"
//                   },
//                   "href": "https://api.spotify.com/v1/users/spotify",
//                   "id": "spotify",
//                   "type": "user",
//                   "uri": "spotify:user:spotify"
//               },
//               "is_local": false,
//               "track": {
//                   "album": {
//                       "album_type": "single",
//                       "available_markets": [
//                           "AD",
//                           "AR",
//                           "AT",
//                           "AU",
//                           "BE",
//                           "BG",
//                           "BO",
//                           "BR",
//                           "CH",
//                           "CL",
//                           "CO",
//                           "CR",
//                           "CY",
//                           "CZ",
//                           "DK",
//                           "DO",
//                           "EC",
//                           "EE",
//                           "ES",
//                           "FI",
//                           "FR",
//                           "GB",
//                           "GR",
//                           "GT",
//                           "HK",
//                           "HN",
//                           "HU",
//                           "IE",
//                           "IS",
//                           "IT",
//                           "LI",
//                           "LT",
//                           "LU",
//                           "LV",
//                           "MC",
//                           "MT",
//                           "MY",
//                           "NI",
//                           "NL",
//                           "NO",
//                           "NZ",
//                           "PA",
//                           "PE",
//                           "PH",
//                           "PL",
//                           "PT",
//                           "PY",
//                           "RO",
//                           "SE",
//                           "SG",
//                           "SI",
//                           "SK",
//                           "SV",
//                           "TR",
//                           "TW",
//                           "UY"
//                       ],
//                       "external_urls": {
//                           "spotify": "https://open.spotify.com/album/5GWoXPsTQylMuaZ84PC563"
//                       },
//                       "href": "https://api.spotify.com/v1/albums/5GWoXPsTQylMuaZ84PC563",
//                       "id": "5GWoXPsTQylMuaZ84PC563",
//                       "images": [
//                           {
//                               "height": 640,
//                               "url": "https://i.scdn.co/image/47421900e7534789603de84c03a40a826c058e45",
//                               "width": 640
//                           },
//                           {
//                               "height": 300,
//                               "url": "https://i.scdn.co/image/0d447b6faae870f890dc5780cc58d9afdbc36a1d",
//                               "width": 300
//                           },
//                           {
//                               "height": 64,
//                               "url": "https://i.scdn.co/image/d926b3e5f435ef3ac0874b1ff1571cf675b3ef3b",
//                               "width": 64
//                           }
//                       ],
//                       "name": "I''m Not The Only One",
//                       "type": "album",
//                       "uri": "spotify:album:5GWoXPsTQylMuaZ84PC563"
//                   }
