import SwiftUI
import PhotosUI

struct ProfileImageSlot: View {
    let image: UIImage?
    let isRequired: Bool
    let onAdd: () -> Void
    let onRemove: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            if let image = image {
                // Image with remove button
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    Button(action: onRemove) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    .padding(8)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 119/255, green: 82/255, blue: 254/255),
                                    Color(red: 255/255, green: 130/255, blue: 171/255)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
            } else {
                // Empty slot with add button
                Button(action: onAdd) {
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(red: 245/255, green: 245/255, blue: 245/255))
                            .frame(width: 100, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 119/255, green: 82/255, blue: 254/255),
                                                Color(red: 255/255, green: 130/255, blue: 171/255)
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 2
                                    )
                            )
                            .overlay(
                                Image(systemName: "plus")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color(red: 150/255, green: 150/255, blue: 150/255))
                            )

                        if isRequired {
                            Text("필수")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 119/255, green: 82/255, blue: 254/255),
                                            Color(red: 255/255, green: 130/255, blue: 171/255)
                                        ]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(8)
                                .padding(8)
                        }
                    }
                }
            }

            // Required badge on image
            if image != nil && isRequired {
                Text("필수")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 119/255, green: 82/255, blue: 254/255),
                                Color(red: 255/255, green: 130/255, blue: 171/255)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(8)
                    .padding(8)
            }
        }
        .frame(width: 100, height: 100)
    }
}

struct ProfileImageGrid: View {
    @Binding var images: [UIImage?]
    @State private var showingImagePicker = false
    @State private var showingActionSheet = false
    @State private var selectedSlotIndex: Int = 0

    private let maxImages = 6

    var body: some View {
        VStack(spacing: 12) {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(0..<maxImages, id: \.self) { index in
                    ProfileImageSlot(
                        image: index < images.count ? images[index] : nil,
                        isRequired: index == 0,
                        onAdd: {
                            selectedSlotIndex = index
                            showingActionSheet = true
                        },
                        onRemove: {
                            removeImage(at: index)
                        }
                    )
                }
            }
        }
        .confirmationDialog("사진 선택", isPresented: $showingActionSheet) {
            Button("촬영하기") {
                // Camera action
                print("카메라 실행")
            }
            Button("앨범에서 선택하기") {
                showingImagePicker = true
            }
            Button("취소", role: .cancel) {}
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $images, selectedIndex: selectedSlotIndex)
        }
    }

    private func removeImage(at index: Int) {
        guard index < images.count else { return }
        images.remove(at: index)
    }
}

// Simple Image Picker wrapper
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: [UIImage?]
    let selectedIndex: Int
    @Environment(\.dismiss) var dismiss

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.dismiss()

            guard let result = results.first else { return }

            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        if self.parent.selectedIndex < self.parent.image.count {
                            self.parent.image[self.parent.selectedIndex] = image
                        } else {
                            self.parent.image.append(image)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileImageGrid(images: .constant([]))
}
