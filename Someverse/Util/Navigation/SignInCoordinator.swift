//
//  SignInCoordinator.swift
//  Someverse
//
//  Created by 박채현 on 2025-12-03.
//

import SwiftUI
import Combine

@MainActor
final class SignInCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to route: SignInRoute) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
