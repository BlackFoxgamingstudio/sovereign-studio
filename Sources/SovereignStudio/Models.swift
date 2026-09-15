import Foundation

struct ServiceVitals: Codable, Identifiable {
    var id: String { name }
    let name: String
    let port: Int
    let status: String
    let domain: String
    let uptime: Double?
}

struct GitHubRepo: Codable, Identifiable {
    var id: String { name }
    let name: String
    let full_name: String
    let html_url: String
    let description: String?
    let language: String?
    let stargazers_count: Int?
}
