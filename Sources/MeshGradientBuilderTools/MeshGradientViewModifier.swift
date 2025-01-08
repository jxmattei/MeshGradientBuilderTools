//
//  MeshGradientViewModifier.swift
//  MeshGradientBuilderHelper
//
//  Created by Jorge Mattei on 1/7/25.
//

import SwiftUI

@available(iOS 18.0, macCatalyst 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
struct CycleMeshGroupAnimationViewModifier<MeshGroup: MeshGradientGroup>: ViewModifier {
    @Binding public var item: MeshGroup
    var animation: Animation = .easeInOut(duration: 4)
    var loop: Bool = true

    func body(content: Content) -> some View {
        content
            .task {
                performAnimation()
        }
    }

    func performAnimation() {
        withAnimation(animation) {
            item = item.next
        } completion: {
            if loop || !loop && item.next != item.first {
                performAnimation()
            }
        }
    }
}
@available(iOS 18.0, macCatalyst 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
public extension View {
    func cycleMeshGroupAnimation<MeshGroup: MeshGradientGroup>(_ meshGroup: Binding<MeshGroup>, animation: Animation = .easeInOut(duration: 4), loop: Bool = true) -> some View {
        modifier(CycleMeshGroupAnimationViewModifier(item: meshGroup, animation: animation, loop: loop))
    }
}
