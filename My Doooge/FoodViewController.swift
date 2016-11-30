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
    init(_ id: Int, _ image: String) {
        self.id = id
        self.image = image
    }
}

class FoodViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var coinLabel: UILabel!
    static let cellIdentifier = "FoodCell"
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var foodCollection: UICollectionView!
    
    
    var foodList: [Food]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width:60,height:47)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        self.foodCollection.collectionViewLayout = flowLayout
        self.foodCollection.register(UINib(nibName:"FoodCell",bundle: nil), forCellWithReuseIdentifier: FoodViewController.cellIdentifier)
        load()
        self.foodCollection.delegate = self
        self.foodCollection.dataSource = self
        
        

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func load() {
        self.foodList = [
            Food(0,"cake"),
            Food(1,"chicken"),
            Food(2,"bone"),
            Food(3,"rice")
        ]
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
        
        
        cell.set(UIImage(named:food.image))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
 /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
