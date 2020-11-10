import Foundation

struct GetTasks: APIRequest {
    typealias Response = [Task]
    
    var resourceName: String {
        return "tasks"
    }
}
