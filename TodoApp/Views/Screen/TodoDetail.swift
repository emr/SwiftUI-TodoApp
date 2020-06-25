import SwiftUI

struct TodoDetail: View {
    var todo: Todo
    var dateFormatter: DateFormatter
    var remainingDate: RemainingDate
    
    init(todo: Todo) {
        self.todo = todo
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        self.remainingDate = RemainingDate(calendar: Calendar.current, format: .medium)
    }
    
    var editButton: some View {
        Button(action: {}) {
            Text("Edit")
        }
    }
    
    var body: some View {
        Form {
            Section {
                Button(action: {}) {
                    HStack {
                        Image(systemName: todo.status == .done ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(Color.green)
                        Text(todo.title)
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                    }
                }
                EventRow(
                    icon: Image(systemName: "clock"),
                    label: Text("Remaining time"),
                    value: Text(remainingDate.buildString(from: Date(), to: todo.dueDate))
                )
                Text(todo.description)
                    .font(.callout)
                    .padding()
            }
            Section (header: Text("Events")) {
                EventRow(
                    icon: Image(systemName: "plus.circle"),
                    label: Text("Created at"),
                    value: Text(dateFormatter.string(from: todo.createdAt)),
                    description: Text(remainingDate.buildString(from: todo.createdAt, to: Date()) + " ago")
                )
            }
            Section(header: Text("Actions")) {
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Done")
                            .foregroundColor(Color.green)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    editButton
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Delete")
                            .foregroundColor(Color.red)
                    }
                    Spacer()
                }
            }
        }
            .navigationBarTitle(Text(todo.title))
            .navigationBarItems(trailing: editButton)
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetail(todo: TodoFixtures.get(0))
    }
}
