import SwiftUI

struct EditTodo: View {
    enum Intent {
        case create
        case edit
    }
    
    var intent: Intent
    @Binding var todo: Todo
    var onSave: () -> Void
    var validate: () -> Bool
    
    var title: Text {
        Text(intent == .create ? "Create Todo" : "Edit Todo")
    }
    
    var saveButton: some View {
        Button("Save", action: { self.onSave() }).disabled(!self.validate())
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
}

struct CreateTodo_Previews: PreviewProvider {
    @State static var todo = TodoFixtures.get(0)
    @State static var newTodo = Todo(id: 0, status: .done, title: "", description: "", createdAt: Date(), dueDate: Date())
    
    static var previews: some View {
        Group {
            EditTodo(
                intent: .edit,
                todo: $todo,
                onSave: {},
                validate: { true }
            )
            EditTodo(
                intent: .create,
                todo: $newTodo,
                onSave: {},
                validate: { false }
            )
        }
    }
}
