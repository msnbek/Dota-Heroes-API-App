//
//  HeroStruct.swift
//  Dota Heroes API App
//
//  Created by Mahmut Şenbek on 15.11.2022.
//

import Foundation

struct HeroStruct : Decodable {
    let localized_name : String
    let primary_attr : String
    let attack_type : String
    let legs : Int
    let img : String
}
