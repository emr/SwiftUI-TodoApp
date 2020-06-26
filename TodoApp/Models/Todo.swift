import Foundation

struct Todo: Identifiable {
    var id: Int
    var status: Status
    var title: String
    var description: String
    var createdAt: Date
    var dueDate: Date
    
    enum Status {
        case todo
        case done
    }
}
