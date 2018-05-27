//
//  GroupsListViewModel.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// Coordinator delegate protocol
protocol GroupListFlowDelegate: FlowController {
    func didStartDetail(of group: Group, on viewModel: GroupListViewModel)
}

// Actions protocol
protocol GroupListViewModelActions {
    func handleSelection(of indexPath: IndexPath)
}

class GroupListViewModel {
    
    // MARK: - Properties
    
    weak var coordinatorDelegate: GroupListFlowDelegate?
    
    var actions: GroupListViewModelActions { return self }
    let groups = BehaviorRelay<[Group]>(value: [])
    let isDataLoadingInProgress = BehaviorRelay<Bool>(value: false)
    
    fileprivate var groupManagementService: GroupManagementService

    // MARK: - Init
    
    init(groupManagementService: GroupManagementService) {
        self.groupManagementService = groupManagementService
    
        loadData()
    }

    fileprivate func loadData() {
        isDataLoadingInProgress.accept(true)
        groupManagementService.loadGroups(success: { [weak self] (groups) in
            self?.isDataLoadingInProgress.accept(false)
            self?.groups.accept(groups)
        }, failure: { [weak self] (error) in
            self?.isDataLoadingInProgress.accept(false)
            self?.coordinatorDelegate?.showErrorAlert(for: error)
        })
    }
    
    // MARK: - Table view setup
    
    var itemCount: Int {
        return groups.value.count
    }
    
    // MARK: - Cell view setup
    
    class GroupCell: GroupCellModel {
        
        var title = ""
        var imageUrl = ""
        
        init(title: String, imageUrl: String) {
            self.title = title
            self.imageUrl = imageUrl
        }
    }
    
    func cellViewModel(for indexPath: IndexPath) -> CellModel? {
        let index = indexPath.row
        guard 0..<itemCount ~= index else { return nil }
        
        let group = groups.value[index]
        return GroupCell(title: group.title, imageUrl: group.thumbnailUrl)
    }
}

// MARK: - GroupListViewModelActions

extension GroupListViewModel: GroupListViewModelActions {

    func handleSelection(of indexPath: IndexPath) {
        let index = indexPath.row
        guard 0..<itemCount ~= index else { return }
        
        let group = groups.value[index]
        coordinatorDelegate?.didStartDetail(of: group, on: self)
    }
}
