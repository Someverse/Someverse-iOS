//
//  ProfileImagePageView.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import SwiftUI
import PhotosUI

// MARK: - Profile Image Page View
struct ProfileImagePageView: View {
    @Binding var images: [UIImage?]
    @State private var showingImagePicker = false
    @State private var showingActionSheet = false
    @State private var selectedSlotIndex: Int = 0

    private let maxImages = 6

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            headerSection
            imageGrid
        }
        .padding(.horizontal, 24)
        .confirmationDialog("사진 선택", isPresented: $showingActionSheet) {
            Button("촬영하기") {
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

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("프로필 사진을 업로드해주세요.")
                .font(.someverseHeadline)
                .foregroundColor(.someverseTextTitle)

            Text("최대 6장까지 등록할 수 있어요.")
                .font(.someverseBodyRegular)
                .foregroundColor(.someverseTextSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Image Grid
private extension ProfileImagePageView {
    var imageGrid: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 12) {
            ForEach(0..<maxImages, id: \.self) { index in
                imageSlot(at: index)
            }
        }
    }

    @ViewBuilder
    func imageSlot(at index: Int) -> some View {
        let image = index < images.count ? images[index] : nil
        let isRequired = index == 0

        Group {
            if let image = image {
                FilledImageSlot(
                    image: image,
                    isRequired: isRequired,
                    onRemove: { removeImage(at: index) }
                )
            } else {
                EmptyImageSlot(isRequired: isRequired) {
                    selectedSlotIndex = index
                    showingActionSheet = true
                }
            }
        }
        .frame(width: 100, height: 100)
    }

    func removeImage(at index: Int) {
        guard index < images.count else { return }
        images.remove(at: index)
    }
}

// MARK: - Filled Image Slot
private struct FilledImageSlot: View {
    let image: UIImage
    let isRequired: Bool
    let onRemove: () -> Void

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .topTrailing) {
                Button(action: onRemove) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.someverseIconLarge)
                        .foregroundColor(.someverseTextWhite)
                        .background(Color.black.opacity(0.5), in: Circle())
                }
                .padding(8)
            }
            .overlay(alignment: .topLeading) {
                if isRequired {
                    RequiredBadge()
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(LinearGradient.someversePrimary, lineWidth: 2)
            }
    }
}

// MARK: - Empty Image Slot
private struct EmptyImageSlot: View {
    let isRequired: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.someverseBackgroundSecondary)
                .overlay {
                    Image(systemName: "plus")
                        .font(.someverseIconLarge)
                        .foregroundColor(.someverseTextTertiary)
                }
                .overlay(alignment: .topLeading) {
                    if isRequired {
                        RequiredBadge()
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(LinearGradient.someversePrimary, lineWidth: 2)
                }
        }
    }
}

// MARK: - Required Badge
private struct RequiredBadge: View {
    var body: some View {
        Text("필수")
            .font(.someverseSmallBold)
            .foregroundColor(.someverseTextWhite)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(LinearGradient.someversePrimary)
            .cornerRadius(8)
            .padding(8)
    }
}

// MARK: - Image Picker
private struct ImagePicker: UIViewControllerRepresentable {
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

            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self else { return }

                if let error = error {
                    print("Failed to load image: \(error.localizedDescription)")
                    return
                }

                guard let image = object as? UIImage else { return }

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

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

#Preview {
    ProfileImagePageView(images: .constant([]))
}
