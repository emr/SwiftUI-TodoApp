import Foundation

final class APITaskStore: TaskStore {
    let client: APIClient
    var tasks: [Task] = []
    
    init(client: APIClient) {
        self.client = client
    }
    
    func all(completion: @escaping ([Task]) -> Void) {
        client.send(request: GetTasks()) { result in
            switch result {
            case .success(let data):
                completion(data)
                self.tasks = data
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func add(task: Task, completion: @escaping (Task) -> Void) {
        tasks.append(task)
        completion(task)
    }
    
    func remove(at: IndexSet, completion: @escaping (Task) -> Void) {
        // not implemented yet.
    }
}
