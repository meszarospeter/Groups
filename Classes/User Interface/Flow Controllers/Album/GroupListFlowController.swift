//
//  GroupsListFlowController.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit

class GroupListFlowController {
    
    fileprivate lazy var groupManagementService: GroupManagementService = GroupManagementService()
    fileprivate var groupListViewController: GroupListViewController!
    
    // MARK: - Flow cycle
    
    init() {
        let viewModel = GroupListViewModel(groupManagementService: groupManagementService)
        viewModel.coordinatorDelegate = self
        
        let storyboard = UIStoryboard(name: "Groups", bundle: nil)
        groupListViewController = storyboard.instantiateViewController(withIdentifier: "GroupListViewController") as! GroupListViewController
        groupListViewController.viewModel = viewModel
    }
}

extension GroupListFlowController: GroupListFlowDelegate {
    
    var mainViewController: UIViewController {
        return groupListViewController
    }
    
    func didStartDetail(of group: Group, on viewModel: GroupListViewModel) {
        let viewModel = GroupDetailViewModel()
        viewModel.group.accept(group)
        
        let storyboard = UIStoryboard(name: "Groups", bundle: nil)
        let groupDetailViewController = storyboard.instantiateViewController(withIdentifier: "GroupDetailViewController") as! GroupDetailViewController
        groupDetailViewController.viewModel = viewModel
        mainViewController.navigationController?.pushViewController(groupDetailViewController, animated: true)
    }
}


