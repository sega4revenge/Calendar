//
//  DayTableCell.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import UIKit
protocol DayTableCellDelegate: AnyObject {
    func didTapAssigment(assigmentId: String, dateWork: DateWork)
}
class DayTableCell: UITableViewCell {
    @IBOutlet weak var tableView: SelfResizeTableView!
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var dayNumberLabel: UILabel!
    var date: DateWork?
    var selectedAssigment: [String] = []
    weak var delegate: DayTableCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        configTableView()
    }

    func configDate(date: DateWork, selectedAssigment: [String]) {
        self.date = date
        self.selectedAssigment = selectedAssigment
        dayNameLabel.text = date.name
        dayNumberLabel.text = date.number?.string
        switch date.statusDate {
        case .today:
            dayNameLabel.textColor = UIColor.color7470EF
            dayNumberLabel.textColor = UIColor.color7470EF
        default:
            dayNameLabel.textColor = UIColor.color7B7E91
            dayNumberLabel.textColor = UIColor.color1E0A3C
        }
        tableView.reloadData()
    }
    
    func configTableView() {
        tableView.register(nibWithCellClass: EventTableCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                     bottom: 0,
                                                     right: 0)
        tableView.estimatedRowHeight = 86.5
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DayTableCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date?.assignments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: EventTableCell.self, for: indexPath)
        if let date = date, let assignmentId = date.assignments[indexPath.row].id {
            let selected = selectedAssigment.contains(assignmentId)
            cell.configCell(assignment: date.assignments[indexPath.row], statusDate: date.statusDate, selected: selected)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let date = date, let assignmentId = date.assignments[indexPath.row].id {
            delegate?.didTapAssigment(assigmentId: assignmentId, dateWork: date)
        }
    }
}
