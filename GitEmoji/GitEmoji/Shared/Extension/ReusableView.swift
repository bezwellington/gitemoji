//
//  ReusableView.swift
//  GitEmoji
//
//  Created by Wellington Bezerra on 12/1/22.
//

import UIKit

// MARK: - Reusable View

protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - Default Conformances

extension UITableViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}


// MARK: - UICollectionView register Cell

extension UICollectionView {
    
    
    // MARK: - Register Cell
    
    func register<T: ReusableView>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: ReusableView>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.defaultReuseIdentifier, bundle: bundle)
        
        self.register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    
    // MARK: - Register Supplementary View (Header|Footer)
    
    func register<T: ReusableView>(_: T.Type, forSupplementaryViewOfKind elementKind: String) {
        self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: ReusableView>(_: T.Type, forSupplementaryViewOfKind kind: String) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.defaultReuseIdentifier, bundle: bundle)

        self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    
    // MARK: - Dequeue
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for  indexPath: IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue reusable supplementary with identifier: \(T.defaultReuseIdentifier)")
        }
        return view
    }
}


// MARK: - UITableView register Cell | Header

extension UITableView {
    
    
    // MARK: - Register Cell

    func register<T: ReusableView>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: ReusableView>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.defaultReuseIdentifier, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    

    // MARK: - Register Supplementary View (Header|Footer)

    func registerNibForHeaderFooterView<T: ReusableView>(_: T.Type) {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.defaultReuseIdentifier, bundle: bundle)

        self.register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    

    // MARK: - Dequeue Cell

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
