//
//  PopPlaceDetailViewModel.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/3/21.
//

import Foundation

final class PopPlaceDetailViewModel {
    
    // MARK: - RequestModel
    private var requestModel: PageDetailRequestModel = PageDetailRequestModel()
    
    // MARK: - Services Initialize and injection
    var placeService: PlacesServiceProtocol
    
    init(placeService: PlacesServiceProtocol) {
        self.placeService = placeService
    }
    
    // MARK: - propeties
    var pageId: String!
    var loading: DataCompletion<Bool>?
    var pageModel: PageDetailModel!
    var detailResponse: DataCompletion<PageDetailModel>?
    var errorHandler: DataCompletion<String>?
    
    // MARK: - API Calls
    func getDetails(pageId: String) {
        self.loading?(true)
        
        placeService.getDetail(params: pageDetailQueryBuilder()) { [weak self] result in
            guard let self = self else { return }
            
            self.loading?(false)
            switch result {
            case .success(let query):
                
                guard ((query.query?.pages?.result?.first(where: {$0.key == pageId})) != nil) else {
                    self.errorHandler?(LocalizedStrings.pageIdNotValid.value)
                    return
                }
                self.pageModel = (query.query?.pages?.result?[pageId]!)!
                self.detailResponse?((query.query?.pages?.result?[pageId]!)!)
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Query Builder
    // we can customize data and create a builder class but its time consuming
    private func pageDetailQueryBuilder() -> PageDetailRequestModel {
        let stringBuilder = WikiStringsBuilder()
        
        var newRequestModel = requestModel
        newRequestModel.propItems = stringBuilder.setProps([.description, .pageimages, .info])
        newRequestModel.action = "query"
        newRequestModel.format = "json"
        newRequestModel.pageids = pageId
        
        return newRequestModel
    }
}
