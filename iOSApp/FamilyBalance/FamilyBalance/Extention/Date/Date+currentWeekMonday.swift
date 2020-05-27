
import Foundation

//получаем начало текущей недели
//TODO: --------------------------------добавить часовой пояс
extension Date {
    var startOfCurrentWeek: Date {
        var comp = Calendar.iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        comp.timeZone = TimeZone(secondsFromGMT: 0)
        let monday = Calendar.iso8601.date(from: comp)!
        return monday
     }
    
    var currentDate: Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}
        return localDate
    }
    
    var startOfCurrentDay: Date {
        var comp = Calendar.iso8601.dateComponents([.year, .month, .day], from: self)
        comp.timeZone = TimeZone(secondsFromGMT: 0)
        let startCurrentDay = Calendar.iso8601.date(from: comp)!
        return startCurrentDay
    }
    
    var startOfCurrentMonth: Date {
        var comp = Calendar.iso8601.dateComponents([.year, .month], from: self)
        comp.timeZone = TimeZone(secondsFromGMT: 0)
        let startDay = Calendar.iso8601.date(from: comp)!
        return startDay
    }
    
    var startOfCurrentYear: Date {
        var comp = Calendar.iso8601.dateComponents([.year], from: self)
        comp.timeZone = TimeZone(secondsFromGMT: 0)
        let startYear = Calendar.iso8601.date(from: comp)!
        return startYear
    }
}
