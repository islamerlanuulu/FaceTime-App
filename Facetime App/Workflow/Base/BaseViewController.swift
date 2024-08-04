//
//  BaseViewController.swift
//  Facetime App
//
//  Created by @islamien  on 4/8/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        //        view.backgroundColor = .systemBackground
        view.backgroundColor = .white
    }
    
    public func setup() {
        view.backgroundColor = .systemBackground
        setupSubViews()
        setupConstraints()
    }
    
    public func setupSubViews() {}
    
    public func setupConstraints() {}
    
}
