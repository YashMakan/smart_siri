//
//  ExampleAsyncAppIntent.swift
//  Runner
//
//  Created by Yash Makan on 24/04/25.
//

import AVFoundation
import AppIntents
import UIKit
import smart_siri

@available(iOS 16, *)
struct ChatIntent: AppIntent {
    static var title: LocalizedStringResource = "Execute Custom Task"
    static var openAppWhenRun: Bool = false

    @Parameter(
        title: "Action to Execute",
        requestValueDialog: "Hey, how can I help you?"
    )
    var task: String

    @MainActor
    func perform() async throws -> some IntentResult {
        SmartSiriPlugin.configureAudioSession()
        SmartSiriPlugin.extendAppLifetime()
        SmartSiriPlugin.notifier.push(task)
        return .result()
    }

    static var parameterSummary: some ParameterSummary {
        Summary("Execute: \(\ChatIntent.$task)")
    }
}
