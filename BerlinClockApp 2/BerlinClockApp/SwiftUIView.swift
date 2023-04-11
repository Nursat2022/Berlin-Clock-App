//
//  SwiftUIView.swift
//  BerlinClockApp
//
//  Created by Nursat Sakyshev on 11.04.2023.
//

import SwiftUI

struct SwiftUIView: View {
//    var body: some View {
//           @State var date = Date()
//
//           let dateFormatter = DateFormatter()
//           dateFormatter.dateFormat = "h:mm a"
//
//           let timeString = dateFormatter.string(from: date)
//           let components = timeString.split(separator: ":")
//
//        var hours: Int {
//            dateFormatter.dateFormat = "h:mm a"
//            let timeString = dateFormatter.string(from: date)
//            let components = timeString.split(separator: ":")
//            return Int(components[0]) ?? 0
//        }
//           let minutes = Int(components[1].prefix(2)) ?? 0
//
//           return VStack {
//               Text("Hours: \(hours)")
//               Text("Minutes: \(minutes)")
//
//               DatePicker(selection: $date, displayedComponents: .hourAndMinute) {
//                   Text("Insert time")
//               }
//               .environment(\.locale, Locale(identifier: "ru_RU"))
//               .datePickerStyle(.compact)
//               Text("\(hours)")
//           }
//       }
        @State private var time = Date()

          var body: some View {
              VStack {
                  Text(getFormattedTime(date: time))
                  
                  DatePicker(selection: $time, displayedComponents: .hourAndMinute) {
                      Text("Insert a time")
                  }
                  .environment(\.locale, Locale(identifier: "ru_RU"))
              }
          }

          func getFormattedTime(date: Date) -> String {
              let formatter = DateFormatter()
              formatter.dateFormat = "HH:mm:ss"
              return formatter.string(from: date)
          }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

