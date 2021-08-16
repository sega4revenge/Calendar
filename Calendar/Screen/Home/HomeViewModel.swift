//
//  HomeViewModel.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import UIKit
import RxCocoa

class HomeViewModel: BaseViewModel {
    var currentDate: Date
    init(currentDate: Date) {
        self.currentDate = currentDate
        listDatesOfWeek = BehaviorRelay<[DateWork]>(value: currentDate.getAllDaysOfTheCurrentWeek())
    }
    let listDatesOfWeek: BehaviorRelay<[DateWork]>
    let listAssignmentSelected = BehaviorRelay<[String]>(value: [])
    
    let updateDateIndex = PublishRelay<Int>()
    
    private let calendarService = CalendarService()
    
    func getWorkouts() {
        calendarService.getWorkouts() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.errorMessage.accept(error.localizedDescription)
            case .success(let workouts):
                let listDates: [DateWork] = self.listDatesOfWeek.value.compactMap({ date in
                    let dateOfWorkout = workouts.first(where: {$0.day == date.day})
                    date.id = dateOfWorkout?.id
                    date.assignments = dateOfWorkout?.assignments ?? []
                    return date
                })
                self.listDatesOfWeek.accept(listDates)
            }
        }
    }
    
    func selectAssigment(assigmentId: String, dateWork: DateWork) {
        var listAssigment = listAssignmentSelected.value
        if listAssigment.contains(assigmentId) {
            listAssigment.removeAll(assigmentId)
        } else {
            listAssigment.append(assigmentId)
        }
        listAssignmentSelected.accept(listAssigment)
        guard let index = listDatesOfWeek.value.firstIndex(where: {$0.id == dateWork.id}) else { return }
        updateDateIndex.accept(index)
    }
}
