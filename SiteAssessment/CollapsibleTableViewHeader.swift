//
//  CollapsibleTableViewHeader.swift
//  Site Assessment
//
//  Created by OMGdadada on 2018/7/10.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Content View
        contentView.backgroundColor = UIColor(red:0.26,green:0.59,blue:1.00,alpha:1.00)
        //UIColor(hex: 0x2E3944)
        let marginGuide = contentView.layoutMarginsGuide
        
        // Arrow label
        contentView.addSubview(arrowLabel)
        arrowLabel.textColor = UIColor.white
        //arrowLabel.backgroundColor = UIColor(red: 0, green: 102/256, blue: 204/256, alpha: 1)
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        // Title label
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        //titleLabel.backgroundColor = UIColor(red: 0, green: 102/256, blue: 204/256, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 41)
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.textAlignment = NSTextAlignment.center
        //
        // Call tapHeader when tapping on this header
        //
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // Trigger toggle section when tapping on the header
    //
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
       
        delegate?.toggleSection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        //
        // Animate the arrow rotation (see Extensions.swf)
        //
        arrowLabel.transform = CGAffineTransform(rotationAngle: collapsed ? .pi / 2 : 0.0)
        //arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
    }
    
}
