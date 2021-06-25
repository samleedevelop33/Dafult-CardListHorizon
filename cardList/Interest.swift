//
//  Interest.swift
//  cardList
//
//  Created by sam on 2021/01/10.
//

import UIKit

class Interest {
    var title = ""
    var color: UIColor
    
    init(title: String, color: UIColor){
        self.title = title
        self.color = color
    }
    
    
    static func fatchInterests() -> [Interest]{
        return [
            Interest(title: "11", color: .systemPink),
            Interest(title: "22", color: .red),
            Interest(title: "33", color: .systemYellow),
            Interest(title: "44", color: .systemBlue),
            Interest(title: "55", color: .systemGray),
            Interest(title: "66", color: .systemGreen)
        ]
    }
}
