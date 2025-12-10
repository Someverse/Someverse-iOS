//
//  ChatRoomRow.swift
//  Someverse
//
//  Created by 박채현 on 12/9/25.
//

import SwiftUI

struct ChatRoomRow: View {
  let room: ChatRoom

  var body: some View {
    HStack(spacing: 12) {
      ProfileImageView(imageURL: room.profileImageURL, size: 48)

      VStack(alignment: .leading, spacing: 4) {
        Text(room.nickname)
          .font(.someverseBody)
          .foregroundColor(.someverseTextTitle)

        Text(room.lastMessage)
          .font(.someverseBodyRegular)
          .foregroundColor(.someverseTextSecondary)
          .lineLimit(1)
      }

      Spacer()

      VStack(alignment: .trailing, spacing: 6) {
        if room.hasUnread {
          Text(room.formattedUnreadCount)
            .font(.someverseSmallBold)
            .foregroundColor(.someverseTextWhite)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.someversePrimary)
            .cornerRadius(10)
        }

        Text(room.formattedTime)
          .font(.someverseCaption)
          .foregroundColor(.someverseTextTertiary)
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
  }
}

#Preview {
  ChatRoomRow(
    room: ChatRoom(
      nickname: "마포구보안관2",
      lastMessage: "동해물과 백두산이 마르고 닳도록 하느님이...",
      lastMessageTime: Date().addingTimeInterval(-120),
      unreadCount: 99
    )
  )
}
