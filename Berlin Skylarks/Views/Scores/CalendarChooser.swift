//
//  CalendarChooser.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 07.01.24.
//

import Foundation
import SwiftUI
import EventKit

#if canImport(EventKitUI)
import EventKitUI

struct CalendarChooser: UIViewControllerRepresentable {
    typealias UIViewControllerType = UINavigationController
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var calendarManager: CalendarManager
    
    /// Keeps track of the calendar the user selected in the calendar chooser view controller.
    @Binding var calendar: EKCalendar?
    
    func makeUIViewController(context: Context) -> UINavigationController {
        // Initializes a calendar chooser that allows the user to select a single calendar from a list of writable calendars only.
        let calendarChooser = EKCalendarChooser(selectionStyle: .single,
                                                displayStyle: .writableCalendarsOnly,
                                                entityType: .event,
                                                eventStore: calendarManager.eventStore)
        /*
            Set up the selected calendars property. If the user previously selected a calendar from the view controller, update the property with it.
            Otherwise, update selected calendars with an empty set.
        */
        if let calendar = calendar {
            let selectedCalendar: Set<EKCalendar> = [calendar]
            calendarChooser.selectedCalendars = selectedCalendar
        } else {
            calendarChooser.selectedCalendars = []
        }
        calendarChooser.delegate = context.coordinator
        
        // Configure the chooser to display Done and Cancel buttons.
        calendarChooser.showsDoneButton = true
        calendarChooser.showsCancelButton = true
        return UINavigationController(rootViewController: calendarChooser)
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, EKCalendarChooserDelegate {
        var parent: CalendarChooser
        
        init(_ controller: CalendarChooser) {
            self.parent = controller
        }
        
        /// The system calls this when the user taps Done in the UI. Save the user's choice.
        func calendarChooserDidFinish(_ calendarChooser: EKCalendarChooser) {
            parent.calendar = calendarChooser.selectedCalendars.first
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        /// The system calls this when the user taps Cancel in the UI. Dismiss the calendar chooser.
        func calendarChooserDidCancel(_ calendarChooser: EKCalendarChooser) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
#else

/// suboptimal attempt to replicate functionality of EventKitUI since it is unavailable on macOS
struct CalendarChooser: View {
    @Binding var calendar: EKCalendar?
    
    @EnvironmentObject var calendarManager: CalendarManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Choose Calendar")
                .font(.headline)
            
            List(calendarManager.calendars, id: \.calendarIdentifier) { cal in
                HStack {
                    Text(cal.title)
                    Spacer()
                    if cal == calendar {
                        Image(systemName: "checkmark")
                            .foregroundColor(.skylarksRed)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    calendar = cal
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .frame(minWidth: 300, minHeight: 400)
            
            HStack {
                Spacer()
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .keyboardShortcut(.cancelAction)
            }
            .padding()
        }
        .padding()
        .onAppear {
            Task {
                await calendarManager.loadCalendars()                
            }
        }
    }
}
#endif
