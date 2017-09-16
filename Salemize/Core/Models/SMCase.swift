//
//  SMCase.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import Foundation

class SMCase {
    var id: Int!
    var case_id: Int!
    var name: String!
    var logo: String!
    var boxInsideLogo: String!
    var price: Int!
    var items: [SMCaseItem]!
    init(name: String, logo: String, boxInsideLogo: String, price: Int) {
        self.name = name
        self.logo = logo
        self.boxInsideLogo = boxInsideLogo
        self.price = price
    }
}
