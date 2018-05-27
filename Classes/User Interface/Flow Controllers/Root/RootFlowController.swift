//
//  RootFlowController.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit

class RootFlowController {
    
    private weak var window: UIWindow?
    
    fileprivate var groupListFlow: GroupListFlowController!
    
    // MARK: - Lifecycle
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        groupListFlow = GroupListFlowController()
        let groupListNavController = UINavigationController(rootViewController: groupListFlow.mainViewController)
        setRoot(to: groupListNavController)
    }
    
    // MARK: - Set root
    
    fileprivate var root: UIViewController? {
        return window?.rootViewController
    }
    
    fileprivate func setRoot(to viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        
        guard root != viewController else { return }
        window?.rootViewController = viewController
    }
}
