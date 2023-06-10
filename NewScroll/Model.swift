//
//  Model.swift
//  NewScroll
//
//  Created by Astemir Eleev on 08/06/2023.
//

import Foundation
import Observation

@Observable
final class Model {
    static let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    var cards: [Card] = [
        Card(title: "Latest Reports", desc: Model.lorem, img: "4", symbol: "camera.metering.multispot"),
        Card(title: "Promising Forecasts", desc: Model.lorem, img: "2", symbol: "wand.and.rays"),
        Card(title: "Vesting", desc: Model.lorem, img: "3", symbol: "bell.and.waves.left.and.right"),
        Card(title: "Planning", desc: Model.lorem, img: "4", symbol: "aqi.low"),
        Card(title: "Latest Reports", desc: Model.lorem, img: "5", symbol: "humidity.fill"),
        Card(title: "Promising Forecasts", desc: Model.lorem, img: "6", symbol: "ellipsis.message"),
        Card(title: "Vesting", desc: Model.lorem, img: "7", symbol: "phone.down.waves.left.and.right"),
        Card(title: "Planning", desc: Model.lorem, img: "1", symbol: "cloud.rainbow.half"),
        Card(title: "Latest Reports", desc: Model.lorem, img: "2", symbol: "shower"),
        Card(title: "Promising Forecasts", desc: Model.lorem, img: "3", symbol: "wifi"),
    ]
}

struct Card: Identifiable {
    var id = UUID()
    var title: String = "Title"
    var desc: String
    var img: String
    var date: Date = .now
    var symbol: String = "rainbow"
}
