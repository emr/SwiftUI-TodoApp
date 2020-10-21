import Foundation

protocol TaskStore {
    
    func all() -> [Task]
    
    func add(task: Task)
    
    func remove(at: IndexSet)
    
}
