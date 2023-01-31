//
//  GameListInfo.swift
//  FreeToGame
//
//  Created by Abdallah on 25/01/2023.
//

import Foundation
// MARK: - GameListInfoElement
struct GameListInfoElement :Codable ,Identifiable{
    var id: Int?
    var title: String?
    var thumbnail: String?
    var shortDescription: String?
    var gameURL: String?
    var genre, platform, publisher, developer: String?
    var releaseDate: String?
    var freetogameProfileURL: String?
  
  enum CodingKeys: String , CodingKey{
       case  id ,title ,thumbnail,genre, platform, publisher, developer
       case  shortDescription = "short_description"
       case gameURL =  "game_url"
        case releaseDate = "release_date"
        case freetogameProfileURL = "freetogame_profile_url"
  }
}
