//
//  SubjectsViewController.swift
//  vktime
//
//  Created by Александр on 25.04.2021.
//

import UIKit

class SubjectsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UINib(nibName: "SubjectCell", bundle: nil), forCellReuseIdentifier: "SubjectCell")
            self.tableView.separatorStyle = .none
        }
    }
    @IBOutlet weak var addPlusButton: UIButton!
    
    var subjects: [Subject] {
        return DatabaseService.shared.getSubjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addPlusButton.layer.cornerRadius = self.addPlusButton.frame.height / 2
        self.addPlusButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Предметы"
        self.tableView.reloadData()
    }

    // MARK: - Actions
    
    @IBAction func onDidAddSubjectTapped(_ sender: Any) {
        let subjectVC = SubjectViewController(subject: nil)
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

extension SubjectsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subject = self.subjects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell") as! SubjectCell
        cell.configure(subject: subject)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let subject = self.subjects[indexPath.row]
//        let vc = SubjectViewController(subject: subject)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
