import SwiftUI

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
