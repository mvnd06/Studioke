//
//  StemSelectionViewController.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import SwiftUI
import UIKit

class StemSelectionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stemSelectionView = StemSelectionView() // Your SwiftUI View
        let hostingController = UIHostingController(rootView: stemSelectionView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
}
