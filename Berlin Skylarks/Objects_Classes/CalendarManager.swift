//
//  CalendarManager.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 03.06.22.
//

import Foundation
import EventKit

class CalendarManager: ObservableObject {
    @Published var calendarAccess = false
    
    @Published var calendars = [EKCalendar]()
    
    //get user calendars
    
    func checkAuthorizationStatus() async -> Bool {
        var accessGranted = false
        let eventStore = EKEventStore()
        
        switch (EKEventStore.authorizationStatus(for: .event)) {
        case .authorized:
            accessGranted = true
        case .notDetermined:
            accessGranted = false
            eventStore.requestAccess(to: .event) { granted, error in
                accessGranted = granted
            }
        case .denied, .restricted:
            accessGranted = false
        @unknown default:
            print("Unknown EventKit authorization status")
        }
        return accessGranted
    }
    
    func askForCalPermission() async throws -> Bool {
        let eventStore = EKEventStore()
        
        return try await eventStore.requestAccess(to: .event)
    }
    
    func getAvailableCalendars() async -> [String] {
        
        let eventStore = EKEventStore()
        var calendars = [EKCalendar]()
        var calendarTitles = [String]()
        
        do {
            let granted = try await askForCalPermission()
            
            if granted {
                calendars = eventStore.calendars(for: .event)
            } else {
                print("no calendar access")
            }
            
        } catch {
            print(error)
        }
        
        for calendar in calendars {
            calendarTitles.append(calendar.title)
        }

        return calendarTitles
    }
    
    //add games to loaded calendars

    #if !os(watchOS)
    func addGameToCalendar(gameDate: Date, gamescore: GameScore, calendarTitle: String) {
        let eventStore = EKEventStore()
             
        eventStore.requestAccess(to: .event) { (granted, error) in
          
          if (granted) && (error == nil) {
              print("granted \(granted)")
              print("error \(String(describing: error))")
              
              let event:EKEvent = EKEvent(eventStore: eventStore)
              let calendars = eventStore.calendars(for: .event)
              
              event.title = "\(gamescore.league.name): \(gamescore.away_team_name) @ \(gamescore.home_team_name)"
              event.startDate = gameDate
              event.endDate = gameDate.addingTimeInterval(2 * 60 * 60)
              
              //add game location if there is data
              
              if let field = gamescore.field, let latitude = gamescore.field?.latitude, let longitude = gamescore.field?.longitude {
                  
                  let location = CLLocation(latitude: latitude, longitude: longitude)
                  let structuredLocation = EKStructuredLocation(title: "\(field.name) - \(field.street ?? ""), \(field.postal_code ?? "") \(field.city ?? "")")
                  structuredLocation.geoLocation = location
                  event.structuredLocation = structuredLocation
              }
              
              event.notes = """
                    League: \(gamescore.league.name)
                    Match Number: \(gamescore.match_id)
                    
                    Field: \(gamescore.field?.name ?? "No data")
                    Address: \(gamescore.field?.street ?? ""), \(gamescore.field?.postal_code ?? "") \(gamescore.field?.city ?? "")
                """
            
              for calendar in calendars where calendar.title == calendarTitle {
                  event.calendar = calendar
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
}
