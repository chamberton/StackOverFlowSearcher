//
//  UIViewController+Extensions.swift
//  StackOverFlowSearcher
//
//  Created by Serge Mbamba on 2020/10/16.
//  Copyright © 2020 Serge Mbamba. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    func showLoadingIndicator(_ message: String?) {
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        progressHUD.mode = .indeterminate
        progressHUD.label.text = message
    }
    
    func hideLoadingIndicator() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    func showFailureAlert(title: String, message: String, retryAction: @escaping (() -> (Void)))  {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let operationAction = UIAlertAction(title: LocalizedCopy(named: "000-Try-again"), style: .default, handler: { (_) in
            retryAction()
        })
        let cancelAction = UIAlertAction(title: LocalizedCopy(named: "000-Cancel"), style: .cancel, handler: nil)
        alertViewController.addAction(operationAction)
        alertViewController.addAction(cancelAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
}
