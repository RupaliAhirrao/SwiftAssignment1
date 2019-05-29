//
//  NetworkServices.swift
//  Assignment
//
//  Created by test on 24/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class NetworkServices {
    func callFactService(completionHandler: @escaping (_ arrayData: TableData?, _ error: Error?) -> Void) {
        NetworkManager.callFactsURL { (dictData, error) in
            completionHandler(dictData, error)
        }
    }
}
