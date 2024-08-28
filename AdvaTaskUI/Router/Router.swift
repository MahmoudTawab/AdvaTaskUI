//
//  Router.swift
//  AdvaTaskUI
//
//  Created by Mahmoud on 28/08/2024.
//

import UIKit

// MARK: - PhotoDetailRouterProtocol

protocol PhotoDetailRouterProtocol: AnyObject {
    func dismiss()
}

// MARK: - PhotoDetailRouter

class PhotoDetailRouter: PhotoDetailRouterProtocol {
    
    // Weak reference to the view controller to avoid retain cycles
    weak var viewController: UIViewController?
    
    // Dismisses the current view controller
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
