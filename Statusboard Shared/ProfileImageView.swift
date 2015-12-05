//
//  ProfileImageView.swift
//  Statusboard
//
//  Created by Sebastian Friedrich on 05.12.15.
//  Copyright © 2015 Kupferwerk GmbH. All rights reserved.
//

import UIKit

@IBDesignable
class ProfilePictureView: UIView {
    private lazy var editLabel: UILabel = {
        let editLabel = UILabel()
        editLabel.translatesAutoresizingMaskIntoConstraints = false
        editLabel.text = "Edit"
        editLabel.hidden = true
        return editLabel
    }()
    
    internal var isEditing = false {
        didSet {
            if isEditing {
                editLabel.hidden = false
            } else {
                editLabel.hidden = true
            }
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    @IBInspectable var borderColor: UIColor = UIColor.blackColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var image: UIImage? {
        didSet {
            self.imageView.image = image
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layer.borderWidth = 2
        layer.masksToBounds = false
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
                
        addSubview(imageView)
        addSubview(editLabel)
        
        imageView.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        imageView.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        
        editLabel.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
        editLabel.centerYAnchor.constraintEqualToAnchor(centerYAnchor).active = true
    }

}
