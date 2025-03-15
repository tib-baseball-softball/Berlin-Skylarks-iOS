//
//  BallparkRow.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 06.08.22.
//

import SwiftUI

struct BallparkRow: View {
    @State var fieldObject: FieldObject
    
    @State var fieldImage = Image(systemName: "photo")
    
    var body: some View {
        HStack {
            if let url = fieldObject.field.photo_url {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
#if !os(watchOS)
                        .frame(maxWidth: 100, maxHeight: 100)
#else
                        .frame(width: 40, height: 40)
#endif
                } placeholder: {
                    ProgressView()
                        .padding()
                }
            }
            //            if let image = fieldObject.image {
            //                image
            //                    .resizable()
            //                    .scaledToFill()
            //                    .clipShape(Circle())
            //                    .frame(maxWidth: 100, maxHeight: 100)
            //            }
            Text(fieldObject.field.name)
            Spacer()
            //MARK: maybe change to ball icons in iOS 16
            LicenseSportIndicator(baseball: fieldObject.field.name.contains("Baseball") ? true : false)
        }
        .padding(.vertical)
        .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct BallparkRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            BallparkRow(fieldObject: FieldObject(field: previewField, image: nil))
            BallparkRow(fieldObject: FieldObject(field: previewField, image: Image("dummy_field")))
        }
        //.listStyle(.grouped)
    }
}
