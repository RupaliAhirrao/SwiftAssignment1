//
//  FactsModel.swift
//  Assignment
//
//  Created by test on 24/05/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

struct FactsModel : Codable {
    var title : String?
    var description : String?
    var imageHref: String?
}

struct tableData : Codable {
    var title : String?
    var rows : [FactsModel]?
}
