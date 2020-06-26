import SwiftUI

struct EditTodo: View {
    enum Intent {
        case create
        case edit
    }
    
    var intent: Intent
    @State var todo: Todo
    var onSave: (Todo) -> Void
    
    var title: Text {
        Text(intent == .create ? "Create Todo" : "Edit Todo")
    }
    
    var saveButton: some View {
        Button("Save", action: { self.onSave(self.todo) }).disabled(!self.validate())
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $todo.title)
                TextField("Description", text: $todo.description)
                DatePicker(
                    "Due Date",
                    selection: $todo.dueDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                Section {
                    HStack {
                        Spacer()
                        saveButton
                        Spacer()
                    }
                }
            }
            .navigationBarTitle(title, displayMode: .inline)
            .navigationBarItems(trailing: saveButton)
        }
    }
    
    private func validate() -> Bool {
        !todo.title.isEmpty && !todo.description.isEmpty
    }
}

struct CreateTodo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditTodo(
                intent: .edit,
                todo: Todo(id: 0, status: .done, title: "", description: "", createdAt: Date(), dueDate: Date()),
                onSave: {_ in}
            )
            EditTodo(
                intent: .create,
                todo: TodoFixtures.get(0),
                onSave: {_ in}
            )
        }
    }
}
