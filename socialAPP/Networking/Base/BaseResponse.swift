//
//  BaseResponse.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 14/11/2022.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    var success: Bool?
    var page:Page?
    var data: T?
    var status: String?
    var message: String?
    enum CodingKeys: String, CodingKey {
       // case status = "status"
        case data = "data"
        case message = "message"
        case success = "success"
    }
}

struct Page:Codable {
    var current: Int?
    var pages: Int?
    var has_next: Bool?
    var has_previous: Bool?
}
//struct Page:Codable{
//    var current: Int?
//    var pages: Int?
//    var has_next: Bool?
//    var has_previous: Bool?
//}
