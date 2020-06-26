import SwiftUI

struct TodoList: View {
    @EnvironmentObject var todoStore: TodoStore
    @State var showCreateScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach (todoStore.todos) { todo in
                    NavigationLink(destination: TodoDetail(todo: todo)) {
                        TodoRow(todo: todo)
                    }
                }
                .onDelete(perform: { self.todoStore.remove(at: $0) })
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
        self.todoStore.add(todo: todo)
        showCreateScreen = false
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
            .environmentObject(TodoStore())
    }
}
