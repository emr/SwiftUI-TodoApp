import Foundation

protocol TodoStore {
    
    func all() -> [Todo]
    
    func add(todo: Todo)
    
    func remove(at: IndexSet)
    
}
