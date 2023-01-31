//
//  AllGameViewModel.swift
//  FreeToGame
//
//  Created by Abdallah on 25/01/2023.
//

import Foundation
import Combine

class AllGameViewModel : ObservableObject {
  
 @Published var allGame = [GameListInfoElement]()
  @Published var isLoading : Bool = false
  @Published var showAlert  : Bool = false
  @Published var titleAlert = ""
  @Published  var id:Int = 0
  var cancellbles = Set<AnyCancellable>()
  init (){
    getListDataOFGames()
  }
  
  func getListDataOFGames(){
    
    // refactor code
//    URLSession.shared.dataTaskPublisher(for: urlString)
//      .subscribe(on: DispatchQueue.global(qos: .background))
//      .receive(on:DispatchQueue.main)
//      .tryMap { (data,response) -> Data in
//        guard let response = response as? HTTPURLResponse,response.statusCode >= 200 && response.statusCode < 300 else{throw URLError(.badServerResponse)}
//        return data
//      }
//      .decode(type: [GameListInfoElement].self, decoder: JSONDecoder())
//      .sink { completion in
//        print(completion)
//      } receiveValue: { [weak self] returnGame in
//        self?.allGame  = returnGame
//      }
//      .store(in: &cancellbles)

    isLoading = true
    guard let urlString =  URL(string: "https://www.freetogame.com/api/games" )else{return}
    URLSession.shared.dataTaskPublisher(for: urlString)
      .receive(on:DispatchQueue.main)
      .tryMap(handleOutput )
          .decode(type: [GameListInfoElement].self, decoder: JSONDecoder())
          .replaceError(with: [])
          .sink(receiveValue: { [weak self] returnGame in
            self?.allGame  = returnGame
          })
          .store(in: &cancellbles)

  }
  
 
  func  handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
    self.isLoading = false
    guard let response = output.response as? HTTPURLResponse,response.statusCode >= 200 && response.statusCode < 300 else{throw URLError(.badServerResponse)}
    return output.data
  }

}
  
