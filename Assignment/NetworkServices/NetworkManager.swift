//
//  NetworkManager.swift
//  Assignment
//
//  Created by test on 24/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

class NetworkManager {
    
    //static func callFactsURL(dict: [String : Any], completionHandler: @escaping ([Rows]?, _ error: Error?) -> Void) {
    static func callFactsURL(completionHandler: @escaping (tableData?, _ error: Error?) -> Void) {
        guard let url = URL(string: Constant.FACTSURL)
            else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data1 = data else { return }
            
            guard let dataString = String(bytes: data1, encoding: String.Encoding.isoLatin1) else { return }
            //print("responseString = \(dataString)")
            
            do {
                
                // let jsonData = JSONSerialization.jsonObject(with: data, options: nil) as? [String: Any]
                let decoder = JSONDecoder()
                guard let dataVal = dataString.data(using: .utf8) else { return } // to avoid forced unwrapping
                let viewData = try decoder.decode(tableData.self, from: dataVal) //dataString.data(using: .utf8)!)
                
                guard let viewRows = viewData.rows else { return } // to avoid forced unwrapping
                tableRows = viewRows
                completionHandler(viewData, nil)
                
            } catch let err {
                completionHandler(nil, err)
            }
            }.resume()
    }
}
