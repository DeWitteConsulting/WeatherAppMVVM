
import SwiftUI

// MARK: - Error Alert ViewModifier

struct ErrorAlertViewModifier: ViewModifier {
    @Binding private var error: Error?
    private let buttonTitle: String
    
    init(error: Binding<Error?>, buttonTitle: String = "OK") {
        _error = error
        self.buttonTitle = buttonTitle
    }
    
    func body(content: Content) -> some View {
        let localizedAlertError = LocalizedAlertError(error: error)
        
        return content.alert(isPresented: .constant(localizedAlertError != nil),
                             error: localizedAlertError) { _ in
            Button(buttonTitle) {
                error = nil
            }
        } message: { error in
            Text(error.recoverySuggestion ?? "An unexpected error occurred.")
        }
    }
}
