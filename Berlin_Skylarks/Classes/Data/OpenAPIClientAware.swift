//
//  OpenAPIClientAware.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 29.12.24.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import SkylarksAPIClient

class OpenAPIClientAware {
    func createClient() throws -> Client {
        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [
                AuthMiddleware(bearerToken: authHeader)
            ]
        )
        return client
    }
}
