//
//  TasteChip.swift
//  Someverse
//
//  Created by 박채현 on 12/2/25.
//

import SwiftUI

struct TasteChip: View {
    let genre: MovieGenre
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(genre.name)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : Color(red: 100/255, green: 100/255, blue: 100/255))
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    Group {
                        if isSelected {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 255/255, green: 107/255, blue: 107/255),
                                    Color(red: 255/255, green: 107/255, blue: 107/255)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        } else {
                            Color(red: 240/255, green: 242/255, blue: 245/255)
                        }
                    }
                )
                .cornerRadius(20)
        }
    }
}

struct TasteChipGrid: View {
    @Binding var selectedGenres: [MovieGenre]
    let maxSelections: Int

    private let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 8)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(MovieGenre.allGenres) { genre in
                TasteChip(
                    genre: genre,
                    isSelected: selectedGenres.contains(genre)
                ) {
                    toggleGenre(genre)
                }
            }
        }
    }

    private func toggleGenre(_ genre: MovieGenre) {
        if let index = selectedGenres.firstIndex(of: genre) {
            selectedGenres.remove(at: index)
        } else if selectedGenres.count < maxSelections {
            selectedGenres.append(genre)
        }
    }
}

#Preview {
    VStack {
        TasteChipGrid(selectedGenres: .constant([]), maxSelections: 5)
            .padding()
    }
}
