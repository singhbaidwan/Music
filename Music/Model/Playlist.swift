//
//  Playlist.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import Foundation
struct Playlist:Codable{
    let description:String
    let external_urls:[String:String]
    let id:String
    let images:[APIImage]
    let name:String
    let owner:PlaylistOwner
}
