//
//  ViewModifiers.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 17.11.21.
//

import Foundation
import SwiftUI

extension Color {
    static let skylarksRed = Color(red: 186 / 255, green: 12 / 255, blue: 47 / 255)
    static let skylarksBlue = Color(red: 4 / 255, green: 30 / 255, blue: 66 / 255)
    static let skylarksSand = Color(red: 206 / 255, green: 184 / 255, blue: 136 / 255)
    //this is not adapting to dark mode!
    static let backgroundGrayPreview = Color(red: 58 / 255, green: 58 / 255, blue: 60 / 255)
    //static let background = Color(UIColor.systemBackground)
}

extension View {
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func tvOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(tvOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    func watchOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(watchOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

//these two are copy and paste and should make reading and storing custom values (Team) in user settings easier

extension UserDefaults {
  func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
    let encoded = try? JSONEncoder().encode(data)
    set(encoded, forKey: defaultName)
  }
}

//// Usage:
//let key = "foo_key"
//let codableObject = CodableObject(value: 100)
//UserDefaults.standard.setCodableObject(codableObject, forKey: key)

extension UserDefaults {
  func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
    guard let userDefaultData = data(forKey: key) else {
      return nil
    }
    return try? JSONDecoder().decode(T.self, from: userDefaultData)
  }
}

//// Usage:
//let key = "foo_key"
//if let retrievedCodableObject = UserDefaults.standard.codableObject(dataType: CodableObject.self, key: key) {
//  print("\(retrievedCodableObject.value)")
//} else {
//  print("Not yet saved with key \(key)")
//}
