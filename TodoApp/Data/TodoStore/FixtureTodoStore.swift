import Foundation
import Combine

final class FixturesTodoStore: TodoStore {
    
    var todos: [Todo]
    
    init() {
        todos = TodoFixtures.todos
    }
    
    func all() -> [Todo] {
        return todos
    }
    
    func add(todo: Todo) {
        todos.append(todo)
    }
    
    func remove(at: IndexSet) {
        // not implemented yet.
    }
    
}
