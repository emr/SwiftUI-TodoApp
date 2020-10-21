import SwiftUI

struct TaskList: View {
    @EnvironmentObject var tasks: Tasks
    @State var showCreateScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach (tasks.tasks) { task in
                    NavigationLink(destination: TaskDetail(task: task)) {
                        TaskRow(task: task)
                    }
                }
                .onDelete(perform: { self.tasks.remove(at: $0) })
            }
                .navigationBarTitle(Text("Todos"))
                .navigationBarItems(
                    trailing: Button(action: { self.showCreateScreen = true }) {
                        Image(systemName: showCreateScreen ? "plus.circle.fill" : "plus.circle")
                    }
                )
                .sheet(isPresented: $showCreateScreen, content: {
                    EditTask(
                        intent: .create,
                        task: Task(id: "", status: .todo, title: "", description: "", createdAt: Date(), dueDate: Date()),
                        onSave: self.handleSave
                    )
                })
        }
    }
    
    private func handleSave(task: Task) {
        self.tasks.add(task: task)
        showCreateScreen = false
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList().environmentObject(Tasks(store: FixturesTaskStore()))
    }
}
