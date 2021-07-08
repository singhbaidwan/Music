//
//  AuthResponse.swift
//  Music
//
//  Created by Dalveer singh on 09/07/21.
//

import Foundation
struct AuthResponse : Codable{
    let access_token:String
    let expires_in:Int
    let refresh_token:String?
    let scope:String
    let token_type:String
}
