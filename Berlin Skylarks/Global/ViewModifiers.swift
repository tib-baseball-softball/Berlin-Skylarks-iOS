//
//  ViewModifiers.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 17.11.21.
//

import Foundation
import SwiftUI

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

//Usage:

//Text("Hello World")
//    .iOS { $0.padding(10) }

//these two are copy and paste and should make reading and storing custom values (Team) in user settings easier

extension View {
    typealias ContentTransform<Content: View> = (Self) -> Content

    @ViewBuilder
    func conditionalModifier<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        ifTrue: ContentTransform<TrueContent>,
        ifFalse: ContentTransform<FalseContent>
    ) -> some View {
        if condition {
            ifTrue(self)
        } else {
            ifFalse(self)
        }
    }
}

#if !os(watchOS) && !os(macOS)
extension UIApplication {
    static var appName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String
    }
    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
#endif



struct ClubIconStyleDynamic: ViewModifier {
    func body(content: Content) -> some View {
        #if !os(watchOS)
        content
            .frame(width: 25, height: 20, alignment: .center)
            .font(.title2)
            .foregroundColor(.skylarksDynamicNavySand)
        #else
        content
            .frame(width: 20, height: 20, alignment: .center)
            .foregroundColor(.skylarksSand)
        #endif
    }
}

extension View {
    func clubIconStyleDynamic() -> some View {
        modifier(ClubIconStyleDynamic())
    }
}

struct ClubIconStyleRed: ViewModifier {
    func body(content: Content) -> some View {
#if !os(watchOS)
        content
            .frame(width: 25, height: 20, alignment: .center)
            .font(.title2)
            .foregroundColor(.skylarksRed)
#else
        content
            .frame(width: 20, height: 20, alignment: .center)
            .foregroundColor(.skylarksRed)
#endif
    }
}

extension View {
    func clubIconStyleRed() -> some View {
        modifier(ClubIconStyleRed())
    }
}

//  this is needed because even though the Apple Watch always uses a dark interface,
//  it does not count as "dark mode" for the purpose of selecting the color with the appropriate contrast

struct ColorDynamicNavySandWatchOS: ViewModifier {
    func body(content: Content) -> some View {
#if !os(watchOS)
        content
            .foregroundColor(.skylarksDynamicNavySand)
#else
        content
            .foregroundColor(.skylarksSand)
#endif
    }
}

extension View {
    func colorDynamicNavySandWatchOS() -> some View {
        modifier(ColorDynamicNavySandWatchOS())
    }
}
