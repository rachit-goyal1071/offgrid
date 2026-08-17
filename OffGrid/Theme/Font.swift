import SwiftUI
import UIKit

@MainActor
extension Font {
    public static let displayXL = Font.custom("SpaceGrotesk-SemiBold", size: 40.0, relativeTo: .largeTitle)
    public static let displayL = Font.custom("SpaceGrotesk-SemiBold", size: 32.0, relativeTo: .largeTitle)
    public static let titleL = Font.custom("SpaceGrotesk-SemiBold", size: 26.0, relativeTo: .title)
    public static let titleM = Font.custom("SpaceGrotesk-SemiBold", size: 24.0, relativeTo: .title2)
    public static let titleS = Font.custom("SpaceGrotesk-SemiBold", size: 22.0, relativeTo: .title3)
    public static let heading = Font.custom("SpaceGrotesk-Medium", size: 15.0, relativeTo: .headline)
    public static let chipL = Font.custom("SpaceGrotesk-Medium", size: 14.0, relativeTo: .callout)
    public static let chipS = Font.custom("SpaceGrotesk-Medium", size: 12.5, relativeTo: .caption)
    public static let buttonL = Font.custom("SpaceGrotesk-SemiBold", size: 16.0, relativeTo: .body)
    public static let buttonM = Font.custom("SpaceGrotesk-SemiBold", size: 14.0, relativeTo: .callout)
    public static let body = Font.system(size: 14.0)
    public static let bodyS = Font.system(size: 13.0)
    public static let caption = Font.system(size: 11.5)
    public static let monoStamp = Font.custom("IBMPlexMono-Regular", size: 10.0, relativeTo: .caption2)
}

@MainActor
extension UIFont {
    public static let displayXL = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: UIFont(name: "SpaceGrotesk-SemiBold", size: 40.0) ?? .systemFont(ofSize: 40.0))
    public static let displayL = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: UIFont(name: "SpaceGrotesk-SemiBold", size: 32.0) ?? .systemFont(ofSize: 32.0))
    public static let titleL = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont(name: "SpaceGrotesk-SemiBold", size: 26.0) ?? .systemFont(ofSize: 26.0))
    public static let titleM = UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: "SpaceGrotesk-SemiBold", size: 24.0) ?? .systemFont(ofSize: 24.0))
    public static let titleS = UIFontMetrics(forTextStyle: .title3).scaledFont(for: UIFont(name: "SpaceGrotesk-SemiBold", size: 22.0) ?? .systemFont(ofSize: 22.0))
    public static let heading = UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "SpaceGrotesk-Medium", size: 15.0) ?? .systemFont(ofSize: 15.0))
    public static let chipL = UIFontMetrics(forTextStyle: .callout).scaledFont(for: UIFont(name: "SpaceGrotesk-Medium", size: 14.0) ?? .systemFont(ofSize: 14.0))
    public static let chipS = UIFontMetrics(forTextStyle: .caption1).scaledFont(for: UIFont(name: "SpaceGrotesk-Medium", size: 12.5) ?? .systemFont(ofSize: 12.5))
    public static let buttonL = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "SpaceGrotesk-SemiBold", size: 16.0) ?? .systemFont(ofSize: 16.0))
    public static let buttonM = UIFontMetrics(forTextStyle: .callout).scaledFont(for: UIFont(name: "SpaceGrotesk-SemiBold", size: 14.0) ?? .systemFont(ofSize: 14.0))
    public static let body = UIFont.systemFont(ofSize: 14.0)
    public static let bodyS = UIFont.systemFont(ofSize: 13.0)
    public static let caption = UIFont.systemFont(ofSize: 11.5)
    public static let monoStamp = UIFontMetrics(forTextStyle: .caption2).scaledFont(for: UIFont(name: "IBMPlexMono-Regular", size: 10.0) ?? .systemFont(ofSize: 10))
}
