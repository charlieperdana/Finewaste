//
//  View+retrieveScrollPosition.swift
//  Finewaste
//
//  Created by Andrean Lay on 07/11/21.
//

import SwiftUI

extension View {
    public func trackScrollPosition(coordinateSpace: CoordinateSpace) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: ScrollOffsetPrefKey.self,
                    value: -proxy.frame(in: coordinateSpace).origin.y
                )
            }
        )
    }
    
    public func getScrollPosition(_ offset: Binding<Double>) -> some View {
        onPreferenceChange(ScrollOffsetPrefKey.self) { value in
            offset.wrappedValue = value / (UIScreen.main.bounds.width / 2)
        }
    }
}

struct ScrollOffsetPrefKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
