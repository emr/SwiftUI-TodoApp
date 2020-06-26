import SwiftUI

struct TodoList: View {
    @State var todos: [Todo]
    @State var showCreateScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach (todos) { todo in
                    NavigationLink(destination: TodoDetail(todo: todo)) {
                        TodoRow(todo: todo, done: .constant(false))
                    }
                }
            }
                .navigationBarTitle(Text("Todos"))
                .navigationBarItems(
                    trailing: Button(action: { self.showCreateScreen = true }) {
                        Image(systemName: showCreateScreen ? "plus.circle.fill" : "plus.circle")
                    }
                )
                .sheet(isPresented: $showCreateScreen, content: {
                    EditTodo(
                        intent: .create,
                        todo: Todo(id: "", status: .todo, title: "", description: "", createdAt: Date(), dueDate: Date()),
                        onSave: self.handleSave
                    )
                })
        }
    }
    
    private func handleSave(todo: Todo) {
        self.todos.append(todo)
        showCreateScreen = false
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(todos: [
            TodoFixtures.get(0),
            TodoFixtures.get(1),
        ])
    }
}
