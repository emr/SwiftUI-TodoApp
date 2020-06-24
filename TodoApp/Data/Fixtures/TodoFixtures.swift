import Foundation

class TodoFixtures {
    
    static func get(_ index: Int) -> Todo {
        let todos = [
            Todo(
                id: 1,
                status: .todo,
                title: "Todo Title",
                description: "Not done yet.",
                dueDate: Date().addingTimeInterval(1800)
            ),
            Todo(
                id: 2,
                status: .done,
                title: "Todo Title with a freaking long title and done status",
                description: "This todo is done.",
                dueDate: Date().addingTimeInterval(86400)
            ),
        ]
        
        return todos[index % 2]
    }
    
}
