//
//  HomeViewController.swift
//  Swfit_SideMenu
//
//  Created by 申民鐡 on 2022/02/11.
//

import UIKit
protocol HomeViewControllerDelegate:AnyObject{
    func didTapMenu()
}


class HomeViewController: UIViewController {

    weak var delegate:HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "HOME"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                                            image: UIImage(systemName: "list.dash"),
                                            style: .done,
                                            target: self,
                                            action: #selector(didTapMenu))
    }
    
    @objc func didTapMenu(){
        delegate?.didTapMenu()
    }
}
