//
//  URLSessionDataTaskMock.swift
//  LocationBased WikipediaTests
//
//  Created by Emad Bayramy on 8/6/21.
//

import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}
