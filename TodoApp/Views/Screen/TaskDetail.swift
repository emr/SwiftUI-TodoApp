import SwiftUI

struct TaskDetail: View {
    var dateFormatter: DateFormatter
    var remainingDate: RemainingDate
    @State var task: Task
    @State var showEditScreen = false
    
    init(task: Task) {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        remainingDate = RemainingDate(calendar: Calendar.current, format: .medium)
        _task = State(initialValue: task)
    }
    
    var editButton: some View {
        Button(action: { self.showEditScreen = true }) {
            Text("Edit")
        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Detail")) {
                Button(action: {}) {
                    HStack {
                        Image(systemName: task.status == .done ? "largecircle.fill.circle" : "circle")
                            .foregroundColor(Color.green)
                        Text(task.title)
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                    }
                }
                EventRow(
                    icon: Image(systemName: "clock"),
                    label: Text("Remaining time"),
                    value: Text(remainingDate.buildString(from: Date(), to: task.dueDate))
                )
                Text(task.description)
                    .font(.callout)
                    .padding()
            }
            Section (header: Text("Events")) {
                EventRow(
                    icon: Image(systemName: "plus.circle"),
                    label: Text("Created at"),
                    value: Text(dateFormatter.string(from: task.createdAt)),
                    description: Text(remainingDate.buildString(from: task.createdAt, to: Date()) + " ago")
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
            .navigationBarTitle(Text(task.title))
            .navigationBarItems(trailing: editButton)
            .sheet(isPresented: $showEditScreen, content: {
                EditTask(
                    intent: .edit,
                    task: self.task,
                    onSave: self.handleSave
                )
            })
    }

    private func handleSave(task: Task) {
        self.task = task
        showEditScreen = false
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetail(task: TaskFixtures.get(0))
    }
}
