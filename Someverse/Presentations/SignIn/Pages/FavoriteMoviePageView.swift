//
//  FavoriteMoviePageView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct FavoriteMoviePageView: View {
    @Binding var selectedMovies: [Movie]
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 0) {
            if isSearching {
                searchHeader
            }

            Text("최소 5개 이상의 영화를 골라주세요!")
                .font(.someverseBodyRegular)
                .foregroundColor(.someverseTextSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 16)

            movieGrid
                .padding(.top, 16)

            Spacer()

            selectionFooter
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { withAnimation { isSearching.toggle() } }) {
                    Image(systemName: isSearching ? "xmark" : "magnifyingglass")
                        .font(.someverseBody)
                        .foregroundColor(.someverseTextTitle)
                }
            }
        }
    }

    private var searchHeader: some View {
        HStack(spacing: 12) {
            TextField("영화 제목으로 검색하기", text: $searchText)
                .font(.someverseBody)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.someverseBackground)
                .cornerRadius(8)
        }
        .padding(.horizontal, 24)
        .padding(.top, 8)
    }

    private var movieGrid: some View {
        ScrollView {
            if isSearching && !searchText.isEmpty {
                searchResultHeader
            }

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(displayedMovies) { movie in
                    MovieCard(
                        movie: movie,
                        isSelected: selectedMovies.contains(movie),
                        onTap: { toggleMovie(movie) }
                    )
                }
            }
            .padding(.horizontal, 24)
        }
    }

    private var searchResultHeader: some View {
        Text("'\(searchText)' 관련 영화")
            .font(.someverseBodyRegular)
            .foregroundColor(.someverseTextSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
    }

    private var selectionFooter: some View {
        Text("총 \(selectedMovies.count)개 선택")
            .font(.someverseBodyRegular)
            .foregroundColor(.someverseTextPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
    }

    private var displayedMovies: [Movie] {
        if searchText.isEmpty {
            return Movie.samples
        } else {
            return Movie.samples.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    private func toggleMovie(_ movie: Movie) {
        if let index = selectedMovies.firstIndex(of: movie) {
            selectedMovies.remove(at: index)
        } else {
            selectedMovies.append(movie)
        }
    }
}

// MARK: - Movie Card
private struct MovieCard: View {
    let movie: Movie
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    moviePoster

                    if isSelected {
                        removeButton
                    }
                }

                Text(movie.title)
                    .font(.someverseLabel)
                    .foregroundColor(isSelected ? .someverseTextTitle : .someverseTextSecondary)
                    .lineLimit(1)
            }
        }
    }

    private var moviePoster: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.someverseBackgroundSecondary)
            .aspectRatio(2/3, contentMode: .fit)
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(LinearGradient.someversePrimary, lineWidth: 3)
                }
            }
    }

    private var removeButton: some View {
        Image(systemName: "xmark.circle.fill")
            .font(.system(size: 20))
            .foregroundColor(.someverseTextTertiary)
            .background(Color.white, in: Circle())
            .offset(x: 6, y: -6)
    }
}

#Preview {
    FavoriteMoviePageView(selectedMovies: .constant([]))
}
