//
//  FlowController.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import Foundation
import UIKit

// MARK: -

protocol FlowController: class {
    var mainViewController: UIViewController { get }
}

// MARK: -

extension FlowController {
    
    // MARK: Message
    
    func showMessage(on parent: UIViewController? = nil, title: String?, message: String?) {
        let okAction = UIAlertAction(title: L10n.ok, style: .cancel, handler: nil)
        showAlert(on: parent, title: title, message: message, actions: [okAction])
    }

    // MARK: Alert
    
    func showErrorAlert(for error: Error) {
        let errorDisplayInfo = ErrorDisplayManager.displayableInfo(for: error)
        showMessage(on: nil, title: errorDisplayInfo.title, message: errorDisplayInfo.message)
    }
    
    func showAlert(on parent: UIViewController? = nil, title: String?, message: String?, actions: [UIAlertAction]) {
        guard let presenterVC = self.presenter(for: parent) else {
            assertionFailure("Can't show screen, because no main VC is available")
            return
        }
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            controller.addAction(action)
        }
        if let presentedVCOnPresenter = presenterVC.presentedViewController {
            presentedVCOnPresenter.present(controller, animated: true, completion: nil)
        } else {
            presenterVC.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: -

extension FlowController {
    
    fileprivate func presenter(for parent: UIViewController?) -> UIViewController? {
        var presenter: UIViewController?
        if parent != nil {
            presenter = parent
        } else {
            presenter = mainViewController
        }
        return presenter
    }
}
