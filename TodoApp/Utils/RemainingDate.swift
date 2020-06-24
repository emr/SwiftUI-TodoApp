import Foundation

private struct RemainingDateComponent: Equatable {
    var value: Int
    var singularUnit: String
    var pluralUnit: String
    var description: String {
        return "\(value) \(value > 1 ? pluralUnit : singularUnit)"
    }
}

class RemainingDate {
    
    var calendar: Calendar
    var date: Date
    
    init(calendar: Calendar, from date: Date) {
        self.calendar = calendar
        self.date = date
    }

    func buildString(to: Date) -> String {
        let components = calendar.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute], from: self.date, to: to)
        return self.buildString(components)
    }
    
    private func buildString(_ components: DateComponents) -> String {
        let components = [
            RemainingDateComponent(value: components.year ?? 0, singularUnit: "year", pluralUnit: "years"),
            RemainingDateComponent(value: components.month ?? 0, singularUnit: "month", pluralUnit: "months"),
            RemainingDateComponent(value: components.weekOfMonth ?? 0, singularUnit: "week", pluralUnit: "weeks"),
            RemainingDateComponent(value: components.day ?? 0, singularUnit: "day", pluralUnit: "days"),
            RemainingDateComponent(value: components.hour ?? 0, singularUnit: "hour", pluralUnit: "hours"),
            RemainingDateComponent(value: components.minute ?? 0, singularUnit: "minute", pluralUnit: "minutes"),
        ]
        
        return self.buildString(components)
    }
    
    private func buildString(_ components: [RemainingDateComponent]) -> String {
        // find first full value
        guard let index = components.firstIndex(where: { $0.value != 0 }) else {
            return ""
        }
        
        return components[index].description
    }

}
