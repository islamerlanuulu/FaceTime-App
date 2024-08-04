//
//  ViewController.swift
//  Facetime App
//
//  Created by @islamien  on 4/8/24.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    override func setup() {
        super.setup()
        navigationItem.title = "Sign In"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AuthManager.shared.signUp(email: "joe5600@gmail.com", password: "password") { [weak self] done in
            guard done else {
                return
            }
            
            DispatchQueue.main.async {
                self?.showAccount()
            }
        }
    }
    
    private func showAccount() {
        let vc = UINavigationController(rootViewController: AccountViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

