//
//  UIControllerRepresentable.swift
//  testProject
//
//  Created by awaleh moussa hassan on 10/11/2020.
//

import Foundation
import SwiftUI
import UIKit


final class ViewControllerResolver: UIViewControllerRepresentable{
    
    let resolver: (UIViewController) -> Void
    
    init(_ resolver: @escaping (UIViewController) -> Void){
        self.resolver = resolver
    }
    
    func makeUIViewController(context: Context) -> ParentResolverViewController {
        let parentResolver = ParentResolverViewController(resolver: resolver)
        return parentResolver
    }
    
    func updateUIViewController(_ uiViewController: ParentResolverViewController, context: Context){
        // Do Nothing......
    }
    
}

class ParentResolverViewController: UIViewController{
    
    let resolver : (UIViewController) -> Void
    
    init(resolver: @escaping (UIViewController) -> Void){
         self.resolver = resolver
         super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        guard let parent = parent else {return}
        
        resolver(parent)
    }
}
