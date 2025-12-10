//
//  ChatView.swift
//  Someverse
//
//  Created by 박채현 on 12/6/25.
//

import SwiftUI

struct ChatView: View {
  @StateObject private var viewModel = ChatViewModel()

  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        TabHeaderView()

        if viewModel.isEmpty {
          EmptyStateView(
            infoTitle: "아직 채팅이 없어요",
            subText: "매칭이 성사되면 채팅을 시작할 수 있어요"
          )
        } else {
          chatListView
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.someverseBackgroundWhite)
    }
  }

  // MARK: - Chat List View
  private var chatListView: some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        if let waiting = viewModel.waitingMembers {
          WaitingMembersBanner(waiting: waiting) {
            viewModel.viewWaitingMembers()
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 8)
        }

        ForEach(viewModel.chatRooms) { room in
          ChatRoomRow(room: room)
            .onTapGesture {
              viewModel.enterChatRoom(room)
            }
        }
      }
    }
  }
}

#Preview("Empty") {
  ChatView()
}

#Preview("With Data") {
  ChatView()
}
