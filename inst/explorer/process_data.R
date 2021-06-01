## Add multiple owners and explanations ----------------------------------------
esca[["land_holder_notes"]] <- ""
esca[["land_holder"]] <- ifelse(esca[["coe"]] %in% c("E18.1.1", "E18.1.2"),
                                "City of Seaside, CalVet",
                                esca[["land_holder"]])
esca[["land_holder_notes"]] <- ifelse(esca[["coe"]] %in% c("E18.1.1", "E18.1.2"),
                                      "The central area in this parcel, approximately between Parker Flats Road and Parker Flats Cut-Off, is owned by CalVet; otherwise, owned by the City of Seaside.",
                                      esca[["land_holder_notes"]])
esca[["land_holder"]] <- ifelse(esca[["coe"]] == "E18.1.3",
                                "City of Seaside, AP Glover Enterprises LLC",
                                esca[["land_holder"]])
esca[["land_holder_notes"]] <- ifelse(esca[["coe"]] == "E18.1.3",
                                      "AP Glover Enterprises LLC owns the approximately 4.98 acre Medical Officer Barracks site. The rest of the parcel is owned by the City of Seaside.",
                                      esca[["land_holder_notes"]])
## Adjust MRA popups -----------------------------------------------------------
esca[["mra_popup"]] <- paste0("<table>",
                              ### COE Field ------------------------------------
                              "<tr><th><b>COE Id: </b></th><td>",
                              esca[["coe"]], "</td></tr>",
                              ### MRA Field ------------------------------------
                              "<tr><th><b>MRA: </b></th><td>",
                              esca[["mra"]], "</td></tr>",
                              ### Jurisdiction Field ---------------------------
                              "<tr><th><b>Land Owner(s): </b></th><td>",
                              get_extended_esca_ownership(.df = esca, .coe = "coe"),
                              "</td></tr>",
                              ### Jurisdiction Field ---------------------------
                              "<tr><th><b>Jurisdiction: </b></th><td>",
                              esca[["jurisdiction"]],
                              "</td></tr>",
                              ### Army ROD Field -------------------------------
                              "<tr><th><b>ROD: </b></th><td>",
                              paste0("<a href='", esca[["rod"]], "' target ='_blank, id = 'link''>Here</a>"),
                              "</td></tr>",
                              ### LUCIP/OMP Field ------------------------------
                              "<tr><th><b>LUCIP/OMP: </b></th><td>",
                              paste0("<a href='", esca[["lucip"]], "' target ='_blank, id = 'link''>Here</a>"),
                              "</td></tr>",
                              ### LUCs Field -----------------------------------
                              "<tr><th><b>MRA LUCS: </b></th><td>",
                              "<table>
                            <tr><th scope='row'>Munitions recognition training</th><td>", checkmark(esca[["munitions_recognition_training"]]),"</td></tr>",
                              "<tr><th scope='row'>Construction support</th><td>", checkmark(esca[["construction_support"]]),"</td></tr>",
                              "<tr><th scope='row'>Access management for habitat reserve</th><td>", checkmark(esca[["access_management_for_habitat_reserve"]]),"</td></tr>",
                              "<tr><th scope='row'>Restrictions in residential use</th><td>", checkmark(esca[["restrictions_in_residential_use"]]),"</td></tr>",
                              "<tr><th scope='row'>Restrictions agains inconsistent use</th><td>", checkmark(esca[["restriction_against_inconsistent_use"]]),"</td></tr>",
                              "</table>",
                              "</table>")
## Adjust owenership popups ----------------------------------------------------
### Removed at the request of BRAC on 1-June -----------------------------------
# apn[["Owner"]] <- ifelse(apn[["APN"]] %in% c("031152011000"),
#                                 "City of Seaside, AP Glover Enterprises LLC",
#                                 apn[["Owner"]])
# apn[["owner_notes"]] <- ""
# apn[["owner_notes"]] <- ifelse(apn[["APN"]] %in% c("031152011000"),
#                                 "AP Glover Enterprises LLC owns the approximately 4.98 acre Medical Officer Barracks site. The rest of the parcel is owned by the City of Seaside.",
#                                 apn[["owner_notes"]])
#
# apn[["owner_popup"]] <- paste0("<table>",
#                                "<tr><th><b>APN: </b></th><td>",
#                                apn[["APN"]],
#                                "</td></tr>",
#                                "<tr><th><b>Owner: </b></th><td>",
#                                get_extended_apn_ownership(.df = apn, .apn = "APN"),
#                                "</td></tr>",
#                                "</table>")
## Adjust jurisdictions popups -------------------------------------------------
esca[["jurisdictions_popup"]] <- paste0("<table>",
                                        get_logo_image(esca[["jurisdiction"]]),
                                        "<tr><th><b>Jurisdiction: </b></th><td>",
                                        esca[["jurisdiction"]],
                                        "</td></tr>",
                                        get_ordinance_row(esca[["jurisdiction"]]),
                                        get_metal_row(esca[["jurisdiction"]]),
                                        "</table>")
