//
//  Subject.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import RealmSwift

class Subject: Object {

    @objc dynamic var title: String = ""
    @objc dynamic var teacher: String = ""
    @objc dynamic var place: String = ""
    
    var times = List<Time>()
    
    convenience init(title: String, times: [Time]) {
        self.init()
        self.title = title
        let list = List<Time>()
        times.forEach { (time) in
            list.append(time)
        }
        self.times = list
    }
    
    func getTimes() -> [Time] {
        var tims: [Time] = []
        self.times.forEach({ tims.append($0) })
        return tims
    }
}

class Time: Object {
    @objc dynamic var start: Int = 0
    @objc dynamic var end: Int = 0
    
    //Четная неделя
    @objc dynamic var parity: Int = 2
    @objc dynamic var weekday: Int = 0
    
    convenience init(start: Int, end: Int, parity: Int, weekday: Int) {
        self.init()
        self.start = start
        self.end = end
        self.parity = parity
        self.weekday = weekday
    }
    
}
