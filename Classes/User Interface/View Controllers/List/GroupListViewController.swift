//
//  GroupsListViewController.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let kAlbumCellIdentifier = "albumCellIdentifier"

class GroupListViewController: UITableViewController {

    var viewModel: GroupListViewModel!
    
    fileprivate var disposeBag: DisposeBag!
    fileprivate var placeholderLabel: UILabel!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.groups
        initUI()
        bind(viewModel: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updatePlaceholderVisibility()
    }
    
    // MARK: - UI
    
    func initUI() {
        
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        
        placeholderLabel = UILabel()
        placeholderLabel.font = Font.bold(size: .large)
        placeholderLabel.textColor = AppStyle.Colors.Text.secondary
        placeholderLabel.text = L10n.emptyGroupList
        placeholderLabel.sizeToFit()
        placeholderLabel.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        placeholderLabel.center = view.center
        view.addSubview(placeholderLabel)
    }
    
    fileprivate func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = viewModel.groups.value.count != 0
    }
}

// MARK: - Binding

extension GroupListViewController {
    
    fileprivate func bind(viewModel: GroupListViewModel) {
        // re-create dispose bag, to be sure previous dispose bag is "killed", so previous bindings die
        disposeBag = DisposeBag()
        
        viewModel.groups.asObservable().debounce(0.4, scheduler: MainScheduler.instance).bind { [weak self] (groups) in
            self?.updatePlaceholderVisibility()
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.isDataLoadingInProgress.asObservable().bind { [weak self] (isDataLoadingInProgress) in
            self?.navigationItem.leftBarButtonItem = isDataLoadingInProgress ? NavBarButtonItemType.loading.button() : nil
        }.disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource

extension GroupListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kAlbumCellIdentifier, for: indexPath) as! GroupTableViewCell
        if let cellModel = viewModel.cellViewModel(for: indexPath) as? GroupCellModel {
            cell.viewModel = cellModel
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension GroupListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.actions.handleSelection(of: indexPath)
    }
}

