//
//  Spatial.swift
//  Pods
//
//  Created by Lim, Jennifer on 1/6/17.
//
//
//

/// Spatial stores all information related to threesixty video
public class Spatial: VIMModelObject
{
    
    /// Represents the projection. Value returned by the server can be: "equirectangular", "cylindrical", "cubical", "pyramid", "dome".
    var projection: String?
    
    /// Represents the format. Value returned by the server can be: "mono", left-right", "top-bottom"
    var stereoFormat: String?
    
    // MARK: - VIMMappable
    
    public override func getObjectMapping() -> AnyObject!
    {
        return ["stereo_format" : "stereoFormat"]
    }
}
