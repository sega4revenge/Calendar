//
//  UserDetailViewModelTests+Helper.swift
//  GithubUsersTests
//
//  Created by Thinh Le on 11/08/2021.
//

import Foundation

@testable import Calendar

extension CalendarViewModelTests {
    // MARK: - Helper
    func makeSut(date: Date) -> HomeViewModel {
        let viewModel = HomeViewModel(currentDate: date)
        return viewModel
    }
    
}
