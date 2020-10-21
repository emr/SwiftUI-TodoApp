import SwiftUI

let remainingDate = RemainingDate(calendar: Calendar.current, format: .short)
let now = Date()

struct TaskRow: View {
    var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(task.title)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(task.description)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    .lineLimit(2)
            }
            Spacer()
            Text(remainingDate.buildString(from: now, to: task.dueDate))
                .font(.caption)
                .foregroundColor(Color.gray)
            Button(action: {
            }) {
                Image(systemName: self.task.status == .done ? "largecircle.fill.circle" : "circle")
            }
        }
            .padding([.top, .bottom], 10)
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskRow(task: TaskFixtures.get(0))
            TaskRow(task: TaskFixtures.get(1))
        }
            .previewLayout(.sizeThatFits)
    }
}
