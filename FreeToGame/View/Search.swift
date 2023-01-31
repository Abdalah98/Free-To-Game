//
//  Search.swift
//  FreeToGame
//
//  Created by Abdallah on 30/01/2023.
//

import SwiftUI
import Kingfisher
struct Search: View {
  @StateObject var vm = SearchViewModel()
  @State var  showAlert = false

  var body: some View {
    NavigationView{
      ScrollView(.vertical,showsIndicators: false,content: {
        
        searchBar
        
        if let searchResponse = vm.searchResult{
          if searchResponse.isEmpty{
            Text("No Results Found")
              .padding(.top,20)
          }else{
            ForEach(searchResponse) { data in
              
              NavigationLink(destination:  Details(id: data.id)) {
                
                HStack(spacing:8){
                  KFImage(URL(string: data.thumbnail ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 140,height: 140)
                    .cornerRadius(16)
                  VStack(alignment: .leading,spacing: 8){
                    Text(data.title ?? "")
                      .foregroundColor(.black)
                      .font(.headline)
                      .fontWeight(.semibold)
                    Text(data.shortDescription ?? "")
                      .lineLimit(2)
                      .font(.subheadline)
                      .foregroundColor(.secondary)
                    HStack{
                      Text(data.genre ?? "")
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.blue)
                        .cornerRadius(8)
                      Text("Free")
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color.blue)
                        .cornerRadius(8)
                      
                    }
                  }
                }.padding(.leading)
              }
            }
            
          }
        }
        else{
          if vm.searchText != "" {
            ProgressView()
              .padding(.top,20)
          }
        }
      })
      
      .navigationTitle("Search")
    }
  }
}

struct Search_Previews: PreviewProvider {
  static var previews: some View {
    Search()
  }
}

extension Search{
  private  var searchBar : some View {
    VStack(spacing: 15){
      HStack(spacing: 15){
        Image(systemName: "magnifyingglass")
          .foregroundColor(.gray)
        
        TextField("Search Game Category ",text: $vm.searchText)
        infoButtonSearchBar
      }
      .padding(.vertical,10)
      .padding(.horizontal)
      .background(Color.white)
      .cornerRadius(12)
      .shadow(color: Color.black.opacity(0.06),radius: 5,x: 5,y: 5)
      .shadow(color: Color.black.opacity(0.06),radius: 5,x: -5,y: -5)
      
    }
    .padding()
  }
  
  private  var infoButtonSearchBar : some View {
    
    Button {
      showAlert.toggle()
    
    } label: {
      Image(systemName: "info.circle.fill")
        .foregroundColor(Color.gray)
    }
    .alert(isPresented: $showAlert) {

      Alert(title: Text("List of categories you are looking for")
            ,message: Text("mmorpg, shooter, strategy, moba, racing, sports, social, sandbox, open-world, survival, pvp, pve, pixel, voxel, zombie, turn-based, first-person, third-Person, top-down, tank, space, sailing, side-scroller, superhero, permadeath, card, battle-royale, mmo, mmofps, mmotps, 3d, 2d, anime, fantasy, sci-fi, fighting, action-rpg, action, military, martial-arts, flight, low-spec, tower-defense, horror, mmorts")
        .font(.body))
    }
    }
}

