//
//  Home.swift
//  FreeToGame
//
//  Created by Abdallah on 30/01/2023.
//

import SwiftUI

struct Home: View {
  
    var body: some View {
      TabView{
        ContentView()
          .tabItem {
            Image(systemName: "gamecontroller.fill")
            Text("All Games")
          }
        Search()
          .tabItem {
            Image(systemName: "magnifyingglass")
            Text("Search")
          }
      }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
