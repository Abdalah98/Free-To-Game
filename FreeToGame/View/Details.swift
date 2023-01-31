//
//  Details.swift
//  FreeToGame
//
//  Created by Abdallah on 25/01/2023.
//

import SwiftUI
import Kingfisher

struct Details: View {
  var id :Int?
  @Environment(\.presentationMode) var presentationMode

  @StateObject var vm = DetailsGameViewModel()
    var body: some View {
      ScrollView {
        images
          .shadow(color: Color.black.opacity(0.3), radius: 20 , x: 0 ,y: 10)

      VStack{
       
          VStack(alignment: .leading, spacing: 16){
            titleSection
            descriptionSection
            Divider()
            allDataSection
            Divider()
            minimumSystemRequirements
            Divider()
            openWebView
              .padding(.bottom,30)
            Spacer()
            Spacer()

          }
        }.padding()
      }.hiddenNavigationBarStyle()
      .ignoresSafeArea()
      .background(.ultraThinMaterial)
      .overlay(
        HStack(alignment: .center, spacing: 260){
          backButton
          shreLink
        }
        ,alignment: .topLeading)
      .onAppear {
        vm.getDetailsGames(id: id ?? 0 )
             }
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
      Details()
    }
}

extension Details {
   // to dismiss Transitions
  private var images : some View {
    TabView {
      ForEach(vm.screenshots){ imageData in
        
        KFImage(  URL(string: imageData.image ?? ""))
          .resizable()
          .scaledToFill()
          .frame(width: UIScreen.main.bounds.width)
          .clipped()
        
      }
    }
    .frame(height: 500)
    .tabViewStyle(PageTabViewStyle())
  }
  
  
  private var titleSection: some View{
    
    VStack(alignment: .leading){
      Text(vm.detailsGames?.title ?? "")
        .font(.largeTitle)
        .fontWeight(.semibold)
    }
  }
  
  
  private var descriptionSection: some View{
    VStack(alignment: .leading, spacing: 6){
      Text("Description:")
        .font(.headline)
      CollapsableTextView(vm.detailsGames?.description ?? "", lineLimit: 5)
       .font(.subheadline)
       .foregroundColor(.secondary)
      
    }
  }
  
  private var allDataSection: some View{
    VStack(alignment: .leading, spacing: 20){
      
      HStack{
        Text("Genre: ")
        Text(vm.detailsGames?.genre ?? "")
          .foregroundColor(.secondary)
      }
      
      HStack{
        Text("Date: ")
        Text(vm.detailsGames?.release_date ?? "")
          .foregroundColor(.secondary)
      }
      
      
      HStack{
        Text("Platform: ")
        Text(vm.detailsGames?.platform ?? "")
          .foregroundColor(.secondary)
      }
      
      HStack{
        Text("Publisher: ")
        Text(vm.detailsGames?.publisher ?? "")
          .foregroundColor(.secondary)
      }
      HStack{
        Text("Developer: ")
        Text(vm.detailsGames?.developer ?? "")
          .foregroundColor(.secondary)
      }
      HStack{
        Text("Status: ")
        Text(vm.detailsGames?.status ?? "")
          .foregroundColor(.secondary)
      }
      
    }
    .font(.headline)
  }
  
  private var minimumSystemRequirements : some View{
    VStack(alignment: .leading,spacing: 10){
      Text("Minimum System Requirements:")
        .font(.headline)
      HStack{
        Text("OS: ")
        Text(vm.detailsGames?.minimum_system_requirements?.os ?? "")
          .foregroundColor(.secondary)
      }
      HStack{
        Text("Processor: ")
        Text(vm.detailsGames?.minimum_system_requirements?.processor ?? "")
          .foregroundColor(.secondary)
      }
      HStack{
        Text("Graphics: ")
        Text(vm.detailsGames?.minimum_system_requirements?.graphics ?? "")
          .foregroundColor(.secondary)
      }
      HStack{
        Text("Storage: ")
        Text(vm.detailsGames?.minimum_system_requirements?.storage ?? "")
          .foregroundColor(.secondary)
      }
    } .font(.subheadline)
      
  }
  
  private var openWebView : some View {
    VStack{
      if let url = URL(string: vm.detailsGames?.game_url ?? ""){
        Link("View On Site", destination: url)
          .font(.headline)
          .padding()
          .tint(.white)
      }
    }
    .background(Color.blue)
    .cornerRadius(12)
  }
  
  private var backButton : some View{
    Button {
      //vm.sheetLoction = nil
      presentationMode.wrappedValue.dismiss()

    } label: {
      Image(systemName: "xmark")
        .font(.headline)
        .padding(16)
        .foregroundColor(.primary)
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(radius: 4)
        .padding()
    }
    
  }
  private var shreLink : some View{
    ShareLink(item: vm.detailsGames?.game_url ?? "", subject: Text(vm.detailsGames?.title ?? ""), message: Text(vm.detailsGames?.short_description ?? "")) {
      Image(systemName: "square.and.arrow.up")
    }
    .font(.headline)
    .padding(16)
    .foregroundColor(.primary)
    .background(.thickMaterial)
    .cornerRadius(10)
    .shadow(radius: 4)
    .padding()
  }
}




