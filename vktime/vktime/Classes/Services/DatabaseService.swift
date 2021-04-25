//
//  DatabaseService.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import RealmSwift

struct Weekday {
    var title: String
    var id: Int
    
    static var all: [Weekday] {
        let monday = Weekday.init(title: "Понедельник", id: 2)
        let tuesday = Weekday.init(title: "Вторник", id: 3)
        let wednesday = Weekday.init(title: "Среда", id: 4)
        let thursday = Weekday.init(title: "Четверг", id: 5)
        let friday = Weekday.init(title: "Пятница", id: 6)
        let saturday = Weekday.init(title: "Суббота", id: 7)
        let sunday = Weekday.init(title: "Воскресение", id: 1)

        return [sunday, monday, tuesday, wednesday, thursday, friday, saturday]
    }
}

class DatabaseService {

    static let shared = DatabaseService()
    let localRealm = try! Realm()
    
    func getSubjects() -> [Subject] {
        var subs: [Subject] = []
        let subjects = localRealm.objects(Subject.self)
        subjects.forEach({ subs.append($0) })
        return subs
    }
    
    func getSubjects(date: Date) -> [Subject] {
        let subjects = self.getSubjects().filter { (subject) -> Bool in
            if subject.getTimes().filter({ $0.weekday == date.weekday }).count > 0 {
                return true
            }
            return false
        }
        return subjects
    }
    
    func addSubject(title: String, teacher: String? = nil, place: String? = nil, times: [Time]) {
        let subject = Subject(title: title, times: times)
        subject.place = place ?? ""
        subject.teacher = teacher ?? ""
        try! localRealm.write {
            localRealm.add(subject)
        }
    }
    
}
