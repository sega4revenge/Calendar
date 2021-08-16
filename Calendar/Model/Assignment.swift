//
//  Workout.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
enum StatusAssignment: Int {
    case assigned
    case progress
    case complete
}
class Assignment: Codable {
    var id: String?
    var title: String?
    var status: Int?
    var totalExercise: Int?
   
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case status
        case totalExercise = "total_exercise"
    }
    
    var statusState: StatusAssignment {
        return StatusAssignment(rawValue: status ?? 0) ?? .assigned
    }
}

