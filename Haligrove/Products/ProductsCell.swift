//
//  ProductsCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-14.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit

class ExpandedLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        
        let size = super.intrinsicContentSize
        let addedWidth = font.pointSize * 0.3
        
        return CGSize(width: size.width  + addedWidth, height: size.height)
    }
}

class ProductsCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 1
//        view.layer.shadowColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
//        view.layer.shadowRadius = 1.0
//        view.layer.shadowOpacity = 1.0
//        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        return view
    }()
    
    let rightArrow: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "rightArrow").withRenderingMode(.alwaysTemplate))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let productLabel: ExpandedLabel = {
        let label = ExpandedLabel()
        label.text = "Products"
        label.font = UIFont(name: "Pineapple Bold Inline", size: 45)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.568627451, green: 0.5254901961, blue: 0.3568627451, alpha: 1)
        label.layer.shadowColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        label.layer.shadowRadius = 1
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = true
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        
         backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9450980392, alpha: 1)
        
        selectionStyle = .none
        
        addSubview(cellView)
        cellView.addSubview(rightArrow)
        cellView.addSubview(productImageView)
        cellView.addSubview(productLabel)
        
        cellView.anchor(top: topAnchor, right: rightAnchor, bottom: bottomAnchor, left: leftAnchor, paddingTop: 4, paddingRight: 4, paddingBottom: 4, paddingLeft: 4, width: 0, height: 0)
        
        rightArrow.anchor(top: nil, right: cellView.rightAnchor, bottom: nil, left: nil, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 30, height: 30)
        rightArrow.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        productImageView.anchor(top: nil, right: nil, bottom: nil, left: productLabel.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 50, height: 50)
        productImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        
        productLabel.anchor(top: nil, right: productImageView.leftAnchor, bottom: nil, left: cellView.leftAnchor, paddingTop: 0, paddingRight: 6, paddingBottom: 0, paddingLeft: 20, width: cellView.frame.width - productImageView.frame.width * 3 , height: 60)
        productLabel.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
