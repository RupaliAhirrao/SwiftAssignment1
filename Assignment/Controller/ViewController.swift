//
//  ViewController.swift
//  Assignment
//
//  Created by test on 21/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

var tableRows = [FactsModel]()

class ViewController: UIViewController  {
    
    var myTableView : UITableView = UITableView()
    var navTitle : String?
    var viewModel: ViewControllerViewModel?
    var indicator: UIActivityIndicatorView!
    var rowHeight: CGFloat = 0.0
    
//MARK: View Controller Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createTableView()
        createServiceCall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//MARK: Other methods
    //initial set up for views
    func setupView() {
        self.view.backgroundColor = UIColor.white
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = refreshButton
        indicator = UIActivityIndicatorView()
    }
    
    //method for calling service request function
    func createServiceCall() {
        let apiservices: NetworkServices = NetworkServices()
        viewModel = ViewControllerViewModel()
        viewModel?.attachView(delegate: self)
        viewModel?.apiServices = apiservices
        
        self.startLoading()
        
        viewModel?.callServiceForFactsData()
    }
    
    //programmatically creation of table view
    func createTableView () {
        self.navigationItem.title = self.navTitle
        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        myTableView.frame.size = CGSize(width: screenWidth, height: screenHeight)
        myTableView.dataSource = self
        myTableView.delegate = self
        
        myTableView.register(TableViewCell.self, forCellReuseIdentifier: Constant.CELLIDENTIFIER)
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
        createServiceCall()
    }
}


//MARK: ViewControllerDelegate Methods
extension ViewController: ViewControllerDelegate {
    func updateView(array: tableData) {
        DispatchQueue.main.async {
            if let navigationTitle = array.title {
                self.navigationItem.title = navigationTitle
            }else {
                self.navTitle = Constant.EMPTYSTRING
            }
            tableRows = array.rows!
            self.myTableView.reloadData()
        }
    }
    
    func startLoading() {
        //var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
        //indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        //indicator.center = uiView.center
        indicator.hidesWhenStopped = true
        indicator.style = UIActivityIndicatorView.Style.gray
            //UIActivityIndicatorViewStyle.
        self.myTableView.addSubview(indicator)
        indicator.startAnimating()
    }
    
    func stopLoading() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    func showAlert(message: String) {
        
    }
}

//MARK: Table View Delegate methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CELLIDENTIFIER, for: indexPath) as! TableViewCell
        cell.cellDetails = tableRows[indexPath.row]
        if let cellDesc = cell.cellDetails?.description {
            self.rowHeight = Utility.heightForLabel(text: cellDesc, font: UIFont.boldSystemFont(ofSize: 14), width: UIScreen.main.bounds.size.width - Constant.CONTENTMARGIN) + Constant.TOPMARGIN
        } else {
            self.rowHeight = Constant.DEFAULTROWHEIGHT
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.rowHeight < Constant.IMAGEVIEWHEIGHT) {
            return Constant.DEFAULTROWHEIGHT
        } else {
            return self.rowHeight
        }
    }
}
