//
//  ViewController.swift
//  DiceNoStoryboard
//
//  Created by Eugene Kotovich on 04.04.2022.
//

import SwiftUI
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
//MARK: - Create UI
    
    let backgroundImage: UIImageView = {
        $0.image = UIImage(named: "background")
        $0.contentMode = .scaleAspectFill
        return $0
    } (UIImageView())
    
    let diceLogo = UIImageView(image: #imageLiteral(resourceName: "dicelogo"))
    
    let diceOneImageView = UIImageView(image: #imageLiteral(resourceName: "dice1"))
    let diceTwoImageView = UIImageView(image: #imageLiteral(resourceName: "dice1"))
    
    let rollButton: UIButton = {
        $0.backgroundColor = #colorLiteral(red: 0.6078431373, green: 0.1058823529, blue: 0.1254901961, alpha: 1)
        $0.setTitle("Roll", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        $0.layer.cornerRadius = 20
        $0.addTarget(nil, action: #selector(rollButtonPressed), for: .touchUpInside)
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40)
        return $0
    }(UIButton(type: .system))
    
        
    
//MARK: - Dice Randomize
    
    let dices = [#imageLiteral(resourceName: "dice1"), #imageLiteral(resourceName: "dice2"), #imageLiteral(resourceName: "dice3"), #imageLiteral(resourceName: "dice4"), #imageLiteral(resourceName: "dice5"), #imageLiteral(resourceName: "dice6")]
    
    @objc func rollButtonPressed() {
        diceOneImageView.image = dices.randomElement()
        diceTwoImageView.image = dices.randomElement()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            rollButtonPressed()
        }
    }
    
//MARK: - Initialize UI & Set Constraints
    
    func initialize() {
        
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        diceLogo.snp.makeConstraints { make in
            make.size.equalTo(200)
        }
        
        let diceStack = UIStackView(arrangedSubviews: [diceOneImageView, diceTwoImageView])
        diceStack.axis = .horizontal
        diceStack.alignment = .fill
        diceStack.distribution = .fill
        diceStack.spacing = 50
        
        let stack = UIStackView(arrangedSubviews: [diceLogo, diceStack, rollButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 100
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    //MARK: - Set SwiftUI Preview
    
    struct FlowProvider: PreviewProvider {
        static var previews: some View {
            ContainterView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
        }
        
        struct ContainterView: UIViewControllerRepresentable {
            
            let view = ViewController()
            func makeUIViewController(context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) -> ViewController {
                return view
            }
            
            func updateUIViewController(_ uiViewController: FlowProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<FlowProvider.ContainterView>) {
                
            }
            
        }
        
    }
}
