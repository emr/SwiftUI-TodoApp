import Foundation

class TodoFixtures {
    
    static func get(_ index: Int) -> Todo {
        let todos = [
            Todo(
                id: 1,
                status: .todo,
                title: "Todo Title",
                description: "Not done yet. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                createdAt: Date().addingTimeInterval(-86400 * 2 - 7200),
                dueDate: Date().addingTimeInterval(1800)
            ),
            Todo(
                id: 2,
                status: .done,
                title: "Todo Title with a freaking long title and done status",
                description: "This todo is done.",
                createdAt: Date().addingTimeInterval(-86400 * 9),
                dueDate: Date().addingTimeInterval(86400)
            ),
        ]
        
        return todos[index % 2]
    }
    
}
