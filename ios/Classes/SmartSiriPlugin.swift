//
//  SmartSiriPlugin.swift
//  YourModuleName
//

import AVFoundation
import Flutter
import UIKit

public class SmartSiriPlugin: NSObject, FlutterPlugin {
  public static let notifier = SelectionsPushOnlyStreamHandler()
  private let speechSynthesizer = AVSpeechSynthesizer()

  public static func extendAppLifetime() {
    guard UIApplication.shared.applicationState != .active else { return }

    let application = UIApplication.shared
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid

    backgroundTask = application.beginBackgroundTask(withName: "ExtendAppLife") {
      application.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }

    DispatchQueue.global().asyncAfter(deadline: .now() + 30) {
      application.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }
  }

  public static func configureAudioSession() {
    let audioSession = AVAudioSession.sharedInstance()
    if audioSession.category == .playback && audioSession.mode == .spokenAudio {
      return
    }
    do {
      try audioSession.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
      try audioSession.setActive(true)
    } catch {
      print("❌ Failed to configure audio session: \(error.localizedDescription)")
    }
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "smart-siri", binaryMessenger: registrar.messenger())
    let instance = SmartSiriPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    let eventChannel = FlutterEventChannel(name: "smart-siri/links",
                                           binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(notifier)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "backgroundResponse": handleBackgroundResponse(call, result: result)
      default:                 result(FlutterMethodNotImplemented)
    }
  }

  private func handleBackgroundResponse(_ call: FlutterMethodCall,
                                        result: @escaping FlutterResult) {
    guard UIApplication.shared.applicationState != .active else { return }

    guard let message = call.arguments as? String else {
      result(FlutterError(code: "INVALID_ARGUMENT",
                          message: "Expected a String message",
                          details: nil))
      return
    }

    let utterance = AVSpeechUtterance(string: message)
    utterance.voice = AVSpeechSynthesisVoice(
      identifier: "com.apple.ttsbundle.siri_female_en-US_compact"
    )

    do {
      try speakUtterance(utterance)
      result(true)
    } catch {
      result(FlutterError(code: "SPEECH_SYNTHESIS_ERROR",
                          message: "Failed to speak",
                          details: error.localizedDescription))
    }
  }

  private func speakUtterance(_ utterance: AVSpeechUtterance) throws {
    guard !speechSynthesizer.isSpeaking else {
      throw NSError(domain: "SpeechError",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "Already speaking"])
    }
    speechSynthesizer.speak(utterance)
  }
}

public class SelectionsPushOnlyStreamHandler: NSObject, FlutterStreamHandler {
  private var sink: FlutterEventSink?
  private var buffer: [String] = []

  public func push(_ selection: String) {
    buffer.append(selection)
    if let s = sink {
      flush(into: s)
    }
  }

  private func flush(into sink: FlutterEventSink) {
    buffer.forEach { sink($0) }
    buffer.removeAll()
  }

  public func onListen(withArguments arguments: Any?,
                       eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    sink = events
    flush(into: events)
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    sink = nil
    return nil
  }
}
