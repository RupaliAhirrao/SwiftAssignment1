//
//  ViewControllerViewModel.swift
//  Assignment
//
//  Created by test on 24/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation



protocol ViewControllerDelegate: NSObjectProtocol {
    func updateView(array: tableData)
    func startLoading()
    func stopLoading()
    func showAlert(message: String)
}

class ViewControllerViewModel {
    
    weak var delegate: ViewControllerDelegate?
    weak var apiServices : NetworkServices?
    
    func attachView(delegate: ViewControllerDelegate) {
        self.delegate = delegate
    }
    
    func dettachedView() {
        self.delegate = nil
        self.apiServices = nil
    }
    
    func callServiceForFactsData() {
        //delegate?.startLoading()
        apiServices?.callFactService(completionHandler: { (dictData, error) in
            //print(array)
            if let arrayData = dictData {
                 self.delegate?.updateView(array: arrayData)
            } else {
                self.delegate?.showAlert(message: "Error")
            }
            
            //self.delegate?.stopLoading()
           
        })
        self.delegate?.stopLoading()
    }
}
