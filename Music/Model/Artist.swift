//
//  Artist.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import Foundation
struct Artist:Codable{
    let id:String
    let name:String
    let images:[APIImage]?
    let type:String
    let external_urls:[String:String]
}
