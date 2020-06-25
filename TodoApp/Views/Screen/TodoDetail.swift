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
    
    var body: some View {
        List {
            Button(action: {}) {
                HStack {
                    Image(systemName: todo.status == .done ? "largecircle.fill.circle" : "circle")
                    Text(todo.title)
                        .font(.headline)
                }
            }
            EventRow(
                icon: Image(systemName: "clock"),
                label: "Remaining time",
                value: remainingDate.buildString(from: Date(), to: todo.dueDate)
            )
            Text(todo.description)
                .font(.callout)
                .padding()
            EventRow(
                icon: Image(systemName: "plus.circle"),
                label: "Created at",
                value: dateFormatter.string(from: todo.createdAt),
                description: remainingDate.buildString(from: todo.createdAt, to: Date()) + " ago"
            )
            Spacer()
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Delete")
                        .foregroundColor(Color.red)
                }
                Spacer()
            }
        }
            .navigationBarTitle(Text(todo.title))
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetail(todo: TodoFixtures.get(0))
    }
}
