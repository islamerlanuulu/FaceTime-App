//
//  CallManager.swift
//  Facetime App
//
//  Created by @islamien  on 4/8/24.
//

import Foundation
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI

class CallManager {
    static let shared = CallManager()
    
    struct Constants {
        static let userToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiWmF5bmVfQ2FycmljayIsImlzcyI6Imh0dHBzOi8vcHJvbnRvLmdldHN0cmVhbS5pbyIsInN1YiI6InVzZXIvWmF5bmVfQ2FycmljayIsImlhdCI6MTcyMjc1NjUwMywiZXhwIjoxNzIzMzYxMzA4fQ.FV1Cbe6xKpamVowcpiUfadI5djxOd26ZznjkcTueW5g"
    }
    
    private var video: StreamVideo?
    private var videoUI: StreamVideoUI?
    public private(set) var callViewModel: CallViewModel?
    
    struct UserCredentials {
        let user: User
        let token: UserToken
    }
    
    func setUp(email: String) {
        setUpCallViewModel()
        
        let credential = UserCredentials(
            user: .guest(email),
            token: UserToken(rawValue: Constants.userToken)
        )
        
        let video = StreamVideo(
            apiKey: "mmhfdzb5evj2",
            user: credential.user,
            token: credential.token) { result  in
                result(.success(credential.token))
            }
        
        let videoUI = StreamVideoUI(streamVideo: video)
        
        self.video = video
        self.videoUI = videoUI
    }
    
    private func setUpCallViewModel() {
        guard callViewModel == nil else { return }
        DispatchQueue.main.async {
            self.callViewModel = CallViewModel()
        }
    }
    
}
