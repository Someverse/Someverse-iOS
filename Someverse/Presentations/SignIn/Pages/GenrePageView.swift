//
//  GenrePageView.swift
//  Someverse
//
//  Created by 박채현 on 12/5/25.
//

import SwiftUI

// MARK: - Genre Page View
struct GenrePageView: View {
    @Binding var selectedGenres: [MovieGenre]

    private let maxSelections = 5

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("어떤 장르의 영화를\n좋아하세요?")
                    .font(.someverseTitle)
                    .foregroundColor(.someverseTextTitle)
                    .lineSpacing(4)

                Text("최대 5개까지 고를 수 있어요!")
                    .font(.someverseBodyRegular)
                    .foregroundColor(.someverseTextSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)

            Spacer()
                .frame(height: 60)

            chipGrid
                .padding(.horizontal, 24)
        }
    }
}

// MARK: - Chip Grid
private extension GenrePageView {
    var chipGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 8)], spacing: 8) {
            ForEach(MovieGenre.allGenres) { genre in
                chip(for: genre)
            }
        }
    }

    func chip(for genre: MovieGenre) -> some View {
        let isSelected = selectedGenres.contains(genre)

        return Button(action: { toggleGenre(genre) }) {
            Text(genre.name)
                .font(.someverseChip)
                .foregroundColor(isSelected ? .someverseTextWhite : .someverseTextPrimary)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(isSelected ? Color.someverseChipActive : Color.someverseBackground)
                .cornerRadius(20)
        }
    }

    func toggleGenre(_ genre: MovieGenre) {
        if let index = selectedGenres.firstIndex(of: genre) {
            selectedGenres.remove(at: index)
        } else if selectedGenres.count < maxSelections {
            selectedGenres.append(genre)
        }
    }
}

#Preview {
    GenrePageView(selectedGenres: .constant([]))
}
