//
//  DefaultStatusProtocol.swift
//  iOSTips
//
//  Created by brian on 2017/12/25.
//  Copyright © 2017年 brian. All rights reserved.
//

import UIKit

protocol StatusProtocol {
    var title: String? { get }
    var description: String? { get }
    var image: UIImage? { get }
    var action: (() -> Void)? { get }
}

extension StatusProtocol {
    var title: String? { return nil }
    var description: String? { return nil }
    var image: UIImage? { return nil }
    var action: (() -> Void)? { return nil }
}

struct Status: StatusProtocol {
    
    var title: String?
    var description: String?
    var image: UIImage?
    var action: (() -> Void)?
    
    init(title: String?, description: String?, image: UIImage?, action: (() -> Void)?) {
        self.title = title
        self.description = description
        self.image = image
        self.action = action
    }
}

//MARK: - DefaultStatusProtocol
protocol DefaultStatusProtocol {
    
    var onView: OnViewProtocol? { get }
    var statusView: StatusViewProtocol? { get }
    func show(status: StatusProtocol)
    func hide()
}

//MARK: - DefaultStatusProtocol的默认实现
extension DefaultStatusProtocol {
    
    var statusView: StatusViewProtocol? {
        return StatusView()
    }
    
    func show(status: StatusProtocol) {
        guard let statusView = statusView else {
            return
        }
        statusView.status = status
        onView?.containerView = statusView.view
    }
    
    func hide() {
        onView?.containerView = nil
    }
}

protocol StatusViewProtocol: class {
    var status: StatusProtocol? { get set }
    var view: UIView? { get }
}

//MARK: - 缺省图显示的位置
// 控制器的view
extension DefaultStatusProtocol where Self: UIViewController {
    var onView: OnViewProtocol? {
        return view
    }
}

// UIView上
extension DefaultStatusProtocol where Self: UIView {
    var onView: OnViewProtocol? {
        return self
    }    
}

// UITableViewController的backgroundView上
extension DefaultStatusProtocol where Self: UITableViewController {
    var onView: OnViewProtocol? {
        if let backgroundView = tableView.backgroundView {
            return backgroundView
        }
        return view
    }
}

protocol OnViewProtocol: class {
    var containerView: UIView? { get set }
}

extension UIView: OnViewProtocol {
    
    static let constainerViewTag = 13
    
    var containerView: UIView? {
        get {
            return viewWithTag(UIView.constainerViewTag)
        }
        set {
            viewWithTag(UIView.constainerViewTag)?.removeFromSuperview()
            guard let containerView = newValue else {
                return
            }
            containerView.tag = UIView.constainerViewTag
            addSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
                containerView.leadingAnchor.constraint(greaterThanOrEqualTo:readableContentGuide.leadingAnchor),
                containerView.trailingAnchor.constraint(lessThanOrEqualTo: readableContentGuide.trailingAnchor),
                containerView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
                containerView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
            ])
        }
    }
}

//MARK: - 显示缺省图的View
class StatusView: UIView, StatusViewProtocol {
    
    var view: UIView? {
        return self
    }
    
    var status: StatusProtocol? {
        didSet {
            titleLabel.text = status?.title
            descriptionLabel.text = status?.description
            imageView.image = status?.image
            action = status?.action
            let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            self.addGestureRecognizer(tapGestrue)
        }
    }
    
    var action: (() -> Void)?
    
    @objc func tapAction() {
        action?()
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.center = self.center
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        return titleLabel
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel: UILabel = UILabel()
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    lazy var verticalStackView: UIStackView = {
        let verticalStackView: UIStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        verticalStackView.alignment = .center
        return verticalStackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let horizontalStackView: UIStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .center
        return horizontalStackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    override var tintColor: UIColor! {
        didSet {
            titleLabel.textColor = tintColor
            descriptionLabel.textColor = tintColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusView {
    func setupSubviews() {
        
        addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
