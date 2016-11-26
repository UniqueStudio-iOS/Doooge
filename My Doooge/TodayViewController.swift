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
    
    
    
    var ttView: UIView?
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var imageView: GifImageView!

    @IBOutlet weak var growthLabel: UILabel!
    
    
    @IBOutlet weak var messageView: MessageView!
    
    var tapGesture: UITapGestureRecognizer!
    
    var timer: Timer?

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

        
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TodayViewController.touchAnimal))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        

        let list = movement(type: .static2)
        self.imageView.play(imageNames: list,repeated: true)

        
        let arr = [NotificationModel(content: "HHHHHH"),
                   NotificationModel(content: "WWWWWW"),
                   NotificationModel(content: "SSSSSS"),
                   NotificationModel(content: "FFFFFF")]
        
        NotificationManager().showRandom(content: arr)
    
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
        lifeValue = UserDefaults.doooge().object(forKey: "growthPoint") as! Int
        
        //growthLabel.text = "\(lifeValue)"


        
        if self.extensionContext?.widgetActiveDisplayMode == .compact {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }

        // messageView.appear()
        
        
        
        // Do any additional setup after loading the view from its nib.
    }
    
    
    
    func saveGrowth(value: Int) {
        lifeValue += value
        // growthLabel.text = "\(lifeValue)"
        let doooge = UserDefaults.doooge()
        doooge.set(lifeValue, forKey: "growthPoint")
        doooge.synchronize()
    }
    
    
    func touchAnimal() {

        timer?.invalidate()
        DispatchQueue.cancelPreviousPerformRequests(withTarget: self)

        let list = movement(type: .touch)
        imageView.play(imageNames: list,repeated: true)
    
        Sound.touch()
        //increment(type: .play)
        Bubble.show(score: 30, superView: self.view)
        saveGrowth(value: 30)
        
        self.perform(#selector(TodayViewController.defaultState), with: nil, afterDelay: 4.0)

        
    }

 
    
    @IBAction func openContainerApp(_ sender: AnyObject) {
  /*
        self.extensionContext?.open(URL(string:"Doooge://")!, completionHandler: { (finished) in
            print("\(finished)")
        })
*/
    }
    
    private func increment(type: IncrementType) {
        switch type {
        case .ontime: lifeValue += 50
        case .overdue:lifeValue += 20
        case .play: lifeValue += 30
        case .undo: lifeValue -= 10
        case .sleep: lifeValue += 20
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if messageView.isShow {
            messageView.disappear()
        } else {
            messageView.appear()
        }
    }
    
    // MARK: 喂食
    @IBAction func feed(_ sender: AnyObject) {
        
        timer?.invalidate()
        DispatchQueue.cancelPreviousPerformRequests(withTarget: self)
        let list: [String] = movement(type: .eat)
        
        imageView.play(imageNames: list,repeated: false)
        
        Sound.eat()


        
        
        Bubble.show(score: 50, superView: self.view)
        saveGrowth(value: 50)

        
        
        self.perform(#selector(TodayViewController.defaultState), with: nil, afterDelay: 3.0)

        
    }
    
    
    @IBAction func sleep(_ sender: AnyObject) {

        timer?.invalidate()
        DispatchQueue.cancelPreviousPerformRequests(withTarget: self)

        let list: [String] = movement(type: .sleep1)
        imageView.play(imageNames: list,repeated: false)
        Sound.sleep()
        //increment(type: .sleep)
        Bubble.show(score: 20, superView: self.view)
        saveGrowth(value: 20)

        self.perform(#selector(TodayViewController.keepSleep), with: nil, afterDelay: 4.8)
      
        
    }
    
    
    func keepSleep() {
        imageView.play(imageNames: ["sleep5","sleep6"], repeated: true)
    }
    
    @IBAction func move(_ sender: AnyObject) {
        timer?.invalidate()
        DispatchQueue.cancelPreviousPerformRequests(withTarget: self)

        let list: [String] = movement(type: .move)
        imageView.play(imageNames: list,repeated: true)
        Sound.play()
        
        
        self.perform(#selector(TodayViewController.defaultState), with: nil, afterDelay: 2.9)
        //increment(type: .play)
        
        Bubble.show(score: 30, superView: self.view)
        saveGrowth(value: 30)

        
        

    }
    
    func randomMovement() {
        
        let imageID = arc4random()%3
        var list = [String]()
        if imageID == 0 {
            list = movement(type: .static1)
        } else if imageID == 1 {
            list = movement(type: .static2)
        } else if imageID == 2 {
            list = movement(type: .wear)
        }
        imageView.play(imageNames: list,repeated: true)
    }
    
    
    func defaultState() {
        DispatchQueue.cancelPreviousPerformRequests(withTarget: self)

        randomMovement()

        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(TodayViewController.randomMovement), userInfo: nil, repeats: true)
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
    
    func movement(type: MovementType)->[String] {
        switch type {
        case .eat: return ["eat11","eat12","eat13","eat14","eat15","eat16","eat17","eat18","eat19","eat110","eat18","eat19","eat110","eat18","eat19","eat110"]
            
        case .sleep1: return ["sleep1","sleep2","sleep3","sleep4","sleep5","sleep4","sleep5","sleep4","sleep5","sleep4","sleep4","sleep5","sleep4","sleep5","sleep4","sleep5","sleep6"]
        case .sleep2: return ["sleep4","sleep5"]
            
        case .static1: return  ["random1","random2"]
            
        case .static2: return  ["doge11","eyes"]
            
        case .touch: return  ["touch1","touch2","touch3","touch4"]
            
        case .move:return ["play1","play2","play3","play4","play5","play6","play7","play8","play9","play10"]
        case .wear: return ["wear1","wear2","wear3","wear4","wear5","wear6"]

        }
    }
    
    /*
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
    }
    
    */

 
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
