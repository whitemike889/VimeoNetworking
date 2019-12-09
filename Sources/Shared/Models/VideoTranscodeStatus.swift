//
//  VideoTranscodeStatus.swift
//  VimeoNetworking
//
//  Created by Nicole Lehrer on 12/9/19.
//  Copyright © 2019 Vimeo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// Representation of a video's transcoding status
public struct VideoTranscodeStatus: Decodable {
    
    /// State of transcoding
    var state: TranscodeState
    
    /// Percent completed
    var progress: Int
    
    /// Time in seconds remaining until completion
    var timeLeft: Int
    
    /// State of the transcoding process
    ///
    /// - active: transcoding is in progress
    /// - failed: transcoding has failed
    /// - finishing: transcoding is finishing
    /// - pending:
    /// - ready:
    /// - retrieved:
    /// - standby: Awaiting for transcode
    /// - starting: Transcode is starting
    public enum TranscodeState: String, Decodable {
        case active
        case failed
        case finishing
        case pending
        case ready
        case retrieved
        case standby
        case starting
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.state = try container.decode(TranscodeState.self, forKey: .state)
        self.progress = try container.decode(Int.self, forKey: .progress)
        self.timeLeft = try container.decode(Int.self, forKey: .timeLeft)
    }
    
    private enum CodingKeys: String, CodingKey {
        case state
        case progress
        case timeLeft = "time_left"
    }
}
