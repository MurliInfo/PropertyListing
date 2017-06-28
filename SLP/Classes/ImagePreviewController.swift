//
//  ImagePreviewController.swift
//  ScrollableImage
//
//  Created by Ratnesh Jain on 08/06/17.
//  Copyright © 2017 Ratnesh Jain. All rights reserved.
//

import UIKit
import AlamofireImage


/// ViewController class
class ImagePreviewController: UIViewController {

    init(images: [String], placeholderImage: String? = nil, previewIndex: Int? = nil) {
        self.images = images
        self.indexPath = IndexPath(item: previewIndex ?? 0, section: 0)
        self.placeholderImage = UIImage(named: placeholderImage ?? "")
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate let cellId = "imagePrevideCellId"
    
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
            self.pager.numberOfPages = self.images.count
        }
    }
    
    var indexPath: IndexPath?
    
    var placeholderImage: UIImage?
    
    var horizontalScrollIndicatorNeeded: Bool = false {
        didSet {
            self.collectionView.showsHorizontalScrollIndicator = horizontalScrollIndicatorNeeded
        }
    }

    var currentPageTintColor: UIColor = .darkGray {
        didSet {
            self.pager.currentPageIndicatorTintColor = currentPageTintColor
        }
    }
    
    var pageIndicatorTintColor: UIColor = .lightGray {
        didSet {
            self.pager.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }

    
    fileprivate lazy var collectionView: UICollectionView! = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.groupTableViewBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pager: UIPageControl = {
        let pager = UIPageControl(frame: .zero)
        pager.currentPage = 0
        pager.currentPageIndicatorTintColor = .gray
        pager.pageIndicatorTintColor = .lightGray
        pager.translatesAutoresizingMaskIntoConstraints = false
        pager.hidesForSinglePage = true
        pager.addTarget(self, action: #selector(pageChanged(pageControl:)), for: .valueChanged)
        return pager
    }()
    
    func pageChanged(pageControl: UIPageControl) {
        let currentPage = pageControl.currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func tapAction() {
        self.previewModeConfigurator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.setupBarButtons()
        self.setupCollectionView()
        //self.setupPageControl()
        
        self.collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.title = "Showing \(1) of \(self.images.count)"
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.layoutIfNeeded()
        
        if let indexPath = indexPath {
            self.collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        }
    }
    
    
    func doubleTapAction() {
        
    }
    
    private func setupBarButtons() {
        let leftBarButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissAction))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    private func setupPageControl() {
        self.view.addSubview(pager)
        
        NSLayoutConstraint(item: pager,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .left,
                           multiplier: 1,
                           constant: 0).isActive = true

        NSLayoutConstraint(item: pager,
                           attribute: .right,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .right,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: pager,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: pager,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .height,
                           multiplier: 1,
                           constant: 30).isActive = true
        
        self.pager.numberOfPages = self.images.count
        
    }
    
    func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint(item: collectionView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .left,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView,
                           attribute: .right,
                           relatedBy: .equal,
                           toItem: self.view,
                           attribute: .right,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        self.horizontalScrollIndicatorNeeded = false
    }
    
}


extension ImagePreviewController: UICollectionViewDelegate ,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? ImagePreviewCell {
            cell.configure(with: images[indexPath.item])
            cell.placeholderImage = self.placeholderImage
            cell.onSingleTap = { [weak self] in
                self?.previewModeConfigurator()
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func previewModeConfigurator() {
        
        let isHidden = !(self.navigationController?.navigationBar.alpha == 0)
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.collectionView.backgroundColor = isHidden ? .black : .groupTableViewBackground
        }
        self.navigationController?.navigationBar.alpha = isHidden ? 0 : 1
    }
}

extension ImagePreviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension ImagePreviewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = self.collectionView.contentOffset.x / self.collectionView.frame.size.width
        self.pager.currentPage = Int(index)
        self.title = "Showing \(Int(index) + 1) of \(self.images.count)"
    }
}



/// Image Preview Cell for ImagePreviewController
class ImagePreviewCell: UICollectionViewCell {

    lazy var imageView: UIImageView! = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        iv.contentMode = .scaleAspectFit
        iv.isUserInteractionEnabled = true
        return iv
    }()

    var placeholderImage: UIImage?
    var onSingleTap: (Void) -> Void = {}
    
    lazy var singleTapGesture: UITapGestureRecognizer = {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapAction))
        singleTap.numberOfTapsRequired = 1
        singleTap.require(toFail: self.doubleTapGesture)
        return singleTap
    }()
    
    lazy var doubleTapGesture: UITapGestureRecognizer = {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        return doubleTap
    }()
    
    
    func singleTapAction() {
        onSingleTap()
    }
    
    
    func doubleTapAction() {
        if self.scrollView.zoomScale < self.scrollView.maximumZoomScale {
            self.scrollView.setZoomScale(self.scrollView.maximumZoomScale, animated: true)
        }else {
            self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
        }
    }
    
    var onImageDrag: (Void) -> Void = {}
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 2.5
        sv.delegate = self
        return sv
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        ai.hidesWhenStopped = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.addSubview(scrollView)
        
        NSLayoutConstraint(item: scrollView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView,
                           attribute: .left,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .left,
                           multiplier: 1,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: scrollView,
                           attribute: .right,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .right,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.frame.size
        scrollView.addGestureRecognizer(singleTapGesture)
        self.imageView.addGestureRecognizer(doubleTapGesture)

    }
    
    func configure(with imageString: String) {
        if let url = URL(string: imageString) {
            setupIndicator(in: imageView)
            activityIndicator.startAnimating()
            self.imageView.af_setImage(withURL: url, placeholderImage: self.placeholderImage) { [weak self] _ in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
            }
        }
        scrollView.contentSize = imageView.frame.size
    }
    
    private func setupIndicator(in view: UIView) {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
}

extension ImagePreviewCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
