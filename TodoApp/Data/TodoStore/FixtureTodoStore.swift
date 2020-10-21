import Foundation
import Combine

final class FixturesTaskStore: TaskStore {
    
    var tasks: [Task]
    
    init() {
        tasks = TaskFixtures.data
    }
    
    func all() -> [Task] {
        return tasks
    }
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func remove(at: IndexSet) {
        // not implemented yet.
    }
    
}
