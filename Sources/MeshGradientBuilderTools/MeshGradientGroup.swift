//
//  MeshGradientGroup.swift
//  MeshGradientBuilderHelper
//
//  Created by Jorge Mattei on 1/7/25.
// 

import SwiftUI

@available(iOS 18.0, macCatalyst 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
public protocol MeshGradientGroup: CaseIterable, Equatable, Sendable {
    static func meshGradient(for state: Self) -> MeshGradient
}

@available(iOS 18.0, macCatalyst 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
public extension MeshGradientGroup {
    var meshGradient: MeshGradient {
        Self.meshGradient(for: self)
    }

    var first: Self { Self.allCases.first! }

    var next: Self {
        let allcases = Self.allCases
        let index = allcases.firstIndex(of: self)!
        if allcases.index(index, offsetBy: 1) == allcases.endIndex {
            return allcases.first!
        } else {
            let nextIndex = allcases.index(index, offsetBy: 1)
            return allcases[nextIndex]
        }
    }
}



