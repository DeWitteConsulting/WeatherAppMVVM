
import SwiftUI

// MARK: - View Extension

extension View {
    func errorAlert(error: Binding<Error?>,
                    buttonTitle: String = "OK") -> some View {
        modifier(
            ErrorAlertViewModifier(
                error: error,
                buttonTitle: buttonTitle
            )
        )
    }
}
