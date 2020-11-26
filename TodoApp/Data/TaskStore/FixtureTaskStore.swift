import Foundation

final class FixturesTaskStore: TaskStore {
    var tasks: [Task] = TaskFixtures.data
    
    func all(completion: @escaping ([Task]) -> Void) {
        completion(tasks)
    }
    
    func add(task: Task, completion: @escaping (Task) -> Void) {
        tasks.append(task)
        completion(task)
    }
    
    func remove(at: IndexSet, completion: @escaping (Task) -> Void) {
        // not implemented yet.
    }
}
