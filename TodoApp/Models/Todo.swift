import Foundation

struct Todo: Codable, Identifiable {
    var id: String
    var status: Status
    var title: String
    var description: String
    var createdAt: Date
    var dueDate: Date
    
    enum Status: String, Codable {
        case todo = "todo"
        case done = "done"
    }
}
