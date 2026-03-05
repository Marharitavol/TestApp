//
//  BaseViewController.swift
//  TestApp
//
//  Created by Rita on 05.03.2026.
//

import UIKit

class BaseViewController: UIViewController {
    
    let navBarTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = navBarTitle
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
