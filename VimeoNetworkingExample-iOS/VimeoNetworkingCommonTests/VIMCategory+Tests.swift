//
//  VIMCategory+Tests.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Westendorf, Michael on 5/15/17.
//  Copyright © 2017 Vimeo. All rights reserved.
//

import XCTest
@testable import VimeoNetworking

class VIMCategory_Tests: XCTestCase
{
    private var parsedCategory: VIMCategory?
    private var categoryJSONDict: VimeoClient.ResponseDictionary?
    
    override func setUp()
    {
        super.setUp()
        
        guard let categoryJSONDict = ResponseUtilities.loadResponse(from: "categories-animation-response.json") else
        {
            self.parsedCategory = nil
            self.categoryJSONDict = nil
            return
        }
        
        self.categoryJSONDict = categoryJSONDict
        self.parsedCategory = try! VIMObjectMapper.mapObject(responseDictionary: categoryJSONDict) as VIMCategory
    }
    
    func test_VIMCategory_ValidateParsing()
    {
        XCTAssertNotNil(self.parsedCategory)
        
        XCTAssertEqual(self.parsedCategory?.name, self.categoryJSONDict?["name"] as? String)
        XCTAssertEqual(self.parsedCategory?.uri, self.categoryJSONDict?["uri"] as? String)
        XCTAssertEqual(self.parsedCategory?.link, self.categoryJSONDict?["link"] as? String)
        XCTAssertTrue(self.parsedCategory?.isTopLevel ?? false)

        //There is no modifiedTime field in the response data so this should be nil
        XCTAssertNil(self.parsedCategory?.modifiedTime)
        
        XCTAssertNotNil(self.parsedCategory?.pictureCollection)
        XCTAssertGreaterThan(self.parsedCategory?.pictureCollection?.pictures?.count ?? 0, 0)
        
        XCTAssertNotNil(self.parsedCategory?.subcategories)
        XCTAssertGreaterThan(self.parsedCategory?.subcategories?.count ?? 0, 0)
    }
    
    func test_VIMCategory_IsFollowingReturnsTrue()
    {
        XCTAssertNotNil(self.parsedCategory)
        XCTAssertTrue(self.parsedCategory?.isFollowing() ?? false)
    }
    
    func test_VIMCategory_ParsedSubcategories()
    {
        XCTAssertNotNil(self.parsedCategory?.subcategories)
        
        let subCatsArray = self.categoryJSONDict?["subcategories"] as? [Dictionary<String, String>]
        
        var i = 0
        for subCategory in self.parsedCategory?.subcategories as! [VIMCategory]
        {
            XCTAssertNotNil(subCategory.name)
            XCTAssertNotNil(subCategory.uri)
            XCTAssertNotNil(subCategory.link)
            
            XCTAssertEqual(subCategory.name, subCatsArray?[i]["name"])
            XCTAssertEqual(subCategory.uri, subCatsArray?[i]["uri"])
            XCTAssertEqual(subCategory.link, subCatsArray?[i]["link"])
            
            i = i + 1
        }
    }

    func test_VIMCategory_ParsedPictureCollection()
    {
        XCTAssertNotNil(self.parsedCategory?.pictureCollection)
        
        let collectionObject = self.categoryJSONDict?["pictures"] as? Dictionary<String, Any>
        let picturesArray = collectionObject?["sizes"] as? [Dictionary<String, Any>]
        
        XCTAssertEqual(self.parsedCategory?.pictureCollection?.uri, collectionObject?["uri"] as? String)
        
        var i = 0
        for picture in self.parsedCategory?.pictureCollection?.pictures as! [VIMPicture]
        {
            XCTAssertNotNil(picture.link)
            XCTAssertNotNil(picture.width)
            XCTAssertNotNil(picture.height)
            
            XCTAssertEqual(picture.link, picturesArray?[i]["link"] as? String)
            XCTAssertEqual(picture.width, picturesArray?[i]["width"] as? NSNumber)
            XCTAssertEqual(picture.height, picturesArray?[i]["height"] as? NSNumber)
            
            i = i + 1
        }
    }
    
    func test_VIMCategory_ConnectionParsing()
    {
        XCTAssertNotNil(self.parsedCategory?.connection(withName: VIMConnectionNameGroups))
        XCTAssertNotNil(self.parsedCategory?.connection(withName: VIMConnectionNameChannels))
        XCTAssertNotNil(self.parsedCategory?.connection(withName: VIMConnectionNameVideos))
        XCTAssertNotNil(self.parsedCategory?.connection(withName: VIMConnectionNameUsers))
    }
    
    func test_Performance_ParsingCategoryObject()
    {
        guard let categoryJSONDict = ResponseUtilities.loadResponse(from: "categories-animation-response.json") else
        {
            XCTFail("unable to load response data from file")
            return
        }
        
        self.measure {
            let parsedCategory = try! VIMObjectMapper.mapObject(responseDictionary: categoryJSONDict) as VIMCategory
            XCTAssertNotNil(parsedCategory)
        }
    }
    
}
