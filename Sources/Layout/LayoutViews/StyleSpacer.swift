//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleDefinitions
import SwiftUI

public struct StyleSpacer: View {

    @Environment(\.style) var style

    private let minLength: Style.NumberKey.ValueBuilderKeyPath?
    private let length: Style.NumberKey.ValueBuilderKeyPath?
    
    public init(_ length: Style.NumberKey.ValueBuilderKeyPath = \.spacingElements) {
        self.minLength = nil
        self.length = length
    }

    public init(min: Style.NumberKey.ValueBuilderKeyPath) {
        self.minLength = min
        self.length = nil
    }

    public var body: some View {
        let valueMin: CGFloat? = if let value = style.number(for: minLength) { CGFloat(value) } else { nil }
        let valueLength: CGFloat? = if let value = style.number(for: length) { CGFloat(value) } else { nil }
        Spacer(minLength: valueMin)
            .frame(width: valueLength ?? nil)
            .layoutPriority(-1) // Without reduced priority it stretches before a text is stretched.
    }

}


// MARK: - Preview

#Preview {
    VStack {
        HStack {
            Text("Some Content")
                .background(.orange)
            StyleSpacer(min: \.spacingElements)
            Text("Some Content")
                .background(.orange)
        }
        .stretch()
        
        HStack {
            Text("Some Content")
                .background(.orange)
            StyleSpacer(\.spacingElements)
            Text("Some Content")
                .background(.orange)
        }
        .stretch()
        
        HStack {
            Text("Some Content with more ")
                .background(.orange)
            StyleSpacer(min: \.spacingElements)
            Text("Some Content with more text")
                .background(.orange)
        }
        .stretch()
        
        HStack {
            Text("Some Content with more ")
                .background(.orange)
            StyleSpacer(\.spacingElements)
            Text("Some Content with more text")
                .background(.orange)
        }
        .stretch()
        
        HStack {
            Text("Some Content")
                .background(.orange)
            StyleSpacer(\.spacingElements)
            Text("Some Content")
                .background(.orange)
        }
        .stretch()
        .style(scaleFactor: 5)
        
        HStack {
            Rectangle()
                .frame(width: 150)
            StyleSpacer(min: \.spacingElements)
            Rectangle()
                .frame(width: 60)
        }
        
        HStack {
            Rectangle()
                .frame(width: 150)
            StyleSpacer(\.spacingElements)
            Rectangle()
                .frame(width: 60)
        }
        
        HStack {
            Rectangle()
                .frame(width: 250)
            StyleSpacer(min: \.spacingElements)
            Rectangle()
                .frame(width: 250)
        }
        
        HStack {
            Rectangle()
                .frame(width: 250)
            StyleSpacer(\.spacingElements)
            Rectangle()
                .frame(width: 250)
        }
    }
    .frame(width: 350)
    .background(.yellow)
}
