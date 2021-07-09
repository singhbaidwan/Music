//
//  UserProfile.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import Foundation
struct UserProfile:Codable{
    let country:String
    let display_name:String
    let email:String
    let explicit_content:[String:Bool]
    let external_urls:[String:String]
//    let followers:[String:Codable?]
    let id:String
    let product:String
    let images:[UserImage]
}
struct UserImage:Codable{
    let url:String
}

//{
//   country = IN;
//   "display_name" = "singh baidwan";
//   email = "dalveerbaidwan3888@gmail.com";
//   "explicit_content" =     {
//       "filter_enabled" = 0;
//       "filter_locked" = 0;
//   };
//   "external_urls" =     {
//       spotify = "https://open.spotify.com/user/qtj3r76s1c97n3tifapucq879";
//   };
//   followers =     {
//       href = "<null>";
//       total = 0;
//   };
//   href = "https://api.spotify.com/v1/users/qtj3r76s1c97n3tifapucq879";
//   id = qtj3r76s1c97n3tifapucq879;
//   images =     (
//   );
//   product = open;
//   type = user;
//   uri = "spotify:user:qtj3r76s1c97n3tifapucq879";
//}
