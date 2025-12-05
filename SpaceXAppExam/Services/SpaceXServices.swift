//
//  SpaceXServices.swift
//  SpaceXAppExam
//
//  Created by Marcus Husted on 01/12/2025.
//

import Foundation

// Custom errors for API operations.
enum APIError: Error {
    case badResponse
    case badStatusCode(Int)
    case decodingFailed
}

// Service layer for all SpaceX API requests.
// Handles network calls and JSON decoding.
struct SpaceXServices {
    
    // Endpoint URLs for the SpaceX API.
    private enum Endpoints {
        static let launchesV5 = URL(string: "https://api.spacexdata.com/v5/launches")!
        static let baseV4 = "https://api.spacexdata.com/v4"
        
        static func rocket(_ id: String) -> URL {
            URL(string: "\(baseV4)/rockets/\(id)")!
        }
        static func launchpad(_ id: String) -> URL {
            URL(string: "\(baseV4)/launchpads/\(id)")!
        }
        static func capsule(_ id: String) -> URL {
            URL(string: "\(baseV4)/capsules/\(id)")!
        }
        static func crew(_ id: String) -> URL {
            URL(string: "\(baseV4)/crew/\(id)")!
        }
        static func payload(_ id: String) -> URL {
            URL(string: "\(baseV4)/payloads/\(id)")!
        }
        static func landpad(_ id: String) -> URL {
            URL(string: "\(baseV4)/landpads/\(id)")!
        }
        static var allLaunchpads: URL {
            URL(string: "\(baseV4)/launchpads")!
        }
    }
    
    // Shared decoder configured for SpaceX API responses.
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        d.dateDecodingStrategy = .iso8601
        return d
    }()

    /// Fetches raw data from a URL with error handling.
    /// - Parameter url: The URL to fetch from.
    /// - Returns: The raw data from the response.
    /// - Throws: APIError if request fails or returns none 200 status.
    private func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.badResponse
        }

        guard httpResponse.statusCode == 200 else {
            throw APIError.badStatusCode(httpResponse.statusCode)
        }

        return data
    }
    
    /// Generic fetch method that decodes JSON into the specified type.
    /// - Parameters:
    ///     type: The Decodable type to decode into.
    ///     url: The URL to fetch from.
    /// - Returns: The decoded object.
    /// - Throws: APIError if request or decoding fails.
    private func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let data = try await fetchData(from: url)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }

    /// Fetches all launches from the SpaceX API.
    func getLaunches() async throws -> [LaunchModel] {
        try await fetch([LaunchModel].self, from: Endpoints.launchesV5)
    }

    /// Fetches a specific rocket by ID.
    func getRocket(id: String) async throws -> RocketModel {
        try await fetch(RocketModel.self, from: Endpoints.rocket(id))
    }

    /// Fetches a specific launchpad by ID.
    func getLaunchpad(id: String) async throws -> LaunchpadModel {
        try await fetch(LaunchpadModel.self, from: Endpoints.launchpad(id))
    }

    /// Fetches a specific capsule by ID.
    func getCapsule(id: String) async throws -> CapsuleModel {
        try await fetch(CapsuleModel.self, from: Endpoints.capsule(id))
    }

    /// Fetches a specific crew member by ID.
    func getCrewMember(id: String) async throws -> CrewMemberModel {
        try await fetch(CrewMemberModel.self, from: Endpoints.crew(id))
    }

    /// Fetches a specific payload by ID.
    func getPayload(id: String) async throws -> PayloadModel {
        try await fetch(PayloadModel.self, from: Endpoints.payload(id))
    }

    /// Fetches a specific landing pad by ID.
    func getLandingpad(id: String) async throws -> LandingpadModel {
        try await fetch(LandingpadModel.self, from: Endpoints.landpad(id))
    }

    /// Fetches all launchpads for the map view.
    func getAllLaunchpads() async throws -> [LaunchpadModel] {
        try await fetch([LaunchpadModel].self, from: Endpoints.allLaunchpads)
    }
}
