# Smart Siri

Smart Siri is a Flutter-based project that enables developers to create and integrate Agentic AI workflows into Siri. With Smart Siri, you can trigger custom AI agents using voice commands like "Hey Sam" directly through Siri. The project leverages Flutter for the core application, AppIntents and AppShortcuts for Siri integration, and MethodChannel to communicate with Swift code. It supports background responses, inbuilt Text-to-Speech (TTS), custom TTS callbacks, and even voice cloning for personalized agent responses(the logic for voice cloning isnt presnt in the reposiytory and external API is used).

## Features

- **Custom Agentic AI Workflows**: Create and integrate personalized AI agents that can be triggered via Siri.
- **Siri Integration**: Use AppIntents and AppShortcuts to enable Siri voice commands like "Hey AGENT_NAME" (e.g., "Hey Sam").
- **Flutter-Based**: Entirely built with Flutter, ensuring cross-platform compatibility.
- **Native Communication**: Utilizes MethodChannel to bridge Flutter with Swift for seamless iOS integration.
- **Background Responses**: Supports AI responses processed in the background.
- **Text-to-Speech (TTS)**: Includes inbuilt TTS and supports custom TTS callbacks for AI responses.
- **Voice Cloning(External Python API)**: Demonstrates advanced voice cloning capabilities, as shown in the demo with a Sam Altman-inspired agent voice.
- **Developer-Friendly**: Provides a framework for developers to extend and customize AI workflows.

## Demo

Watch the YouTube demo showcasing Smart Siri, including the "Hey Sam" agent with a Sam Altman-inspired voice clone:

[Smart Siri Demo on YouTube](https://www.youtube.com/watch?v=G-GVmEaySdw)

## Getting Started

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Xcode (for iOS development and Siri integration)
- macOS (for building and testing iOS apps)
- An iOS device or simulator with Siri enabled

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/YashMakan/smart_siri.git
   cd smart_siri
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the App**:
   ```bash
   flutter run
   ```

## Example: Triggering "Hey Sam"

In the demo, the "Sam" agent is triggered by saying "Hey Sam" to Siri. The workflow:
- Receives the voice input via Siri.
- Uses MethodChannel to pass the request to the Flutter app.
- Processes the AI workflow in Flutter.
- Returns a response using a Sam Altman-inspired cloned voice.

## Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -m 'Add your feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or support, please open an issue on the GitHub repository or contact [contact@yashmakan.com](mailto:contact@yashmakan.com).