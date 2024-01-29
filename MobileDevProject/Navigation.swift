//
//  Navigation.swift
//  MobileDevProject
//
//  Created by Baptiste Keunebroek on 29/01/2024.
//

import Foundation

import SwiftUI

struct Navigation: View {
    var body: some View {
        TabView {
            
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            AllActivitiesView()
                .tabItem {
                    Label("Activities", systemImage: "list.bullet")
                }
        }
        
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation()
    }
}
