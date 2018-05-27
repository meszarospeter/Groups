//
//  GroupsDetailViewController.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class GroupDetailViewController: UIViewController {
    
    var viewModel: GroupDetailViewModel!
    fileprivate var disposeBag: DisposeBag!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.groups
        initUI()
        bind(viewModel: viewModel)
    }
    
    // MARK: - UI
    
    func initUI() {
        titleLabel.font = Font.regular(size: .large)
        titleLabel.textColor = AppStyle.Colors.Text.primary
    }
}

// MARK: - Binding

extension GroupDetailViewController {
    
    fileprivate func bind(viewModel: GroupDetailViewModel) {
        // re-create dispose bag, to be sure previous dispose bag is "killed", so previous bindings die
        disposeBag = DisposeBag()
        
        viewModel.group.asObservable().bind { [weak self] (group) in
            self?.titleLabel.text = group?.title
        
            if let imageUrl = group?.thumbnailUrl {
                self?.coverImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: Image(asset: Asset.Icons.albumCoverPlaceholder))
            }
        }.disposed(by: disposeBag)
    }
}

