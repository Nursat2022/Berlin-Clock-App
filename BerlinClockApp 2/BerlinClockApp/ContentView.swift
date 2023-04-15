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
    var body: some View {
        let berlin = Array(toBerlin(date: time))
        return VStack(spacing: 10) {
            getDate(date: $time)
                .onAppear {
                    updateTimer()
                }
                .fontWeight(.semibold)
            
            VStack(spacing: 16) {
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(String(berlin[0]) == "O" ? Color(red: 255/255, green: 224/255, blue: 102/255) : Color(red: 255/255, green: 204/255, blue: 0/255))
                
                HStack(spacing: 10) {
                    ForEach(1..<5) { i in
                        bigRect(color: String(berlin[i]) == "O" ? Color(red: 255/255, green: 137/255, blue: 131/255) : Color(red: 255/255, green: 59/255, blue: 48/255))
                    }
                }
                HStack(spacing: 10) {
                    ForEach(5..<9) { i in
                        bigRect(color: String(berlin[i]) == "O" ? Color(red: 255/255, green: 137/255, blue: 131/255) : Color(red: 255/255, green: 59/255, blue: 48/255))
                    }
                }
                HStack(spacing: 10) {
                    ForEach(9..<20) { i in
                        if String(berlin[i]) != "O" && (i == 11 || i == 14 || i == 17) {
                            smallRect(color: Color(red: 255/255, green: 59/255, blue: 48/255), width: i >= 12 && i <= 16 ? 20 : 21)
                        }
                        else if String(berlin[i]) != "O" {
                            smallRect(color: Color(red: 255/255, green: 204/255, blue: 0), width: i >= 12 && i <= 16 ? 20 : 21)
                        }
                        else {
                            if i == 11 || i == 14 || i == 17 {
                                smallRect(color: Color(red: 255/255, green: 137/255, blue: 131/255), width: i >= 12 && i <= 16 ? 20 : 21)
                            }
                            else {
                                smallRect(color: Color(red: 255/255, green: 224/255, blue: 102/255), width: i >= 12 && i <= 16 ? 20 : 21)
                            }
                        }
                    }
                }
                
                HStack(spacing: 10) {
                    ForEach(20..<berlin.count) { i in
                        bigRect(color: String(berlin[i]) == "O" ? Color(red: 255/255, green: 224/255, blue: 102/255) : Color(red: 255/255, green: 204/255, blue: 0))
                    }
                }
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
    
    func updateTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            time = time.addingTimeInterval(1)
        }
    }
}

struct bigRect: View {
    var color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .frame(width: 74, height: 32)
            .foregroundColor(color)
    }
}

struct smallRect: View {
    var color: Color
    var width: CGFloat = 21
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .frame(width: width, height: 32)
            .foregroundColor(color)
    }
}



func dateToString(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    let stringFormat = formatter.string(from: date)
    return stringFormat
}

func toBerlin(date: Date) -> String {
   var stringFormat = dateToString(date: date)
    var berinClock = BerlinClock(clock: stringToClock(timeString: stringFormat)).entireClock
    return berinClock
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct getDate: View {
    @Binding var date: Date
    var body: some View {
        var stringFormat = dateToString(date: date)
        return Text("Time is \(stringFormat)")
    }
}

struct BerlinClock {
    var clock: Clock
    
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
}

