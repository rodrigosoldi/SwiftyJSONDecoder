//
//  File.swift
//  
//
//  Created by Soldi on 08/09/22.
//

import Foundation

public protocol DefaultCaseCodable: RawRepresentable {
    static var defaultCase: Self { get }
}

public extension DefaultCaseCodable where Self: Decodable, Self.RawValue: Decodable {
    init(from decoder: Decoder) throws {
        guard let container = try? decoder.singleValueContainer(),
            let rawValue = try? container.decode(RawValue.self) else {
            self = Self.defaultCase
            return
        }

        self = Self.init(rawValue: rawValue) ?? Self.defaultCase
    }
}

public protocol DecodingKeysMapCodable {
    static var decodingKeysMap: [String: String] { get }
}
