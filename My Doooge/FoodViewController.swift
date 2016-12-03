//
//  FoodViewController.swift
//  Doooge
//
//  Created by VicChan on 2016/11/26.
//  Copyright © 2016年 VicChan. All rights reserved.
//

import UIKit

struct Food{
    var image: String
    var id: Int
    var num: Int
    init(_ id: Int, _ image: String, _ num: Int = 1) {
        self.id = id
        self.image = image
        self.num = num
    }
}

protocol PresentViewControllerDelegate {
    func dismiss()
}


class FoodViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coinLabel: UILabel!
    static let cellIdentifier = "FoodCell"
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var foodCollection: UICollectionView!
    var currentRow = 0
    
    var delegate: PresentViewControllerDelegate?
    
    var foodList: [Food]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:60,height:47)
        flowLayout.minimumLineSpacing = 3
        flowLayout.scrollDirection = .horizontal
        forwardButton.isHidden = true
        backButton.isHidden = true
        
        
        self.foodCollection.collectionViewLayout = flowLayout
        self.foodCollection.register(UINib(nibName:"FoodCell",bundle: nil), forCellWithReuseIdentifier: FoodViewController.cellIdentifier)
        load()
        self.foodCollection.delegate = self
        self.foodCollection.dataSource = self
        
        
        currentRow = 3
        
        AnimationEngine.shared.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        delegate?.dismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    func load() {
        self.foodList = [
            Food(0,"cake"),
            Food(1,"chicken"),
            Food(2,"bone"),
            Food(3,"rice"),
            Food(0,"cake"),
            Food(1,"chicken"),
            Food(2,"bone"),
            Food(3,"rice"),
            Food(0,"cake"),
            Food(1,"chicken"),
            Food(2,"bone"),
            Food(3,"rice"),
            Food(0,"cake"),
            Food(1,"chicken"),
            Food(2,"bone"),
            Food(3,"rice")
        ]
        if foodList.count > 4 {
            forwardButton.isHidden = false
        }
        
        self.foodCollection.reloadData()
    }
    
    
    // MARK: Collection
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodViewController.cellIdentifier, for: indexPath) as! FoodCell
        let food = self.foodList[indexPath.row]
        cell.numLabel.text = "\(food.num)"
        cell.set(UIImage(named:food.image))
        return cell
    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        containerView.isHidden = true
        let food = self.foodList[indexPath.row]
        print(food)
        let id = food.id
        if id == 3 {
            AnimationEngine.shared.switchAnimation(.eat)
        }
        
    }
    
    @IBAction func goForward(_ sender: Any) {
        currentRow += 4
        let index = IndexPath.init(row: currentRow, section: 0)
        self.foodCollection.scrollToItem(at: index, at: .right, animated: true)


        if currentRow/4 == (foodList.count-1)/4 {
            forwardButton.isHidden = true
        }
        backButton.isHidden = false

        
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        
        if currentRow >= 7 {
            currentRow = currentRow - 4
        }
        if currentRow >= 3 {
            currentRow -= 3
        }
        let index = IndexPath.init(row: currentRow, section: 0)
        self.foodCollection.scrollToItem(at: index, at: .left, animated: true)
        
        if currentRow == 0 {
            backButton.isHidden = true
        }
        forwardButton.isHidden = false
        currentRow += 3
    }
    

    
}

extension FoodViewController:AnimationEngineDelegate {
    @objc(didFinshEating)
    func didFinshEating(){
        containerView.isHidden = false
    }
}
