//
//  testProjectApp.swift
//  testProject
//
//  Created by awaleh moussa hassan on 06/11/2020.
//

import SwiftUI

@main
struct PYNApp: App {
    
    @Environment(\.scenePhase) var scenephase
    @ObservedObject var searchResultProvider = SearchResultProvider()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(searchResultProvider)
        }
        .onChange(of: scenephase){ newphase in
            switch newphase {
            case .active:
                self.searchResultProvider.loadFromDisc()
            case .background:
                self.searchResultProvider.saveToDisc()

            default:
                break
            }
        }
    }
}
