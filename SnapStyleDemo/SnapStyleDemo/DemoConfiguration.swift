//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Observation
import SnapStyle
import SwiftUI

@Observable
class DemoConfiguration {

    var accentPrimary: SnapStyle.Accent
    var accentSecondary: SnapStyle.Accent

    var scaleFactor: SnapStyle.Context.ScaleFactor
    
    var fontDesign: Font.Design?

    var fontWidth: Font.Width?

    init(
        accentPrimary: SnapStyle.Accent = SnapStyle.Accent.fallbackPrimary,
        accentSecondary: SnapStyle.Accent = SnapStyle.Accent.fallbackSecondary,
        scaleFactor: SnapStyle.Context.ScaleFactor = SnapStyle.Context.scaleFactorDefault,
        fontDesign: Font.Design? = SnapStyle.Context.fontDesignDefault,
        fontWidth: Font.Width? = SnapStyle.Context.fontWidthDefault,
        cornerRadius: CornerRadiusOption = .medium,
    ) {
        self.accentPrimary = accentPrimary
        self.accentSecondary = accentSecondary
        self.scaleFactor = scaleFactor
        self.fontDesign = fontDesign
        self.fontWidth = fontWidth
        self.cornerRadius = cornerRadius
    }


// MARK: - Corner Radius

    var cornerRadius: CornerRadiusOption
    
    enum CornerRadiusOption: String, CaseIterable {
        case small, medium, large
        
        var valueComponent: SnapStyle.NumberKey.ValueBuilderKeyPath {
            switch self {
                case .small: \.cornerRadiusMedium
                case .medium: \.cornerRadiusLarge
                case .large: \.cornerRadiusLargest
            }
        }
        var valueMetricCard: SnapStyle.NumberKey.ValueBuilderKeyPath {
            switch self {
                case .small: \.cornerRadiusSmallest
                case .medium: \.cornerRadiusSmall
                case .large: \.cornerRadiusMedium
            }
        }
    }
}


// MARK: - Environment

extension EnvironmentValues {

    @Entry var demoConfiguration: DemoConfiguration = DemoConfiguration()

}
