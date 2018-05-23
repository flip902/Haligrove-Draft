//
//  StrainsFoldingCell.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-23.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit
import FoldingCell
import EasyPeasy

class StrainsFoldingCell: FoldingCell, NSCacheDelegate {
    
    //Sean Note: As of right now you are creating all of your UI elements within the scrope of a funtion (createContainerView & createForegroundView). This means you do not have access to the UI elements outside of the scope of that function. You need access to them so you can set properties on them. I did 2 as an example (strainName & strainType). You'll have to complete the rest. They get initialized here, configured in your "create" functions, then I assign their text in "set(strain)" on lines 54 and 55. You'd need to do this for all your UI elements that need set.
    
    // foreground cell UI Items
    var imageContainer = UIImageView()
    
    var strainName = UILabel()
    var strainType = UILabel()
    var pricePerGramLabel = UILabel()
    var priceOfFiveLabel = UILabel()
    var saleMark = UILabel()
    var new = UILabel()
    var inventoryBar = UIImageView()
    
   // How to get reference to strain[indexPath.row]
    
    
    // ContainerView UI Items
    var overAll = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    var overallTrackLayer = CAShapeLayer()
    var overallShapeLayer = CAShapeLayer()
    var overallValueLabel = UILabel()
    
    var ThcView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    var ThcTrackLayer = CAShapeLayer()
    var ThcShapeLayer = CAShapeLayer()
    var thcValueLabel = UILabel()
    
    var containerImageView = UIImageView()
    
    var foldoutStrainLabel = UILabel()
    var foldoutStrainType = UILabel()
    
    var strainDescription = UILabel()
    
    
    //Start of Sean's code
    //Having access to the passed strain here might not be needed. But I'm putting it here just in case you need access to it. This is getting set from the strain I passed over in set(strain) on line 53. If you find yourself not needing it, then delete it.
    var strain: Strain?
    //End of Sean's code
    
    var img = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        containerView = createContainerView()
        foregroundView = createForegroundView()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.33, 0.26, 0.26]
        return durations[itemIndex]
    }
    
    
    
    
    
    //Start of Sean's Code
    func set(strain: Strain) {
        self.strain = strain
        
        // foreground View
        strainName.text = strain.name
        strainName.adjustsFontSizeToFitWidth = true
        strainName.minimumScaleFactor = 0.5
        
        strainType.text = strain.type
        
        pricePerGramLabel.text = "$\(Int(strain.pricePerGram))/g"
        pricePerGramLabel.adjustsFontSizeToFitWidth = true
        pricePerGramLabel.minimumScaleFactor = 0.5
        
        priceOfFiveLabel.text = "5 for $\(Int(strain.priceForFive))"
        
        if strain.sale == "sale" {
            saleMark.isHidden = false
        } else {
            saleMark.isHidden = true
        }
        
        if strain.isNew == "new" {
            new.isHidden = false
        } else {
            new.isHidden = true
        }
        
        if strain.inventory == "full" {
            inventoryBar.image = #imageLiteral(resourceName: "full")
        }
        if strain.inventory == "med" {
            inventoryBar.image = #imageLiteral(resourceName: "half")
        }
        if strain.inventory == "low" {
            inventoryBar.image = #imageLiteral(resourceName: "oneQuarter")
        }
        
        
        imageContainer.loadImageUsingUrlString(urlString: strain.src)
        
        
       

        // Container View
        overallShapeLayer.strokeEnd = CGFloat(Float(strain.overall) / 100)
        overallValueLabel.text = "\(strain.overall)"
        
        ThcShapeLayer.strokeEnd = CGFloat(Float(strain.THC) / 100)
        thcValueLabel.text = "\(strain.THC)%"
        
        containerImageView.loadImageUsingUrlString(urlString: strain.src)
        
        foldoutStrainLabel.text = strain.name
        foldoutStrainType.text = strain.type
        
        
        strainDescription.text = strain.description
        
        
        
        // This is where you'd continue to set the values of your UI elements. Just did the first 2 as an example.
    }
    //End of Sean's Code
  
    
}



extension StrainsFoldingCell {
    
    
    
    func createForegroundView() -> RotatedView {
        
        
        let foregroundView = RotatedView(frame: .zero)
        foregroundView.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        foregroundView.layer.cornerRadius = 5
        
        
        
        imageContainer.contentMode = .scaleAspectFill
        imageContainer.layer.cornerRadius = 5
        imageContainer.clipsToBounds = true
        
                
        // Sean's note: You initialize these up top, and then edit them here. Delete line 91 comment. I'm leaving it there so you can see what I did. Same for line 102.
        
//        let strainName = UILabel()
        strainName.font = UIFont(name: "Pineapple Bold Inline", size: 38)
        strainName.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        strainName.layer.shadowColor = #colorLiteral(red: 0.568627451, green: 0.5254901961, blue: 0.3568627451, alpha: 1)
        strainName.layer.shadowRadius = 1.0
        strainName.layer.shadowOpacity = 1.0
        strainName.layer.shadowOffset = CGSize(width: 3, height: 3)
        strainName.layer.masksToBounds = true
        
        

        strainType.font = UIFont(name: "Quicksand-Bold", size: 20)
        strainType.textColor = #colorLiteral(red: 0.568627451, green: 0.5254901961, blue: 0.3568627451, alpha: 1)
        strainType.layer.masksToBounds = true
        
        
        // initialize up Top
       
        saleMark.font = UIFont(name: "Quicksand-Regular", size: 16)
        saleMark.textColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9450980392, alpha: 1)
        saleMark.text = "sale"
        saleMark.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.3529411765, blue: 0.8352941176, alpha: 1)
        saleMark.layer.cornerRadius = 5
        saleMark.clipsToBounds = true
        
       
     
        pricePerGramLabel.font = UIFont(name: "Quicksand-Bold", size: 26)
        pricePerGramLabel.textColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        
       
        
        priceOfFiveLabel.font = UIFont(name: "Quicsand-Light", size: 14)
        priceOfFiveLabel.textColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        priceOfFiveLabel.text = ""
        
        // initialize up Top
        
        new.font = UIFont(name: "Quicksand-Regular", size: 16)
        new.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        new.text = "new"
        new.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9803921569, blue: 0.3294117647, alpha: 1)
        new.layer.cornerRadius = 5
        new.clipsToBounds = true
        
        // initialize up Top
       
        inventoryBar.contentMode = .scaleToFill
        
        // initialize up Top
        let inventoryLabel = UILabel()
        inventoryLabel.font = UIFont(name: "Quicksand-Regular", size: 8)
        inventoryLabel.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        inventoryLabel.text = "inventory"
        
        
        contentView.addSubview(foregroundView)
        foregroundView.addSubview(imageContainer)
        foregroundView.addSubview(strainName)
        foregroundView.addSubview(strainType)
        foregroundView.addSubview(saleMark)
        foregroundView.addSubview(pricePerGramLabel)
        foregroundView.addSubview(priceOfFiveLabel)
        foregroundView.addSubview(new)
        foregroundView.addSubview(inventoryBar)
        foregroundView.addSubview(inventoryLabel)
        
        inventoryLabel.anchor(top: nil, right: foregroundView.rightAnchor, bottom: inventoryBar.topAnchor, left: priceOfFiveLabel.rightAnchor, paddingTop: 0, paddingRight: 6, paddingBottom: 2, paddingLeft: 6, width: 0, height: 9)
        
        inventoryBar.anchor(top: saleMark.bottomAnchor, right: foregroundView.rightAnchor, bottom: foregroundView.bottomAnchor, left: imageContainer.rightAnchor, paddingTop: 8, paddingRight: 6, paddingBottom: 6, paddingLeft: 6, width: 0, height: 6.8)
        
        new.anchor(top: imageContainer.topAnchor, right: foregroundView.rightAnchor, bottom: nil, left: nil, paddingTop: 0, paddingRight: 6, paddingBottom: 0, paddingLeft: 0, width: 0, height: 20)
        
        priceOfFiveLabel.anchor(top: pricePerGramLabel.bottomAnchor, right: inventoryLabel.leftAnchor, bottom: nil, left: pricePerGramLabel.leftAnchor, paddingTop: 0, paddingRight: 38, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        
        pricePerGramLabel.anchor(top: strainName.bottomAnchor, right: foregroundView.rightAnchor, bottom: nil, left: strainType.rightAnchor, paddingTop: -4, paddingRight: 0, paddingBottom: 0, paddingLeft: 12, width: 0, height: 0)
        
        saleMark.anchor(top: strainType.bottomAnchor, right: nil, bottom: nil, left: imageContainer.rightAnchor, paddingTop: 8, paddingRight: 0, paddingBottom: 0, paddingLeft: 6, width: 0, height: 20)
        
        
        strainType.anchor(top: strainName.bottomAnchor, right: strainName.centerXAnchor, bottom: nil, left: imageContainer.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 6, width: 0, height: 21)
        
        strainName.anchor(top: foregroundView.topAnchor, right: nil, bottom: nil, left: imageContainer.rightAnchor, paddingTop: 6, paddingRight: 6, paddingBottom: 0, paddingLeft: 6, width: 0, height: 0)
        
        imageContainer.anchor(top: foregroundView.topAnchor, right: nil, bottom: foregroundView.bottomAnchor, left: foregroundView.leftAnchor, paddingTop: 6, paddingRight: 0, paddingBottom: 6, paddingLeft: 6, width: 100, height: 80)
        
        foregroundView.easy.layout([
            Height(120),
            Left(8),
            Right(8),
        ])
        
        let top = (foregroundView.easy.layout([Top(8)])).first
        top?.identifier = "ForegroundViewTop"
        self.foregroundViewTop = top
        
        foregroundView.layoutIfNeeded()
        
        return foregroundView
    }
    
    
    private func createContainerView() -> UIView {
        
        
        
        let containerView = UIView(frame: .zero)
        containerView.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        itemCount = 3
        
        
        
        let foldoutImage: UIImageView = {
            
            containerImageView.contentMode = .scaleAspectFit
            containerImageView.layer.cornerRadius = 5
            containerImageView.clipsToBounds = true
            
            let infoButton: UIButton = {
                let button = UIButton(type: .custom)
                let image = UIImage(named: "info")
                let tintedImage = image?.withRenderingMode(.alwaysTemplate)
//                button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                button.setImage(tintedImage, for: .normal)
                button.addTarget(self, action: #selector(showStrainInfoView), for: .touchUpInside)
                button.tintColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
                return button
            }()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showStrainInfoView))
            containerImageView.addGestureRecognizer(tapGesture)
            containerImageView.isUserInteractionEnabled = true
            
            containerImageView.addSubview(infoButton)
            infoButton.anchor(top: containerImageView.topAnchor, right: nil, bottom: nil, left: containerImageView.leftAnchor, paddingTop: 6, paddingRight: 0, paddingBottom: 0, paddingLeft: 6, width: 25, height: 25)
            
            return containerImageView
        }()
        
        img = foldoutImage
        
    
        
        
        foldoutStrainLabel.font = UIFont(name: "PineappleBoldInline", size: 26)
        foldoutStrainLabel.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        
        
        foldoutStrainType.font = UIFont(name: "Quicksand-Regular", size: 18)
        foldoutStrainType.textColor = #colorLiteral(red: 0.568627451, green: 0.5254901961, blue: 0.3568627451, alpha: 1)
        
        strainDescription.numberOfLines = 0
        //strainDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        strainDescription.font = UIFont(name: "Quicksand-Medium", size: 14)
        strainDescription.adjustsFontSizeToFitWidth = true
        
        
        
        let overAllView: UIView = {
            

            let circularPath = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)

            overallTrackLayer.path = circularPath.cgPath
            overallTrackLayer.strokeColor = #colorLiteral(red: 0.7076940536, green: 0.6990507841, blue: 0.6990718842, alpha: 1)
            overallTrackLayer.lineWidth = 5
            overallTrackLayer.lineCap = kCALineCapRound
            overallTrackLayer.fillColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
            overallTrackLayer.position = overAll.center


            overallShapeLayer.path = circularPath.cgPath
            overallShapeLayer.strokeColor = #colorLiteral(red: 0.6196078431, green: 0.3529411765, blue: 0.8352941176, alpha: 1)
            overallShapeLayer.lineWidth = 5
            overallShapeLayer.lineCap = kCALineCapRound
            overallShapeLayer.fillColor = UIColor.clear.cgColor
            overallShapeLayer.position = overAll.center

            overallShapeLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)

            overallValueLabel.textColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
            overallValueLabel.textAlignment = .center
            overallValueLabel.font = UIFont(name: "Quicksand-Bold", size: 22)

            overallValueLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            overallValueLabel.center.x = overAll.center.x
            overallValueLabel.center.y = overAll.center.y - 4

            let overallLabel: UILabel = {
                let label = UILabel()
                label.text = "overall"
                label.textColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
                label.textAlignment = .center
                label.font = UIFont(name: "Quicksand-Light", size: 12)
                return label
            }()

            overallLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
            overallLabel.center.x = overAll.center.x
            overallLabel.center.y = overAll.center.y + 8

            overAll.layer.addSublayer(overallTrackLayer)
            overAll.layer.addSublayer(overallShapeLayer)
            overAll.addSubview(overallValueLabel)
            overAll.addSubview(overallLabel)




            return overAll
        }()
        
        let thcView: UIView = {
            
            let circularPath = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)

            ThcTrackLayer.path = circularPath.cgPath
            ThcTrackLayer.strokeColor = #colorLiteral(red: 0.7076940536, green: 0.6990507841, blue: 0.6990718842, alpha: 1)
            ThcTrackLayer.lineWidth = 5
            ThcTrackLayer.lineCap = kCALineCapRound
            ThcTrackLayer.fillColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
            ThcTrackLayer.position = ThcView.center


            ThcShapeLayer.path = circularPath.cgPath
            ThcShapeLayer.strokeColor = #colorLiteral(red: 0.5960784314, green: 0.9098039216, blue: 0.5568627451, alpha: 1)
            ThcShapeLayer.lineWidth = 5
            ThcShapeLayer.lineCap = kCALineCapRound
            ThcShapeLayer.fillColor = UIColor.clear.cgColor
            ThcShapeLayer.position = ThcView.center

            ThcShapeLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)

            
            thcValueLabel.textColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
            thcValueLabel.textAlignment = .center
            thcValueLabel.font = UIFont(name: "Quicksand-Bold", size: 20)

            thcValueLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
            thcValueLabel.center.x = ThcView.center.x
            thcValueLabel.center.y = ThcView.center.y - 5

            let thcLabel: UILabel = {
                let label = UILabel()
                label.text = "THC"
                label.textColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
                label.textAlignment = .center
                label.font = UIFont(name: "Quicksand-Light", size: 12)
                return label
            }()

            thcLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
            thcLabel.center.x = ThcView.center.x
            thcLabel.center.y = ThcView.center.y + 11

            ThcView.layer.addSublayer(ThcTrackLayer)
            ThcView.layer.addSublayer(ThcShapeLayer)
            ThcView.addSubview(thcValueLabel)
            ThcView.addSubview(thcLabel)

            return ThcView
        }()
        
        let addToCartButton: UIButton = {
            let button = UIButton(type: .custom)
            let image = UIImage(named: "buy")
            let tintedImage = image?.withRenderingMode(.alwaysTemplate)
            button.setImage(tintedImage, for: .normal)
            button.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
            button.tintColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            return button
        }()
        
        let singlePrice: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Quicksand-Bold", size: 32)
            label.text = "$10 ea."
            label.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
            label.textAlignment = .center
            return label
        }()
        
        let for5Price: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Quicksand-Bold", size: 18)
            label.text = "5 for $50"
            label.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
            label.textAlignment = .left
            return label
        }()
        
        let forOzPrice: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "Quicksand-Bold", size: 18)
            label.text = "$235 per Oz."
            label.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
            label.textAlignment = .left
            return label
        }()
        
        contentView.addSubview(containerView)
        containerView.addSubview(foldoutImage)
        containerView.addSubview(foldoutStrainLabel)
        containerView.addSubview(foldoutStrainType)
        containerView.addSubview(strainDescription)
        containerView.addSubview(overAllView)
        containerView.addSubview(thcView)
        containerView.addSubview(addToCartButton)
        containerView.addSubview(singlePrice)
        containerView.addSubview(for5Price)
        containerView.addSubview(forOzPrice)
        
        forOzPrice.anchor(top: for5Price.bottomAnchor, right: addToCartButton.leftAnchor, bottom: nil, left: foldoutImage.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 8, width: 0, height: 0)
        
        for5Price.anchor(top: singlePrice.bottomAnchor, right: addToCartButton.leftAnchor, bottom: nil, left: foldoutImage.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 6, paddingLeft: 8, width: 0, height: 0)
        
        singlePrice.anchor(top: containerView.topAnchor, right: addToCartButton.leftAnchor, bottom: nil, left: foldoutImage.rightAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 6, paddingLeft: 8, width: 0, height: 0)
        
        addToCartButton.anchor(top: containerView.topAnchor, right: containerView.rightAnchor, bottom: nil, left: nil, paddingTop: 8, paddingRight: 8, paddingBottom: 0, paddingLeft: 0, width: 45, height: 45)
        

        thcView.anchor(top: overAllView.topAnchor, right: containerView.rightAnchor, bottom: overAllView.bottomAnchor, left: overAllView.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 0)
        
        overAllView.anchor(top: nil, right: nil, bottom: foldoutStrainType.topAnchor, left: foldoutImage.rightAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: -20, paddingLeft: 10, width: 75, height: 75)
        
        
        strainDescription.anchor(top: foldoutStrainLabel.bottomAnchor, right: containerView.rightAnchor, bottom: containerView.bottomAnchor, left: containerView.leftAnchor, paddingTop: 0, paddingRight: 8, paddingBottom: 6, paddingLeft: 8, width: 0, height: 0)
       
        
        foldoutStrainType.anchor(top: foldoutImage.bottomAnchor, right: foldoutImage.rightAnchor, bottom: strainDescription.topAnchor, left: foldoutStrainLabel.rightAnchor, paddingTop: 10, paddingRight: 0, paddingBottom: 0, paddingLeft: 6, width: 0, height: foldoutStrainLabel.bounds.size.height + 20)
        
        foldoutStrainLabel.anchor(top: foldoutImage.bottomAnchor, right: nil, bottom: strainDescription.topAnchor, left: containerView.leftAnchor, paddingTop: -20, paddingRight: 0, paddingBottom: -30, paddingLeft: 6, width: 0, height: 50)
        
        foldoutImage.anchor(top: containerView.topAnchor, right: containerView.centerXAnchor, bottom: containerView.centerYAnchor, left: containerView.leftAnchor, paddingTop: 6, paddingRight: 0, paddingBottom: 0, paddingLeft: 6, width: 200, height: 200)
        
         containerView.easy.layout([
            Height(CGFloat(120 * itemCount)),
            Left(8),
            Right(8),
        ])
        
        let top = (containerView.easy.layout([Top(8)])).first
        top?.identifier = "ContainerViewTop"
        self.containerViewTop = top
        
        containerView.layoutIfNeeded()
        
        return containerView
    }
    
    
    
    
    @objc func showStrainInfoView() {
        print("present info view")
    }
    
   @objc func addToCart() {
        print("add to cart button pressed")
//        addToCartButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.5)
//        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 12, options: [.curveEaseIn, .curveEaseOut, .allowUserInteraction], animations: {
//            self.addToCartButton.transform = .identity
//        }, completion: nil)
    }
}






