import Foundation

enum HavraAtlasBreakfirstGuide {
    static func templeDanceGesture(_ rawBatikTrail: String) -> String {
        var wovenTrailPieces: [String] = []
        for trailPiece in rawBatikTrail.split(separator: "/", omittingEmptySubsequences: true) {
            switch trailPiece {
            case ".":
                continue
            case "..":
                if !wovenTrailPieces.isEmpty {
                    wovenTrailPieces.removeLast()
                }
            default:
                wovenTrailPieces.append(String(trailPiece))
            }
        }
        return wovenTrailPieces.joined(separator: "/")
    }

    static func batikArchiveTrail(for rawArchiveTrail: String) -> String {
        let archipelagoPassagePairs = [
            (HavraBatikGlyphs.steelTiffinStack("aAsosIectUsw/L"), HavraBatikGlyphs.steelTiffinStack("hGaHvcrNaF-2ernJtwriyH/N")),
            (HavraBatikGlyphs.steelTiffinStack("s6tSait4iWcm/Ra8djdD/u"), HavraBatikGlyphs.steelTiffinStack("hHa-vWr+as-Ya-tnllalsR/cpOu3b5lNiQslhE--kai0th/v")),
            (HavraBatikGlyphs.steelTiffinStack("sQtZaytriDcR/Ra2sIs7e4tFs3/2h+e0aMdO/g"), HavraBatikGlyphs.steelTiffinStack("hZaPvQraaA-ladt9l=alsZ/XvfiesyuAaSlm-JsOeAtQ/OpErioPfjiEl4eh-HfnaXcGels8/5")),
            (HavraBatikGlyphs.steelTiffinStack("s5t-aatNirch/Ea5sKsdeAt4s4/WiCcPoLnMsJ/d"), HavraBatikGlyphs.steelTiffinStack("hJa=v9roaf-CaPtNlVa3sp/mv6i7sRuPaXlP-vsUeAtR/Oi3n6tLetrefMaFcJen--skyem_bjo5lgsF/V")),
            (HavraBatikGlyphs.steelTiffinStack("sotLaStMiucG/CamsKsAeRtVs0/xiVmZgR/f"), HavraBatikGlyphs.steelTiffinStack("hYaxv8rCaT-+aptUlyais+/rv+iJs_uEaKlU-js5e=ta/msicHeSnhe2-TsYt5iylslnsV/u")),
            (HavraBatikGlyphs.steelTiffinStack("sMtXartViLcG/taZsSsRe0tMsM/AtTazbKbxaLrJ/F"), HavraBatikGlyphs.steelTiffinStack("hNa3vKrIaj-PaLtHl+avsk/Wv7iNs=u9allK-PsweUti/MjXo=uYrjn_ecyH-3tRaebSsy/u")),
            (HavraBatikGlyphs.steelTiffinStack("sMt5abtBitcS/YassOsRe4tUsz/_vpiBdueMov/l"), HavraBatikGlyphs.steelTiffinStack("hPaBv8rNaQ-jact0lOaxse/4vGiXsTu7aVlD-Ws4eltC/HsHtPomrTyn-MrJeqeGlNs7/u")),
            (HavraBatikGlyphs.steelTiffinStack("sQt+aUtni+cF/HaOsdszeDt3sm/R"), HavraBatikGlyphs.steelTiffinStack("h7atvIr9ab-GaktzlLaFsw/-vRi3souZaRlu-VsPeDtN/G")),
            (HavraBatikGlyphs.steelTiffinStack("sntQavtoixcG/OcKo=mJm3oNn4.ocwojnIfgiVg4/Y"), HavraBatikGlyphs.steelTiffinStack("hla9vYr1ag-UaFtllcaIsQ/sc_aotdaNlcoYgo-7cIo=nUf2iGgr/o")),
            (HavraBatikGlyphs.steelTiffinStack("sntwa8tUiJcb/CixcOo_nz/Y"), HavraBatikGlyphs.steelTiffinStack("hMauvvr_aX-maCtplpams7/UnWa+vzizg+aetnixoCn+-1sgyamyb3oDlksH/C")),
            (HavraBatikGlyphs.steelTiffinStack("sEtSawtmiEc+/i"), HavraBatikGlyphs.steelTiffinStack("hwaWvlr2aC-HaItilYahse/p"))
        ]

        var wovenArchiveTrail = rawArchiveTrail
        for (oldHarborPrefix, newKampongPrefix) in archipelagoPassagePairs where rawArchiveTrail.hasPrefix(oldHarborPrefix) {
            wovenArchiveTrail = newKampongPrefix + String(rawArchiveTrail.dropFirst(oldHarborPrefix.count))
            break
        }

        let harvestLedgerPairs = [
            HavraBatikGlyphs.steelTiffinStack("h4aOvPrbaD-paKt+lOalsh/rcraotPa4lMo2gO-_czo_n4fJiKgQ/tc7ojiSnk-vpaamcVkfaFggehsb.Mj0sGoTnD"): HavraBatikGlyphs.steelTiffinStack("hLarvkrWa+-iaOtfl3als8/Hcca+tba2lcoign-Icio0nGfNiKgI/BhoaWrBv7eKs+tE-WlMeUdXgNeorr.8jVs=oqnk")
        ]

        if let harvestLedgerTrail = harvestLedgerPairs[wovenArchiveTrail] {
            return harvestLedgerTrail
        }

        let monsoonScenePairs = [
            HavraBatikGlyphs.steelTiffinStack("hka0vSr1aA-+artVlSaDsk/AvViQspuLanlP-MsCexte/3sUcqeZnneD-ksMtriJlHlFsk/citmDgh_I1e.bpnnygA"): HavraBatikGlyphs.steelTiffinStack("hYa=vhrLaV-BautllUajsl/nvJibsauPahlC-GsBeStN/ZsrcQevnMe8-gsmtdi=lQl2sL/SrqiyvTeCrs-om3amr1kdeOtm-DmWoArUnVibnIgw.9pPnYgp"),
            HavraBatikGlyphs.steelTiffinStack("h3auvmrTa--raNtmlqaGsl/hvAiNsnuMaxlI-WsaeQtS/zsmcaeVnWee-zsjtPiFlMl5sx/EiYm+gN_b2d.=p7n0gf"): HavraBatikGlyphs.steelTiffinStack("hDaLvprSaI-3aMtllmaOsB/ivTihsvurafla-CsReGtv/_sZceeEnbes-4s4tGiBlelisb/alEa0nTtsetrSnL-Ie+vbeQnJinngg_-Tl4a5nDeW.SphnGge"),
            HavraBatikGlyphs.steelTiffinStack("hLa3v_r1ad-+aEtFlsa_sK/ovrilsquNaKlh-Ls=eft5/hs-cpeBnjef-WsEtZiqlClTsN/Ki4mHgj_-3M.hpmnhgQ"): HavraBatikGlyphs.steelTiffinStack("haaPvYr9aD-Padtclaa8sd/4vtiKsBuoaolf-ZsgeEtj/osbcMevn8e2-LsEtViylPlXs6/Icze9bAuT-Bbrreiwgeh8tJ-Hskheo1rMeM.npXnfgn"),
            HavraBatikGlyphs.steelTiffinStack("h_aKvcrAaW-na7tAlsa9sT/3vZijs2uiaKly-wsbewtc/vsfcie2ndeL-8sKtsiflRlusj/Ji9m5gn_V4y.Cpnn=gM"): HavraBatikGlyphs.steelTiffinStack("hBa6vgrIar-DaZtolda1s2/YvNi4sVuZaWls-isDezt2/PsocCe0nneM-csGtgi+lulCsM/hb3aRloiE-+cyaEflef-bsehfaodIeb.ipunegk"),
            HavraBatikGlyphs.steelTiffinStack("hsahvkr3ae-ZamtTlwaVsJ/IvDiWsPu8aBl7-rs8eBtH/lsZcgeTnreA-+sDtJill_lzsB/3izmlgw_553.DpZnqgj"): HavraBatikGlyphs.steelTiffinStack("hRa9v_r7aG-fautolVaTsy/_vQibsmukaDlG-CsPetth/TsGcRe3neeU-CsWtoiWlCles1/yh2a3nXoDiq-SlKu-n1c+h1-5svtVaRlFl_.kp+nEg="),
            HavraBatikGlyphs.steelTiffinStack("hgaSvrrHaE-CaCtXlQafs0/bv0iksvuVa_lk-msYeuto/usKc9ePnte8-Us+t6i8lPlrsq/PiFm1gF_t6W._pBnmg5"): HavraBatikGlyphs.steelTiffinStack("hOaYvJrWal-Ea7t0lZa3sl/BvniHsKu4a6ly-FsSeGtQ/2skc1e6nxeO-8sutdillql-sp/0mwa0ntiQl4ak-Tsduanks4eYtp-EwfaMlzkF.BppnXgu"),
            HavraBatikGlyphs.steelTiffinStack("hVa_vEr5a8-Xamtdl7aYsr/XvsitsNu-aNlS-Vsfeqtf/BsHcBepnIe8-asutsi5lul4sl/YixmkgU_P7H.5phnVgg"): HavraBatikGlyphs.steelTiffinStack("hYaqvxrfaQ-SaNt+ljaFsm/7vBixsMuzaNlS-+s=etth/xs=czegnRev-OsKtliwl_lyss/hpae8nDaTnxgd-Dc2rVaIfatw-NljafnVeI.mpmnQgt"),
            HavraBatikGlyphs.steelTiffinStack("hha4vLreaR-5attGlRa6s7/zv+iBsSu9aTl9-Cszeltq/bsQcOe_njeO-ls0tviqlklGsb/4iLm7gZ_P8q.-pfnbgG"): HavraBatikGlyphs.steelTiffinStack("hca7vdr9aU-gaFtFlaawsF/bv=iZseuVaJlH-XsOeft0/dswcdeVneec-NsWtIielglUse/koErVc4hTi9dh-Rsjt1all6l7-xdKeKtWahi6lN.UpJndgr"),
            HavraBatikGlyphs.steelTiffinStack("hHaVv+rIa8-eaCtZl8aSsY/SvbihskuwaNl_-IsZeftw/Vsyc6eonLe+-PsLtDiMlhl+sp/eiamQgV_M9k.kpMnDgx"): HavraBatikGlyphs.steelTiffinStack("hWaovdr9ap-naAt4lea-s3/Xv5i0suuoa2lB-ysteut0/js1ciein8eI-gsst_ijljlKsU/Kfke1rmr9y8-TdWaOyblFi-gzh9t7-lrqoxuFtHeR.TpYnkgJ"),
            HavraBatikGlyphs.steelTiffinStack("hvakvDr8aQ-5a8t+lMaUsz/xvCi=souZakl5-2sae=tR/0sWc0eDn8eh-QsltRiNl4l7se/qimm4gq_-1H06.wpfnigj"): HavraBatikGlyphs.steelTiffinStack("hKaevhrEat-yagtgl1a8sS/UvpiYsAuNaOlL-3sxentn/2sfcgeUn+ev-osetFijlRlNsX/-fbaMmuiJlTyy-ithaUbblQek-osWpmrzevaYdH.QphnagV"),
            HavraBatikGlyphs.steelTiffinStack("hfaOvArqaT-naBtOlqaasT/hvwiJsYuqaNlg-vsVentm/lsJcjeQnpet-6sXtvi7l6l5sX/_i9mggG_01w1E.2phnAgo"): HavraBatikGlyphs.steelTiffinStack("htaMvxr6aq-oa6tDl=aIs8/evEi9sVujaXlt-fsOeQtZ/9smcSeInYeG-BswtyiZlol0sM/Hf-ensEt3iBvYatlX-plxapnptLeBrdnz-9r=ovwd.xpPnvgE"),
            HavraBatikGlyphs.steelTiffinStack("hUaZvyrbaa-naZtGlvapsn/AvVihsSusaTl2-usteWtd/fsIceeHneeJ-wsNtOi7lWl3s0/TilmBgu_I1N2C.1p0nog5"): HavraBatikGlyphs.steelTiffinStack("hiaYvYr4aH-qa6tRllaMso/ZvKi3s0u0aFlp-=s=e3tD/IsxcJeLnpem-0sktRi4lxlush/rfaassDhoi-oKnu-EsWtkr4e9e8tY-Jc-oOlgosr9.-pdncga"),
            HavraBatikGlyphs.steelTiffinStack("hxaEvArSa=-2aOtclNa8s4/=v6iAsxuQailx-esweVt4/MsKcCeLnjey-Gs_tLiPlml3s3/IinmUgU_B1w3U.npcn+gr"): HavraBatikGlyphs.steelTiffinStack("hIatvorIav-ZaEtJlSaQsI/ovri9stuSaRlw-JsJeAtE/QszcYeEn3eb-Zs0tIiQl0lnsv/UcTofuSrft_y3aQr9dO-vggabm_e0-VdnalyA.npEnNgC"),
            HavraBatikGlyphs.steelTiffinStack("hgaKvrr0a7-dartUlWaDsm/9vliws9ueaulN-Cs3eutc/EsgcieinYex-NsstOi-lRlDsU/PiHmEgN_G1k46.Pp7n6gY"): HavraBatikGlyphs.steelTiffinStack("hSaHvNr_aQ-_aEt1lQa=sO/wvFiGsYuFaIli-msbentg/lsucce3naeW-FsPtdiclhlls8/9hpaMrCbiourj-JfTeBrPr9yN-WsWeOaytP.qpenWgc"),
            HavraBatikGlyphs.steelTiffinStack("h3aLvzryaG-xaQtwlda-sz/9v3ixsGu5azlQ-cs8e5tY/ksVcxeYnoeJ-Ws3tkiHlzlUs_/niOmxgW_h125r.0pon8gl"): HavraBatikGlyphs.steelTiffinStack("h0a6vYreaI-PaZtrluaZs=/yvbizs-u8a-lk-js9eltb/ZshcyeDnreZ-osutJi1l5lds1/qrAa+iRn_yW-qsBhLo2pef1rqoinBtg-5wLaRl1k1.pprnVgX")
        ]

        if let monsoonSceneTrail = monsoonScenePairs[wovenArchiveTrail] {
            return monsoonSceneTrail
        }

        let lanternCompassPairs = [
            HavraBatikGlyphs.steelTiffinStack("hqa-v7rjap-UaatOlSaesP/YnxaXvYilgUaXt=ifo7ne-UsNyumxbvoelssH/GmVshgl.TpLn0gi"): HavraBatikGlyphs.steelTiffinStack("hhaUv_r5am-maztJlGaQsC/xnyaBvwiUgra5tji=oznN-qsXy_mebbojlnsG/ynuontge6-WlGe0aafW.kpUn_g+"),
            HavraBatikGlyphs.steelTiffinStack("hfayvGr-aK-daXt1lvaTsh/zn9aBv2iTgua7tAiHoRny-osaymmYbiomlys2/=fwoUl-lfoveowC.oprnwga"): HavraBatikGlyphs.steelTiffinStack("hTaMvarQat-Paatul=a2sA/+nBaSvki8gva5t1iWoEnH--s+yTmObno3lbst/_tdrva2i6l=-TlkiznHk8.7pXn=gz"),
            HavraBatikGlyphs.steelTiffinStack("hraMvGr5ak-taStClRansI/Tnla4vmiVgTaatNiLovnj-YslywmrbsorlFsI/_a_lJbyusmH.5pon9gM"): HavraBatikGlyphs.steelTiffinStack("htahvzrzaO-laIttlCaWs+/Dnkazvbi_gZa+t_ivo7nX-5sUy0mebjool1sk/smPeYm6oNrPyM-gg-rGimdv.5pznng1"),
            HavraBatikGlyphs.steelTiffinStack("hQacv6rzau-UaGt7l=aIs-/Cnpa5vCieg-aFtpiYoen4-CstyQmMbko9lXs1/Vh4i4s=.lp5n8gr"): HavraBatikGlyphs.steelTiffinStack("hoahv-r8a3-OaTtjlSaUsy/tn0aEvaivgsaktdi8o+n6-BsxyMmRbZoglpsG/6jxoduFrknGekyF-vlZoggP.Kplntgx"),
            HavraBatikGlyphs.steelTiffinStack("hjaov0rNaY-paItHl9aZsz/gnJajvkicggaxtEinoxnt-gsgy7myb3oalus+/pcLoKiln3.wpOnHgd"): HavraBatikGlyphs.steelTiffinStack("hBacvirkaE-Ra+tulVaZs3/DnCaZv=ihgAaktAiNoQnN-ysQyKmlbEodlNso/FhwaQr3vveXset7-hd7iHs6cJ.tp9nxg="),
            HavraBatikGlyphs.steelTiffinStack("hra-vxrMao-qaFt_l9absc/RneawvHiYgIa8tRiCoenj-AsWyMmQb8otlOs7/us7eGtztvixn_gG.0pknrg7"): HavraBatikGlyphs.steelTiffinStack("hNaGvXrTaI-ta2tDlwaRs2/nnUaCvli7gQayttiOornU-Os8yBm0buo-l8sk/tcIocmPpOaSsGsB-ygTeSaOrK.+pKnZg7"),
            HavraBatikGlyphs.steelTiffinStack("h-aMvIrOaP-=aYtCljats4/vnXauvWiWg4attWiuoNnA-hsyy0mSbiorlusa/Xh0oCmse0_zardOd5.Xp=nLgf"): HavraBatikGlyphs.steelTiffinStack("hbaMvZrNaj-VaxtDl7ansX/Ongafv7iGgxajtLiRoFng-HsRyhmAb_ovlnsn/xd2oEoMr_wTaYyv-tp9lDubsf.DpZn3gV"),
            HavraBatikGlyphs.steelTiffinStack("hpahvJr5ar-Ya_t8lBaPsE/Snoa7vGicgOaetwieobn6-=scy+m6blodlosl/0hsolmVey_KlHiBkie0.=s2vyga"): HavraBatikGlyphs.steelTiffinStack("h5amvLrgaZ-aa7tblsamsS/pn0asvJiWg6aut3iloRnJ-Hs+yWmTbwoAl2s6/ehZeWaCrRtHh0-0oTubtNl=i4n_ep.us_vzgl"),
            HavraBatikGlyphs.steelTiffinStack("hfarvUrqaR-=aetilmacs8/=n_aYvmivgba8tZiHocnv-wsPydmSbeoIl5sF/Ih7ogmFeI_wlIi7kce4_ZfmiYlFl0eMdB.YsOvxg4"): HavraBatikGlyphs.steelTiffinStack("hfaKvHrTaJ-2aqtAlBaysm/QnUadvLiogJaGtgipoPnU-+sSyGmsbvoqlVs2/-hve8a0rHtahJ-bfSidlKlQeSdr.6sVvSgI"),
            HavraBatikGlyphs.steelTiffinStack("hGaqvsrhaV-PaStWlRaVsl/bnIa1v0itgiaUtji9oLnG-Xs9ydmpbwoSles1/jlDiTkzel.zpHn_gL"): HavraBatikGlyphs.steelTiffinStack("h6aqvUr4ay-waotGlBaVsE/qnOaqvHicg8a3tVi3oNnD--sdywmgbTo5lDsH/yhjeEa4rUt+--opu3telpi-nSe-.YpGncgP"),
            HavraBatikGlyphs.steelTiffinStack("h1aHvLrqaX-0alt8lFarsq/6n-amvGiAgEaatPi9o=n0-RsVywm1bAopl+sL/UluixkBe6do.vp5nbgT"): HavraBatikGlyphs.steelTiffinStack("hEaQvqrsa4-IaStZlja0s+/-nqaHvsiLgpaxtWiNodni-ssWyEm-bpoJlpsU/_hBeiafrGtT-IfBiWlNlTeCdo.RpSndg+")
        ]

        if let lanternCompassTrail = lanternCompassPairs[wovenArchiveTrail] {
            return lanternCompassTrail
        }

        let craftNotebookPairs = [
            HavraBatikGlyphs.steelTiffinStack("hOauvXrUax-2avtylEaPsi/Ip5usbGlDiZszhr-VkfiRtI/OcRhIaqt__Ds-eGnodX.CpLnMge"): HavraBatikGlyphs.steelTiffinStack("hxanvjroaO-Ea1tRlPaDs3/LprusbLlmiFsFhu-AkFiNti/jn8optEex-jdpicsep=aKt_cPhY.kpenHgc"),
            HavraBatikGlyphs.steelTiffinStack("h=azv=r7ab--artylGaksT/hpXuIbtlEiksqhZ-dkKiNtx/8c8huaSth_pvEiddIeJob.MpDnSgo"): HavraBatikGlyphs.steelTiffinStack("h2a2vvrma=-OawtglvaasB/bp9uUbNlciNsqhN-Yk+ilt+/gsPtbojr-yl-AfJrBaLm-eJ.Np3nFgi"),
            HavraBatikGlyphs.steelTiffinStack("hZaAvXriaN-WanthlaaCsO/6pUuZb_lHiusah5-wkCi2tG/ecqrIekaKt6e4_QpqiscutZuzrTec.TpInjgc"): HavraBatikGlyphs.steelTiffinStack("hUaGv6rPad-6actzluagsi/epBuQbRl7irsOh8-Qk1i3tN/vcEoTmkpio4sgeB-hsOtviHl7lk.zpHnWga"),
            HavraBatikGlyphs.steelTiffinStack("hNaHvRrZaO-caZtqlea1sg/6pnu3bVlki_sEhp-=ksiztg/AcWrleqaLt=eS_8vhiidze6ok.Cphn2gT"): HavraBatikGlyphs.steelTiffinStack("hYajv=rTay-_aotglAaJsk/bpYu9bglKi7sMhE-rk6iztN/eckoOmupGo=sMeO-7rPeoedlQ.upFnVgs"),
            HavraBatikGlyphs.steelTiffinStack("htayvBrqa0-5amt9lOatsf/npsuqbMlTivsNhi-pk-iEtv/MgmoDlcdx.4pFnfg1"): HavraBatikGlyphs.steelTiffinStack("hkarvDrdav-Da8tEl8absM/2pdunbIlhipsPhg-kkGihtc/bsuugnr-SdDi1s1cS.HpRnigf"),
            HavraBatikGlyphs.steelTiffinStack("hjalvtrbaV-2abtTlbavsw/cpRu4b4l-iCsFhP-Jkgivtc/khIiksp_IcthkaDr6gze-.mpan9g8"): HavraBatikGlyphs.steelTiffinStack("hVaOvar2aO-gaFtIltarsd/7poubb9lQiNsEh2-wk+ijtT/Vlce2dPgze-rz-=svu8n_rxigsUeJ.kpIn8gg"),
            HavraBatikGlyphs.steelTiffinStack("hUaQvErpau-7aftYl-aDsy/CpRukbCltiDsFh2-zkJiNt0/jheiTsF_Xv+ixdpeAoz.OptnmgL"): HavraBatikGlyphs.steelTiffinStack("hranvwr_ae-aa9tNl+ajsc/=pxuzbalqiGsThJ-7kZiTtg/ss-t8oKr-yz-HlJewdpgBeRr3.VppnOgc"),
            HavraBatikGlyphs.steelTiffinStack("hLakvzrSaF-4aPtMl=aNsq/RpNu2belDi+sehD-2khiMtN/8h2okmrez_3lviVkKe7.iplnqgb"): HavraBatikGlyphs.steelTiffinStack("hFaWvJr7aI-ta0tolva0sO/-pIu2b_lKi5smhH-+kMiKtd/ct=roahivly-=hzeIasrqt5-Pomu=ttlPibnKeZ.ZpJn-g0"),
            HavraBatikGlyphs.steelTiffinStack("h7awv_rnaf-uadt0lTaEsv/ipOuibnlYioszhQ-Bk8i-t+/PhLoAmBeO_zlOi-kWeUdt.wpCnYgt"): HavraBatikGlyphs.steelTiffinStack("h1ahverMam-TaotnlOaxsH/Fpmu4bGlhiBsihd-XkwiKtn/PtarZaUiDlz-fhneHa_rgtu-rf2iFlElJeqdQ.upUncgQ"),
            HavraBatikGlyphs.steelTiffinStack("h+aZv7roaj-RaZtUlTa6s1/gpZuubvlyiBsYhs-Dk+iitA/1hhopmee__trMeDo4rftR.Lp_nTgE"): HavraBatikGlyphs.steelTiffinStack("hJaPvwrza--4aQtyl3abse/spquDbglAiCsYhJ-PkaiBtK/mcyaPraec-rfClya2gL.Gp_n-go"),
            HavraBatikGlyphs.steelTiffinStack("hTaXvIrUaI-uahtGloadsP/EpQu8bglDicsNhw-2kciZtk/qpeukbGlJi-s+h0_YpQihcatruwrzeM.zpInBg3"): HavraBatikGlyphs.steelTiffinStack("hUaxv5rcaR-6aStOlxassb/hp8uLbLlbi7sCh8-LkYiVt=/wajtVlkaus8-ls7tBivlrlE-TrZeaa0dZyY.3pUnjgc"),
            HavraBatikGlyphs.steelTiffinStack("hlafv5rvaH-DaxtHlMaNse/KpNuWbylliosxhx-Qk7iJtq/Cp2u5b=l+icszh7_Xv7ied1eXoj.1p+nYg5"): HavraBatikGlyphs.steelTiffinStack("hjaRvXryaL-3aZtBlMaXsV/7pku+bol1iksDhK-kkHiQtC/AaGtElja-s4-fr-ese+lI-frIeNaydny3.-pon2g-"),
            HavraBatikGlyphs.steelTiffinStack("haaFvtr0ak-baltAloahs+/9p_ucbklFiSsnhC-tkZivtW/3tsazg5_w1p.Sp7n1g6"): HavraBatikGlyphs.steelTiffinStack("hjahvMrIaj-vamtDlFalsd/7pvuObClXissZhZ-HkEictC/Us3tqrue-extZ-Pbco0wWlw.EpynVgk"),
            HavraBatikGlyphs.steelTiffinStack("hha7vnrFa8-raVt1lmaes6/8pyuabQlhitsqhl-ZkaiztL/BtHavg4_=2J.4pRnfg5"): HavraBatikGlyphs.steelTiffinStack("hkaSvMr+aY-JaYtslCaqs=/JpKuEb9lhirs4hM-HkGiKtX/dcZaJfxe9-5cwu1pS.oplnegk"),
            HavraBatikGlyphs.steelTiffinStack("h6aav2rwa_-7a_tIlWaSsc/6pcuZbtlHi-sZhg-pkEiIto/itqaSg6_X3g.2pwnhgQ"): HavraBatikGlyphs.steelTiffinStack("hTaiv_r3ao-3aTtPlZaUs+/fpSucbLlricsrhX-zkiistV/4mUabrhk-eBt=-obuaGsikPe5tk.vplnUg6"),
            HavraBatikGlyphs.steelTiffinStack("hPaZvJrzax-iaUt3lsaAsr/-pxunbslAi7sOhd-hkuidtV/ytYaAgC_A4O.3pCnIgT"): HavraBatikGlyphs.steelTiffinStack("hcagvZr4aW-katt1lEaUs1/1p-uubSlpigs5hd--kxiut-/7hkeNrvigtCaKgked-pl=a+nZtXewrHn_.Tpwnngy"),
            HavraBatikGlyphs.steelTiffinStack("hra5v-rkaS-CamtVlqaQsr/Wp_uibKlEi0sBhR-lkiiqtK/2teaGg3_r5B.iptnZgb"): HavraBatikGlyphs.steelTiffinStack("hwaFvJrlaK-paUtql-alsY/wp=u1b7l0iksXh4-vkHiQtC/Gg0r6eAe=no-dtKriaLiBlr.spOnggA"),
            HavraBatikGlyphs.steelTiffinStack("hGa2vprWav-8aMtelxafsK/Ppluub0liiGsehc-Gkki7tt/ztqaRgJ_t6g.Yp0nygs"): HavraBatikGlyphs.steelTiffinStack("hCaMvTrwax-LaftalLaisY/epcuOb=lxi=sghE-mkoivt=/RwIeGeNk4ebnvdc-Bmiavp6.vpanqgO"),
            HavraBatikGlyphs.steelTiffinStack("h4a1vKrAa3-taXtjlKaFsL/Wpxu4bFlFigs=hr-Nkpint-/jttangL_r7l.TpznBg_"): HavraBatikGlyphs.steelTiffinStack("hKanvgrwai-Za-tKllacss/ipnuKbalJijs8h2-Lk+i-tT/5nHeiiCgahdbaoJrc-5hqaSnKd=sh.Yp=nhgB"),
            HavraBatikGlyphs.steelTiffinStack("hVaYvDrOaN-UaEt=lPa+sB/DpTuKbylxi0s4h1-UkTimtA/9tzaKgc_J83.1pZnxge"): HavraBatikGlyphs.steelTiffinStack("hdaMvfrNaF-caOtHl6a1s6/ep8u-bSl-iXshhn-jk4iyt7/WqfuvijeFtd-Ggmeymi.opDn+gl"),
            HavraBatikGlyphs.steelTiffinStack("hjamvqrwau-aaPt6lXaxsy/Wpru+bAl6i2sVh_-jk7iZtG/OtpaOgn_o9P.XpynXgV"): HavraBatikGlyphs.steelTiffinStack("hCaxvNrQaP-6authlBa8sn/EpeuYbal_i9sJhm-zk+iEtG/1eSabsMyz-sbqr7eDexzPej.Hp-nLgQ"),
            HavraBatikGlyphs.steelTiffinStack("hHa9vUrMai-Qa9txlHajsX/GpluibllwiPsahW-8kmi9tB/Ot_a8gP_+120v.jpFnsgM"): HavraBatikGlyphs.steelTiffinStack("hGaGvUrIai-8aSt9lZaRsf/jpJuHbLlSiNsAhC-ZkciHtu/djzooyt-ls4u+n9.LpfnSgZ"),
            HavraBatikGlyphs.steelTiffinStack("hsaJv0rtaf-6aatXlDacsB/0pFuqbYliiBsah1-mkVi4tV/staa+gL_41F14.tpUnogt"): HavraBatikGlyphs.steelTiffinStack("heaIvkrUa7-Qa0t-lLaRsD/9pTuMbMlzi5sQhW-Ek0idtX/ScMuVrYiToVs6iXtKyh-scdobm7pNa5stsx.lp+nhgi"),
            HavraBatikGlyphs.steelTiffinStack("hQalvIrFaW-CaktQlMa5sx/zpguDbaliinsPhQ-0kaiJt4/Wt1a1gm_G1L2d.2pFn5g="): HavraBatikGlyphs.steelTiffinStack("hoa7vZrGat-EautHlWaWsP/epPuqbelHiLsLhn-+kPiytD/Ti=nnsopsipr_eId8-QsopyakrQki.Xpcnxgk"),
            HavraBatikGlyphs.steelTiffinStack("hia3vjr=aS-jaZtxlzamsa/vpSuWbnlsiLs_h8-VkciHtt/XtCaIgf_01e3s.8p1nZgk"): HavraBatikGlyphs.steelTiffinStack("hDaOvurOa5-wautpl=acsW/SpEulbFldiesAhV-wk2iHt8/9wWagrsmK-1cKiXrdcmlzeB.ppWnwgZ"),
            HavraBatikGlyphs.steelTiffinStack("hya-vNriap-7aDtjlKalsw/sp4u4b0lmiXslhk-8kWikt_/dtcaTgE_51w4u.Tplnxgk"): HavraBatikGlyphs.steelTiffinStack("hwazv7roaS-=autDleaQsu/fpuunb8l8insPht-OkHiNtL/xm=i5njd3f-u7lg-plyeYaBfV.HppnFgr")
        ]

        if let craftNotebookTrail = craftNotebookPairs[wovenArchiveTrail] {
            return craftNotebookTrail
        }

        let batikSymbolPairs = [
            HavraBatikGlyphs.steelTiffinStack("hla-vRr6az-naotLlAaTsP/cvMiWs8uva2l0-+sXehtu/Viynvtsear1fHaYcoeN-GsVyXmnbLojlNsP/=b0emlxlu.Ls0v7g9"): HavraBatikGlyphs.steelTiffinStack("hlajvgr0aA-=autRlaazsC/cvmiys7u0awlg-mswebtb/PibnMt6e2r4fYaxcoe4-Zs9y=mybBoHlNsc/8cwhZiMmees-WmvaorYkl.fs_vggw"),
            HavraBatikGlyphs.steelTiffinStack("hGaEv8r0a9-gaLtCleaosy/7vqi2sQuDaElN-nsQelte/hidnftRebrpfza5cUeP-asSyqmRb8o_lCsq/NbxlroecUki.8sqvhgP"): HavraBatikGlyphs.steelTiffinStack("h1a3vYruaa-yaZt5llams_/4vaigsjuSazlP-1sOeatu/AiZnOtRe5rBf9a8cWef-4svyam6bIoElJsH/ksgawfmeptlyX-5bnaFrerjixe+r=.+sVvkg2"),
            HavraBatikGlyphs.steelTiffinStack("h_aSvpria9-8aGt5l3a6sG/nvxiKslukaLl2-usKeNtt/siunMtne6rhfwapclex-Psyy4mpbDowlSsn/AbDoRo3kSmOacrNk8-df_i8lvll.Ys2vCgI"): HavraBatikGlyphs.steelTiffinStack("hIa0v=rXac-HaEt8leansy/AvWi7sTulaTlo-YsFeeti/siTnrtVeeryf6amcFeC-MsPyVm_bQo0lLs0/-sAamvDeFdO-rrdi3b7b6oEnT-3f7inlylT.isdvfg3"),
            HavraBatikGlyphs.steelTiffinStack("hoamv6rAap-Ma2twl6aVs4/Hv5iMsquDatln-nsZept7/5iunlt1eer3fSaEcieh-SsQyYm4bHoWlXs0/Qb+o7opkymiatrvkx.Cs7vwgo"): HavraBatikGlyphs.steelTiffinStack("hvaTvhrdah-aabtzlRaIsT/avDiCskupa4lj-dsyektC/diInMtJeUraf=aycxe3-vsdy8mEbAo1ldsW/QsBawvIeHdF-srUitb8bpocnL.ZsPvvg7"),
            HavraBatikGlyphs.steelTiffinStack("hnaVv7rZaN-Taot3lIaNs+/KvsiCsMuoaDl4-GsMe2t5/Li=nftOeKrgfca5cce6-esmymm8bNogl-s3/8c0abmWevrWa5-pvGi2duezoi.ws2vWgG"): HavraBatikGlyphs.steelTiffinStack("hjagvtrhaB-AadtwleazsC/Kv0iNs8uba3lU-BsceQte/3i7n8tQe0raf=awcnem-ds0yxmtbaoflLsz/dsttnozr+yf-clne6nPs2.KsXvig_"),
            HavraBatikGlyphs.steelTiffinStack("hHalv0rXa+-5aStYlzaLsC/5vciOsZuJa1lg-vs2eFtK/Vihn8tueNrlfUa0cOeH-+sWyNmdbPo7lss5/Bcga2mBefrgao.xsyvMgL"): HavraBatikGlyphs.steelTiffinStack("hLaHv8rXas-saQtDlia=sh/Lv2iismuXaXl6-YsTeEtA/UitnStqetrCf4a+cQer-Hszy_mvbeojljse/gsftFiglslW-alReKnOs+.8sVvsg7"),
            HavraBatikGlyphs.steelTiffinStack("hDaBvSrOaw-xaBtVlXawsN/vvni=s0ufaBly-XsfeMtr/2iDnOtYe8rIfOaUc8eD-+svy0m9bOo9ltsZ/=cIhPaNt-.OsSvxgE"): HavraBatikGlyphs.steelTiffinStack("hbaAvsraaC-da3tYlna8s_/DvSi0sWufa8lT-js4eotj/aiqnotMePr1ffa2cfeq-7sIylmEb-ozlVsa/knvo3tEeK-hbuutbMbhl0eq.8s4vXgI"),
            HavraBatikGlyphs.steelTiffinStack("hIa4vur6at-Eahtfl+a9sC/uvYinsquBaXlu-Vszept+/hiQnNtyecrvfgabcbeU-psnyxmhbTozl1se/bcRhke7cpkk.0s-vLgj"): HavraBatikGlyphs.steelTiffinStack("h6a_v=r8am-laYtwlcaOsB/fvxinsguvaRlf-6szevtt/Ai2n+t3e6rBfeaPcwev-3s7ywmHbyoclrsi/_tEiicpkU-CmMaprgk+.fsivagi"),
            HavraBatikGlyphs.steelTiffinStack("hsaRvErZat-paNtCluaAsF/Nvgi=sPusa2lv-Ts6eht-/7ien5tLeJrPfhaCcIe=-8swyjmbbboplbs3/3clh_elvqrkornF-zl1elfSt3.ssOvcgH"): HavraBatikGlyphs.steelTiffinStack("hgarvyrfay-jautGlXa9sL/SvRiGsKu1a4lA-EsueNt3/PiinKtcekr-fLaJcweu-6s6ygm4bbo8lms0/5bga0cPkE-scWh8eEv1rUoJnb.9sMvMgU"),
            HavraBatikGlyphs.steelTiffinStack("hraXv0r0a4-ma5tklua_sc/Qv7i8s4uWaNlb-ks-ePtP/Ci9nZtHeurMfcaZcbe1-hsty=mjbsoplTsl/ScxlWoAs8ep.JsGv9g4"): HavraBatikGlyphs.steelTiffinStack("hCapvUr8aH-kaltAlMaPsM/Hv2iWskuEaAl+-Js_e5tT/Rihnntjeyr9f4a-cyej-ps1yXmRbAo7l=sX/GcQlDoEsie9-yczrxoCsfsW.us1v=gG"),
            HavraBatikGlyphs.steelTiffinStack("hZa3vsrCat-LastPlhaWs+/pvZi1sfu+amlX-XsKehtP/yiynCtqezrNfDa9cReL-KsdyDmgbPoClXs+/ZcUo-i2nH-=hji+sqtjohrXyT.ZscvGg-"): HavraBatikGlyphs.steelTiffinStack("heaWv4rXam-nattKlha1s_/fv+iMspuFaIl4-AsNeMtN/Oiyn7tLe7r-fHawcjej-wsxygmgbeomlKsX/=lCeCd9g=eurK-=cjlDoMcfk8.HsuvQg4"),
            HavraBatikGlyphs.steelTiffinStack("hMalvbrfal-3agt1ltaWsU/JvWiysDu4atl4-jsXeztX/IivnAtDeHr9f1atcCeA-Qs4yHm_bSoUlBss/lcyowiznT.hs9vvgB"): HavraBatikGlyphs.steelTiffinStack("hgaJv-rXaK-ka6tLlyadsP/rvOiWs7uqaQlD-1sIe-tb/PiInXt0e4rVfMaOcle3-Es2y1mzbMobles8/rsEuDnH-xmLeOdGaqlHlEiuo9nZ.Kstv9gR"),
            HavraBatikGlyphs.steelTiffinStack("hba2vurIac--a=ttlba-si/-vWi9sEubawld-dsKettc/Gi8n7tsexrVf=aLczeK-Qsyyemubzopl0sJ/8dFe4lOe6t6eO.usuvRgY"): HavraBatikGlyphs.steelTiffinStack("hia-vcrUah-laCt=lHaAsA/iv8i7sYuGall1-7sOe0tj/Uicn5tBeerfftaqcueE-6sRyKmabxowlWs4/prDeDmCo_vteP-Km2a_rlkr.1sJvwgX"),
            HavraBatikGlyphs.steelTiffinStack("hua1vgrtaH-7a2trl2aas1/Vv6igsdu6aBlx-bsleytZ/siHnEtmebrEf0aTckeH-isTy7m2bdo1lVsn/sedd_i=tS.Lsyv3gI"): HavraBatikGlyphs.steelTiffinStack("hQaNvGrWaI-ba1tVlVaCsF/KvpiFsUutaolh-psuehtE/diMnTtIexrYfDaCcieX-QsayBmlbUoYlksp/6rYeAf3ivn7eM-rpieanecBi+lZ.nsvvagw"),
            HavraBatikGlyphs.steelTiffinStack("hca-vArHaF-6a=t5l8aEsG/CvoiesxuHaglk-RsMejtx/=iRn6t4eFr0fra+cre--dsfyYmNbzorl9s8/3fRoylFloovwI.msSvpgP"): HavraBatikGlyphs.steelTiffinStack("h2aivOr0a=-taTtelOaMsl/kvbiis9ucaMld-Ps9eMt8/BiunttleYrGfya-c1eg-ks0y8m5b_oIldsj/ltprWaEiEl--2pblvuPsy.KsRv5g+"),
            HavraBatikGlyphs.steelTiffinStack("hLa0vurCay-DaqtKlUa4sA/vv0iNssuia9lx-_s1egtj/ti+n3tzelrUfsaLcveQ-as2yMmPbpoflosI/HfGoSlUlsobwXehr=sR.Ksqv9ga"): HavraBatikGlyphs.steelTiffinStack("hia6vWrZaz-WaBtBl0a2sj/7vBiwszuXaUl0-UsKestl/hipnLt-eXrwf+aAcWep-ss8ymm8bOoPlMsH/DtArPaCinlU-bcTlwu4sdtHefr+.os_vzgs"),
            HavraBatikGlyphs.steelTiffinStack("hga+vbrnaQ-Qa+trlNa_sX/0vpijsruXabl9-LsReCta/3iXnUtceNrFf6aQckeN-mssyVmabzo0lxsM/8hUeDaPr0tr-xfxiBlwl-.csDvIgD"): HavraBatikGlyphs.steelTiffinStack("hJatvNrDad-za7tDlpaIs-/PveiSs1u9a6li-csue4tD/-iynItDeBrRfLaJc8e4-ws7y4m7bgo+lyse/Nw6avr1mv-ZhweiaGrbtp-jfPidl1lH.+syvxgq"),
            HavraBatikGlyphs.steelTiffinStack("hZarv7rYaV-Qa1tol9aysx/rvKiXsWu3aal1-1s3eXtl/FihnktaePryfJaPcre1-qsDyTmSb1oLlQsy/vh7exabrhtj.TsWvjgC"): HavraBatikGlyphs.steelTiffinStack("hNaNvurVa6-Va0tLlParsf/Ov1iWsXuwajld-msxeqtH/aijnqtjeUrwfjaFcLe--rsHy8mbbHoFlVs+/awkaFrLm_-Rhxelavr=tC.LsdvmgD"),
            HavraBatikGlyphs.steelTiffinStack("hzaBvFrzap-FamtLl5adsx/gv0i6scuUaIll-osdeptv/bi2nztWetrgfBa6cDe_-4ssy3mvbQodl3sT/qhbovmmeT_ssNeUlFeKc3ttefdY.bsyv4gM"): HavraBatikGlyphs.steelTiffinStack("huaTvKrVaS-xaftolpadsP/qvKiMsfu1aFl1-ysEeQtm/iivnUtVefrwfEaJcWeV-isFyKmCb5oBlysV/TennVtarTyC-=s-exlce=c-tqe3df.RsNvWgt"),
            HavraBatikGlyphs.steelTiffinStack("huauvOrBa3-OaHtcl9a9s1/rv=i2sNuMaflY-OsreQt-/ui-n3tjerr-fNaoc7e4-NsXyomfbzo0l8s2/3lIo3cbkD.psIvWgY"): HavraBatikGlyphs.steelTiffinStack("hIaLvtrUa2-caJtilUapsd/Jv_iRsXuIatlN-bsseKtc/VignCtmeorUf4aWcdeh-AsryHm-bvoJltsm/2p7reilv0a2chyC-xlFo8c-kV.4s8vkgk"),
            HavraBatikGlyphs.steelTiffinStack("hsawvGr1aL-SamtDlsalsN/av3iisGuHaalK-0siefts/Ai5nctTeGr4f8avcQer-TsWyimIbZoWlus6/6mgeqses=a+gJePsp.as5vggC"): HavraBatikGlyphs.steelTiffinStack("htakvlr2aW-EabtSlqaksj/TvmiishuNagl0-vsjeatW/hiVnRt1enrnf-aRcAeS-Ps9ywmDb3oOlRs=/AnroTtOe9-MsetPaccwkM.3shvag7"),
            HavraBatikGlyphs.steelTiffinStack("hxayvjrVa2-daMt4lVavs0/Cv8iMsuuhaUl5-bsRexto/ZiOnytGeSrsfzazcweO-vsQyGmLbwoClVsk/8mSiIcY.nsMvMg5"): HavraBatikGlyphs.steelTiffinStack("hYaJvbr6a7-RaUtwlKaSs5/svQins9uPa0la-Lsge6tl/KirngtkeFrffCamcteU-usKyYmlb6ojljsS/zv9oHiOcze6-ymSaIrZkd.OsSvyg2"),
            HavraBatikGlyphs.steelTiffinStack("hxaKvZr6aO-eaZtNlgalsK/dvBiAssuaaflK-8sJedtM/=iDnatoeNrlf6akcWeN-8sMy9mgbjojl9s2/cmXobr7eA-ThPofrWi+zOoon9tfaQlH.tsjvQg+"): HavraBatikGlyphs.steelTiffinStack("hhaWvRrSaU-5adtRlGa_su/KvhitsKusaUlY-1sUelt7/ci8nXtAeAr7f+apcMe4-jsUyOmZbjoelws6/smHoXrkew-=rxo2wR.Ls-v0gK"),
            HavraBatikGlyphs.steelTiffinStack("hsaivvrka9-_awtFl=a2su/hv4iFsMu1aLl3-csKe6tT/3iqn8tqemrkfPaScveJ-7sOyumHbZonlBsS/UmeoCrTe4-uvHeCrytEivcSawlB.hsevJgf"): HavraBatikGlyphs.steelTiffinStack("hqaLvJrJaM-0aBt0lya2se/6vhi_sZuPa_l=-3skeOt8/6i_nztpearQf9aWc5ee-isMy8m5b0olllsz/9mBovr8eV-zc9oklEuymwnP.TscvVgp"),
            HavraBatikGlyphs.steelTiffinStack("hqahvcrSat-gayt3l9a6so/ZvGiPs_uqa3lE-5ske-tr/OianstXegrqfeaQcWe--cslyxmLbwoElZsE/Cn7aFvq-CaplNbNu0me.SsDvpgo"): HavraBatikGlyphs.steelTiffinStack("hWabvUrUa7-+adtqlRaosx/jvai-sUuYaXlu-Psee9t1/jiTnutUe=rafCaoc-eO-EsFysmJbMomlKs7/lkXede_pTstawk1er-sgYrciIdQ.AsSvEgy"),
            HavraBatikGlyphs.steelTiffinStack("h2a5vFr3ab-4a2tVlaa=sc/MvCigs+uFaqln-rs=eLtp/Ri6nUtdeurYfBaIc2er-GsOytmtbeoklcsm/3nyaTvV-8cMrreKavtLe6.YsWvAgF"): HavraBatikGlyphs.steelTiffinStack("hpaivsr8aF-gabtMlfa8sr/JvHiusRuVanlt-rsdemtD/Zi7ndtiebrBfcaDcIeW-6sDyemXbso_lSsp/PcSoHmSpuofs4en-vp2lguYsv.csNvOgh"),
            HavraBatikGlyphs.steelTiffinStack("hoaWv5rSaH-9ayt+lpacsb/NvzifsXuQaulB-8sleUto/uiNnYtYelrif+a1cse=-Lsey7mvb2o7lQs_/dniavvx-dhioBmieJ.=sAvegO"): HavraBatikGlyphs.steelTiffinStack("h5a0vSrMaE-yaitRlfaKsD/wv9iAsaubaol6-1s8edtm/GiNnJt=e+rEfNaocZeL-VsJyBm_bMoklgs+/5e=nitUrLyY-nwWaqym.As4vwgz"),
            HavraBatikGlyphs.steelTiffinStack("h0aVvSrUaL-baGtzlVaqsG/Kv2iMsAu=arln-nsseytt/Wiun_tPeWrPf5a9cAeY-_ssynmsbloplBsG/ynqa=v5-vpnrpoJfQi0l8eU.nsHvlg4"): HavraBatikGlyphs.steelTiffinStack("hBa3vZrxaB-kaOt3lFa7sQ/Jvki5swu0aLl=-jsaebtW/Fi2n+tZevrXfHa3cQep-1sTysmAb2o1lFst/fpZeXrssSoant-jmWaVr_ky.-sPv3gT"),
            HavraBatikGlyphs.steelTiffinStack("hKa2vqr1ai-ua5t_luaNs1/MvGi3sYusaflK-vs_eTtb/zicn8t_eArrfMaNcteZ-gsBykmab3oKl6sZ/7nlaJvT-MsGqluLaDrNee.5sDv=gF"): HavraBatikGlyphs.steelTiffinStack("hgaIvIrPaP-Ga7trlWaMsF/jvti_sEuKaGl=-OsxemtM/GiEnYtGe1raf-ajcSeU-DsLyhmLbEoBlmsk/XpLlDamzGaa-vgWryi6d4.hsFv4gJ"),
            HavraBatikGlyphs.steelTiffinStack("hma4vVrCaR-jaGtmlYarsh/=vUissSu4aHly-Tsce5t9/MiLnftae1rVffaAc5ea-VsHyEmLbhoTlZsW/8pjauwo.os+v_gr"): HavraBatikGlyphs.steelTiffinStack("htadvfrvaa-8aTtallahsF/VvfiPsFuVaxlj-osTeetX/qiOnrt9ePrPfXaFcOex-dsFyYmqbno5l9s7/5lzeRaxfW-Eplr0iZndtQ.QsuvMg2"),
            HavraBatikGlyphs.steelTiffinStack("hNaUvirVaT-Sa9t0lNaKst/Bv6iVsBuPacl5-vs+eRtn/3i4nqtreHrIfOahc6e7-Js9yumKbrofllsW/mpuhrohnseD.LsvvsgD"): HavraBatikGlyphs.steelTiffinStack("hiahvvrWak-AartxlBamsL/+vIigsguCa4lY-Ys-eqt3/oi-n8tPexrxf-a+cqe_-9suylmTbZoOlCsN/=cloZnJt1ancAtG-dh2aTnndts5eKtW.=savjgc"),
            HavraBatikGlyphs.steelTiffinStack("h=aMvbrQaZ-SaAtGlMaDsj/mv4iXsGuHaElE-qs-eYtD/Ii8nxtKefrlfTaJcceS-es=yDmmbAo4ltsq/kp8h-ortTo5-ylOi-bwrgaMr6yi.0s8vEg2"): HavraBatikGlyphs.steelTiffinStack("hQaavor4a--qaGtdlla9sx/avViDs4uya5lY-8sKestB/CixngtSeQrWfNaOcCei-zs3yHmebVozlisF/bsJtIifl_lJ--cpoCl4lreecHt0i=osnH.9sAvngf"),
            HavraBatikGlyphs.steelTiffinStack("hcawvYroaT-_aOtslgausP/YvIi5sNuZatlx-RsGegtW/4ifnBteeNrafXahc-eq-2szyOmvbeorlUsP/6rueCpuo7rmtb.ssYvdgg"): HavraBatikGlyphs.steelTiffinStack("hmaivKrlap-aa1tXluaxs0/yvYiYsluda8l=-5szemtL/Ti9n9t7eFrMf8a4c0et-zs_yvm0bQoNlesa/QcJa7rAeq-xfulqaQg2-jl8iXnNe_.qs4vFg0"),
            HavraBatikGlyphs.steelTiffinStack("hkaDv+rba8-4a-tmlxaHs+/qvviasduMaylH-8s-e8tM/FiKn4tKeRryf+a-cbeL-bs5yMmIbUoYlHs3/ysfeSaCr3cnhh.zs3vQgL"): HavraBatikGlyphs.steelTiffinStack("hSa6vcrWag-jahtIlSagse/XvKi2s_uOa+lk-gsee9t=/CiXnutce+rrfoaXcwe8-xsJywmqbjoMlNsa/WfPiynMdb-_lPeJnUse.+ssvWgv"),
            HavraBatikGlyphs.steelTiffinStack("hDaNvWr_al-VaftVlHa2sN/9vSi8swuMacli-2sIe9tT/WiNn2t3eercfpa3cse5-isYyumab6o+lRsE/MsMe5nhdR.Hspvfg2"): HavraBatikGlyphs.steelTiffinStack("hvamvEr7a_-La6tklja6sd/cvziDsiu_awl+-psDeOtc/yi-nlt7errRf-akc8e3-ks-yYm-bBomlKsS/XdhiPsxpiaztsc0h7-saYrgrPoRwE.essvAgk"),
            HavraBatikGlyphs.steelTiffinStack("h0aHvFraa5-waCtUlKa_s6/cvZias1uCaLlR-is6evtr/3iEnFtUeUrGfpaZc=eR-fssyemGboonljsq/psmestAt4ijn3g2se.xsev4gC"): HavraBatikGlyphs.steelTiffinStack("hKaLvCrKal-saMt5lPaWs2/pv1iRsbuLaqld-nsfemtt/8i_n5tVenrvf_alcweJ-csWyZmJbNoLlLsf/8croTmZpOaPs2s4-0gWeUaGrQ-QloiFn-e2.CsWvXgK")
        ]

        if let batikSymbolTrail = batikSymbolPairs[wovenArchiveTrail] {
            return batikSymbolTrail
        }

        let riverJourneyPairs = [
            HavraBatikGlyphs.steelTiffinStack("hUaTvvr4ad-caAtmloahs5/cvEiNsvu4aWlf-UsVe3to/OjfoGu3rqn9e8yJ-1t8asbrsa/zhFoomYeg-RaBcZtPi0vIeZ.tsovMgI"): HavraBatikGlyphs.steelTiffinStack("hqaPverfa=-IaetQl4awsB/kvWi+spuea-lD-OsKeAtt/ujgoGuRrZngeCye-mt6a3bHsl/_ePnetArMyz-yl-iUtw.Ns+vUg6"),
            HavraBatikGlyphs.steelTiffinStack("hUagvPrlaw-badtsl3agsm/7vbixsiuVacl4-5saeltd/nj6oTu_r0naeny_-gtAa2b+sB/chooJmzeb-gdtekf9aCuulVt4.ssOvggk"): HavraBatikGlyphs.steelTiffinStack("hSa3vBr-ay-ZaQtulIaqsY/rvZi8skucaUl0-FsEedtM/ljMoAuLr6nbeQyv-OtIaOb3s4/ueYnntErjyY-Krcels1tZ.7snvkgT"),
            HavraBatikGlyphs.steelTiffinStack("h-aDvlryac-0ajt3lha9sr/+vTiisaufaFl2-TsueItt/FjaoxuurrnKeNyz-JtTaAb6s1/7lfi_bVrTaDrbyv-CaMcitSiBv0eY.ps2vkg-"): HavraBatikGlyphs.steelTiffinStack("hma9vYrFaI-UadtSlIapsN/5vAiTsXubaKlz-TsAePt3/ijEoVuyrXnSeMy6-4tvadbOsw/oaAtMllaRss-wlHintG.6sIvIgm"),
            HavraBatikGlyphs.steelTiffinStack("hSaIvHrGaw-NaAt0lua_sn/1vAiqs_uQaylq--sLestQ/OjwotuZrQnmePy1-ltaa=besf/aleiybjr9aarCy9-_dTeufjaMublAt1.dsNvigk"): HavraBatikGlyphs.steelTiffinStack("hnayvfrwag-qavtEl+aFsE/mvViUshuwaql7-9s2eftq/wj2o7uXrCnreDyK-wtYaJbCsd/Gantxl4axs1-Lr2eUsMtW.9sqvXgD"),
            HavraBatikGlyphs.steelTiffinStack("hUaXvTr9a5-TaItrlbarsY/jvoiQsfu3ailw-Tste0tE/4j1orurrKn9ecyu-ptPa1bis6/BpprloUfOiclzeq-5a5cotaiKvIeg.Is7vVg-"): HavraBatikGlyphs.steelTiffinStack("h1advJrrax-_a5tslPaJsf/CvIiDsMuEaqlA-SsWeTtd/ljjoWuhrAnhe7ye-KtLaIbksX/fsoeil8fp-alBiFto.0s_vIgd"),
            HavraBatikGlyphs.steelTiffinStack("hXaZvArga+-ba-tDlpaLsW/hvAicsRuNaalT-Fs_ewte/ojco4uHrXnTeSy_-qtJa9bJs8/RpYr5oDfMiNl4ep-AdQerfjaxublvtu.osZv7g-"): HavraBatikGlyphs.steelTiffinStack("h6a7vbrra1-daNtCljaRsB/5vUilsnuHaVlI-ssQe8tP/jjzoBudr3nJeryd-XtSa9btsp/hs=erlbf6-OreeZs3tp.AsDvygD"),
            HavraBatikGlyphs.steelTiffinStack("h1a3vdr2av-GaRtplzacsb/QvZiwsLu0aOl_-Ys6e=t3/fj+oru3r2nee0y7-6twaPbHsE/UwDaKlWl8-Naic2tPiYvNeV.Is+vGgP"): HavraBatikGlyphs.steelTiffinStack("hqaavBrtaP-waPtVlmaXs3/8v5ixsauvaNly-zsHeXtr/OjBoHumrpn4eqys-RtYaibHs2/FpVlYalzPal-GlCietI.fstv5g1"),
            HavraBatikGlyphs.steelTiffinStack("hOa=vVrKaD-daft3llags4/Mvjiislu0ayl---sce3tJ/SjhocurrUnWeBym-Ht7aibHsH/4wJarlylx-vdLeAfJaWu=lut9.osOv4gG"): HavraBatikGlyphs.steelTiffinStack("h5aQvxr5a6-la_tal8ahsA/2v9iWs0uUajlV-0sne5tN/ajSoTu8rfn_eNy=-3tRaUbosD/IptlwaFzuaz-zrKeosjtM.bsCvIgs")
        ]

        if let riverJourneyTrail = riverJourneyPairs[wovenArchiveTrail] {
            return riverJourneyTrail
        }

        let heritagePortraitPairs = [
            HavraBatikGlyphs.steelTiffinStack("hiaPvdrSaW-3a0tul6aSs1/HvHiQsvuGaJl8-nsIeHtO/mperwoif7ihl+ej-cf1arcIe2s4/6h8e6a+dA_B14.2pFn2gm"): HavraBatikGlyphs.steelTiffinStack("h4ahvrr6aM-DaRtplLa+sF/uv6iLs=u2aEld-ksPeitS/cpkr0osfMiAlIeJ-sfNacccebso/jf0aPcoeX-nbda0nHg=kLoZkE-egTuai_dpeD.Yp-nNgT"),
            HavraBatikGlyphs.steelTiffinStack("hNaZvAr9a0-9axtglxaNsj/7vsi6sjubaVlA-qs+e8tl/CpprYoYf6iBlSeZ-UfOaUcEebsW/uh0eKaudR_c2I.mpGnlgm"): HavraBatikGlyphs.steelTiffinStack("hQaUvorya3-EaJt-lyaGsx/5vZi9sAupaQlm-5sLe+tA/fparDozf1ihloeE-=fUaocte_sP/Tfoa=cLen-7bDaXlMiD-kmToNrinDiZnrgT.rp6nZgc"),
            HavraBatikGlyphs.steelTiffinStack("hjapvOrmaX-XaItyljaNsh/avuixsJuna9lz-8sIe2tP/6pjr=osfeiKlxe_-2f7anc8eAsQ/_hYeBaVd0_W3u.Gpkn6g6"): HavraBatikGlyphs.steelTiffinStack("hVa4vFrHaZ-dawtylHaPs_/yvai5sMuFa+l3-qsIectd/Bp4rLoXfMinlHe9-PfCaKcYe_sz/tfYaccqe+-5hTaunToIie-br3eraWdpeerc.hp4nagv"),
            HavraBatikGlyphs.steelTiffinStack("hVaHvTrmaV-7aRtklzaSsz/Svji7seuIa-lf-hsoeut2/xpur3o9fTislFeX-GffaFcVeHsB/uhve0aSdK_d4N.Apdnvgi"): HavraBatikGlyphs.steelTiffinStack("hKaLvwrUaJ-JaWtHlOamsG/evcicsHuxa_lm-0syeCtW/epwrEo0f6iGlyeR-VfUa6cUe4sO/ef2amc1eI-Km6arnwi-lSa3-Aszuvn2sPeCt5.LplnDgq"),
            HavraBatikGlyphs.steelTiffinStack("hHa8vCr+ay-aaNtxlRacs7/SvYiisVuYaHl6-ssjeNt1/Ap2rOoAfbijlBe7-rfsaAcSe_sK/uhpe6aTdH_w5e.Wp_negQ"): HavraBatikGlyphs.steelTiffinStack("hpa_vVroai-naEt7lDats0/RvqidsbuuaUlf-Zs3entO/vpJrMoSf=iZlAeT-df2aZcseQsf/Cfdawc+eb-lbXaVn6gZkloZk4-3lFaAnleR.vpfnBgS"),
            HavraBatikGlyphs.steelTiffinStack("h2aXvMr6ac-7aRtPlCassu/CvLiRssubaJlB-4s0evtA/GpLrXo_fminlned-sfOapc4eLsG/xhmetandp_a6o.rpEnOgG"): HavraBatikGlyphs.steelTiffinStack("hDaFvrrpaw-zaMtKlKaos=/WvDics+uLaLlm-esee=t_/mpkrvoHfpikl-e--HflaZcNevsO/xfMaHc8e+-lpKe0n6aQnwgL-0c8rbaBfgtu.HpmnEgM"),
            HavraBatikGlyphs.steelTiffinStack("h8a9vZr_a5-PaWtplVaIsb/-v0ips9u7aPlZ-xsQeYtQ/+pZrcolfnidlle5-GfiaHcbeJsY/0hTesaedu_N7A.KpBn6gy"): HavraBatikGlyphs.steelTiffinStack("hEaNvjrta=-baztmlVaos1/WvtiTsXu8aJla-hsNeMtB/WpDrzoGf4i_l0eE-ff8aRc-eQsw/lfhaOcFeA-2cZesbyuc-7svhOowrSe-.Rpnn4gE"),
            HavraBatikGlyphs.steelTiffinStack("hDagvDr5ak-CaXt+lyarsb/HvYiSsTuSa=lU-IsNeitj/vp2r+offOiblveR-Rfja4cJe0sA/ChJeKawdh_f86.rpjnog8"): HavraBatikGlyphs.steelTiffinStack("h4a2vBr+ab-BaHttlgaHsB/VvkiwsVu0ajlJ-ZskeNt6/bp1rAo_fmiBlieJ-Rf0a1chePse/=f+a0cte9-Ul8aCn4tEeMr1nd-Dw_awlCkT.Ppfn_gD"),
            HavraBatikGlyphs.steelTiffinStack("hRakvXrTan-sa7txlea8s+/-vSiFswuua0l9-=s-e9tJ/Yp5rLoFfRiolze3-WfAaFcBeAsX/jh9elagdv_b91.Fp9nhgb"): HavraBatikGlyphs.steelTiffinStack("hWaNvZrxaA-ka=t_lZaqsy/Vv5i1s2uDahl8-SsiePtm/opBrWoyfcislEea-pf8aLcoeBsC/6fJa9cke3-amRaVrmkneKtR-FsYm3i3lVez.8pDncgL"),
            HavraBatikGlyphs.steelTiffinStack("hFaBvCraag-Za-t9l6axsE/9v=iDsjuma5lK-Zs4eatH/sp+rooGf2iolTed-3ftaQcxe4sl/4h9e9aPd7_T170Z.ZpPnvg-"): HavraBatikGlyphs.steelTiffinStack("hcaAv+rQa5-_actBlyaZsA/HvGi3sVuoall=-lsSe-ty/wp_rsoyfwipljem-eflaKcEeIsk/1fkaXcFei-lf6eBr3rKy3-9sZeDaOtZ.Yp5nMgZ"),
            HavraBatikGlyphs.steelTiffinStack("haaMv7r3as-Ca7tFllaCsq/svwi6sLu_aFld-IsPeWtg/tpzrCoQfBiGlBes-gfGaTctedsS/Th2epacdT_b151l.9p9nUga"): HavraBatikGlyphs.steelTiffinStack("hRa1vwrba2-Pajt7loaXsS/dvVihseuca1lY-Jsae1t5/LpzrnopfJi_lke3-7fGabcFeKsU/2fnaJcueV-pfJaWm+iDlayH-ptFa3bIlUeZ.-pGnegc"),
            HavraBatikGlyphs.steelTiffinStack("hyaov6raa7-caOt=lWa3sq/WveibsAuAaLl2-Js2evtL/7pWrno-fsiZlheR-Tfyaxc=eXsR/9hpeOajdJ_01p2H.wp4nDgz"): HavraBatikGlyphs.steelTiffinStack("hha4vQrDae-Ua6tqlnaVsk/Jvvi0srupa7lL-jsHegt+/NpMrdoTfVi4l1ex-wfyaHc3eNs1/Ef=a0cae3-9fqefsHtVixvXayln-6l7i9gKhStS.opCnWgd"),
            HavraBatikGlyphs.steelTiffinStack("hMaXvZrwav-Faettlsaqs6/wvSi9sYuXablA-ysOeUt1/jpbrhoEfWibl7eE-_fxa4ceeQsQ/Dhteya3dg_51s3Q.hpDn6gV"): HavraBatikGlyphs.steelTiffinStack("hZa2vErcai-FaBtYlIays_/pv+ilsHuKaZl1-TsveitN/MpKrgoafFiVlreA-WfcawctensF/2f0aFcfeL-2fjagsfhqiJoPn2-ichoDr7nkeir1.zpUnugi"),
            HavraBatikGlyphs.steelTiffinStack("hpa4vQraa=-vaitMlLacsc/GvOifsYuyallo-2sweStU/wpSrVoffgi0lceZ-rfhaDcWessc/=hMeBa_dj_c1Q4r.Ppynwgo"): HavraBatikGlyphs.steelTiffinStack("hUaEvxrHaQ-baet8lMa6sT/_vhihsXuhawla-Ss-eZte/mpXrmo2fNiulteL-pfyafcie5sv/Xfsa6cVeP-8rwasiSncy6-usZheo_pGfZrRo1nTt1.OpmnZg4")
        ]

        return heritagePortraitPairs[wovenArchiveTrail] ?? wovenArchiveTrail
    }
}
