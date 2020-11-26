import Foundation

struct GetTasks: APIRequest {
    typealias Response = [Task]
    
    var resource: APIResource {
        return APIResource(path: "tasks", method: "GET")
    }
}
