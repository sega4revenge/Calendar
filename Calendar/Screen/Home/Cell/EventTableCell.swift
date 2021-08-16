//
//  EventTableCell.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import UIKit

class EventTableCell: UITableViewCell {
    @IBOutlet weak var backgroundContent: UIView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var exerciseLabel: UILabel!
    @IBOutlet weak var completedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }
    
    func configCell(assignment: Assignment, statusDate: StatusDate, selected: Bool) {
        activityName.text = assignment.title
        if let totalExercise = assignment.totalExercise {
            exerciseLabel.text = totalExercise == 0 ? "" : "\(totalExercise) exercise\(totalExercise != 1 ? "" : "s")"
        } else {
            exerciseLabel.text = ""
        }
        
        switch statusDate {
        case .past:
            switch assignment.statusState {
            case .assigned:
                statusLabel.text = "Missed"
                statusLabel.textColor = .colorFF5E5E
                statusLabel.isHidden = false
                dotView.isHidden = false
            case .complete:
                statusLabel.text = "Completed"
                statusLabel.isHidden = false
                statusLabel.textColor = selected ? .white : .color1E0A3C
                dotView.isHidden = false
            case .progress:
                statusLabel.text = ""
                statusLabel.isHidden = true
                dotView.isHidden = true
            }
        case .future:
            statusLabel.isHidden = true
            dotView.isHidden = true
        case .today:
            statusLabel.isHidden = true
            dotView.isHidden = true
        }
        
        if selected {
            activityName.textColor = .white
            exerciseLabel.textColor = .white
            dotView.backgroundColor = .white
        } else {
            activityName.textColor = statusDate == .future ? .color7B7E91 : .color1E0A3C
            exerciseLabel.textColor = statusDate == .future ? .color7B7E91 : .color1E0A3C
            dotView.backgroundColor = .color1E0A3C
        }
        
        completedIcon.isHidden = !selected
        
        backgroundContent.backgroundColor = selected ? .color7470EF : .colorF7F8FC
    }
}
