//
//  DateWork.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
import UIKit
enum StatusDate {
    case past
    case today
    case future
}
class DateWork: Codable {
    var id: String?
    var assignments: [Assignment] = []
    var day: Int?
    var name: String?
    var number: Int?
    var date: Date?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case assignments
        case day
    }
    
    var statusDate: StatusDate {
        if let date = date {
            if date.isInToday {
                return .today
            } else if date.isInPast {
                return .past
            } else {
                return .future
            }
        } else {
            return .past
        }
    }
}

extension Date {
    func getAllDaysOfTheCurrentWeek(selectDate: Date = Date()) -> [DateWork] {
        var dates: [DateWork] = []
        
        guard let dateInterval = Calendar.current.dateInterval(of: .weekOfYear,
                                                               for: selectDate) else {
            return dates
        }
        Calendar.current.enumerateDates(startingAfter: dateInterval.start,
                                        matching: DateComponents(hour:0),
                                        matchingPolicy: .nextTime) { date, _, stop in
                guard let date = date else {
                    return
                }
                if date <= dateInterval.end {
                    let dateWork = DateWork()
                    dateWork.number = date.day
                    dateWork.name = date.dayName(ofStyle: .threeLetters)
                    dateWork.day = date.weekday
                    dateWork.date = date
                    dates.append(dateWork)
                } else {
                    stop = true
                }
        }
        
        return dates
    }
}
