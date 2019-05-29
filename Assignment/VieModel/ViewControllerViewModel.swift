//
//  ViewControllerViewModel.swift
//  Assignment
//
//  Created by test on 24/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

protocol ViewControllerDelegate: NSObjectProtocol {
    func updateView(array: TableData)
}

class ViewControllerViewModel {
    weak var delegate: ViewControllerDelegate?
    weak var apiServices: NetworkServices?
    func attachView(delegate: ViewControllerDelegate) {
        self.delegate = delegate
    }
    func dettachedView() {
        self.delegate = nil
        self.apiServices = nil
    }
    func callServiceForFactsData() {
        //delegate?.startLoading()
        apiServices?.callFactService(completionHandler: { (dictData, _ error) in
            if let arrayData = dictData {
                 self.delegate?.updateView(array: arrayData)
            }
        })
    }
}
