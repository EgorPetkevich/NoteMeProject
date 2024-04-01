//
//  HomeViewModelTests.swift
//  NoteMeTests
//
//  Created by George Popkich on 26.03.24.
//

import XCTest
@testable import NoteMe

final class HomeViewModelTests: XCTestCase {
    
    private let adapterSpy = HomeAdapterSpy()
    private let storageSpy = HomeStorageStub()
    private let frcSpy = HomeFRCServiceSpy()
    private let coordinatorSpy = HomeCoordinatorStub()
    
    private func makeSut() -> HomeVM {
        return HomeVM(adapter: adapterSpy,
                      storage: storageSpy,
                      coordinator: coordinatorSpy,
                      frcService: frcSpy)
    }
    
    private func clearData() {
        frcSpy.startHandleCalled = false
        adapterSpy.reloadDataCalled = false
        adapterSpy.reloadDataDTOList =  []
    }
    
    func test_ViewDidLoad() {
        clearData()
        let sut = makeSut()
        
        frcSpy.fetchedDTOs = [HomeDTOMock(), HomeDTOMock()]
        
        sut.viewDidLoad()
        
        XCTAssert(frcSpy.startHandleCalled)
        XCTAssert(adapterSpy.reloadDataCalled)
        XCTAssert(frcSpy.fetchedDTOs.count == adapterSpy.reloadDataDTOList.count)
    }
    
    func test_filter() {
        
    }
    
}
