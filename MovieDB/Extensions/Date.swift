//
//  Date.swift
//  MovieDB
//
//  Created by Mai Hassen on 21/04/2024.
//

import Foundation
extension Date {
    

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
