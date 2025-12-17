//
//  CloudKitKeys.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 16/12/25.
//

import Foundation

enum CKTypes {
    static let event = "Event"
    static let courseConfig = "CourseConfig"
    static let participant = "Participant"
    static let inviteAlias = "InviteAlias"
    static let dish = "Dish"
}

enum CKEventKeys {
    static let createdAt = "createdAt"
    static let hostUserrecordName = "hostUserrecordName"
    static let location = "location"
    static let name = "name"
    static let startDateTime = "startDateTime"
}

enum CKCourseConfigKeys {
    static let appetizerCount = "appetizerCount"
    static let dessertCount = "dessertCount"
    static let mainCount = "mainCount"
    static let sideCount = "sideCount"
    static let eventRef = "eventRef"
}

enum CKParticipantKeys {
    static let displayName = "displayName"
    static let eventRef = "eventRef"
    static let joinedAt = "joinedAt"
    static let userIdentity = "userIdentity"
}

enum CKInviteAliasKeys {
    static let code = "Code"
    static let shareURL = "ShareURL"
    static let createdAt = "createdAt"
    static let eventRef = "eventRef"
}
