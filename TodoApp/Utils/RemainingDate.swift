import Foundation

private struct RemainingDateComponent: Equatable {
    var value: Int
    var singularUnit: String
    var pluralUnit: String
    var description: String {
        return "\(value) \(value > 1 ? pluralUnit : singularUnit)"
    }
}

enum RemainingDateFormat {
    case short
    case medium
}

class RemainingDate {
    
    var calendar: Calendar
    var format: RemainingDateFormat
    
    init(calendar: Calendar, format: RemainingDateFormat) {
        self.calendar = calendar
        self.format = format
    }

    func buildString(from: Date, to: Date) -> String {
        let dateComponents = calendar.dateComponents([.year, .month, .weekOfMonth, .day, .hour, .minute], from: from, to: to)
        let remainingDateComponents = self.createRemainingDateComponents(dateComponents)
        return self.buildString(remainingDateComponents)
    }
    
    private func createRemainingDateComponents(_ components: DateComponents) -> [RemainingDateComponent] {
        return [
            RemainingDateComponent(value: components.year ?? 0, singularUnit: "year", pluralUnit: "years"),
            RemainingDateComponent(value: components.month ?? 0, singularUnit: "month", pluralUnit: "months"),
            RemainingDateComponent(value: components.weekOfMonth ?? 0, singularUnit: "week", pluralUnit: "weeks"),
            RemainingDateComponent(value: components.day ?? 0, singularUnit: "day", pluralUnit: "days"),
            RemainingDateComponent(value: components.hour ?? 0, singularUnit: "hour", pluralUnit: "hours"),
            RemainingDateComponent(value: components.minute ?? 0, singularUnit: "minute", pluralUnit: "minutes"),
        ]
    }
    
    private func buildString(_ components: [RemainingDateComponent]) -> String {
        // select first full value as the first index
        guard let firstIndex = components.firstIndex(where: { $0.value != 0 }) else {
            return ""
        }
        // select next index as the last index if available
        var lastIndex = firstIndex
        if format == .medium {
            lastIndex += 1
        }
        if lastIndex == components.count || components[lastIndex].value == 0 {
            lastIndex = firstIndex
        }
        
        return combineDescriptions(components[firstIndex...lastIndex])
    }
    
    private func combineDescriptions(_ components: ArraySlice<RemainingDateComponent>) -> String {
        var str = ""
        for component in components {
            str += component.description
            if component != components.last {
                str += ", "
            }
        }
        
        return str
    }

}
