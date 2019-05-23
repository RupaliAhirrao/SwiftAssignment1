//
//  ViewController.swift
//  Assignment
//
//  Created by test on 21/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

var tableRows = [Rows]()

struct tableData : Codable {
    var title : String?
    var rows : [Rows]?
}

struct Rows : Codable {
    var title : String?
    var description : String?
    var imageHref: String?
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    var myTableView : UITableView = UITableView()
    var navTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = refreshButton
        
        parseData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//table View delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        //cell.textLabel?.text = tableRows[indexPath.row].title
        cell.cellDetails = tableRows[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
     func parseData() {
        guard let imageUrl = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
            else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            
            guard let dataString = String(bytes: data!, encoding: String.Encoding.isoLatin1) else { return }
            print("responseString = \(dataString)")
            
            do {
                let decoder = JSONDecoder()
                let viewData = try decoder.decode(tableData.self, from: dataString.data(using: .utf8)!)
                print("title: ", viewData.title!)
                if let navigationTitle = viewData.title {
                    self.navTitle = navigationTitle
                }else {
                    self.navTitle = ""
                }
                
                tableRows.removeAll() // remove all objects from table array before appending new values
                
                for row in viewData.rows!{
                    
                    let values = Rows(title: row.title,  description:row.description, imageHref: row.imageHref)
                    tableRows.append(values)
                }
                
                DispatchQueue.main.async {
                    self.createTableView()
                    self.myTableView.reloadData()
                }

            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    func createTableView () {
        
        self.navigationItem.title = self.navTitle
        
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        myTableView.frame.size = CGSize(width: screenWidth, height: screenHeight)
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(TableViewCell.self, forCellReuseIdentifier: "customCell")
        
        self.view.addSubview(myTableView)
        
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        myTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        myTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        myTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    }

    //Refresh Table view
    @objc func refresh() {
        parseData()
    }
    
}

