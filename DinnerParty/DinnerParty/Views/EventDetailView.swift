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
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 8)
                    .overlay(
                        VStack(spacing: 20) {
                            Text("Draw a card to\nreveal")
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(Color(.systemBrown))
                                .multilineTextAlignment(.center)
                            
                            NavigationLink {
                                DrawChallengeView()
                            } label: {
                                Text("Claim")
                                    .font(.headline)
                                    .frame(width: 200)
                                    .padding(.vertical, 14)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(26)
                                    .shadow(color: Color.orange.opacity(0.25), radius: 10, x: 0, y: 6)
                            }
                        }
                        .padding(.vertical, 28)
                    )
                    .frame(height: 280)
                    .padding(.horizontal, 8)
                                
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
