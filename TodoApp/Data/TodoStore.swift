import Foundation
import Combine

final class TodoStore: ObservableObject {
    
    @Published var todos: [Todo] = []
    
    var client = ApiClient(baseUrl: Environment.apiBaseUrl() + "/todos")
    
    init() {
        self.fetchAll()
    }
    
    func fetchAll() {
        do {
            let sub: AnyPublisher<[Todo], Error> = try client.get(path: "")
            sub.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { self.todos = $0 })
        } catch {
            fatalError("An error occurred when trying to send a request to the api service:\n\(error)")
        }
    }
    
    func add(todo: Todo) {
        do {
            let sub: AnyPublisher<Todo, Error> = try client.post(path: "")
            sub.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }
            }, receiveValue: { self.todos.append($0) })
        } catch {
            fatalError("An error occurred when trying to send a request to the api service:\n\(error)")
        }
    }
    
    func remove(at indexSet: IndexSet) {
        todos.remove(atOffsets: indexSet)
        // not implemented yet.
    }
    
}
