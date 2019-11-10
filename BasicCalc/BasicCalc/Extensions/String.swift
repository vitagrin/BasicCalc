//
//  String.swift
//  BasicCalc
//
//  Created by Vitaliy Grinevetsky on 6/11/19.
//  Copyright © 2019 Vitaliy Grinevetsky. All rights reserved.
//

import Foundation

extension String{
    var isNumber: Bool {
        return NumberFormatter().number(from: self) != nil
    }
}
