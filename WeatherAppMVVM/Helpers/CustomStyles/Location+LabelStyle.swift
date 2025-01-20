import SwiftUI

struct TitleWithIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
                .font(.title)
                .fontWeight(.semibold)
            
            configuration.icon
                .imageScale(.large)
        }
    }
}

// MARK: - Convenience Extension

extension LabelStyle where Self == TitleWithIconLabelStyle {
    static var titleWithIcon: TitleWithIconLabelStyle { .init() }
}
