import SwiftUI

struct BullseyeTextField: View {
    
    @Binding var text: String
    
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    @FocusState.Binding var isFocused: Bool
    
    var hasText: Bool {
        text != ""
    }
    
    init(
        text: Binding<String>,
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        isFocused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._isFocused = isFocused
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text(placeholder)
                .foregroundColor(.white.opacity(0.5))
            )
            .font(.russo(size: 25))
            .foregroundStyle(.white)
            .focused($isFocused)
            .keyboardType(keyboardType)
            
            if hasText {
                Button {
                    text = ""
                    isFocused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
        }
        .frame(height: 75)
        .padding(.horizontal, 12)
        .background(.bcGreen.opacity(0.95))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.bcGreen, lineWidth: 3)
        }
    }
}
