import Foundation
import Combine

final class Tasks: ObservableObject {
    private let store: TaskStore
    @Published var tasks: [Task]
    
    init(store: TaskStore) {
        self.store = store
        self.tasks = store.all()
    }
    
    func add(task: Task) {
        store.add(task: task)
    }
    
    func remove(at: IndexSet) {
        store.remove(at: at)
    }
    
}
