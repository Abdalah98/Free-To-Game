//
//  DetailsGameViewModel.swift
//  FreeToGame
//
//  Created by Abdallah on 25/01/2023.
//

import Foundation
import Combine
class DetailsGameViewModel : ObservableObject {
  
  @Published var detailsGames: DetailsGame?
  @Published var screenshots =  [Screenshots]()
  @Published var isLoading = false
  @Published var showAlert = ""
  var cancellbles = Set<AnyCancellable>()

  
  func getDetailsGames(id : Int){
    isLoading = true
    guard let urlString =  URL(string: "https://www.freetogame.com/api/game?id=\(id)" )else{return}
    URLSession.shared.dataTaskPublisher(for: urlString)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on:DispatchQueue.main)
      .tryMap(handleOutput )
      .decode(type: DetailsGame.self, decoder: JSONDecoder())
      .sink { completion in
        print(completion)
      } receiveValue: {[weak self] returnGame in
        self?.detailsGames  = returnGame
        self?.screenshots = returnGame.screenshots ?? []
      }
          .store(in: &cancellbles)
  }
  
 
  func  handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
    self.isLoading = false
    guard let response = output.response as? HTTPURLResponse,response.statusCode >= 200 && response.statusCode < 300 else{throw URLError(.badServerResponse)}
    return output.data
  }

  


}
