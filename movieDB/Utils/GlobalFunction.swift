//
//  GlobalFunction.swift
//  movieDB
//
//  Created by Muhammad Fahmi on 20/10/22.
//

import Foundation
import UIKit

extension UIViewController {
    func utcToLocal(_ dateStr: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertDate = dateFormat.date(from: dateStr)
        
        let dateFormatNew = DateFormatter()
        dateFormatNew.timeZone = TimeZone(identifier: "Asia/Jakarta")
        dateFormatNew.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localeDate = dateFormatNew.string(from: convertDate!)
        return localeDate
    }
    
    func substring(_ str:String,_ startIndex:Int,_ endIndex:Int, _ type:String) -> String {
        if type == "getDate" {
            return String(str[startIndex..<endIndex])
        }else{
            return str
        }
    }
    
    func customDate(_ minute:Double, _ formatDate:String) -> Date {
        let date = Date().addingTimeInterval(minute * 60)
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateformat.string(from: date)
        let dateConvert = dateformat.string(from: date)
        return dateformat.date(from: dateConvert)!
    }
    
    func customDateString(_ minute:Double, _ formatDate:String) -> String {
        let date = Date().addingTimeInterval(minute * 60)
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = formatDate
        return dateFormat.string(from: date)
    }
    
    func createAlert(_ title:String,_ message:String) -> Void {
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
}


extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
