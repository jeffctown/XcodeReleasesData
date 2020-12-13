//
//  Xcode.swift
//  xcodereleases
//
//  Created by Xcode Releases on 4/3/18.
//  Copyright © 2018 Xcode Releases. All rights reserved.
//

import Foundation

public struct Xcode: Codable {
    public var id: Int?
    public let name: String
    public let version: Version
    public let date: YMD
    public let requires: String
    public let sdks: SDKs?
    public let compilers: Compilers?
    public let links: Links?
    public let checksums: Checksums?
    
    public init(name: String = "Xcode", version: Version, date: (Int, Int, Int), requires: String, sdks: SDKs? = nil, compilers: Compilers? = nil, links: Links? = nil, checksums: Checksums? = nil) {
        self.name = name
        self.version = version;
        self.date = YMD(date);
        self.requires = requires;
        self.sdks = sdks;
        self.compilers = compilers
        self.links = links
        self.checksums = checksums
    }
}

// MARK: - Protocol Identifiable
extension Xcode: Identifiable { }

// MARK: - Protocol CustomStringConvertible
extension Xcode: CustomStringConvertible {
    public var description: String {
        var display = "\(name)"
        if let number = version.number {
            display += " \(number)"
        }
        display += " \(version.release)"
        return display
    }
}

// MARK: - Protocol Equatable
extension Xcode: Equatable {
    public static func == (lhs: Xcode, rhs: Xcode) -> Bool {
        guard lhs.date.year == rhs.date.year,
            lhs.date.month == rhs.date.month,
            lhs.date.day == rhs.date.day,
            lhs.description == rhs.description,
            lhs.name == rhs.name else {
                return false
        }
        return true
    }
}

// MARK: - Protocol Hashable
extension Xcode: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(version.build)
        hasher.combine(version.number)
    }
}

// MARK: - Sequence Sorting
extension Sequence where Element == Xcode {
    public func sortedByDate() -> [Element] {
        return self.sorted {
            guard let date0 = $0.date.components.date else {
                return false
            }
            guard let date1 = $1.date.components.date else {
                return false
            }
            return date0.compare(date1) == .orderedAscending
        }
    }
}
