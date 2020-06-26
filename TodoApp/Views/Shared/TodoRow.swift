import SwiftUI

let remainingDate = RemainingDate(calendar: Calendar.current, format: .short)
let now = Date()

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
                    .lineLimit(2)
            }
            Spacer()
            Text(remainingDate.buildString(from: now, to: todo.dueDate))
                .font(.caption)
                .foregroundColor(Color.gray)
            Button(action: {
            }) {
                Image(systemName: self.todo.status == .done ? "largecircle.fill.circle" : "circle")
            }
        }
            .padding([.top, .bottom], 10)
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoRow(
                todo: TodoFixtures.get(0)
            )
            TodoRow(
                todo: TodoFixtures.get(1)
            )
        }
            .previewLayout(.sizeThatFits)
    }
}
