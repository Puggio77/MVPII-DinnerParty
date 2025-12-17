//
//  InvitePeopleView.swift
//  DinnerParty
//
//  Created by Seyedreza Aghayarikordkandi on 15/12/25.
//

import SwiftUI
import UIKit

struct InvitePeopleView: View {

    let eventID: UUID

    @State private var inviteURL: URL?
    @State private var isGenerating = false
    @State private var errorText: String = ""
    @State private var showCopiedFeedback = false

    @ObservedObject private var eventManager = EventManager.shared

    var body: some View {
        VStack(spacing: 24) {

            // Title
            Text("Invite People")
                .font(.system(size: 28, weight: .bold, design: .serif))
                .padding(.top, 10)

            if let url = inviteURL {
                VStack(spacing: 16) {

                    Text("Invite link")
                        .font(.headline)

                    Text(url.absoluteString)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)

                    Button {
                        UIPasteboard.general.string = url.absoluteString
                        showCopiedFeedback = true

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            showCopiedFeedback = false
                        }
                    } label: {
                        Text(showCopiedFeedback ? "Copied ✓" : "Copy link")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(showCopiedFeedback ? Color.green : Color.amberGlow)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal, 24)

                    ShareLink(item: url) {
                        Text("Share invite link")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color("MutedTeal"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal, 24)
                }
            } else {
                Button {
                    Task { await generateInviteLink() }
                } label: {
                    Text(isGenerating ? "Generating..." : "Generate invite link")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(isGenerating ? Color.gray.opacity(0.3) : Color("MutedTeal"))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal, 24)
                .disabled(isGenerating)
            }

            if !errorText.isEmpty {
                Text(errorText)
                    .foregroundColor(.red)
                    .padding(.horizontal, 24)
            }

            Spacer()
        }
        .navigationTitle("Invite Guests")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Generate invite link using CloudKit
    private func generateInviteLink() async {
        isGenerating = true
        errorText = ""

        do {
            let url = try await eventManager.createInviteLink(for: eventID)
            inviteURL = url
        } catch {
            errorText = error.localizedDescription
        }

        isGenerating = false
    }
}

#Preview {
    InvitePeopleView(eventID: Event.sampleEvent.id)
}
