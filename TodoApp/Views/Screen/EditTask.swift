import SwiftUI

struct EditTask: View {
    enum Intent {
        case create
        case edit
    }
    
    var intent: Intent
    @State var task: Task
    var onSave: (Task) -> Void
    
    var title: Text {
        Text(intent == .create ? "Create Todo" : "Edit Todo")
    }
    
    var saveButton: some View {
        Button("Save", action: { self.onSave(self.task) }).disabled(!self.validate())
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $task.title)
                TextField("Description", text: $task.description)
                DatePicker(
                    "Due Date",
                    selection: $task.dueDate,
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
        !task.title.isEmpty && !task.description.isEmpty
    }
}

struct EditTask_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditTask(
                intent: .edit,
                task: Task(id: "", status: .done, title: "", description: "", createdAt: Date(), dueDate: Date()),
                onSave: {_ in}
            )
            EditTask(
                intent: .create,
                task: TaskFixtures.get(0),
                onSave: {_ in}
            )
        }
    }
}
