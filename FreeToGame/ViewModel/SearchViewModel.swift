//
//  SearchViewModel.swift
//  FreeToGame
//
//  Created by Abdallah on 30/01/2023.
//

import Foundation
import Combine
class SearchViewModel : ObservableObject {
  
  @Published var searchResult :[GameListInfoElement]? = nil

  @Published var searchText = ""
  var searchCancellable :AnyCancellable? = nil
  var cancellbles = Set<AnyCancellable>()

  init(){
    searchCancellable = $searchText
      .removeDuplicates()
      .debounce(for: 0.6, scheduler: RunLoop.main)
      .sink(receiveValue: { str in
        if str == "" {
          self.searchResult = nil
        }else {
          self.searchGame()
        }
      })
    
  }
  
  
  func searchGame(){
    guard let urlString =  URL(string: "https://www.freetogame.com/api/games?category=\(searchText)" )else{return}
  URLSession.shared.dataTaskPublisher(for: urlString)
    .receive(on:DispatchQueue.main)
    .tryMap(handleOutput )
    .decode(type: [GameListInfoElement].self, decoder: JSONDecoder())
        .replaceError(with: [])
        .sink(receiveValue: { [weak self] returnGame in
          print(returnGame,"ffff")
          self?.searchResult  = returnGame
        })
       .store(in: &cancellbles)

}


func  handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
  guard let response = output.response as? HTTPURLResponse,response.statusCode >= 200 && response.statusCode < 300 else{throw URLError(.badServerResponse)}
  return output.data
}

}
