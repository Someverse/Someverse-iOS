import SwiftUI

struct PageIndicator: View {
    let totalPages: Int
    let currentPage: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.someversePrimary : Color.someverseInactive)
                    .frame(width: index == currentPage ? 24 : 8, height: 8)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: currentPage)
    }
}

#Preview {
    VStack(spacing: 20) {
        PageIndicator(totalPages: 5, currentPage: 0)
        PageIndicator(totalPages: 5, currentPage: 2)
        PageIndicator(totalPages: 5, currentPage: 4)
    }
}
