//
//  Logger.swift
//  Vimeo
//
//  Created by Lim, Jennifer on 4/9/18.
//  Copyright © 2018 Vimeo. All rights reserved.
//

/// This class `Logger` is used to logs different type of messages on the console.
@objc public class Logger: NSObject
{
    @objc public enum Subject: Int
    {
        case api
        case analytics
        // case performance
        // case caching
        case undefined
    }

    @objc public enum Level: Int
    {
        case info = 0
        case warning = 10
        case error = 20
    }

    // MARK: - Private

    private static let levelEvent: Level = .error
    static var subject: Subject = .api

    /// Add a emoji to indicates the type of level the log is.
    ///
    /// - Parameter level: Provide the Level of the log
    /// - Returns: A string that reflect the level of the log
    private static func levelToString(level: Level) -> String
    {
        switch level
        {
            case .info:
                return "ℹ️"
            case .warning:
                return "⚠️"
            case .error:
                return "‼️"
        }
    }

    private static func subjectToString(subject: Subject) -> String
    {
        switch subject
        {
        case .api:
            return "🌐"
        case .analytics:
            return "📊"
        case .undefined:
            return ""
        }
    }

    /// A helper can provide the source fileName
    private class func sourceFileName(filePath: String) -> String
    {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }

    /// Format the log.
    ///
    /// - Parameters:
    ///   - message: Indicates the message that will be logged on the console
    ///   - level: Indicates what type of the level is the log (info, warning, error or verbose)
    ///   - fileName: Indicates the file name where the log has been called from.
    ///   - funcName: Indicates the function name where the log has been called from.
    private class func logs(message: String, subject: Subject, level: Level, fileName: String, line: Int) -> String?
    {
        let eventString = Logger.levelToString(level: level)
        let subjectString = Logger.subjectToString(subject: subject)

        let isSubjectMatched = Logger.subject == .undefined ? true : Logger.subject  == subject

        let shouldLog = level.rawValue >= Logger.levelEvent.rawValue && isSubjectMatched

        guard shouldLog else
        {
            return nil
        }

        return "\(eventString)\(subjectString) \(Logger.sourceFileName(filePath: fileName)):\(line)\t \(message)"
    }

    // MARK: - Public

    @objc public class func log(message: String,
                                subject: Subject = .undefined,
                                level: Level,
                                fileName: String,
                                line: Int)
    {
        #if DEBUG
            guard let log = Logger.logs(message: message, subject: subject, level: level, fileName: fileName, line: line) else { return }
            print(log)
        #endif
    }
}
