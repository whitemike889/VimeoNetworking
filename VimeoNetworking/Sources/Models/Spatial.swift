//
//  Spatial.swift
//  Pods
//
//  Created by Lim, Jennifer on 1/6/17.
//
//
//

public class Spatial: VIMModelObject
{
    public dynamic var projection: String?
    public dynamic var stereoFormat: String?
    
    // MARK: - VIMMappable
    
    public override func getObjectMapping() -> AnyObject!
    {
        return ["stereo_format" : "stereoFormat"]
    }
}
