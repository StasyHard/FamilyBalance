
import Foundation

extension Date {
    
        func stripTime() -> Date {
            var comp = Calendar.current.dateComponents([.year, .month, .day], from: self)
            comp.timeZone = TimeZone(secondsFromGMT: 0)
            let date = Calendar.current.date(from: comp)
            return date!
        }

}
