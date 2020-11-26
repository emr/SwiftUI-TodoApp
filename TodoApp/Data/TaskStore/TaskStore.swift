import Foundation

protocol TaskStore {
    
    func all(completion: @escaping ([Task]) -> Void)
    
    func add(task: Task, completion: @escaping (Task) -> Void)
    
    func remove(at: IndexSet, completion: @escaping (Task) -> Void)
    
}
