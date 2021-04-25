//
//  SubjectViewController.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class SubjectViewController: UIViewController {

    var subject: Subject?
    var times: [Time] = []
    
    @IBOutlet weak var subjectTitleField: UITextField!
    @IBOutlet weak var teacherTitleField: UITextField!
    @IBOutlet weak var placeTitleField: UITextField!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    @IBOutlet weak var addTimeButton: UIButton! {
        didSet {
            self.addTimeButton.layer.cornerRadius = self.addTimeButton.frame.width / 2
            self.addTimeButton.layer.masksToBounds = true
        }
    }
    
    init(subject: Subject? = nil) {
        self.subject = subject
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let saveBarItem = UIBarButtonItem.init(title: "Сохранить", style: .plain, target: self, action: #selector(onDidSaveTapped))
        self.navigationItem.setRightBarButton(saveBarItem, animated: true)
        
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        if let subject = self.subject {
            self.subjectTitleField.text = subject.title
            self.teacherTitleField.text = subject.teacher
            self.placeTitleField.text = subject.place
            var tims: [Time] = []
            subject.times.forEach { (time) in
                tims.append(time)
            }
            self.times = tims
        }
    }
    
    @objc func onDidSaveTapped() {
        createSubject()
    }
    
    func createSubject() {
        guard let title = subjectTitleField.text, title.isEmpty == false else {
            
            let alert = UIAlertController(title: nil, message: "Данные не корректно заполнены", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        DatabaseService.shared.addSubject(title: title, teacher: teacherTitleField.text, place: placeTitleField.text, times: times)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func onDidAddTime(_ sender: Any) {
        
        let timePopup = TimeViewController()
        timePopup.didSaveTapped = { time in
            self.times.append(time)
            self.tableView?.reloadData()
            timePopup.dismiss(animated: true, completion: nil)
        }
        self.present(timePopup, animated: true, completion: nil)
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

extension SubjectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let subject = self.subject {
            return subject.times.count
        } else {
            return self.times.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let time = self.times[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let weekdays = Weekday.all
        let weekday = weekdays.first(where: { $0.id == time.weekday })?.title ?? ""
        let even = time.parity == 2 ? "Четная" : "Нечетная"
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "hh:mm"
        cell.textLabel?.text = "\(weekday), \(even), \(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(time.start))))-\(formatter.string(from: Date(timeIntervalSince1970: TimeInterval(time.end))))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let time = self.times[indexPath.row]
        let timePopup = TimeViewController(time: time)
        timePopup.didSaveTapped = { time in
            self.times.append(time)
            self.tableView?.reloadData()
        }
        self.present(timePopup, animated: true, completion: nil)
    }

}
