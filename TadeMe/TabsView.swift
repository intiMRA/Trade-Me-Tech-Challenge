//
//  TabsView.swift
//  TadeMe
//
//  Created by Inti Albuquerque on 21/01/22.
//

import Foundation
import SwiftUI

struct TabsView: View {
    
    var body: some View {
        TabView {
            NavigationView {
                ListingsView()
            }
            .tabItem {
                VStack {
                    Image(iconName: .search)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("LatestListings")
                }
            }
            
            
            NavigationView {
                WatchListView()
            }
            .tabItem {
                VStack {
                    Image(iconName: .magnet)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Watchlist")
                }
            }
            
            
            NavigationView {
                MyTradeMeView()
            }
            .tabItem {
                VStack {
                    Image(iconName: .profile)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("MyTradeMe")
                }
            }
            
            
        }
    }
}
