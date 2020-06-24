import SwiftUI

let remainingDate = RemainingDate(calendar: Calendar.current, from: Date())

struct TodoRow: View {
    var todo: Todo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.title)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(todo.description)
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            Spacer()
            Text(remainingDate.buildString(to: todo.dueDate))
                .font(.caption)
                .foregroundColor(Color.gray)
            Button(action: {
            }) {
                Image(systemName: "info.circle")
            }
        }
        .padding()
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoRow(todo: Todo(
                status: .todo,
                title: "Todo Title",
                description: "Not done yet.",
                dueDate: Date().addingTimeInterval(1800)
            ))
            TodoRow(todo: Todo(
                status: .done,
                title: "Todo Title with a freaking long title and done status",
                description: "This todo is done.",
                dueDate: Date().addingTimeInterval(86400)
            ))
        }
            .previewLayout(.sizeThatFits)
    }
}
