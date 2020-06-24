import SwiftUI

struct TodoList: View {
    var body: some View {
        List {
            TodoRow(todo: Todo(
                status: .todo,
                title: "Todo Title",
                description: "Not done yet.",
                dueDate: Date().addingTimeInterval(1800)
            ))
            TodoRow(todo: Todo(
                status: .done,
                title: "Todo Title with a freaking long title and done status",
                description: "This todo is done.",
                dueDate: Date().addingTimeInterval(86400)
            ))
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}
