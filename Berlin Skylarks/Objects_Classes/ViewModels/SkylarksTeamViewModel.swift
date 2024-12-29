//
//  SkylarksTeamViewModel.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 29.12.24.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import SkylarksAPIClient

/// Calls Skylarks website API with generated client code from library.
@MainActor
@Observable
class SkylarksTeamViewModel: OpenAPIClientAware {
    var loadingInProgress = false
    var teams: [Components.Schemas.Team] = []

    public func loadClubTeams(id: Int?) async {
        var client: Client
        do {
            client = try createClient()
        } catch {
            print("Error creating client: \(error)")
            return
        }

        var response: Operations.GetTeams.Output
        do {
            response = try await client.getTeams(query: .init(id: id))
        } catch {
            print("Error loading teams: \(error)")
            return
        }

        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let teamsResponse):
                teams = teamsResponse
            }
        case .internalServerError(let error):
            print("Error loading teams: \(error)")
        case .notFound(_):
            print(
                "No team was found after API call with id: \(id.debugDescription)"
            )
        case .undocumented(let statusCode, _):
            print("undocumented status code: \(statusCode)")
        }
    }
}
