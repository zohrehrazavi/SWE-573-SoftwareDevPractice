//
//  SwipingController.swift
//  OnboardingExample
//
//  Created by ömer nasuhi aydemir on 13.02.2020.
//  Copyright © 2020 Anitaa. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "int_pic_1", headerText: "PATIENT'S WEIGHT", bodyText: "This application aims to help physicians calculating the appropriate weight-based dose."),
        Page(imageName: "int_pic_2",headerText: "TREATMNET STAGE", bodyText: "It also indicates which of the loading and maintenance dose regimens have the least amount of wastage over a 4 week dosing period."),
        Page(imageName: "int_pic_3", headerText: "SELECTION CRITERIA", bodyText: "You can calculate the required dose with the minimum amount of wasted drug  product or minimum number of injections"),
        Page(imageName: "int_pic_1", headerText: "RESULT", bodyText: "You will have the weight-based result(in mg) and volume(in mL) in accordance with the Hemlibra label."),
       
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrev() {
        
        self.performSegue (withIdentifier: "GirisYap", sender: self)

       /* let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
 */
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "ileri_ok_icon") as UIImage?
        button.setBackgroundImage(image, for: UIControlState.normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        button.imageView?.contentMode = UIViewContentMode.scaleAspectFit

        
       
        button.setImage(image, for: UIControlState.normal)
        
        


      //  button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1)
        return pc
    }()
    
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        bottomControlsStackView.backgroundColor = UIColor(red: 0/255, green: 191/255, blue: 255/255, alpha: 1)
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
        
        setupBottomControls()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        
        //        cell.bearImageView.image = UIImage(named: page.imageName)
        //        cell.descriptionTextView.text = page.headerText
        
        //        let imageName = imageNames[indexPath.item]
        //        cell.bearImageView.image = UIImage(named: imageName)
        //        cell.descriptionTextView.text = headerStrings[indexPath.item]
        
        // definitely don't try this, it is a very bad idea
        //        let imageView = UIImageView()
        //        cell.addSubview(imageView)
        
        //        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
