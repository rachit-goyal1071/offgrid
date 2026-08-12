import SwiftUI

struct SkeletonView: View {
    @Environment(Theme.self) private var theme
    var body: some View {
        ZStack {
            theme.bgBase.ignoresSafeArea()
            ProgressView()
        }
    }
}
