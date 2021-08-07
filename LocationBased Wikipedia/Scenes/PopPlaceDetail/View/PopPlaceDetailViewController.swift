//
//  PopPlaceDetailViewController.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/2/21.
//

import UIKit

class PopPlaceDetailViewController: BaseVC, Storyboarded {
    
    // MARK: - outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet var getThereButton: UIButton!
    @IBOutlet var routeSuggestionButton: UIButton!
    
    // MARK: - Coordinator
    weak var coordinator: AppCoordinator?
    
    // MARK: - ViewModel
    let mainViewModel = PopPlaceDetailViewModel(placeService: PlacesService.shared)
    
    // MARK: - CollectionView DataSource
    var imagesCollectionViewDataSource: CustomCollectionViewDataSource<ImageViewCell>!
    
    // MARK: - Properties
    var getThereCompletion: DataCompletion<String> = { _ in }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        APICall()
    }
    
    // MARK: - View
    private func setupView() {
        
        // CollectionView Setup
        imagesCollectionViewDataSource = CustomCollectionViewDataSource(items: [], collectionView: imagesCollectionView, delegate: self)
        imagesCollectionView.delegate = imagesCollectionViewDataSource
        imagesCollectionView.dataSource = imagesCollectionViewDataSource
        imagesCollectionView.showsHorizontalScrollIndicator = true
        
        getThereButton.setTitle(LocalizedStrings.getThere.value, for: .normal)
        routeSuggestionButton.setTitle(LocalizedStrings.routeSuggestion.value, for: .normal)
        
        setupTapFunctions()
        
    }
    
    private func setupTapFunctions() {
        getThereButton.addTarget(self, action: #selector(didTapGetThere(_:)), for: .touchUpInside)
    }
    
    @objc private func didTapGetThere(_ button: UIButton) {
        print("Get There tapped")
        getThereCompletion(mainViewModel.pageId)
    }
    
    private func fillView() {
        titleLabel.text = mainViewModel.pageModel.title
        descriptionLabel.text = mainViewModel.pageModel.articleDescription
        
        guard let images = mainViewModel.pageModel.thumbnail else {
            imagesCollectionView.isHidden = true
            return
        }
        
        imagesCollectionView.isHidden = false
        imagesCollectionViewDataSource.appendItemsToCollectionView([images])
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        
        // Subscribe to Loading
        mainViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.view.animateActivityIndicator() : self.view.removeActivityIndicator()
        }
        
        // Subscribe to Places
        mainViewModel.detailResponse = { [weak self] _ in
            guard let self = self else { return }
            self.fillView()
        }
        
        // Subscribe to errors
        mainViewModel.errorHandler = { [weak self] error in
            guard let self = self else { return }
            self.showAlert(message: error)
        }
        
    }
    
    // MARK: - API Calls
    private func APICall() {
        mainViewModel.getDetails(pageId: mainViewModel.pageId)
    }
}

// MARK: - CustomCollectionViewDelegate
extension PopPlaceDetailViewController: CustomCollectionViewDelegate { }
