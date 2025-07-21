//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyle
import SwiftUI

struct DemoMetricCard: View {
    
    static var exampleRectangle: Self { DemoMetricCard(icon: "rectangle", value: "\(Int.random(in: 1..<999))", title: "Rectangle") }
    static var exampleTriangle: Self { DemoMetricCard(icon: "triangle", value: "\(Int.random(in: 1..<999))", title: "Triangle") }
    static var exampleCircle: Self { DemoMetricCard(icon: "circle", value: "\(Int.random(in: 1..<999))", title: "Circle") }
    
    let icon: String
    let value: String
    let title: String
    
    var body: some View {
            CornerContainer {
                Image(systemName: icon)
                    .style(element: .icon)
            } topTrailing: {
                Text(value)
                    .style(element: .value)
            } bottomLeading: {
                Text(title)
                    .style(element: .title, hierarchy: .primary)
            } bottomTrailing: {
                
            }
            .style(component: .metricCard)
    }
}


// MARK: - Preview

#Preview {
    StyleScreen {
        StyleStack(.horizontal, spacing: \.spacingElements) {
            DemoMetricCard.exampleRectangle
            DemoMetricCard.exampleTriangle
            DemoMetricCard.exampleCircle
        }
    }
}
