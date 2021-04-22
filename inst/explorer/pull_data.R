# County Parcels with APNs =====================================================
wanted <- tibble::tribble(
  ~APN, ~Group, ~Owner, ~Jurisdiction, ~MRA,
  # Future East Garrison -------------------------------------------------------
  "031161033000", "Group 4", "County of Monterey", "County of Monterey", "Future East Garrison",
  # County North & CSUMB -------------------------------------------------------
  "031161042000", "Group 2", "County of Monterey", "County of Monterey", "County North",
  "031161041000", "Group 2", "County of Monterey", "County of Monterey", "County North",
  "031101065000", "Group 2", "County of Monterey", "County of Monterey", "County North",
  "031101066000", "Group 2", "County of Monterey", "County of Monterey", "County North",
  "031101022000", "Group 2", "CSUMB", "County of Monterey", "CSUMB Off-Campus",
  "031101023000", "Group 2", "CSUMB", "County of Monterey", "CSUMB Off-Campus",
  # MOUT -----------------------------------------------------------------------
  "031011042000", "Group 3", "MPC", "County of Monterey", "MOUT",
  # Barloy Canyon --------------------------------------------------------------
  "031131004000", "Group 3", "County of Monterey", "County of Monterey", "MOUT",
  # Laguna Seca Parking --------------------------------------------------------
  "031131011000", "Group 3", "County of Monterey", "County of Monterey", "Laguna Seca Parking",
  "031131010000", "Group 3", "County of Monterey", "County of Monterey", "Laguna Seca Parking",
  "031131008000", "Group 3", "County of Monterey", "County of Monterey", "Laguna Seca Parking",
  "031131009000", "Group 3", "County of Monterey", "County of Monterey", "Laguna Seca Parking",
  "031011020000", "Group 3", "County of Monterey", "County of Monterey", "Laguna Seca Parking",
  # Del Rey Oaks ---------------------------------------------------------------
  "031191022000", "Group 3", "MPRPD", "Del Rey Oaks", "DRO/Monterey",
  "031191020000", "Group 3", "Del Rey Oaks", "Del Rey Oaks", "DRO/Monterey",
  "031191021000", "Group 3", "Del Rey Oaks", "Del Rey Oaks", "DRO/Monterey",
  # Monterey -------------------------------------------------------------------
  "031191018000", "Group 3", "City of Monterey", "City of Monterey", "DRO/Monterey",
  # Seaside --------------------------------------------------------------------
  "031211001000", "Group 1", "City of Seaside", "City of Seaside", "Seaside",
  "031151062000", "Group 1", "City of Seaside", "City of Seaside", "Seaside",
  # Interim Action Ranges ------------------------------------------------------
  "031011045000", "Interim Action Ranges", "MPC", "City of Seaside", "Interim Action Ranges",
  "031011048000", "Interim Action Ranges", "MPC", "County of Monterey", "Interim Action Ranges",
  "031011049000", "Interim Action Ranges", "MPC", "County of Monterey", "Interim Action Ranges",
  # Parker Flats ---------------------------------------------------------------
  "031011061000", "Group 1", "MPC", "County of Monterey", "Parker Flats",
  "031011062000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031011046000", "Group 1", "MPC", "County of Monterey", "Parker Flats",
  "031152007000", "Group 1", "City of Seaside", "City of Seaside", "Parker Flats",
  "031011066000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031152006000", "Group 1", "City of Seaside", "City of Seaside", "Parker Flats",
  "031011044000", "Group 1", "MPC", "County of Monterey", "Parker Flats",
  "031011043000", "Group 1", "MPC", "County of Monterey", "Parker Flats",
  "031152005000", "Group 1", "CalVet", "County of Monterey", "Parker Flats",
  "031152002000", "Group 1", "CalVet", "City of Seaside", "Parker Flats",
  "031152008000", "Group 1", "City of Seaside", "City of Seaside", "Parker Flats", 
  "031011065000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031152010000", "Group 1", "City of Seaside", "City of Seaside", "Parker Flats",
  "031071008000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031071022000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031101060000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031011070000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031011071000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031011069000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031011067000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031011068000", "Group 1", "County of Monterey", "County of Monterey", "Parker Flats",
  "031152011000", "Group 1","City of Seaside", "City of Seaside", "Parker Flats")
apn <- tryCatch(
  {
    temp <- sf::st_read(paste0("https://services2.arcgis.com/nOGTdfb4kF4dZljH/arcgis/rest/services/Parcels_Data/FeatureServer/0/query?",
                               "where=", in_repeater(.field = "APN", .values = wanted[["APN"]]),
                               "&outFields=APN&outSR=4326&f=json"))
    sf::st_as_sf(merge(x = wanted, y = temp, by = "APN"))
  },
  error = function(cond) {
    message(cond)
    return(NA)
  },
  warning = function(cond) {
    message(cond)
    return(NA)
  },
  finally = function(cond) {
    message("Nothing worked... :(")
  }
)
# Restricted Areas =============================================================
restricted_areas <- tryCatch(
  {sf::st_read("https://maps.fodis.net/server/rest/services/OpenData/AdministrativeBoundaries/FeatureServer/1/query?where=parcel_id='F1.13'%20OR%20parcel_id='E8a.1.1.1'&outFields=*&outSR=4326&f=json")
  },
  error = function(cond) {
    message(cond)
    return(NA)
  },
  warning = function(cond) {
    message(cond)
    return(NA)
  },
  finally = function(cond) {
    message("Nothing worked... :(")
  })
# Former Fort Ord Boundaries ===================================================
ft_ord <- tryCatch(
  {sf::st_read("https://maps.fodis.net/server/rest/services/OpenData/AdministrativeBoundaries/FeatureServer/4/query?where=1%3D1&outFields=*&outSR=4326&f=json")
  },
  error = function(cond) {
    message(cond)
    return(NA)
  },
  warning = function(cond) {
    message(cond)
    return(NA)
  },
  finally = function(cond) {
    message("Nothing worked... :(")
  })
# ESCA Parcels =================================================================
wanted <- tribble(~coe, ~mra, ~group, ~jurisdiction, ~land_holder, ~lucip, ~rod, ~munitions_recognition_training, ~construction_support, ~access_management_for_habitat_reserve, ~restrictions_in_residential_use, ~restriction_against_inconsistent_use,
                  "E11b.6.1", "Future East Garrison", "Group 4", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0364B//ESCA-0364B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0360//ESCA-0360.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E11b.7.1.1", "Future East Garrison", "Group 4", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0364B//ESCA-0364B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0360//ESCA-0360.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E11b.8", "Future East Garrison", "Group 4", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0364B//ESCA-0364B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0360//ESCA-0360.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E18.1.1", "Parker Flats", "Group 1", "City of Seaside", "City of Seaside", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E18.1.2", "Parker Flats", "Group 1", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E18.1.3", "Parker Flats", "Group 1", "City of Seaside", "City of Seaside", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E18.4", "Parker Flats", "Group 1", "City of Seaside", "City of Seaside", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E19a.1", "Parker Flats", "Group 1", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E19a.2", "Parker Flats", "Group 1", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E19a.3", "Parker Flats", "Group 1", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E19a.4", "Parker Flats", "Group 1", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E19a.5", "Parker Flats", "Group 1", "County of Monterey", "MPC", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E20c.2", "Parker Flats", "Group 1", "City of Seaside", "City of Seaside", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E21b.3", "Parker Flats", "Group 1", "County of Monterey", "MPC", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E23.1", "Seaside", "Group 1", "City of Seaside", "City of Seaside", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E23.2", "Seaside", "Group 1", "City of Seaside", "City of Seaside", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E24", "Seaside", "Group 1", "City of Seaside", "City of Seaside", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E29.1", "DRO / Monterey", "Group 3", "City of Monterey", "City of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "E34", "Seaside", "Group 1", "City of Seaside", "City of Seaside", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "E38", "Interim Action Ranges", "Interim Action Ranges", "City of Seaside", "MPC", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0337B//ESCA-0337B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0331//ESCA-0331.pdf", "Yes", "Yes", NA, "Yes", "Yes",
                  "E39", "Interim Action Ranges", "Interim Action Ranges", "County of Monterey", "MPC", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0337B//ESCA-0337B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0331//ESCA-0331.pdf", "Yes", "Yes", NA, "Yes", "Yes",
                  "E40", "Interim Action Ranges", "Interim Action Ranges", "County of Monterey", "MPC", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0337B//ESCA-0337B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0331//ESCA-0331.pdf", "Yes", "Yes", NA, "Yes", "Yes",
                  "E41", "Interim Action Ranges", "Interim Action Ranges", "County of Monterey", "MPC", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0337B//ESCA-0337B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0331//ESCA-0331.pdf", "Yes", "Yes", NA, "Yes", "Yes",
                  "E42", "Interim Action Ranges", "Interim Action Ranges", "County of Monterey", "MPC", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0337B//ESCA-0337B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0331//ESCA-0331.pdf", "Yes", "Yes", NA, "Yes", "Yes",
                  "F1.7.2", "MOUT", "Group 3", "County of Monterey", "MPC", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.13.1.2", "DRO / Monterey", "Group 3", "City of Del Rey Oaks", "City of Del Rey Oaks", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.13.3.1", "DRO / Monterey", "Group 3", "City of Del Rey Oaks", "City of Del Rey Oaks", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.18", "Parker Flats", "Group 1", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "L20.19.1.1", "Future East Garrison", "Group 4", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0364B//ESCA-0364B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0360//ESCA-0360.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "L20.2.1", "County North", "Group 2", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0305B//ESCA-0305B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0298/ESCA-0298.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.3.1", "Laguna Seca Parking", "Group 3", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.3.2", "Laguna Seca Parking", "Group 3", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.5.1", "Laguna Seca Parking", "Group 3", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.5.2", "Laguna Seca Parking", "Group 3", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.5.3", "Laguna Seca Parking", "Group 3", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.5.4", "Laguna Seca Parking", "Group 3", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L20.8", "MOUT", "Group 3", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L23.2", "Parker Flats", "Group 1", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "L32.1", "Parker Flats", "Group 1", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0361E//ESCA-0361E.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0359//ESCA-0359.pdf", "Yes", "Yes", "Yes", "Yes", "Yes",
                  "L5.7", "County North", "Group 2", "County of Monterey", "County of Monterey", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0305B//ESCA-0305B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0298/ESCA-0298.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "L6.2", "DRO / Monterey", "Group 3", "City of Del Rey Oaks", "MPRPD", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0301B//ESCA-0301B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0293/ESCA-0293.pdf", "Yes", "Yes", NA, "Yes", NA,
                  "S1.3.2", "CSUMB Off-Campus", "Group 2", "County of Monterey", "CSUMB", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0305B//ESCA-0305B.pdf", "https://docs.fortordcleanup.com/ar_pdfs/AR-ESCA-0298/ESCA-0298.pdf", "Yes", "Yes", NA, "Yes", NA)
esca <- tryCatch(
  {temp <- sf::st_read(paste0("https://maps.fodis.net/server/rest/services/OpenData/AdministrativeBoundaries/FeatureServer/1/query?",
                              "where=", in_repeater(.field = "FortOrd_DBO_tblParcel_COENumber", .values = wanted[["coe"]]),
                              "&outFields=*", #"FortOrd.DBO.PARCEL_AREA.FortOrd_DBO_tblParcel_COENumber,FortOrd.DBO.tblParcel.ParcelName,FortOrd.DBO.tblParcel.HMP_category,FortOrd.DBO.tblParcel.Authority,FortOrd.DBO.tblParcel.TrackingNumber_Name",
                              "&outSR=4326&f=json"))
  colnames(temp) <- tolower(sub("FortOrd.DBO.tblParcel.|FortOrd.DBO.PARCEL_AREA.|FortOrd_DBO_tblParcel_",
                                "", colnames(temp)))
  sf::st_as_sf(merge(x = wanted, y = temp,
                     by.y = "coenumber",
                     by.x = "coe"))
  
  },
  error = function(cond) {
    message(cond)
    return(NA)
  },
  warning = function(cond) {
    message(cond)
    return(NA)
  },
  finally = function(cond) {
    message("Nothing worked... :(")
  }
)
