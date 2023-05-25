//
//  Storyboarded.swift
//  ProductList
//
//  Created by Farghaly on 24/05/2023.
//

import UIKit

enum Storyboard: String {
	case Main

	var instance: UIStoryboard {
	  return UIStoryboard(name: rawValue, bundle: Bundle.main)
	}
}

extension UIViewController {
	class var storyboardID: String {
		return "\(self)"
	}
}
