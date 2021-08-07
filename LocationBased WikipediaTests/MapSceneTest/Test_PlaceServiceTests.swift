//
//  Test_PlaceServiceTests.swift
//  LocationBased WikipediaTests
//
//  Created by Emad Bayramy on 8/6/21.
//

import XCTest

@testable import LocationBased_Wikipedia

final class PlaceServiceTests: XCTestCase {
    
    var sut: PlacesService?
    var nerabyPlaceJSON: Data?
    var PageDetailJSON: Data?
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        if let path = bundle.path(forResource: "NeabyPlaceMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.nerabyPlaceJSON = data
            } catch {
                
            }
        }
        
        if let path = bundle.path(forResource: "PageDetailMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                self.PageDetailJSON = data
            } catch {

            }
        }
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_getPlaces() {
        
        // Given
        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = nerabyPlaceJSON
        let mockRequestManager = RequestManagerMock(session: urlSessionMock, validator: MockResponseValidator())
        sut = PlacesService(requestManager: mockRequestManager)
        let expectation = XCTestExpectation(description: "Async query test")
        var baseResponse: BaseResponse<QueryModel>?
        
        // When
        sut?.getNearbyPlaces(params: NearbyArticlesRequestModel(), completionHandler: { (result) in
            defer {
                expectation.fulfill()
            }
            switch result {
            case .success(let response):
                baseResponse = response
            case .failure:
                XCTFail("Fail to get Result")
            }
        })
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(baseResponse?.query?.geosearch?.count == 50)
    }
    
    func test_getPageDetail() {
        
        // Given
        let urlSessionMock = URLSessionMock()
        urlSessionMock.data = PageDetailJSON
        let mockRequestManager = RequestManagerMock(session: urlSessionMock, validator: MockResponseValidator())
        sut = PlacesService(requestManager: mockRequestManager)
        let expectation = XCTestExpectation(description: "Async PageDetail test")
        var pageDetailBaseResponse: BaseResponse<PlaceDetailResponseModel>?
        
        // When
        sut?.getDetail(params: PageDetailRequestModel(), completionHandler: { (result) in
            defer {
                expectation.fulfill()
            }
            switch result {
            case .success(let pageDetail):
                pageDetailBaseResponse = pageDetail
            case .failure:
                XCTFail("Fail to get Result")
            }
        })
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertTrue(((pageDetailBaseResponse?.query?.pages?.result) != nil))
        
    }
}
