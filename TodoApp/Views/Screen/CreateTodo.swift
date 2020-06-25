import SwiftUI

struct CreateTodo: View {
    @State var todo: Todo = Todo(id: 0, status: .done, title: "", description: "", createdAt: Date(), dueDate: Date())
    
    var dueDateRange: ClosedRange<Date> {
        let now = Date()
        let oneMonthLater = Calendar.current.date(byAdding: .month, value: 1, to: now)!
        
        return now...oneMonthLater
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $todo.title)
                TextField("Description", text: $todo.description)
                DatePicker(
                    "Due Date",
                    selection: $todo.dueDate,
                    in: dueDateRange,
                    displayedComponents: [.date, .hourAndMinute]
                )
                Section {
                    HStack {
                        Spacer()
                        Button("Save", action: {})
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Create Todo", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done", action: {}))
        }
    }
}

struct CreateTodo_Previews: PreviewProvider {
    static var previews: some View {
        CreateTodo()
    }
}
