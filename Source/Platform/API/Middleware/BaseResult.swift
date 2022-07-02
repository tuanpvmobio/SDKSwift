//
//  BaseResult.swift
//  Movie

import Foundation

enum BaseResult<T: Codable> {
    case success(T?)
    case failure(error: BaseError?)
}
