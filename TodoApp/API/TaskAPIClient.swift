import Foundation

final class TaskAPIClient: APIClient {
    let session: URLSession
    let decoder: JSONDecoder
    let baseEndpoint: String
    
    init(baseEndpoint: String) {
        self.session = URLSession.shared
        self.decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.decoder.dateDecodingStrategy = .formatted(dateFormatter)
        self.baseEndpoint = baseEndpoint
    }
    
    func send<T: APIRequest>(request: T, completion: @escaping ResultCallback<T.Response>) {
        guard let endpoint = URL(string: request.resource.path, relativeTo: URL(string: baseEndpoint)) else {
            fatalError("Bad resource: \(baseEndpoint)/\(request.resource.path)")
        }

        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    let result = try self.decoder.decode(T.Response.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
