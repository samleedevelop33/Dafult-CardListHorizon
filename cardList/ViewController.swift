//
//  ViewController.swift
//  cardList
//
//  Created by sam on 2021/01/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var interests = Interest.fatchInterests()
    let cellScale: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ui시작점이 화면중간
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellWidth) / 2.0

        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        //ui시작점이 화면중간

        collectionView.dataSource = self
        collectionView.delegate = self
    }


}

extension ViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntCollectionViewCell", for: indexPath) as! IntCollectionViewCell
        let interest = interests[indexPath.item]
        cell.interest = interest
        
        return cell
        
    }
    
    
}

//스크롤 걸리게 만들기
extension ViewController : UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
}

class IntCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var backgColor: UIView!
    @IBOutlet weak var intLabel : UILabel!
    
    var interest: Interest!{
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        if let interest = interest {
            intLabel.text = interest.title
            backgColor.backgroundColor = interest.color
        } else {
            intLabel.text = nil
            backgColor.backgroundColor = nil
        }
        
        backgColor.layer.cornerRadius = 10.0
        backgColor.layer.masksToBounds = true
    }
    
}

