import Foundation

protocol TaskStore {
    
    func all() -> [Todo]
    
    func add(todo: Todo)
    
    func remove(at: IndexSet)
    
}
