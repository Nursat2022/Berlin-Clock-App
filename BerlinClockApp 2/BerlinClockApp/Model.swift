//
//  Model.swift
//  BerlinClockApp
//
//  Created by Nursat Sakyshev on 11.04.2023.
//

import UIKit

//class BerlinClock {
//    var seconds: String {
//        clock.seconds % 2 == 0 ? "Y" : "O"
//    }
//    
//    var hours: String {
//        let numberOfFiveHours = clock.hours / 5
//        return String(repeatElement("R", count: numberOfFiveHours)) + String(repeatElement("O", count: 4 - numberOfFiveHours))
//    }
//    
//    var singleHours: String {
//        let numberOfSingleHours = clock.hours % 5
//        return String(repeatElement("R", count: numberOfSingleHours)) + String(repeatElement("O", count: 4 - numberOfSingleHours))
//    }
//    
//    var minutes: String {
//        let numberOfFiveMinutes = clock.minutes / 5
//        var str = ""
//        for i in 1..<numberOfFiveMinutes + 1 {
//            str = i % 3 == 0 ? str + "R" : str + "Y"
//        }
//        str += String(repeatElement("O", count: 11 - numberOfFiveMinutes))
//        return str
//    }
//    
//    var singleMinutes: String {
//        let numberOfSingleMinutes = clock.minutes % 5
//        return String(repeatElement("Y", count: numberOfSingleMinutes)) + String(repeatElement("O", count: 4 - numberOfSingleMinutes))
//    }
//    
//    var entireClock: String {
//        seconds + hours + singleHours + minutes + singleMinutes
//    }
//    
//    var clock: Clock
//    
//    init(clock: Clock) {
//        self.clock = clock
//    }
//}


class Clock {
    var hours: Int {
        didSet {
            if hours > 23 {
                hours = 23
            }
        }
    }
    var minutes: Int {
        didSet {
            if minutes > 59 {
                minutes = 59
            }
        }
    }
    var seconds: Int {
        didSet {
            if seconds > 59 {
                seconds = 59
            }
        }
    }
    
    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.hours = hours > 23 ? 23 : hours
        self.minutes = minutes > 59 ? 59 : minutes
        self.seconds = seconds > 59 ? 59 : seconds
    }
}

func stringToClock(timeString: String) -> Clock {
    var time = timeString.split(separator: ":")
    var clock: [Int] = []
    for i in time.indices {
        clock.append(Int(time[i]) ?? 0)
    }
    return Clock(hours: clock.count > 0 && clock[0] >= 0 ? clock[0] : 0, minutes: clock.count > 1 && clock[1] >= 0 ? clock[1] : 0, seconds: clock.count > 2 && clock[2] >= 0 ? clock[2] : 0)
}

var C = stringToClock(timeString: "-11:-37:-01")
var test = "ORROOROOOYYRYYRYOOOOYYOO"

//var B = BerlinClock(clock: C)
//print(b.seconds)
//print(b.hours)
//print(b.singleHours)
//print(b.minutes)
//print(b.singleMinutes)


