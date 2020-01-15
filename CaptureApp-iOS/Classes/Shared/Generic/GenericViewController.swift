//
//  GenericViewController.swift
//  CaptureApp-iOS
//
//  Created by Tiago Mendes on 18/12/2019.
//

import Foundation
import UIKit

public class GenericViewController<View: GenericView>: UIViewController, UIScrollViewDelegate {
    
    internal var statNavigationInVC: Int = 0 // Sum controller that is used Tests
    
    internal var contentView: View { return view as! View }
    
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    public required init?(coder: NSCoder){
        super.init(coder: coder)
    }
    
    
    public override func loadView() {
        
        self.navigationController?.setNavigationBarHidden(preferNavigationBarHidden(), animated: false)
        view = View()
    }
    
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
 
    // MARK: Navigation
    
    /// Open new ViewController using a horizontal slide transition.
    internal func pushViewController(_ viewController: UIViewController, animated: Bool){
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        self.statNavigationInVC += 1
    }
    
    
    @objc internal func popToRooViewController(animated: Bool = true) {
        
        self.statNavigationInVC += 1
        if let nC = self.navigationController {
            DispatchQueue.main.async {
                nC.popToRootViewController(animated: true) // navigate back to the root
            }
        }
    }
    
    
    /// Back Button
    @objc internal func goBack() {
        DispatchQueue.main.async {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
        
    @objc func dismissPresenter() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
    
    
    @objc func cancelDismiss(){
        
        self.statNavigationInVC += 1
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Preference
    
    internal func preferNavigationBarHidden() -> Bool { return true }
        
    
    // MARK: Interface Rotation
    
    public override var shouldAutorotate: Bool{ return true }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask { get { return .portrait }}
    
    internal func forceInterfaceRotation(orientation: UIInterfaceOrientation = .portrait) {
        
        DispatchQueue.main.async {
            let value = orientation.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        }
    }
    
    
    // MARK: Alert
    
    internal func showAlertError(message: String){
        
        self.showAlertMessage(title: "Sorry...", message: message)
    }
    
    
    internal func showAlertMessage(title: String, message: String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
        })
        alertController.addAction(defaultAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: Spinner
    
    internal func startSpinner() {
        DispatchQueue.main.async {
            self.contentView.spinnerIsHidden(state: false)
            self.contentView.spinner.startAnimating()

        }
    }
    
    
    internal func stopSpinner() {
        DispatchQueue.main.async {
            self.contentView.spinnerIsHidden(state: true)
            self.contentView.spinner.stopAnimating()
        }
    }
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
