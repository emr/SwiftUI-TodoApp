import Foundation
import Combine

final class Tasks: ObservableObject {
    private let store: TaskStore
    @Published var tasks: [Task] = []
    
    init(store: TaskStore) {
        self.store = store
        store.all { self.tasks = $0 }
    }
    
    func add(task: Task) {
        store.add(task: task) { self.tasks.append($0) }
    }
    
    func remove(at: IndexSet) {
        // not implemented yet
    }
}
