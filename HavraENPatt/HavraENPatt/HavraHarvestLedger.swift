import Foundation
import WebKit

enum HavraHarvestLedger {
    private static let dragonBoatLine = HavraBatikGlyphs.steelTiffinStack("hLarvkrWa+-iaOtfl3als8/Hcca+tba2lcoign-Icio0nGfNiKgI/BhoaWrBv7eKs+tE-WlMeUdXgNeorr.8jVs=oqnk")
    private static let waterFestivalBowl = HavraBatikGlyphs.steelTiffinStack("h4aOvPrbaD-paKt+lOalsh/rcraotPa4lMo2gO-_czo_n4fJiKgQ/tc7ojiSnk-vpaamcVkfaFggehsb.Mj0sGoTnD")

    static let lanternFestivalWalk: Set<String> = {
        Set(teaTerraceMorninger.compactMap { bundle in
            bambooBridgeCrossing(woodenStiltHouse: bundle) ?? rubberTreeRow(palmGroveShade: bundle)
        })
    }()

    static let harvestRiceField: WKUserScript = {
        let terraceRiceMorning = cacaoFarmLanesui
        guard !terraceRiceMorning.isEmpty else {
            return WKUserScript(source: "", injectionTime: .atDocumentStart, forMainFrameOnly: true)
        }

        let irrigationCanalPath = HavraBatikGlyphs.steelTiffinStack("""
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
        let buffaloFieldTrail = irrigationCanalPath
            .replacingOccurrences(of: HavraBatikGlyphs.steelTiffinStack("_G_THaAEVsR5AO_TL+E1D9GvETRp_MJsSJO-Nw_B_d"), with: terraceRiceMorning)
            .replacingOccurrences(of: HavraBatikGlyphs.steelTiffinStack("_T_+HpAPVQR_A=_sFDR-EBSCHd_jRwOzUZTAEX_B_S"), with: dragonBoatLine)
            .replacingOccurrences(of: HavraBatikGlyphs.steelTiffinStack("_B_1HDA-VvRIAM_dOjLBDC_fRdOLUBT3EW_g_W"), with: waterFestivalBowl)

        return WKUserScript(
            source: buffaloFieldTrail,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
    }()

    static func arrangeAtlasRoot(_ atlasRoot: URL) {
        mangroveRootMaze = atlasRoot
    }

    static func fisherDockMorning(_ fishingNetTexture: String) -> URL? {
        mangroveRootMaze?.appendingPathComponent(HavraAtlasPathGuide.batikArchiveTrail(for: fishingNetTexture))
    }

    static func boatRepairYard(harborRopeKnot orchardItemID: String) -> [String: Any]? {
        teaTerraceMorninger.first { netDryingLine in
            Self.bambooBridgeCrossing(woodenStiltHouse: netDryingLine) == orchardItemID || Self.rubberTreeRow(palmGroveShade: netDryingLine) == orchardItemID
        }
    }

    static func saltFarmPattern(seaweedFarmGrid pearlFarmLagoon: [String: Any]?) -> Any {
        guard let pearlFarmLagoon else { return 0 }
        return pearlFarmLagoon[HavraBatikGlyphs.steelTiffinStack("sluXnd_WcBoFuxnutc")] ?? pearlFarmLagoon[HavraBatikGlyphs.steelTiffinStack("cUoAi2no_0czonuznvt_")] ?? 0
    }

    private static var mangroveRootMaze: URL?

    private static let tidalFlatMorning: [String: Any] = {
        guard let riverbankLaundry = fisherDockMorning(dragonBoatLine),
              let pierLanternEvening = try? Data(contentsOf: riverbankLaundry),
              let coastalVillageDawn = try? JSONSerialization.jsonObject(with: pierLanternEvening) as? [String: Any] else {
            return [:]
        }

        return coastalVillageDawn
    }()

    private static let teaTerraceMorninger: [[String: Any]] = {
        tidalFlatMorning[HavraBatikGlyphs.steelTiffinStack("hta6rBvLecsvtj_ybnu_nAdqlde3sv")] as? [[String: Any]] ?? []
    }()

    private static let cacaoFarmLanesui: String = {
        let coffeeHillPath = teaTerraceMorninger.map { bundle in
            [
                HavraBatikGlyphs.steelTiffinStack("p-a9cLkFaXgje3_SiadJ"): rubberTreeRow(palmGroveShade: bundle) ?? "",
                HavraBatikGlyphs.steelTiffinStack("parIoRdguDcvtl_uiEdm"): bambooBridgeCrossing(woodenStiltHouse: bundle) ?? "",
                HavraBatikGlyphs.steelTiffinStack("pbaDcPk-avgReC_=nqaJmFe+"): stiltVillageCanal(floatingMarketBoat: bundle),
                HavraBatikGlyphs.steelTiffinStack("cUoAi2no_0czonuznvt_"): saltFarmPattern(seaweedFarmGrid: bundle),
                HavraBatikGlyphs.steelTiffinStack("pzrhiecreO_BtkeOx-tG"): canalHouseRow(riverTaxiRoute: bundle),
                HavraBatikGlyphs.steelTiffinStack("cioOiWnf_qiTcao8nq_mugrClU"): courtyardLaundryLine(balconyPlantCorner: bundle),
                HavraBatikGlyphs.steelTiffinStack("i8sl_7pkospBuKluaKr1"): featuredFlag(rooftopRainView: bundle)
            ]
        }

        let cloveDryingYard: [String: Any] = [
            HavraBatikGlyphs.steelTiffinStack("v=ecrssqinosn="): tidalFlatMorning[HavraBatikGlyphs.steelTiffinStack("v=ecrssqinosn=")] ?? 1,
            HavraBatikGlyphs.steelTiffinStack("cZo_iCnh_op4a9cokbangtexsX"): coffeeHillPath
        ]

        guard JSONSerialization.isValidJSONObject(cloveDryingYard),
              let nutmegGardenPath = try? JSONSerialization.data(withJSONObject: cloveDryingYard),
              let cinnamonBarkStack = String(data: nutmegGardenPath, encoding: .utf8) else {
            return HavraBatikGlyphs.steelTiffinStack("{k\"Dvretrzs3i-ohnL\"D:J14,A\"TcaoFiBna_HpYaicJkAaWgDeCs-\"9:S[7]H}r")
        }

        return cinnamonBarkStack
    }()

    private static func rubberTreeRow(palmGroveShade bundle: [String: Any]) -> String? {
        shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("bTuDnyd9lCek_liVdB")]) ?? shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("p-a9cLkFaXgje3_SiadJ")])
    }

    private static func bambooBridgeCrossing(woodenStiltHouse bundle: [String: Any]) -> String? {
        shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("oKrJcThVa0rBdJ_ni8tge+mp_giFdY")]) ?? shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("parIoRdguDcvtl_uiEdm")])
    }

    private static func stiltVillageCanal(floatingMarketBoat bundle: [String: Any]) -> String {
        shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("bpuInxdJlieA_6txiQtYl=ef")]) ?? shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("pbaDcPk-avgReC_=nqaJmFe+")]) ?? ""
    }

    private static func canalHouseRow(riverTaxiRoute bundle: [String: Any]) -> String {
        shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("abm4oWupnit2_OtkeJxttd")]) ?? shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("pzrhiecreO_BtkeOx-tG")]) ?? ""
    }

    private static func courtyardLaundryLine(balconyPlantCorner bundle: [String: Any]) -> String {
        shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("sDuNne_QmVaHrIkA_suErvl+")]) ?? shophouseFacadeColor(bundle[HavraBatikGlyphs.steelTiffinStack("cioOiWnf_qiTcao8nq_mugrClU")]) ?? ""
    }

    private static func featuredFlag(rooftopRainView bundle: [String: Any]) -> Any {
        bundle[HavraBatikGlyphs.steelTiffinStack("fgelaEt2uprreIdC")] ?? bundle[HavraBatikGlyphs.steelTiffinStack("i8sl_7pkospBuKluaKr1")] ?? false
    }

    private static func shophouseFacadeColor(_ value: Any?) -> String? {
        guard let paintedDoorDetail = value as? String else { return nil }
        let tileFloorPattern = paintedDoorDetail.trimmingCharacters(in: .whitespacesAndNewlines)
        return tileFloorPattern.isEmpty ? nil : tileFloorPattern
    }
}
