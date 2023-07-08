//
//  Model.swift
//  NewScroll
//
//  Created by Astemir Eleev on 08/06/2023.
//

import SwiftUI
import Foundation
import Observation

@Observable
final class Model {
    static let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    var cards: [Card] = [
        Card(title: "Latest Reports", desc: Model.lorem, img: "4", symbol: "camera.metering.multispot", color: .red),
        Card(title: "Promising Forecasts", desc: Model.lorem, img: "2", symbol: "wand.and.rays", color: .blue),
        Card(title: "Vesting", desc: Model.lorem, img: "3", symbol: "bell.and.waves.left.and.right", color: .green),
        Card(title: "Planning", desc: Model.lorem, img: "4", symbol: "aqi.low", color: .yellow),
        Card(title: "Latest Reports", desc: Model.lorem, img: "5", symbol: "humidity.fill", color: .mint),
        Card(title: "Promising Forecasts", desc: Model.lorem, img: "6", symbol: "ellipsis.message", color: .indigo),
        Card(title: "Vesting", desc: Model.lorem, img: "7", symbol: "phone.down.waves.left.and.right", color: .cyan),
        Card(title: "Planning", desc: Model.lorem, img: "1", symbol: "cloud.rainbow.half", color: .teal),
        Card(title: "Latest Reports", desc: Model.lorem, img: "2", symbol: "shower", color: .orange),
        Card(title: "Promising Forecasts", desc: Model.lorem, img: "3", symbol: "wifi", color: .purple),
    ]
}

struct Card: Identifiable, Hashable {
    var id = UUID()
    var title: String = "Title"
    var desc: String
    var img: String
    var date: Date = .now
    var symbol: String = "rainbow"
    var color: Color
}
