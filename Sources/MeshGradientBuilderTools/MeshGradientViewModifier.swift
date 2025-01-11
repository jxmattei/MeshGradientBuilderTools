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
    @State var isAnimating: Bool = true

    func body(content: Content) -> some View {
        content
            .task {
                guard item.next != item else { return }
                performAnimation()
            }
            .onDisappear {
                isAnimating = false
            }
    }

    func performAnimation() {
        withAnimation(animation) {
            if item.next != item {
                item = item.next
            }
        } completion: {
            guard isAnimating else { return }
            if loop || !loop && item.next != item.first {
                performAnimation()
            }
        }
    }
}


@available(iOS 18.0, macCatalyst 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
struct MeshGradientAnimationViewModifier: ViewModifier {
    @Binding var current: MeshGradient
    let meshGradient2: MeshGradient
    let animation: Animation

    init(animation: Animation, meshGradient1: Binding<MeshGradient>, meshGradient2: MeshGradient) {
        _current = meshGradient1
        self.meshGradient2 = meshGradient2
        self.animation = animation
    }

    func body(content: Content) -> some View {
        content
            .animation(animation, value: current)
            .task {
                current = meshGradient2
            }
    }

}

@available(iOS 18.0, macCatalyst 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
public extension View {
    func meshGradientAnimation(animation: Animation, meshGradient1: Binding<MeshGradient>, meshGradient2: MeshGradient) -> some View {
        modifier(MeshGradientAnimationViewModifier(animation: animation, meshGradient1: meshGradient1, meshGradient2: meshGradient2))
    }
}

@available(iOS 18.0, macCatalyst 18.0, macOS 15.0, tvOS 18.0, visionOS 2.0, watchOS 11.0, *)
public extension View {
    func cycleMeshGroupAnimation<MeshGroup: MeshGradientGroup>(_ meshGroup: Binding<MeshGroup>, animation: Animation = .easeInOut(duration: 4), loop: Bool = true) -> some View {
        modifier(CycleMeshGroupAnimationViewModifier(item: meshGroup, animation: animation, loop: loop))
    }
}
