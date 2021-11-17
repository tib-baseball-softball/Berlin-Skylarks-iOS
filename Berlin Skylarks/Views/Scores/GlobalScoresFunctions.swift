//
//  GlobalScoresFunctions.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 19.10.21.
//

import Foundation
import EventKit
import SwiftUI

var away_team_logo: Image? = Image("App_road_team_logo")
var home_team_logo: Image? = Image("App_home_team_logo")

let teamLogos = [
    "Skylarks": Image("Bird_whiteoutline"),
    "Roosters": Image("Roosters_Logo"),
    "Sluggers": Image("Sluggers_Logo"),
    "Eagles": Image("Mahlow-Eagles_Logo"),
    "Ravens": Image("ravens_logo"),
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

var skylarksAreHomeTeam = false
var skylarksWin = false
var isDerby = false

var gameDate: Date?

func determineGameStatus(gamescore: GameScore) {
    if gamescore.home_team_name.contains("Skylarks") && !gamescore.away_team_name.contains("Skylarks") {
        skylarksAreHomeTeam = true
        isDerby = false
    } else if gamescore.away_team_name.contains("Skylarks") && !gamescore.home_team_name.contains("Skylarks") {
        skylarksAreHomeTeam = false
        isDerby = false
    }
    if gamescore.away_team_name.contains("Skylarks") && gamescore.home_team_name.contains("Skylarks") {
        isDerby = true
    }
    if skylarksAreHomeTeam && !isDerby {
        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
            if homeScore > awayScore {
                skylarksWin = true
            }
            if homeScore < awayScore {
                skylarksWin = false
            }
        }
    } else if !skylarksAreHomeTeam && !isDerby {
        if let awayScore = gamescore.away_runs, let homeScore = gamescore.home_runs {
            if homeScore > awayScore {
                skylarksWin = false
            }
            if homeScore < awayScore {
                skylarksWin = true
            }
        }
    }
}

func setCorrectLogo(gamescore: GameScore) {
    for (name, image) in teamLogos {
        if gamescore.away_team_name.contains(name) {
            away_team_logo = image //teamLogos[name]
        }
    }
    
    for (name, image) in teamLogos {
        if gamescore.home_team_name.contains(name) {
            home_team_logo = image //teamLogos[name]
        }
    }
}

func getDatefromBSMString(gamescore: GameScore) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "y-M-dd HH:mm:ss Z"
    
    //force unwrapping alert: gametime really should be a required field in BSM DB - let's see if there are crashes
    gameDate = dateFormatter.date(from: gamescore.time)!
}

//-------------------------------CALENDAR EVENTS---------------------------------//

func addGameToCalendar(gameDate: Date, gamescore: GameScore) {
    let eventStore = EKEventStore()
         
    eventStore.requestAccess(to: .event) { (granted, error) in
      
      if (granted) && (error == nil) {
          print("granted \(granted)")
          print("error \(String(describing: error))")
          
          let event:EKEvent = EKEvent(eventStore: eventStore)
          let calendars = eventStore.calendars(for: .event)
          
          for calendar in calendars {
              //print("start loop")
              if calendar.title == "Development Calendar" {
                  event.title = gamescore.league.name + ": " + gamescore.away_team_name + " @ " + gamescore.home_team_name
                  event.startDate = gameDate
                  event.endDate = gameDate.addingTimeInterval(2 * 60 * 60)
                  event.notes = gamescore.match_id
                  //add more info
                  
                  event.calendar = calendar
                  //event.calendar = eventStore.defaultCalendarForNewEvents
                  do {
                      try eventStore.save(event, span: .thisEvent)
                  } catch let error as NSError {
                      print("failed to save event with error : \(error)")
                  }
                  print("Saved Event successfully")
              }
          }
      }
      else{
      
          print("failed to save event with error : \(String(describing: error)) or access not granted")
      }
    }
}

//        switch EKEventStore.authorizationStatus(for: .event) {
//        case .authorized:
//            insertEvent(store: eventStore, gameDate: gameDate)
//        case .denied:
//            print("Access denied")
//        case .notDetermined:
//
//            eventStore.requestAccess(to: .event, completion:
//              {[weak self] (granted: Bool, error: Error?) -> Void in
//                  if granted {
//                    self!.insertEvent(store: eventStore)
//                  } else {
//                        print("Access denied")
//                  }
//            })
//            default:
//                print("Case default")
//        }
