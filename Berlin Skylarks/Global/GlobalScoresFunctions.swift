//
//  GlobalScoresFunctions.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.10.21.
//

import Foundation
import EventKit
import SwiftUI

//these are deprecated for actual use, but it's nevertheless helpful to have some fallback images defined

var away_team_logo = Image("App_road_team_logo")
var home_team_logo = Image("App_home_team_logo")

let teamLogos = [
    "Skylarks": skylarksSecondaryLogo,
    "Roosters": Image("Roosters_Logo"),
    "Sluggers": Image("Sluggers_Logo"),
    "Eagles": Image("Mahlow-Eagles_Logo"),
    "Ravens": Image("ravens_logo"),
    "R´s": Image("ravens_logo"),
    "Porcupines": Image("potsdam_logo"),
    "Sliders": Image("Sliders_Rund_2021"),
    "Flamingos": Image("Berlin_Flamingos_Logo_3D"),
    "Challengers": Image("challengers_Logo"),
    "Rams": Image("Rams-Logo"),
    "Wizards": Image("Wizards_Logo"),
    "Poor Pigs": Image("Poorpigs_Logo"),
    "Dukes": Image("Dukes_Logo"),
    "Roadrunners": Image("Roadrunners_Logo"),
    "Dragons": Image("Dragons_Logo"),
]

func fetchCorrectLogos(gamescore: GameScore) -> (road: Image, home: Image) {
    
    var road = away_team_logo
    var home = home_team_logo
    
    for (name, image) in teamLogos {
        if gamescore.away_team_name.contains(name) {
            road = image
        }
    }
    
    for (name, image) in teamLogos {
        if gamescore.home_team_name.contains(name) {
            home = image
        }
    }
    return (road, home)
}

func getDatefromBSMString(gamescore: GameScore) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "y-M-dd HH:mm:ss Z"
    
    return dateFormatter.date(from: gamescore.time)!
    //force unwrapping alert: gametime really should be a required field in BSM DB - let's see if there are crashes
    //gameDate = dateFormatter.date(from: gamescore.time)!
}

func processGameDates(gamescores: [GameScore]) -> (next: GameScore?, last: GameScore?) {
    // processing
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    
    //for testing purposes this can be set to some date in the season, normally it's just the current date
    let now = Date()
    //let now = formatter.date(from: "20210928") ?? Date.now // September 27th, 2021 UTC
    
    var nextGames = [GameScore]()
    var previousGames = [GameScore]()

    //add game dates to all games to allow for ordering | outsourced below
    let gameList = addDatesToGames(gamescores: gamescores)
    
    //collect nextGames and add to array
    for gamescore in gameList where gamescore.gameDate! > now {
        nextGames.append(gamescore)
    }
    
    //Add last games to separate array and set it to be displayed
    for gamescore in gameList where gamescore.gameDate! < now {
        previousGames.append(gamescore)
    }
    
    //case: there is both a last and next game (e.g. middle of the season)
    if nextGames != [] && previousGames != [] {
        return (nextGames.first!, previousGames.last!)
    }
    
    //case: there is a previous game and no next game (e.g. season over for selected team)
    if nextGames == [] && previousGames != [] {
        return (nil, previousGames.last!)
    }
    
    //case: there is a next game and no previous game (e.g. season has not yet started for selected team)
    if nextGames != [] && previousGames == [] {
        return (nextGames.first!, nil)
    }
    
    //case: there is no game at all (error loading data, problems with async?)
    else {
        print("nothing to return, gamescores is empty")
        return (nil, nil)
    }
}

//MARK: Deprecated - use mutating func on struct

func addDatesToGames(gamescores: [GameScore]) -> [GameScore] {
    
    //this is used because the passed gamescores element cannot be mutated
    var gameList = gamescores
    
    for (index, _) in gameList.enumerated() {
        gameList[index].gameDate = getDatefromBSMString(gamescore: gameList[index])
        gameList[index].determineGameStatus()
    }
    return gameList
}

//-------------------------------------------------------------------------------//
//-----------------------------------LOAD DATA-----------------------------------//
//-------------------------------------------------------------------------------//

//MARK: Generic load function that accepts any codable type

func loadBSMData<T: Codable>(url: URL, dataType: T.Type, completion: @escaping ((T) -> Void)) {
    
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in

        if let data = data {
            if let response_obj = try? JSONDecoder().decode(T.self, from: data) {

                DispatchQueue.main.async {
                    let loadedData = response_obj
                    completion(loadedData)
                }
            }
        }
    }.resume()
}

// new version with async/await

func fetchBSMData<T: Codable>(url: URL, dataType: T.Type) async throws -> T {
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let responseObj = try JSONDecoder().decode(T.self, from: data)
    return responseObj
}

func loadSkylarksTeams(season: Int) async throws -> [BSMTeam] {
    
    let teamURL = URL(string:"https://bsm.baseball-softball.de/clubs/485/teams.json?filters[seasons][]=" + "\(season)" + "&sort[league_sort]=asc&api_key=" + apiKey)!
    let teams = try await fetchBSMData(url: teamURL, dataType: [BSMTeam].self)
    return teams
}

//-------------------------------------------------------------------------------//
//-------------------------------CALENDAR EVENTS---------------------------------//
//-------------------------------------------------------------------------------//

var calendarStrings = [String]()

func getAvailableCalendars() {
    
    let eventStore = EKEventStore()
    //var calendars = [EKCalendar]()
         
    eventStore.requestAccess(to: .event) { (granted, error) in
      
      if (granted) && (error == nil) {
          print("granted \(granted)")
          print("error \(String(describing: error))")
          
          //let event:EKEvent = EKEvent(eventStore: eventStore)
          let calendars = eventStore.calendars(for: .event)
          
          //clear the array before loading new
          calendarStrings = []
          
          for calendar in calendars {
              calendarStrings.append(calendar.title)
          }
          //print(calendars)
      }
      else {
          print("Access not granted")
      }
    }
}

#if !os(watchOS)
func addGameToCalendar(gameDate: Date, gamescore: GameScore, calendarString: String) {
    let eventStore = EKEventStore()
         
    eventStore.requestAccess(to: .event) { (granted, error) in
      
      if (granted) && (error == nil) {
          print("granted \(granted)")
          print("error \(String(describing: error))")
          
          let event:EKEvent = EKEvent(eventStore: eventStore)
          let calendars = eventStore.calendars(for: .event)
          
          event.title = gamescore.league.name + ": " + gamescore.away_team_name + " @ " + gamescore.home_team_name
          event.startDate = gameDate
          event.endDate = gameDate.addingTimeInterval(2 * 60 * 60)
          event.notes = gamescore.match_id
          //add more info
          
          for calendar in calendars {
              if calendar.title == calendarString {
                  event.calendar = calendar
              }
          }
          //event.calendar = eventStore.defaultCalendarForNewEvents
          do {
              try eventStore.save(event, span: .thisEvent)
          } catch let error as NSError {
              print("failed to save event with error : \(error)")
          }
          print("Saved Event successfully")
      }
      else {
          print("failed to save event with error : \(String(describing: error)) or access not granted")
      }
    }
}
#endif
