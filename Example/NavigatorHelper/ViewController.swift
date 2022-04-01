//
//  ViewController.swift
//  NavigatorHelper
//
//  Created by hlltd on 03/31/2022.
//  Copyright (c) 2022 hlltd. All rights reserved.
//

import UIKit
import NavigatorHelper

class ViewController: UIViewController {
  
  private lazy var openButton: UIButton = {
    let button = UIButton()
    button.setTitle("Enter background after click", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(openWebPage), for: .touchUpInside)
    button.backgroundColor = .systemOrange
    button.layer.cornerRadius = 25
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  @objc
  func openWebPage() {
    showToast(message: "Please enter background", seconds: 2)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      // Mock notificationLink
      NavigatorHelper.shared.handleNotificationLink(URL(string: "navigator://web?url=www.baidu.com"))
    }
  }
  
  func setupUI() {
    view.addSubview(openButton)
    
    NSLayoutConstraint.activate([
      openButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      openButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      openButton.widthAnchor.constraint(equalToConstant: 300),
      openButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
}

extension UIViewController {
  
  func showToast(message: String, seconds: Double) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.view.backgroundColor = .black
    alert.view.alpha = 0.6
    alert.view.layer.cornerRadius = 15
    
    self.present(alert, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
      alert.dismiss(animated: true)
    }
  }
}
