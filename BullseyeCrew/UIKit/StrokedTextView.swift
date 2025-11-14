import SwiftUI

struct StrokedTextView: View {
    
    let text: String
    let size: CGFloat
    
    var body: some View {
        ZStack {
            ZStack {
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 0, y: -1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 0, y: -2)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 0, y: -3)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 1, y: -1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 2, y: -2)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 3, y: -3)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -1, y: -1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -2, y: -2)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -3, y: -3)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -1, y: 0)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -1, y: 1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -1, y: 2)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -1, y: 3)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -2, y: 0)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -3, y: 0)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 0, y: 1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 0, y: 2)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 0, y: 3)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 1, y: 1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 2, y: 2)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 3, y: 3)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -1, y: 1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -2, y: 2)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -3, y: 3)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: 3, y: 1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -3, y: -1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -3, y: 1)
                
                Text(text)
                    .foregroundStyle(.bcGreen)
                    .offset(x: -3, y: 2)
            }
            .foregroundStyle(.bcGreen)
            
            Text(text)
                .foregroundStyle(.white)
        }
        .font(.russo(size: size))
    }
}

#Preview {
    StrokedTextView(text: "Add", size: 30)
}
