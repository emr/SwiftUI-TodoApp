import SwiftUI

let remainingDate = RemainingDate(calendar: Calendar.current, format: .short)
let now = Date()

struct TodoRow: View {
    var todo: Todo
    @Binding var done: Bool
    
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
            Text(remainingDate.buildString(from: now, to: todo.dueDate))
                .font(.caption)
                .foregroundColor(Color.gray)
            Button(action: {
            }) {
                Image(systemName: self.done ? "largecircle.fill.circle" : "circle")
            }
        }
            .padding([.top, .bottom], 10)
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoRow(
                todo: TodoFixtures.get(0),
                done: .constant(false)
            )
            TodoRow(
                todo: TodoFixtures.get(1),
                done: .constant(true)
            )
        }
            .previewLayout(.sizeThatFits)
    }
}
