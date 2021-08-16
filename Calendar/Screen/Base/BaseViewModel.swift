//
//  BaseViewModel.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import Foundation
import RxCocoa
import RxSwift

class BaseViewModel {
    let dispose = DisposeBag()
    let errorMessage = PublishRelay<String>()
}
