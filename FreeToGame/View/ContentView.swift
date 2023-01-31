//
//  ContentView.swift
//  FreeToGame
//
//  Created by Abdallah on 25/01/2023.
//

import SwiftUI
import Kingfisher
struct ContentView: View {
  
  @StateObject var vm = AllGameViewModel()

  var body: some View {
    
    NavigationView {
      List{
          cellView
      }  .navigationTitle("Free To Games")
          .overlay {if vm.isLoading {ProgressView("Loading")}
       }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AllGameViewModel())
      
    }
}

extension ContentView {
  private var cellView : some View {
    ForEach(vm.allGame) { data in
      NavigationLink(destination:  Details(id: data.id)) {

        HStack(spacing:8){
          KFImage(URL(string: data.thumbnail ?? ""))
            .resizable()
            .scaledToFill()
            .frame(width: 140,height: 140)
            .cornerRadius(16)
          VStack(alignment: .leading,spacing: 8){
            Text(data.title ?? "")
            
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
        }
      }
           
    } .alert(isPresented: $vm.showAlert) {
      
      Alert(title: Text(vm.titleAlert))
    }
  }
}
