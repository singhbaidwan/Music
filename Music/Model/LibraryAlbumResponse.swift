//
//  AlbumPlaylistResponse.swift
//  Music
//
//  Created by Dalveer singh on 19/07/21.
//

import Foundation
struct LibraryAlbumResponse:Codable{
    let items:[SavedAlbum]
}
struct SavedAlbum:Codable{
    let added_at:String
    let album:Album
}
