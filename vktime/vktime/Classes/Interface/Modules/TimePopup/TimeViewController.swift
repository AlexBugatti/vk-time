//
//  TimeViewController.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import UIKit
import BottomPopup
import DropDown

class TimeViewController: BottomPopupViewController {

    var didSaveTapped: ((Time) -> Void)?
    var time: Time?
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var weekdayField: UITextField!
    @IBOutlet weak var beginPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!
    
    override var popupHeight: CGFloat {
        return 500
    }
    
    init(time: Time? = nil) {
        self.time = time
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.saveButton.layer.cornerRadius = 10
        self.saveButton.layer.masksToBounds = true
        self.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        self.view.backgroundColor = .white
        self.beginPicker.minimumDate = Date().startOfDay
        self.beginPicker.maximumDate = Date().endOfDay
        self.beginPicker.date = Date()
        self.endPicker.minimumDate = beginPicker.date
        
        beginPicker.addTarget(self, action: #selector(onDidBeginPickerChanged), for: .valueChanged)
        
        if let time = time {
            self.beginPicker.date = Date.init(timeIntervalSince1970: TimeInterval(time.start))
            self.endPicker.date = Date.init(timeIntervalSince1970: TimeInterval(time.end))
            self.segmentView.selectedSegmentIndex = time.parity - 1
            self.weekdayField.tag = time.weekday
            let weekdays = Weekday.all
            if let weekday = weekdays.first(where: { $0.id == self.weekdayField.tag }) {
                self.weekdayField.text = weekday.title
            }
        }
        // Do any additional setup after loading the view.
    }

    @objc func onDidBeginPickerChanged() {
        self.endPicker.minimumDate = self.beginPicker.date
        self.endPicker.maximumDate = Date().endOfDay
    }
    
    func save() {
        let parity = segmentView.selectedSegmentIndex + 1
        if let time = time {
            time.start = Int(beginPicker.date.timeIntervalSince1970)
            time.end = Int(endPicker.date.timeIntervalSince1970)
            time.parity = parity
            time.weekday = weekdayField.tag
            self.didSaveTapped?(time)
        } else {
            let time = Time(start: Int(beginPicker.date.timeIntervalSince1970), end: Int(endPicker.date.timeIntervalSince1970), parity: parity, weekday: weekdayField.tag)
            self.didSaveTapped?(time)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onDidWeekdayTapped(_ sender: UIButton) {
        let dropDown = DropDown(anchorView: sender)
        let weekdays = Weekday.all
        dropDown.dataSource = weekdays.map({ $0.title })
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if let weekday = weekdays.first(where: { $0.id == (index + 1) }) {
                self.weekdayField.text = weekday.title
                self.weekdayField.tag = weekday.id
            }
            
          print("Selected item: \(item) at index: \(index)")
        }
        dropDown.show()
    }
    
    @IBAction func onDidSaveTapped(_ sender: Any) {
        if self.weekdayField.tag == 0 {
            let alert = UIAlertController(title: nil, message: "Выберите день недели", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        } else {
            save()
        }
        
    }
    

}
