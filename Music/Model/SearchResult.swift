//
//  SearchResult.swift
//  Music
//
//  Created by Dalveer singh on 14/07/21.
//

import Foundation
enum SearchResult{
    case artist(model:Artist)
    case album(model:Album)
    case track(model:AudioTrack)
    case playlist(model:Playlist)
}
