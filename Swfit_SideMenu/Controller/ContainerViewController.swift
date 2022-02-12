//
//  ViewController.swift
//  Swfit_SideMenu
//
//  Created by 申民鐡 on 2022/02/11.
//

import UIKit

class ContainerViewController: UIViewController, HomeViewControllerDelegate,UITableViewDataSource,UITableViewDelegate, MenuViewControllerDelegate {
    
    enum MenuState {
        case opened
        case colsed
    }
    
    private var menuState: MenuState = .colsed
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func didTapMenu() {
        toggleMenu(completion: nil)
    }
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .colsed:
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut){
                    self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 150
                } completion: { done in
                    if done {
                        self.menuState = .opened
                    }
                }
        case .opened:
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut){
                    self.navVC?.view.frame.origin.x = 0
                } completion: { [weak self ] done in
                    if done {
                        self?.menuState = .colsed
                        DispatchQueue.main.async {
                            completion?()
                        }
                    }
                }
        }
    }
    func didSelect(item: MenuViewController.MenuOption) {
        toggleMenu(completion: nil)
            switch item {
            case .home:
                self.returnToHome()
            case .info:
                self.addInfo()
//                let vc = InfoViewController()
//                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            case .appRating:
                break
            case .shareApp:
                break
            case .settings:
                break
                
            }
        }

    let homeVC = HomeViewController()
    let menuVC = MenuViewController()
    var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addChildVC()
    }

    func addInfo(){
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func returnToHome(){
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "HOME"
    }
    
    
    func addChildVC () {
        //menu
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        menuVC.delegate = self
        
        //home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

