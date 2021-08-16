//
//  HomeViewController.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: SelfResizeTableView!
    var viewModel = HomeViewModel(currentDate: Date())
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewIsReady.accept(())
        configTableView()
        
        viewModel.errorMessage .subscribe(
            onNext: { [unowned self] error in
                refreshControl.endRefreshing()
                showAlert(title: "Error", message: error)
            }).disposed(by: dispose)
        
        viewModel.listDatesOfWeek
            .subscribe(
                onNext: { [unowned self] list in
                    refreshControl.endRefreshing()
                    tableView.reloadData()
                }).disposed(by: dispose)
        
        viewModel.updateDateIndex
            .subscribe(
                onNext: { [unowned self] index in
                    UIView.performWithoutAnimation({
                            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
                        })
                }).disposed(by: dispose)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: viewModel.getWorkoutsTrigger)
            .disposed(by: dispose)
        
    }
    
    func configTableView() {
        tableView.register(nibWithCellClass: DayTableCell.self)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                     bottom: 0,
                                                     right: 0)
        tableView.refreshControl = refreshControl
        tableView.estimatedRowHeight = 111
    }
    
    @objc func reloadData() {
        viewModel.getWorkouts()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listDatesOfWeek.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: DayTableCell.self, for: indexPath)
        let date = viewModel.listDatesOfWeek.value[indexPath.row]
        cell.configDate(date: date, selectedAssigment: viewModel.listAssignmentSelected.value)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let date = viewModel.listDatesOfWeek.value[indexPath.row]
        if date.assignments.count <= 1 {
            return 111
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension HomeViewController: DayTableCellDelegate {
    func didTapAssigment(assigmentId: String, dateWork: DateWork) {
        viewModel.selectAssigment(assigmentId: assigmentId, dateWork: dateWork)
    }
}
