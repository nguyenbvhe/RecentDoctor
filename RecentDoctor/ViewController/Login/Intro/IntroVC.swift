//
//  IntroVC.swift
//  RecentDoctor
//
//  Created by minhnguyen on 12/6/26.
//

import UIKit

class IntroVC: UIViewController {

    @IBOutlet weak var buttonCreateAccount: UIButton!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ViewBackground: UIView!
    var c = UIScreen.main.bounds.width + 40 + 156
    let introModel: [IntroModel] = [
        IntroModel(image: "Intro 1", quote: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", title: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"),
        IntroModel(image: "Intro 2", quote: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", title: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"),
        IntroModel(image: "Intro 3", quote: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", title: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupPageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        buttonLogin.titleLabel?.font = UIFont(name: "NunitoSans-SemiBold", size: 24)
        buttonCreateAccount.titleLabel?.font = UIFont(name: "NunitoSans-SemiBold", size: 15)
        let background = UIImageView(image: UIImage(named: "introBackground"))
        background.contentMode = .scaleAspectFill
        collectionView.backgroundView = background
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(cellType: IntroCollectionCell.self)
        
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = introModel.count
        pageControl.currentPage = 0
        
        if let  layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: (UIScreen.main.bounds.size.width + 156 + 20))
        ])
    }
    

    

}
extension IntroVC: UICollectionViewDataSource,UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeue(cellType: IntroCollectionCell.self, for: indexPath)
        cell.configure(with:introModel[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWight = collectionView.frame.width
        let currentPage = scrollView.contentOffset.x / pageWight
        var newPage = currentPage
        if velocity.x == 0 {
            newPage = round(currentPage)
        } else {
            newPage = velocity.x > 0 ? floor(currentPage + 1) : ceil(currentPage - 1)
        }
        newPage = max(min(CGFloat(introModel.count - 1 ), newPage), 0)
            targetContentOffset.pointee.x = newPage * pageWight
            pageControl.currentPage = Int(newPage)
    }
}


