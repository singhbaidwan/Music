//
//  Extensions.swift
//  Music
//
//  Created by Dalveer singh on 08/07/21.
//

import Foundation
import UIKit

extension UIView{
    var width:CGFloat{
        return frame.size.width
    }
    var height:CGFloat{
        return frame.size.height
    }
    var left:CGFloat{
        return frame.origin.x
    }
    var right:CGFloat{
        return left+width
    }
    var top:CGFloat{
        return frame.origin.y
    }
    var bottom:CGFloat{
        return top+height
    }
}
extension DateFormatter{
    static let dateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }()
    static let displayDateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

extension String{
    static func formatterDate(string:String)->String {
        guard  let date = DateFormatter.dateFormatter.date(from: string) else{
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}

// created notification for user album view contoller to show update ui when the albums gets updates
extension Notification.Name{
    static let albumSaveNotification = Notification.Name("albumSaveNotification")
}
