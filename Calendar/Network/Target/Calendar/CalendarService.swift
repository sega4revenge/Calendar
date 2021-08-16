//
//  CalendarService.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
class CalendarService {
    func getWorkouts(completion: @escaping ApiCompletion<[DateWork]>) {
        let target = CalendarTarget.getWorkouts
        
        ApiManager.shared.request(target: target, completion: completion)
    }
}
