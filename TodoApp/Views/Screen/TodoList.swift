import SwiftUI

struct TodoList: View {
    @State var todos: [Todo]
    @State var showCreateScreen = false
    @State private var newTodo: Todo = Todo(id: 0, status: .done, title: "", description: "", createdAt: Date(), dueDate: Date())
    
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
                        todo: self.$newTodo,
                        onSave: self.handleSave,
                        validate: self.validateNewTodo
                    )
                })
        }
    }
    
    private func handleSave() {
        self.todos.append(self.newTodo)
        showCreateScreen = false
    }
    
    private func validateNewTodo() -> Bool {
        !newTodo.title.isEmpty && !newTodo.description.isEmpty
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
