//
//  ContentView.swift
//  BerlinClockApp
//
//  Created by Nursat Sakyshev on 11.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var time = Date()
    let formatter = DateFormatter()
    @State private var berlinClock: BerlinClock?
    
//    func getStringDate() -> BerlinClock {
//        let stringFormat = formatter.string(from: time)
//        @State var clock = stringToClock(timeString: stringFormat)
//         return BerlinClock(clock: $clock)
//    }
    
    init() {
        formatter.dateFormat = "HH:mm:ss"
        let stringFormat = formatter.string(from: time)
        @State var clock = stringToClock(timeString: stringFormat)
        berlinClock = BerlinClock(clock: $clock)
    }
    
    var body: some View {
        formatter.dateFormat = "HH:mm:ss"
        let stringFormat = formatter.string(from: time)
        @State var clock = stringToClock(timeString: stringFormat)
        berlinClock = BerlinClock(clock: $clock)
        
        return VStack(spacing: 10) {
            
            getDate(date: $time)
                .fontWeight(.semibold)
            VStack(spacing: 16) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(Color(red: 255/255, green: 204/255, blue: 0/255))
                
                FourRects()
                FourRects()
                FiveMinRow()
                FourRects()
            }
            .padding(.vertical, 32)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(12)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .frame(width: 358, height: 54)
                .overlay {
                    DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
                        Text("Insert time")
                    }
                    .environment(\.locale, Locale(identifier: "ru_RU"))
                    .frame(width: 332, height: 38)
                }
            Spacer()
        }
        .padding(.top, 10)
        .frame(width: UIScreen.main.bounds.width)
        .background(Color(red: 242/255, green: 242/255, blue: 238/255))
    }
}

struct bigRect: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 74, height: 32)
            .foregroundColor(Color(red: 255/255, green: 59/255, blue: 48/255))
    }
}

struct smallRect: View {
    var width: CGFloat = 21
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: width, height: 32)
            .foregroundColor(Color(red: 255/255, green: 204/255, blue: 0))
    }
}

struct FiveMinRow: View {
    var body: some View {
        HStack(spacing: 10) {
            Group {
                smallRect()
                smallRect()
                smallRect()
                smallRect(width: 20)
                smallRect(width: 20)
            }
            Group {
                smallRect(width: 20)
                smallRect(width: 20)
                smallRect(width: 20)
                smallRect()
                smallRect()
                smallRect()
            }
        }
    }
}

struct FourRects: View {
    var body: some View {
        HStack(spacing: 10) {
            bigRect()
            bigRect()
            bigRect()
            bigRect()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct getDate: View {
    @Binding var date: Date
    var body: some View {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let stringFormat = formatter.string(from: date)
        @State var clock = stringToClock(timeString: stringFormat)
        var b = BerlinClock(clock: $clock)
        return Text("Time is \(stringFormat)")
    }
}

struct BerlinClock {
    @Binding var clock: Clock
    
    var seconds: String {
        clock.seconds % 2 == 0 ? "Y" : "O"
    }
    
    var hours: String {
        let numberOfFiveHours = clock.hours / 5
        return String(repeatElement("R", count: numberOfFiveHours)) + String(repeatElement("O", count: 4 - numberOfFiveHours))
    }
    
    var singleHours: String {
        let numberOfSingleHours = clock.hours % 5
        return String(repeatElement("R", count: numberOfSingleHours)) + String(repeatElement("O", count: 4 - numberOfSingleHours))
    }
    
    var minutes: String {
        let numberOfFiveMinutes = clock.minutes / 5
        var str = ""
        for i in 1..<numberOfFiveMinutes + 1 {
            str = i % 3 == 0 ? str + "R" : str + "Y"
        }
        str += String(repeatElement("O", count: 11 - numberOfFiveMinutes))
        return str
    }
    
    var singleMinutes: String {
        let numberOfSingleMinutes = clock.minutes % 5
        return String(repeatElement("Y", count: numberOfSingleMinutes)) + String(repeatElement("O", count: 4 - numberOfSingleMinutes))
    }
    
    var entireClock: String {
        seconds + hours + singleHours + minutes + singleMinutes
    }
    
//    var clock: Clock
    
//    init(clock: Clock) {
//        self.clock = clock
//    }
}

