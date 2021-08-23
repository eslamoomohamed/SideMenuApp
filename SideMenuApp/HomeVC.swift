//
//  ViewController.swift
//  SideMenuApp
//
//  Created by eslam on 6/19/21.
//

import UIKit

class HomeVC: UITableViewController {
    
    
    let menuVC    = MenuVC()
    let menuWidth: CGFloat = 300
    var isMenuOpened = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        configureNavigationController()
        configureMenuVC()
        configurePanGetsure()
    }
    
    
    private func configureNavigationController(){
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openBtnTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(hideBtnTapped))
    }
    
    
    func configurePanGetsure(){
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(configurePan))
        view.addGestureRecognizer(panGesture)
    }
    
    
    @objc func configurePan(panGesture: UIPanGestureRecognizer){
        let translation = panGesture.translation(in: view)
        let velocity    = panGesture.velocity(in: view)
        if panGesture.state == .changed{
            var x = translation.x
            if isMenuOpened{
                //?????
                x += menuWidth
                print(x)
            }
            x = min(menuWidth, x)
            print(x)
            x = max(0, x)
            print(x)
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuVC.view.transform = transform
            navigationController?.view.transform = transform
        }else if panGesture.state == .ended {
            if isMenuOpened{
                if abs(velocity.x) > 500{
                    hideBtnTapped()
                    return
                }
                if abs(translation.x) < menuWidth / 2 {
                    openBtnTapped()
                }else{
                    hideBtnTapped()
                }
            }else{
                if velocity.x > 500{
                    openBtnTapped()
                    return
                }
                if translation.x < menuWidth / 2{
                    hideBtnTapped()
                }else{
                    openBtnTapped()
                }
            }
        }
    }
    
    
    func configureMenuVC(){
        DispatchQueue.main.async { [self] in
            self.menuVC.view.frame = CGRect(x: -self.menuWidth, y: 0, width: self.menuWidth, height: view.frame.height)
            let mainWindow = UIApplication.shared.windows.first{$0.isKeyWindow}
            mainWindow?.addSubview(self.menuVC.view)
            addChild(menuVC)
        }
    }
    
    
    @objc func openBtnTapped(){
        print("Open button tapped")
        isMenuOpened = true
        performAnimation(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
    }
    
    
    @objc func hideBtnTapped(){
        print("Hide button tapped")
        performAnimation(transform: .identity)
        isMenuOpened = false
    }

    
    func performAnimation(transform: CGAffineTransform){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.menuVC.view.transform = transform
            self.navigationController?.view.transform = transform
        })
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
