//
//  Album.swift
//  Music
//
//  Created by Dalveer singh on 14/07/21.
//

import Foundation
struct Album:Codable{
    let album_type:String
    let artists:[Artist]
    let available_markets:[String]
    let id:String
    var images:[APIImage]
    let name:String
    let release_date:String
    let total_tracks:Int
}
