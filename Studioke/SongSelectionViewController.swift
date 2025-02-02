//
//  SongSelectionViewController.swift
//  Studioke
//
//  Created by Armand Raynor on 1/27/25.
//

import SwiftUI
import UIKit

class SongSelectionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = SongSelectionView()  // Your SwiftUI View
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(
                equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
        ])

        hostingController.didMove(toParent: self)
    }
}
