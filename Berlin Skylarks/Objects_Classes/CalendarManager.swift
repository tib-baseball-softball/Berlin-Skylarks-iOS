//
//  CalendarManager.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 03.06.22.
//

import Foundation
import EventKit

#if !os(watchOS)
class CalendarManager: ObservableObject {
    @Published var calendarAccess = false
    
    let eventStore = EKEventStore()
    
    func addGameToCalendar(gameDate: Date, gamescore: GameScore, calendar: EKCalendar? = nil) async {
        var granted = false
             
        do {
            granted = try await eventStore.requestWriteOnlyAccessToEvents()
        } catch {
            print("error \(String(describing: error))")
        }
      
        if granted {
          let event = EKEvent(eventStore: eventStore)
          
          event.calendar = calendar ?? eventStore.defaultCalendarForNewEvents
          event.title = "\(gamescore.league.name): \(gamescore.away_team_name) @ \(gamescore.home_team_name)"
          event.startDate = gameDate
          event.endDate = gameDate.addingTimeInterval(2 * 60 * 60)
          event.timeZone = TimeZone(identifier: "Europe/Berlin")
          
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
          
          do {
              try eventStore.save(event, span: .thisEvent)
              print("Saved Event \(String(describing: event.title)) with start time \(String(describing: event.startDate)) successfully")
          } catch let error as NSError {
              print("failed to save event \(String(describing: event.title)) with start time \(String(describing: event.startDate)) with error : \(error)")
          }
        }
        else {
          print("failed to save event with error: error fetching it or access not granted")
        }
    }
}
#endif
