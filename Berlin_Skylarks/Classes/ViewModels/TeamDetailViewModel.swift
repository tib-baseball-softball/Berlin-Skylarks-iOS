//
//  PlayerViewModel.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 29.12.24.
//

import Foundation
import OpenAPIKit

@MainActor
@Observable
class TeamDetailViewModel: OpenAPIClientAware {
    var playerState: ViewState = .notInitialised
    var trainingState: ViewState = .notInitialised
    var players: [Components.Schemas.Player] = []
    var trainings: [Components.Schemas.Training] = []

    /// Loads Trainings for the specified team
    /// - Parameters:
    ///    - id: ID of the team
    public func loadTrainingsForTeam(id: Int) async throws {
        trainingState = .loading
        let client = try createClient()
        let response = try await client.getTrainingTimes(query: .init(team: id))

        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let trainingsResponse):
                trainings = trainingsResponse
            }
            trainings = try response.ok.body.json
            trainingState = .found
        case .notFound(_):
            trainingState = .noResults
        case .internalServerError(_):
            trainingState = .error
        case .undocumented(let statusCode, _):
            print("undocumented status code: \(statusCode)")
            trainingState = .error
        }
    }

    /// Loads Players according to API definition
    public func loadPlayers(id: Int?, bsmID: Int?, team: Int?) async {
        playerState = .loading
        var client: Client
        do {
            client = try createClient()
        } catch {
            print("Error creating client: \(error)")
            return
        }

        var response: Operations.GetPlayers.Output
        do {
            response = try await client.getPlayers(
                query: .init(id: id, bsmid: bsmID, team: team))
        } catch {
            print("Error loading players: \(error)")
            return
        }

        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let playersResponse):
                players = playersResponse
            }
            playerState = .found
        case .internalServerError(let error):
            print("Error loading players: \(error)")
            playerState = .error
        case .notFound(_):
            print(
                "No player was found after API call: \(String(describing: id)), \(String(describing: bsmID)), \(String(describing: team))"
            )
            playerState = .noResults
        case .undocumented(let statusCode, _):
            print("undocumented status code: \(statusCode)")
            playerState = .error
        case .badRequest(_):
            print(
                "Bad Request response on API call: \(String(describing: id)), \(String(describing: bsmID)), \(String(describing: team))"
            )
            playerState = .error
        }
    }
}
