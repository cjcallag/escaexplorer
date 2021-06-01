shinyServer(function(input, output) {a
  # Set up observers ===========================================================
  observeEvent(input$load_about, {
    modal_about()
  })

  output$information <- renderUI({
    if (input$data_set == "MRA Groups") {
      out <- "The ESCA areas were consolidated into five munitions response area (MRA) groups according to similar pathway-to-closure characteristics. Each group has a unique Record of Decision and Land Use Control Plan, which can be accessed by selecting a parcel."
    } else if (input$data_set == "Municipal Jurisdictions") {
        out <- "The ESCA areas are situated accross various municipal jurisdictions with different regulations. This visualization includes links and information relevant to each municipality."
    } else if (input$data_set == "Ownership") {
        out <- "All ESCA parcels have been transfered to the land owners. This visualization leverages the Assessor Parcel Number (APN) assign to each real property in order to track parcels and related information."
    }
    return(tags$p(out, style = "font-size:10px;"))
  })

  # Get map ====================================================================
  output$map <- renderLeaflet({
    ## Validate data -----------------------------------------------------------
    if (is.na(esca) || is.na(ft_ord) || is.na(restricted_areas)
        # || is.na(apn)
        ) {
      showNotification(ui = "One of the required datasets are failing to load, refresh your browser. If this persists, contact the adminstrator (ccallaghan@ci.seaside.ca.us).",
                       type = "error",
                       duration = NULL)
      }
    validate(need(!is.na(esca), message = FALSE))
    # validate(need(!is.na(apn), message = FALSE))
    validate(need(!is.na(ft_ord), message = FALSE))
    validate(need(!is.na(restricted_areas), message = FALSE))
    source("process_data.R")
    ## Color palettes ----------------------------------------------------------
    group_pal <- colorFactor(palette = c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0"),
                          domain = esca[["group"]], na.color = "#ff7f00")
    reuse_pal <- colorFactor(palette = c("#7fc97f", "#beaed4", "#fdc086", "#ffff99"),
                             domain = esca[["hmp_category"]], na.color = "#ff7f00")
    # owner_pal <- colorFactor(palette = c("#7fc97f", "#beaed4", "#fdc086", "#ffff99", "#386cb0", "#f0027f", "#bf5b17", "#666666"),
    #                          domain = apn[["Owner"]], na.color = "#ff7f00")
    juris_pal <- colorFactor(palette = c("#7fc97f", "#beaed4", "#fdc086", "#ffff99"),
                             domain = esca[["jurisdiction"]], na.color = "#ff7f00")
    ## Map making --------------------------------------------------------------
    my_map <- leaflet(options = leafletOptions(zoomControl = FALSE)) %>%
      addProviderTiles(providers$Esri.WorldGrayCanvas, group = "Basemap") %>%
      addProviderTiles(providers$Esri.WorldImagery, group = "Imagery") %>%
      addPolygons(data = ft_ord, fill = FALSE, weight  = 4, color = "#000000",
                  opacity = 1, group = "Ft. Ord Boundary") %>%
      addPolygons(data = restricted_areas[restricted_areas[["FortOrd.DBO.PARCEL_AREA.FortOrd_DBO_tblParcel_COENumber"]] == "F1.13", ], fillColor = "red", fillOpacity = 0.1,
                  color = "red", weight = 0.75,
                  popup = paste0(
                    "<table>
                    <tr><th><b><center>Impact Area MRA</center></b></th></tr>",
                    "<tr><th><b><center><p style='color:red;'>Army - Authorized personnel only.</p></center></b></th></tr>",
                    "<tr><td><center><img src='danger.jpg'></center></td></tr>",
                    "<tr><td><small>The Impact Area MRA is closed as the munitions cleanup is not yet complete.</small></td></tr>",
                    "</table>"))  %>%
      addLayersControl(baseGroups = c("Basemap", "Imagery"), position = "topright",
          options = layersControlOptions(collapsed = FALSE)) %>%
      setView(lng = -121.77, lat = 36.613, zoom = 12.5) %>%
      addMeasure(position = "topright", primaryLengthUnit = "feet",
                 primaryAreaUnit = "acres")

    my_map %>% clearControls()

    if (input$data_set == "MRA Groups") {
      my_map %>%
        addPolygons(data = esca, fillColor = ~group_pal(esca[["group"]]),
                    fillOpacity = 0.5, weight = 1, opacity = 1,
                    color = "#000000", label = paste0("COE: ", esca[['coe']]),
                    popup = ~mra_popup, group = "ESCA Parcels") %>%
        addLegend(position = "bottomright", pal = group_pal,
                  values = esca[["group"]], title = "Groups", opacity  = 1) %>%
        addSearchFeatures(targetGroups = "ESCA Parcels",
                          options = searchFeaturesOptions(zoom = 15,
                                                          openPopup = TRUE,
                                                          moveToLocation = TRUE,
                                                          position = "topleft",
                                                          hideMarkerOnCollapse = TRUE,
                                                          textPlaceholder = "Search COE...",
                                                          autoCollapse = TRUE))
    }
    ### Commented out at the request of BRAC on 1-June -------------------------
    # else if (input$data_set == "Ownership") {
    #   my_map %>%
    #     addPolygons(data = apn, fillColor = ~owner_pal(apn[["Owner"]]),
    #                 fillOpacity = 0.5, weight = 1, opacity = 1, color = "#000000",
    #                 label = paste0("APN: ", apn[["APN"]]),
    #                 popup = ~owner_popup, group = "Owner") %>%
    #     addLegend(position = "bottomright", pal = owner_pal, values = apn[["Owner"]],
    #               title = "Land Owners", opacity  = 1) %>%
    #     addSearchFeatures(targetGroups = "Owner",
    #                       options = searchFeaturesOptions(zoom = 15,
    #                                                       openPopup = TRUE,
    #                                                       moveToLocation = TRUE,
    #                                                       position = "topleft",
    #                                                       hideMarkerOnCollapse = TRUE,
    #                                                       textPlaceholder = "Search APN...",
    #                                                       autoCollapse = TRUE))
    # }
    else if (input$data_set == "Municipal Jurisdictions") {
      my_map %>%
        addPolygons(data = esca, fillColor = ~juris_pal(esca[["jurisdiction"]]),
                    fillOpacity = 0.5, weight = 1, opacity = 1, color = "#000000",
                    label = paste0("COE: ", esca[['coe']]),
                    popup = ~jurisdictions_popup, group = "Municipal Jurisdicition") %>%
        addLegend(position = "bottomright", pal = juris_pal, values = esca[["jurisdiction"]],
                  title = "Municipal Jurisdictions", opacity  = 1) %>%
        addSearchFeatures(targetGroups = "Municipal Jurisdicition",
                          options = searchFeaturesOptions(zoom = 15,
                                                          openPopup = TRUE,
                                                          moveToLocation = TRUE,
                                                          position = "topleft",
                                                          hideMarkerOnCollapse = TRUE,
                                                          textPlaceholder = "Search COE...",
                                                          autoCollapse = TRUE))
    }
  })
  })
