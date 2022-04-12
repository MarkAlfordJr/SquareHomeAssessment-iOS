//
//  ViewController.swift
//  SquareTakeHome
//
//  Created by Mark Alford on 4/5/22.
//

import UIKit

class ViewController: UIViewController{
    // add in refreshControl class
    private let refreshControl = UIRefreshControl()
    var networkObject: ApiManager = .sharedInstance
    
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.reuseID)
        tableview.rowHeight = UITableView.automaticDimension
        return tableview
    }()
    // good Ol'data array
        // will be filled with JSON responses
    var dataArray: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        
        view.backgroundColor = .systemGray3
        view.addSubview(tableView)
        title = "Employees"
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        let dispatchGroup = DispatchGroup()
    
        dispatchGroup.enter()
        networkObject.getRequest(endpoint: EmployeeApi.getEmployees(description: "")) { (result: Result<EmployeeModel, Error>) in
            switch result {
            case .success(let response):
                // working with the JSON
                self.dataArray = response.employees
            case .failure(let error):
                print(error)
            }
            dispatchGroup.leave()
        }
        
        /// `Notify Main thread`
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Refresh Functionality
    @objc func pullToRefresh() {
        // removes data, and reloads tabeView, so info can show again
        dataArray.removeAll()
        tableView.reloadData()
        // calls API again for refresh
        networkObject.getRequest(endpoint: EmployeeApi.getEmployees(description: "")) { (result: Result<EmployeeModel, Error>) in
            switch result {
            case .success(let response):
                // working with the JSON
                self.dataArray = response.employees
                // waits 3 seconds to perform code
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.tableView.refreshControl?.endRefreshing()
                    self.refreshControl.isHidden = true
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.reuseID, for: indexPath) as! EmployeeTableViewCell
        // get inpexPath of dat array
        let cellData = dataArray[indexPath.row]
        // fill in data for cell UI properties
        cell.setupImage(url: cellData.photoURLSmall)
        cell.configureCell(phoneNumber: cellData.phoneNumber, email: cellData.emailAddress, teamName: cellData.team, fullName: cellData.fullName, summary: cellData.biography)
        return cell
    }
    
}
