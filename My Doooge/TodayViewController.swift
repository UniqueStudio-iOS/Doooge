//
//  TodayViewController.swift
//  My Doooge
//
//  Created by VicChan on 2016/10/29.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit
import NotificationCenter
import AVFoundation





extension CGRect {
    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.init(x: x, y: y, width: width, height: height)
    }
}

extension UserDefaults {
    private static let groupIdentifier = "group.com.vic.Doooge"
    class func  doooge() -> UserDefaults {
        let user = UserDefaults(suiteName: groupIdentifier)!
        return user
    }
}



extension DateFormatter {
    private static let manager = DateFormatter()
    public class func shared() -> DateFormatter {
        return DateFormatter.manager
    }
    
}


enum MovementType: Int {
    case sleep1 = 0
    case sleep2 = 1
    case eat = 2
    case touch = 3
    case static1 = 4
    case static2 = 5
    case move = 6
    case wear = 7
    
}


class Sound {
    static var isOn: Bool = true
    
    static func sleep() {
        if Sound.isOn {
            let urlString = Bundle.main.path(forResource: "sleep", ofType: "wav")
            let url = URL(fileURLWithPath: urlString!)
            
            castVoice(url: url)
        }
    }
    
    static func eat() {
        if Sound.isOn {
            let urlString = Bundle.main.path(forResource: "eat", ofType: "mp3")
            let url = URL(fileURLWithPath: urlString!)
            castVoice(url: url)
        }
        
    }
    
    static func play() {
        if Sound.isOn {
            let urlString = Bundle.main.path(forResource: "play", ofType: "mp3")
            let url = URL(fileURLWithPath: urlString!)
            castVoice(url: url)
        }
        
    }
    
    static func touch() {
        if Sound.isOn {
            let urlString = Bundle.main.path(forResource: "touchdog", ofType: "mp3")
            let url = URL(fileURLWithPath: urlString!)
            
            castVoice(url: url)
        }
    }
    
    private static func castVoice(url: URL) {
        
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
}




/*
class DateManager {
    
    private static let manager = DateManager()
    class func shared() -> DateManager {
        return DateManager.manager
    }
}

*/


enum IncrementType: Int {
    case ontime = 0
    case overdue = 1
    case play = 2
    case undo = 3
    case sleep = 4
}

extension UIView {
    
    

}



class TodayViewController: UIViewController, NCWidgetProviding,UIViewControllerTransitioningDelegate {
    
    
    let animation = AnimationEngine.shared
    
    var animationView: AnimationView!

    @IBOutlet weak var growthLabel: UILabel!
    
    
    var messageView: MessageView!
    
    var tapGesture: UITapGestureRecognizer!
    

    @IBOutlet weak var verticalConstraint: NSLayoutConstraint!
    
    var tag: Int = 0

    
    private var lifeValue: Int = 0
    
    override func viewDidLayoutSubviews() {
        let width = UIScreen.main.bounds.width
        
        self.preferredContentSize = CGSize(width: width,height: 200)
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
    }
    
    
    override func viewWillLayoutSubviews() {
        let width = UIScreen.main.bounds.width

        self.preferredContentSize = CGSize(width: width,height: 200)
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tag += 1
        if self.extensionContext?.widgetActiveDisplayMode == .compact {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        self.view.addSubview(AnimationEngine.shared.animationView)
        animation.defaultAnimation()

    }
    
    
    @IBAction func openSound(_ sender: UIButton) {
        if Sound.isOn {
            sender.setBackgroundImage(UIImage(named:"AssistorOff"), for: .normal)
            Sound.isOn = false
        } else {
            sender.setBackgroundImage(UIImage(named:"AssistorOn"), for: .normal)
            Sound.isOn = true
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tag += 1
        //lifeValue = UserDefaults.doooge().object(forKey: "growthPoint") as! Int
        
        //growthLabel.text = "\(lifeValue)"
        let width = UIScreen.main.bounds.width
        
        let progressBar = ProgressBar(CGRect(width-120,2,100,13), 100, lv: 1)
        progressBar.levelLabel.text = "Lv35"
        self.view.addSubview(progressBar)
        
        if self.extensionContext?.widgetActiveDisplayMode == .compact {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }
        animationView = AnimationView(frame: CGRect(width/2.0-60,40,90,90))
        AnimationEngine.shared.initView(animationView)
        
        messageView = MessageView(frame: CGRect(width/2.0+30,60,97,22.5))
        self.view.addSubview(messageView)
        messageView.appear("Hello Worldello Worldello Worldello Worldello World")
    }
    
    
    

    
    @IBAction func play(_ sender: AnyObject) {

    }
    
    @IBAction func eat(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "showFood", sender: nil)
        //animation.switchAnimation(.eat)
        
    }
    
    @IBAction func sleep(_ sender: Any) {
        animation.switchAnimation(.sleep)
    
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {

        if activeDisplayMode == NCWidgetDisplayMode.compact {
            let width = UIScreen.main.bounds.width
            animate(expand: false)
            self.preferredContentSize = CGSize(width: width,height: 200)
            print("1")
        } else {
            let width = UIScreen.main.bounds.width
            animate(expand: true)
            self.preferredContentSize = CGSize(width: width,height: 120)
            print("2")

        } 
        
    }
    
    func animate(expand: Bool) {
        if expand == true && tag > 1 {
            verticalConstraint.constant += 15
            UIView.animate(withDuration: 0.3, animations: { 
                self.view.layoutIfNeeded()
            })
        } else if expand == false && tag > 1 {
            verticalConstraint.constant -= 15
            UIView.animate(withDuration: 0.3, animations: { 
                self.view.layoutIfNeeded()
            })
        }
    }

    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Transition()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFood" {
            let controller = segue.destination
            controller.transitioningDelegate = self
        }
    }

 
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {

        
        completionHandler(NCUpdateResult.newData)
    }
    
}
