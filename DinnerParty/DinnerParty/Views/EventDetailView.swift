//
//  EventDetailView.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 09/12/25.
//

import SwiftUI

struct EventDetailView: View {
    
    private let viewModel = CardChallengeViewModel()
    
    @State private var selectedCourse = "Main Dishes"
    private let courses = ["Main Dishes", "Starters", "Side Dishes", "Desserts", "Drinks"]
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                // MARK: Friendsgiving dinner section
                VStack(spacing: 8) {
                    Text("Friendsgiving Dinner")
                        .font(.title.bold())
                        .foregroundColor(.orange)
                    
                    Text("November 20 | 7:00 PM")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text("Ana's Apartment")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 16)
                
                // MARK: Clock
                HStack(spacing: 32) {
                    VStack(spacing: 4) {
                        Text("05 :")
                            .font(.system(size: 34, weight: .semibold))
                            .foregroundStyle(.orange)
                        Text("Days")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(spacing: 4) {
                        Text("03")
                            .font(.system(size: 34, weight: .semibold))
                            .foregroundStyle(.orange)
                        Text("Hours")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    VStack(spacing: 4) {
                        Text(": 30")
                            .font(.system(size: 34, weight: .semibold))
                            .foregroundStyle(.orange)
                        Text("Minutes")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 8)
                
                // MARK: course picker sectio
                
                Picker("Course", selection: $selectedCourse) {
                    ForEach(courses, id: \.self) { course in
                        Text(course).tag(course)
                    }
                }
                .pickerStyle(.menu)
                .labelsHidden()
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.orange)
                )
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .contentShape(Rectangle())
                .padding(.top, 8)

                
                //MARK: Challenge card section
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.cards) { card in
                            ChallengeCardView(card: card)
                        }
                    }
                    .padding(.horizontal, 4)
                }
                                
                Button(action: {
                    // invite func
                }) {
                    Text("Invite more People")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                
            }
            .padding(.horizontal, 16)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Event Detail")
        }
    }
}

#Preview {
    EventDetailView()
}

struct ChallengeCardView: View {
    let card: CardChallenge
    
    var body: some View {
        VStack(spacing: 16) {
            Text(card.challenge)
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
            
            Image(systemName: card.img)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            
            Button(action: {
                // azione per "Claim"
            }) {
                Text("Claim")
                    .font(.subheadline.weight(.semibold))
                    .padding(.horizontal, 32)
                    .padding(.vertical, 8)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
        .frame(width: 260)
    }
}
