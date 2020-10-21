import Foundation
import Combine

final class Todos: ObservableObject {
    private let store: TodoStore
    @Published var todos: [Todo]
    
    init(store: TodoStore) {
        self.store = store
        self.todos = store.all()
    }
    
    func add(todo: Todo) {
        store.add(todo: todo)
    }
    
    func remove(at: IndexSet) {
        store.remove(at: at)
    }
    
}
