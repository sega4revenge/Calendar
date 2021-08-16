//
//  BaseViewController.swift
//  FestFive
//
//  Created by Techchain on 25/02/2021.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import IQKeyboardManagerSwift

class BaseViewController: UIViewController {
    typealias Completion = () -> Void
    let dispose = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        let description = String(describing: self)
        dump("Init: \(description)")
    }
    
    deinit {
        let description = String(describing: self)
        print("Deinit: \(description)")
    }
}
