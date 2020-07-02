
import Foundation


final class FilterConverter {
    
    //Преобразовываем filter в period
    static func getPeriodByFilter(_ filter: PeriodFilter) -> PeriodModel {
        let endDate = Date().currentDate
        
        switch filter {
        case .mounth:
            let startOfCurrentMonth = Date().startOfCurrentMonth
            return PeriodModel(startDate: startOfCurrentMonth,
                          endDate: endDate)
        case .today:
            let startOfCurrentDay = Date().startOfCurrentDay
            return PeriodModel(startDate: startOfCurrentDay,
                          endDate: endDate)
        case .week:
            let startOfCurrentWeek = Date().startOfCurrentWeek
            return PeriodModel(startDate: startOfCurrentWeek,
                          endDate: endDate)
        case .year:
            let startOfCurrentYear = Date().startOfCurrentYear
            return PeriodModel(startDate: startOfCurrentYear,
                          endDate: endDate)
        }
    }
    
}
