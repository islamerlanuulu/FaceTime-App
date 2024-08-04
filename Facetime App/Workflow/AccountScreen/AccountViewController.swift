//
//  AccountViewController.swift
//  Facetime App
//
//  Created by @islamien  on 4/8/24.
//

import UIKit
import Combine
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI

class AccountViewController: BaseViewController {
    
    private var cancellables = Set<AnyCancellable>()
    
    private var activecallView: UIView?
    
    override func setup() {
        super.setup()
        navigationItem.title = "Account"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Join Call", style: .done, target: self, action: #selector(joinCall))
    }
    
    private func listenForIncomingCalls() {
        guard let callViewModel = CallManager.shared.callViewModel else { return }
        
        callViewModel.$callingState.sink { [weak self] newState in
            switch newState {
            case .incoming(_):
                DispatchQueue.main.async {
                    self?.showCallUI()
                }
            case .idle:
                DispatchQueue.main.async {
                    self?.hideCallUI()
                }
            default:
                break
            }
        }
        .store(in: &cancellables)
    }
    
    private func showCallUI() {
        guard let callViewModel = CallManager.shared.callViewModel else { return }
        let callVc = CallViewController.make(with: callViewModel)
        view.addSubview(callVc.view)
        callVc.view.bounds = view.bounds
        activecallView = callVc.view
    }
    
    private func hideCallUI() {
        activecallView?.removeFromSuperview()
    }
    
    @objc
    private func joinCall() {
        guard let callViewModel = CallManager.shared.callViewModel else { return }
        callViewModel.joinCall(callType: .default, callId: "default_5affb092-24c3-459d-b4fe-5bee317f30ba")
        
        showCallUI()
    }
    
    @objc
    private func signOut() {
        AuthManager.shared.signOut()
        let vc = UINavigationController(rootViewController: WelcomeViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
