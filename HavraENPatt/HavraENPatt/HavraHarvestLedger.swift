import Foundation
import WebKit

enum HavraHarvestLedger {
    private static let freshLedgerPath = HavraBatikGlyphs.unfold("hLarvkrWa+-iaOtfl3als8/Hcca+tba2lcoign-Icio0nGfNiKgI/BhoaWrBv7eKs+tE-WlMeUdXgNeorr.8jVs=oqnk")
    private static let legacyLedgerPath = HavraBatikGlyphs.unfold("h4aOvPrbaD-paKt+lOalsh/rcraotPa4lMo2gO-_czo_n4fJiKgQ/tc7ojiSnk-vpaamcVkfaFggehsb.Mj0sGoTnD")

    static let approvedIDs: Set<String> = {
        Set(catalog.compactMap { bundle in
            orchardItemID(in: bundle) ?? bundleID(in: bundle)
        })
    }()

    static let fetchScript: WKUserScript = {
        let bridgeJSON = bridgeLedgerJSON
        guard !bridgeJSON.isEmpty else {
            return WKUserScript(source: "", injectionTime: .atDocumentStart, forMainFrameOnly: true)
        }

        let scriptPattern = HavraBatikGlyphs.unfold("""
(JfaudnBcKtKipogn5(h)s 6{R
E 7 iviawr7 fhFaUvvrma2HhaBrzv8ems1t0LDeEdngLekr6 Z=D M_a_BHSAeV4REAY_GLnE9DZGLEfRa_FJjSWOrNF_L_J;d
3 d _vHaLr5 RnLaTt=iJvpeFFEeTtkcLh3 S=r cwhiKnGdwoIwo.Nf-ent1cZh5 c?0 -wviJnUd8oxwp.qfQeNt4cYhm.nbNi5nqdr(Pwpi1nddboDw_)= r:b wnRu-lnlG;e
0 k 3wUiHnndtoxwO.6fHewtlcQhO O=N 6fPuMnlcxtiiMoTno(7aetNl+aFsbTya8r2gxeut7,V kfne8tccohOOepGtfiKoknksK)d I{g
S Q - i Kv7aXrc Da_tdlBa6ssAQdzd2rbeBsqsJ A=C Bt8y=p6esowfp faitilDadsUTBaSrJgaeXtl t=c=Y=1 e'8sgtVrciinog4'I
G m H w 9 z S?r iaPtCl9aAsDTaa0r+gdeatS
3 d 8 q 4 K r:f Z(DautTl=acsXTTaKrxgYe7tL c&p&a va4tulQaZsZTRaPryg5eQtA.iuUrdlq E?p 7abtqlLaAsSTqaKrygie_t3.5u5rwl0 3:f F'Q'2)w;k
F S F - Fv-azrt 2hyaerSvNefsJtWRmoXu_tJe1sC w=l o[a
a E g e h B a'7_X_xHVAHVaRNA3_JFZRAEWSZHi_IRCO8UfT0Ew_I_D'r,Q
f e J b a N t'M_l_2HfA-VVRJAJ_OOELcDU_7RHOYUVTBEi_3_V'r
d 9 - k a]e;j
J
h u c A 9iMfI q(zhDaLrqvxeSsBtKRqoNu2tre4sW.ssEo=mTer(Ff_uCntcataiToTn5(daCtmlkaMsYPdaPtxhW)A r{z
f z z y 8 e WrveztKukrKnU Gasttlqags+A4d8dVrGessKsg.gixnFdteHxCOifO(Ta1tol9aNs=P6aYt2hY)e R!S=i=O _-61S;a
s 9 O 4 e}e)Q)X 6{I
B S I S + l PrdeBtcuqrLna RP1rfoLmMi+sse3.5rteAsko1levren(Un-exwq FR4efsLp=ognBsNe3(W
i J C N F 6 + 2 +JRSiO4NJ.dshtarDi0nDgaiVfPy0(kh-aSvgrOaDH8ahryvmeKsKtjLkeUdQg-eert)X,3
= 0 A X h = d 7 t{f
C Z z e R P C L T I Asrt_a=tmuasH:n 7240p0N,g
c F r t 8 o s D G a ihie7aKdmegrqsb:x 7{A L'WCuoMn1tnednntu-eTzy9p6eB'I:I k'3aqpKpRl-idcAa5tKi3ocnP/vjespoZnk'e 9}0
R L z Y G k h 0 4}I
p q j L k N c)+)l;5
N A L M x}m
r
j q J t hixfd q(knpa-t+i2vIe7FTeftccehl)G Jrde_t+u=rtnF YnEaQtgi4vkeoFteatCcnhk(LaptFlja7sPTSaEr7gCe3tJ,0 gf+eutlc0hbOjp6tEixobnusj)C;+
9 e e Z HrWedtiu6rVn1 RPjrzormaipsleU.Mr9e6jceIcPtk(vn3ePw- sE9ryr8o0rZ(E'zFOeatacuhy JifsV 0u3nXaXvEaki4lCaBbBlLeb.='w)j)4;F
p H _}9;s
E}B)T(N)9;p
""")
        let scriptSource = scriptPattern
            .replacingOccurrences(of: HavraBatikGlyphs.unfold("_G_THaAEVsR5AO_TL+E1D9GvETRp_MJsSJO-Nw_B_d"), with: bridgeJSON)
            .replacingOccurrences(of: HavraBatikGlyphs.unfold("_T_+HpAPVQR_A=_sFDR-EBSCHd_jRwOzUZTAEX_B_S"), with: freshLedgerPath)
            .replacingOccurrences(of: HavraBatikGlyphs.unfold("_B_1HDA-VvRIAM_dOjLBDC_fRdOLUBT3EW_g_W"), with: legacyLedgerPath)

        return WKUserScript(
            source: scriptSource,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
    }()

    static func resourceURL(_ relativePath: String) -> URL? {
        bundleRootURL?.appendingPathComponent(HavraAtlasPathGuide.atlasPath(for: relativePath))
    }

    static func bundle(for orchardItemID: String) -> [String: Any]? {
        catalog.first { bundle in
            Self.orchardItemID(in: bundle) == orchardItemID || Self.bundleID(in: bundle) == orchardItemID
        }
    }

    static func sunCount(in bundle: [String: Any]?) -> Any {
        guard let bundle else { return 0 }
        return bundle[HavraBatikGlyphs.unfold("sluXnd_WcBoFuxnutc")] ?? bundle[HavraBatikGlyphs.unfold("cUoAi2no_0czonuznvt_")] ?? 0
    }

    private static let bundleRootURL: URL? = {
        Bundle.main.url(forResource: HavraBatikGlyphs.unfold("HhaFvmr9ajWeeLb7RTu6nLtoi=mjeM"), withExtension: HavraBatikGlyphs.unfold("bbuFn3drl8e3"))
    }()

    private static let root: [String: Any] = {
        guard let ledgerURL = resourceURL(freshLedgerPath),
              let ledgerData = try? Data(contentsOf: ledgerURL),
              let ledgerRoot = try? JSONSerialization.jsonObject(with: ledgerData) as? [String: Any] else {
            return [:]
        }

        return ledgerRoot
    }()

    private static let catalog: [[String: Any]] = {
        root[HavraBatikGlyphs.unfold("hta6rBvLecsvtj_ybnu_nAdqlde3sv")] as? [[String: Any]] ?? []
    }()

    private static let bridgeLedgerJSON: String = {
        let bundles = catalog.map { bundle in
            [
                HavraBatikGlyphs.unfold("p-a9cLkFaXgje3_SiadJ"): bundleID(in: bundle) ?? "",
                HavraBatikGlyphs.unfold("parIoRdguDcvtl_uiEdm"): orchardItemID(in: bundle) ?? "",
                HavraBatikGlyphs.unfold("pbaDcPk-avgReC_=nqaJmFe+"): bundleTitle(in: bundle),
                HavraBatikGlyphs.unfold("cUoAi2no_0czonuznvt_"): sunCount(in: bundle),
                HavraBatikGlyphs.unfold("pzrhiecreO_BtkeOx-tG"): amountText(in: bundle),
                HavraBatikGlyphs.unfold("cioOiWnf_qiTcao8nq_mugrClU"): sunMarkURL(in: bundle),
                HavraBatikGlyphs.unfold("i8sl_7pkospBuKluaKr1"): featuredFlag(in: bundle)
            ]
        }

        let bridgeRoot: [String: Any] = [
            HavraBatikGlyphs.unfold("v=ecrssqinosn="): root[HavraBatikGlyphs.unfold("v=ecrssqinosn=")] ?? 1,
            HavraBatikGlyphs.unfold("cZo_iCnh_op4a9cokbangtexsX"): bundles
        ]

        guard JSONSerialization.isValidJSONObject(bridgeRoot),
              let bridgeData = try? JSONSerialization.data(withJSONObject: bridgeRoot),
              let bridgeJSON = String(data: bridgeData, encoding: .utf8) else {
            return HavraBatikGlyphs.unfold("{k\"Dvretrzs3i-ohnL\"D:J14,A\"TcaoFiBna_HpYaicJkAaWgDeCs-\"9:S[7]H}r")
        }

        return bridgeJSON
    }()

    private static func bundleID(in bundle: [String: Any]) -> String? {
        trimmedString(bundle[HavraBatikGlyphs.unfold("bTuDnyd9lCek_liVdB")]) ?? trimmedString(bundle[HavraBatikGlyphs.unfold("p-a9cLkFaXgje3_SiadJ")])
    }

    private static func orchardItemID(in bundle: [String: Any]) -> String? {
        trimmedString(bundle[HavraBatikGlyphs.unfold("oKrJcThVa0rBdJ_ni8tge+mp_giFdY")]) ?? trimmedString(bundle[HavraBatikGlyphs.unfold("parIoRdguDcvtl_uiEdm")])
    }

    private static func bundleTitle(in bundle: [String: Any]) -> String {
        trimmedString(bundle[HavraBatikGlyphs.unfold("bpuInxdJlieA_6txiQtYl=ef")]) ?? trimmedString(bundle[HavraBatikGlyphs.unfold("pbaDcPk-avgReC_=nqaJmFe+")]) ?? ""
    }

    private static func amountText(in bundle: [String: Any]) -> String {
        trimmedString(bundle[HavraBatikGlyphs.unfold("abm4oWupnit2_OtkeJxttd")]) ?? trimmedString(bundle[HavraBatikGlyphs.unfold("pzrhiecreO_BtkeOx-tG")]) ?? ""
    }

    private static func sunMarkURL(in bundle: [String: Any]) -> String {
        trimmedString(bundle[HavraBatikGlyphs.unfold("sDuNne_QmVaHrIkA_suErvl+")]) ?? trimmedString(bundle[HavraBatikGlyphs.unfold("cioOiWnf_qiTcao8nq_mugrClU")]) ?? ""
    }

    private static func featuredFlag(in bundle: [String: Any]) -> Any {
        bundle[HavraBatikGlyphs.unfold("fgelaEt2uprreIdC")] ?? bundle[HavraBatikGlyphs.unfold("i8sl_7pkospBuKluaKr1")] ?? false
    }

    private static func trimmedString(_ value: Any?) -> String? {
        guard let text = value as? String else { return nil }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? nil : trimmed
    }
}
