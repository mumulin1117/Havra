// FerryHarborRoute.swift
// Havra · B module

import UIKit
import WebKit

final class FerryHarborRoute {
    static let tranquilWonderTrail = FerryHarborRoute()
    private weak var window: UIWindow?
    private var fallback: (() -> UIViewController)?
    static var tranquilCuriosityTrail: Bool {
        get {
            HavraBConfiguration.Storage.entryState()
        }
        set { UserDefaults.standard.set(newValue, forKey: BambooLanternPath.stateKey) }
    }

    func tranquilThoughtTrail(tranquilAffinityTrail: UIWindow, tranquilReflectionTrail: @escaping () -> UIViewController) {
        window = tranquilAffinityTrail
        fallback = tranquilReflectionTrail
        connect()
    }

    private func connect(automatically: Bool = true) {
        (window?.rootViewController as? UINavigationController)?.viewControllers
            .compactMap { $0 as? TropicalCourtyardLife }.forEach { $0.gentleExpressionBeacon() }
        window?.rootViewController = HavraBEntryController(automatically: automatically) { [weak self] configuration, webView in
            guard let self else { return }
            guard let configuration else {
                self.window?.rootViewController = self.fallback?()
                return
            }
            if automatically && !Self.tranquilCuriosityTrail { return self.connect(automatically: false) }
            let controller = TropicalCourtyardLife(configuration: configuration, manual: !automatically, webView: webView,
                fallback: { [weak self] in self?.window?.rootViewController = self?.fallback?() },
                reconnect: { [weak self] in self?.connect(automatically: false) })
            let navigation = UINavigationController(rootViewController: controller)
            navigation.setNavigationBarHidden(true, animated: false)
            self.window?.rootViewController = navigation
        }
    }
}

final class HavraBEntryController: UIViewController {
    private let automatically: Bool
    private let completion: (HavraBEntryConfiguration?, WKWebView?) -> Void
    private let loading = FestivalLanternGlow()
    private var task: Task<Void, Never>?
    private var prewarmed: WKWebView?

    init(automatically: Bool, completion: @escaping (HavraBEntryConfiguration?, WKWebView?) -> Void) {
        self.automatically = automatically
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    deinit { task?.cancel() }

    override func viewDidLoad() {
        super.viewDidLoad()
        loading.havraFill(view)
        loading.stellarInspirationTrail(stellarReflectionTrail: !automatically, stellarThoughtTrail: !automatically)
        loading.sereneImaginationTrail.addTarget(self, action: #selector(connect), for: .touchUpInside)
        if automatically { connect() }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        task?.cancel()
        prewarmed = nil
    }

    @objc private func connect() {
        guard task == nil else { return }
        loading.stellarWonderTrail(true)
        task = Task { [weak self] in
            guard let self else { return }
            let entryWaitStarted = ProcessInfo.processInfo.systemUptime
            HavraBConfiguration.Diagnostics.startup("entry_wait_started")
            self.prewarmed = TropicalCourtyardLife.gentleWonderSignalPath()
            do {
                let configuration = try await CoastalKitchenScene.lucentCuriosityTrail.lucentDreamTrail()
                try Task.checkCancellation()
                HavraBConfiguration.Diagnostics.elapsed("entry_wait_ms", since: entryWaitStarted)
                let webView = configuration == nil ? nil : self.prewarmed
                self.task = nil
                self.prewarmed = nil
                self.loading.stellarInspirationTrail(stellarReflectionTrail: configuration != nil, stellarThoughtTrail: !self.automatically)
                self.completion(configuration, webView)
            } catch {
                guard !Task.isCancelled else { return }
                self.task = nil
                self.prewarmed = nil
                if self.automatically {
                    self.completion(nil, nil)
                } else {
                    self.loading.stellarWonderTrail(false, velvetCuriosityTrail: "Unable to connect. Please try again.")
                }
            }
        }
    }
}
