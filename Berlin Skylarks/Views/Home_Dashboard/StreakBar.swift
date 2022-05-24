//
//  StreakBar.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 24.05.22.
//

import SwiftUI

struct StreakBar: View {
    
    var value: Double
    var total: Double
    
    var body: some View {
        Section(
            header: Text("Visualization of current streak"),
            footer: Text("Blue indicates a losing streak, whereas red indicates a winning streak.")
        ){
            VStack {
                ProgressView(value: value, total: total)
                    .progressViewStyle(StreakProgressViewStyle())
                HStack {
                    Text("❄️")
                    //                        Spacer()
                    //                        Text("Even")
                    Spacer()
                    Text("🔥")
                }
                .font(.largeTitle)
                .padding(.bottom)
            }
        }
    }
}

struct StreakProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 30)
                .fill(LinearGradient(gradient: Gradient(colors: [.skylarksBlue, .skylarksRed]), startPoint: .leading, endPoint: .trailing))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 30)
//                        .stroke(Color.skylarksSand)
//                )
                .padding(.vertical)
                .overlay(
                    GeometryReader { geo in
                        Circle()
                            .fill(.white)
                            .shadow(color: .gray, radius: 2)
                            .frame(maxWidth: 25)
                        //12.5 points is half the radius of the circle to center it since GeometryReader aligns Views to the top left in stead of centered
                            .offset(x: geo.size.width * CGFloat(fractionCompleted) - 12.5, y: 0)
                    }
                )
        }
    }
}

struct StreakBar_Previews: PreviewProvider {
    static var previews: some View {
        List {
            StreakBar(value: 8, total: 20)
        }
    }
}
