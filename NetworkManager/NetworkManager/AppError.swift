//
//  AppError.swift
//  NetworkManager
//
//  Created by Rahul Thengadi on 30/03/22.
//

import Foundation

public enum AppError: Error {
  case badURL(String) // associated value
  case noResponse
  case networkClientError(Error) // no internet connection
  case noData
  case decodingError(Error)
  case badStatusCode(Int) // 404, 500
  case badMimeType(String) // image/jpg
}
