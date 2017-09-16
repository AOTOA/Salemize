//
//  SMCaseItem.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import Foundation

class SMCaseItem {
    var id: Int!
    var title: String!
    var subtitle: String!
    var odds: Float!
    init(title: String, subtitle: String, odds: Float) {
        self.title = title
        self.subtitle = subtitle
        self.odds = odds
    }
}
