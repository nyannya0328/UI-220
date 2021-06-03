//
//  Place.swift
//  UI-220
//
//  Created by にゃんにゃん丸 on 2021/06/03.
//

import SwiftUI
import CoreLocation

struct Place: Identifiable {
    var id = UUID().uuidString
    var placeMark : CLPlacemark
}

