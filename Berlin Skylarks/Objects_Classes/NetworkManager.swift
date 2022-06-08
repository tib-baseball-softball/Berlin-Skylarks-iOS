//
//  NetworkManager.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 08.06.22.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    
    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
           
            if path.status == .satisfied {
                print("Yay! We have internet!")
            
                self.isConnected = true
            } else {
                print("No internet!")
                self.isConnected = false
            }
            }
        }
        monitor.start(queue: queue)
    }
}
