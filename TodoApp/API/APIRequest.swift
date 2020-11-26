import Foundation

protocol APIRequest: Encodable {
    associatedtype Response: Decodable

    var resource: APIResource { get }
}
