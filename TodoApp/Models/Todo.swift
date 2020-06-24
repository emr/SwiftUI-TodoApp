import SwiftUI

enum TodoStatus {
    case todo
    case done
}

struct Todo: Identifiable {
    var id: Int
    var status: TodoStatus
    var title: String
    var description: String
    var dueDate: Date
}
