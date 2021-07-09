//
//  SettingsModel.swift
//  Music
//
//  Created by Dalveer singh on 09/07/21.
//

import Foundation

struct Section{
    let title:String
    let options:[Option]
}
struct Option{
    let title:String
    let handler:()->Void
}
