//
//  SubjectCell.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class SubjectCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        // Initialization code
    }

    func configure(subject: Subject) {
        self.titleLabel.text = subject.title
        
        teacherLabel.text = subject.teacher
        teacherLabel.isHidden = subject.teacher.isEmpty
        
        placeLabel.text = subject.place
        placeLabel.isHidden = subject.place.isEmpty
        
        timeLabel.isHidden = subject.getTimes().count == 0
        
        var strings: [String] = []
        for time in subject.getTimes() {
            let weekdays = Weekday.all
            let weekday = weekdays.first(where: { $0.id == time.weekday })?.title ?? ""
            let even = time.parity == 2 ? "Четная" : "Нечетная"
            
            let formatter = DateFormatter.init()
            formatter.dateFormat = "hh:mm"
            let text = "\(weekday), \(even), \(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(time.start))))-\(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(time.end))))\n"
            strings.append(text)
        }
        timeLabel.text = strings.joined(separator: ";")
        
    }
    
}
