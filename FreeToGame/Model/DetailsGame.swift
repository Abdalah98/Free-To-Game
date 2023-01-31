//
//  DetailsGame.swift
//  FreeToGame
//
//  Created by Abdallah on 25/01/2023.
//

import Foundation
// MARK: - DetailsGame
struct DetailsGame : Codable,Identifiable {
  let id : Int?
  let title : String?
  let thumbnail : String?
  let status : String?
  let short_description : String?
  let description : String?
  let game_url : String?
  let genre : String?
  let platform : String?
  let publisher : String?
  let developer : String?
  let release_date : String?
  let freetogame_profile_url : String?
  let minimum_system_requirements : Minimum_system_requirements?
  let screenshots : [Screenshots]?

  enum CodingKeys: String, CodingKey {

    case id = "id"
    case title = "title"
    case thumbnail = "thumbnail"
    case status = "status"
    case short_description = "short_description"
    case description = "description"
    case game_url = "game_url"
    case genre = "genre"
    case platform = "platform"
    case publisher = "publisher"
    case developer = "developer"
    case release_date = "release_date"
    case freetogame_profile_url = "freetogame_profile_url"
    case minimum_system_requirements = "minimum_system_requirements"
    case screenshots = "screenshots"
  }


}
struct Minimum_system_requirements : Codable {
let os : String?
let processor : String?
let memory : String?
let graphics : String?
let storage : String?



}
struct Screenshots : Codable,Identifiable {
  let id : Int?
  let image : String?
}
