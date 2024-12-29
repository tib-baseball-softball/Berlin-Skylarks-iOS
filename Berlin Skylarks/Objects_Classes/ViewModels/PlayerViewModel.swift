//
//  PlayerViewModel.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 29.12.24.
//

import Foundation

@MainActor
@Observable
class PlayerViewModel: OpenAPIClientAware {
    var players: [Components.Schemas.Player] = []
    var loadingInProgress = false

    public func loadPlayers(id: Int?, bsmID: Int?, team: Int?) async {
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
        case .internalServerError(let error):
            print("Error loading players: \(error)")
        case .notFound(_):
            print(
                "No player was found after API call: \(String(describing: id)), \(String(describing: bsmID)), \(String(describing: team))"
            )
        case .undocumented(let statusCode, _):
            print("undocumented status code: \(statusCode)")
        case .badRequest(_):
                print("Bad Request response on API call: \(String(describing: id)), \(String(describing: bsmID)), \(String(describing: team))")
        }
    }
}
