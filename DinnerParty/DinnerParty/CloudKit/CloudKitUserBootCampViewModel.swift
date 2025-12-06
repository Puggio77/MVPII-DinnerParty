//
//  CloudKitUserBootCampViewModel.swift
//  DinnerParty
//
//  Created by Riccardo Puggioni on 05/12/25.
//

import Foundation
import CloudKit
import Combine

@MainActor
class CloudKitUserBootCampViewModel: ObservableObject {

    @Published var isSignedToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""

    private let container = CKContainer.default()

    init() {
        Task {
            await getiCloudStatus()
            await fetchCurrentUserName()
        }
    }

    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountNotRestricted
        case iCloudAccountUnknown
    }

    func getiCloudStatus() async {
        do {
            let status = try await container.accountStatus()
            switch status {
            case .available:
                isSignedToiCloud = true
            case .noAccount:
                error = CloudKitError.iCloudAccountNotFound.rawValue
            case .couldNotDetermine:
                error = CloudKitError.iCloudAccountNotDetermined.rawValue
            case .restricted:
                error = CloudKitError.iCloudAccountNotRestricted.rawValue
            case.temporarilyUnavailable:
                error = "iCloud temporaly unavailable"
            @unknown default:
                error = CloudKitError.iCloudAccountUnknown.rawValue
            }
        } catch {
            self.error = error.localizedDescription
        }
    }

    func fetchCurrentUserName() async {
        do {
            let recordID = try await container.userRecordID()
            let participant = try await container.shareParticipant(forUserRecordID: recordID)

            if let nameComponents = participant.userIdentity.nameComponents {
                let formatter = PersonNameComponentsFormatter()
                userName = formatter.string(from: nameComponents)
            }
        } catch {
            self.error = error.localizedDescription
        }
    }
}
