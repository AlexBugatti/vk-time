//
//  ScheduleViewController.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import CalendarKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var dayView: DayView! {
        didSet {
            self.dayView.delegate = self
            self.dayView.dataSource = self
            self.dayView.calendar = Calendar.current
        }
    }
    @IBOutlet weak var editButton: UIButton! {
        didSet {
            self.editButton.layer.cornerRadius = self.editButton.frame.width / 2
            self.editButton.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Расписание"
        self.dayView.reloadData()
    }

    // MARK: - Actions
    
    @IBAction func onDidEditTapped(_ sender: Any) {
        let subjectVC = SubjectsViewController.init(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(subjectVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ScheduleViewController: DayViewDelegate, EventDataSource {
    
    func eventsForDate(_ date: Date) -> [EventDescriptor] {
        let subjects = DatabaseService.shared.getSubjects(date: date) // Get events (models) from the storage / API
        var events = [Event]()

        for subject in subjects {
            
            let times = subject.getTimes().filter({ $0.weekday == date.weekday })
            for time in times {
                let event = Event()
                
                let timeStart = Date(timeIntervalSince1970: TimeInterval(time.start))
                let timeEnd = Date(timeIntervalSince1970: TimeInterval(time.end))

                let startDate = date.setTime(hour: timeStart.hours, min: timeStart.minute, sec: timeStart.seconds)!
                let endDate = date.setTime(hour: timeEnd.hours, min: timeEnd.minute, sec: timeEnd.seconds)!

                event.startDate = startDate
                event.endDate = endDate
                
                let info = [subject.title, subject.teacher, subject.place]
                event.text = info.reduce("", {$0 + $1 + "\n"})
                events.append(event)
            }
            
        }
          return events
    }
    
    func dayViewDidSelectEventView(_ eventView: EventView) {
        //
    }
    
    func dayViewDidLongPressEventView(_ eventView: EventView) {
        //
    }
    
    func dayView(dayView: DayView, didTapTimelineAt date: Date) {
        //
    }
    
    func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
        //
    }
    
    func dayViewDidBeginDragging(dayView: DayView) {
        //
    }
    
    func dayViewDidTransitionCancel(dayView: DayView) {
        //
    }
    
    func dayView(dayView: DayView, willMoveTo date: Date) {
        //
    }
    
    func dayView(dayView: DayView, didMoveTo date: Date) {
        //
    }
    
    func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
        //
    }
    
}
