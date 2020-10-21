import Foundation

class TodoFixtures {

    static let todos = [
        Todo(
            id: "1",
            status: .done,
            title: "Todo Title",
            description: "This todo is done. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
            createdAt: Date().addingTimeInterval(-86400 * 2 - 7200),
            dueDate: Date().addingTimeInterval(1800)
        ),
        Todo(
            id: "2",
            status: .todo,
            title: "Todo Title with a long title and done status",
            description: "Not done yet. Ut enim ad minim veniam.",
            createdAt: Date().addingTimeInterval(-86400 * 9),
            dueDate: Date().addingTimeInterval(86400)
        ),
    ]
    
    static func get(_ index: Int) -> Todo {
        return todos[index % 2]
    }
    
}
