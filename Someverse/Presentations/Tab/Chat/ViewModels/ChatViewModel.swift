//
//  ChatViewModel.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI
import Combine

@MainActor
final class ChatViewModel: ObservableObject {
  // MARK: - Published Properties
  @Published private(set) var chatRooms: [ChatRoom] = []
  @Published private(set) var waitingMembers: WaitingMembers?
  @Published private(set) var isLoading = false
  @Published var error: Error?

  // MARK: - Computed Properties
  var isEmpty: Bool {
    chatRooms.isEmpty && waitingMembers == nil
  }

  var hasWaitingMembers: Bool {
    waitingMembers != nil
  }

  // MARK: - Initialization
  init() {
    loadMockData()
  }

  // MARK: - Public Methods
  func loadChatRooms() async {
    isLoading = true
    defer { isLoading = false }

    // TODO: API 연동 시 실제 서비스 호출로 대체
    loadMockData()
  }

  func enterChatRoom(_ room: ChatRoom) {
    // TODO: 채팅방 진입 로직
  }

  func viewWaitingMembers() {
    // TODO: 대기 중인 회원 목록 보기
  }

  func refreshChatRooms() async {
    await loadChatRooms()
  }

  // MARK: - Private Methods
  private func loadMockData() {
    #if DEBUG
    chatRooms = ChatRoom.mockData
    waitingMembers = WaitingMembers(count: 99, lastUpdated: Date().addingTimeInterval(-120))
    #endif
  }
}
