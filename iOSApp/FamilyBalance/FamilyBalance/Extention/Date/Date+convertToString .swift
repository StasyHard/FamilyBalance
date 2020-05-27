
import Foundation

//конвертация даты в строку формата medium: 1 мая 2020 г.
extension Date {
     static func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ru_RU")
        let date = formatter.string(from: date)
        return date
    }
}
