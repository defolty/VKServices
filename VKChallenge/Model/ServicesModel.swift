//
//  ServiceModel.swift
//  VKChallenge
//
//  Created by Nikita Nesporov on 14.07.2022.
//

import Foundation

struct AllData: Decodable {
    let body: Results
    let status: Int
}
 
struct Results: Decodable {
    let services: [Service]
}
 
struct Service: Decodable {
    let name, serviceDescription: String
    let link: String
    let iconURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case serviceDescription = "description"
        case link
        case iconURL = "icon_url"
    }
}
