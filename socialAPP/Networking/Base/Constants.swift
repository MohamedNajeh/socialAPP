//
//  Constants.swift
//  lnkr-clinic
//
//  Created by MohamedNajeh on 15/11/2022.
//

import Foundation
enum ErrorMessages: String,Error{
    case noInternet                   = "No Internet Please Check Your Connection"
    case invalidUrl                   = "invalid URL, Please try again later"
    case invalidResponse              = "Invalid response from the server, Please try again later"
    case invalidData                  = "The data recived from the server is invalid"
    case invalidDataAfterDecoding     = "Invalid after decoding"
    case errorRetivingFromLocal       = "Couldn't retrive from Local storage"
    case errorSavingDataLocally       = "Couldn't save to Local storage"
}

enum URLs:String {
    case baseURL = "https://jsonplaceholder.typicode.com"
}
