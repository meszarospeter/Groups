//
//  UIBarButtonItem+Type.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit

enum NavBarButtonItemType {
    case loading, loadingWhite
    
    func button() -> UIBarButtonItem {
        var result: UIBarButtonItem
        
        switch self {
            case .loading:
                result = customLoadingBarButtonItem(activityIndicatorStyle: .gray)
            case .loadingWhite:
                result = customLoadingBarButtonItem(activityIndicatorStyle: .white)
        }

        return result
    }
    
    fileprivate func customLoadingBarButtonItem(activityIndicatorStyle style: UIActivityIndicatorViewStyle) -> UIBarButtonItem {
        let loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
        loadingIndicator.startAnimating()
        return UIBarButtonItem(customView: loadingIndicator)
    }
}

extension UIViewController {
    
    var isPresentedModally: Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
    
    var isPushed: Bool {
        guard let navigationController = navigationController else { return false }
        
        return navigationController.viewControllers.first != self
    }
    
    var isTopViewController: Bool {
        guard let navigationController = navigationController else { return false }
        
        return navigationController.viewControllers.last == self
    }
}
