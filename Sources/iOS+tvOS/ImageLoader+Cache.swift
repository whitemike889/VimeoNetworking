//
//  ImageLoader+Cache.swift
//  VimeoNetworking
//
//  Created by Rogerio de Paula Assis on 9/18/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//

import UIKit
import AFNetworking

// TODO: This wrapper must be removed from the networking layer in favor of a more generic solution
// The only reason this is currently here is due to our dependency on AFNetworking and the
// fact that we use their loading/caching UIKit extensions extensively throughout our source code
extension UIImageView {

    @objc public func setImage(
        with urlRequest: URLRequest,
        placeholder: UIImage? = nil,
        then callback: ((UIImage?, Error?) -> Void)?) {
        self.setImageWith(
            urlRequest,
            placeholderImage: placeholder,
            success: { callback?($2, nil) },
            failure: { callback?(nil, $2) }
        )
    }
}
