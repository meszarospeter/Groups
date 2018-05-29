//
//  GroupTableViewCell.swift
//  Groups
//
//  Created by Peter Meszaros on 27/05/2018.
//  Copyright © 2018 Peter Meszaros. All rights reserved.
//

import UIKit
import SDWebImage

protocol GroupCellModel: CellModel {
    var title: String { get }
    var imageUrl: String { get }
}

class GroupTableViewCell: UITableViewCell {

    // MARK: UI elements
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: GroupCellModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        albumImageView.sd_cancelCurrentImageLoad()
    }
    
    // MARK: - UI
    
    func initUI() {
        titleLabel.font = Font.regular(size: .medium)
        titleLabel.textColor = AppStyle.Colors.Text.primary
    }
    
    fileprivate func updateView() {
        titleLabel.text = viewModel?.title
        if let imageUrl = viewModel?.imageUrl {
            albumImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: Image(asset: Asset.Icons.albumCoverPlaceholder))
        }
    }
}
