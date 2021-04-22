in_repeater <- function(.field, .values) {
  temp <- sapply(.values, function(x) {
    paste0("%27", x, "%27,")
  })
  temp <- paste0(unlist(temp), collapse ="")
  paste0(.field, "%20in%20(", substr(temp, 1, nchar(temp) - 1), ")")
}
checkmark <- function(x) {
  sapply(x, function(y) ifelse(y != "Yes" | is.na(y),  "N/A", "<span>&#10003;</span>"))
}
get_extended_esca_ownership <- function(.df, .coe) {
  sapply(.df[[.coe]], function(y) {
    if (length(unlist(strsplit(.df[.df[[.coe]] == y, ][["land_holder"]], ","))) > 1) {
      paste0("<details><summary>",
             .df[.df[[.coe]] == y, ][["land_holder"]],
             "</summary><p>",
             .df[.df[[.coe]] == y, ][["land_holder_notes"]],
             "</p></details>")
    } else {
      paste0(.df[.df[[.coe]] == y, ][["land_holder"]])
    }
  })
}
get_extended_apn_ownership <- function(.df, .apn) {
  sapply(.df[[.apn]], function(y) {
    if (length(unlist(strsplit(.df[.df[[.apn]] == y, ][["Owner"]], ","))) > 1) {
      paste0("<details><summary>",
             .df[.df[[.apn]] == y, ][["Owner"]],
             "</summary><p>",
             .df[.df[[.apn]] == y, ][["owner_notes"]],
             "</p></details>")
    } else {
      paste0(.df[.df[[.apn]] == y, ][["Owner"]])
    }
  })
}
get_logo_image <- function(x) {
  sapply(x, function(y) {
    res <- switch(y, 
                  `County of Monterey` = "moco_logo.png",
                  `City of Monterey` = "monterey_logo.png",
                  `City of Del Rey Oaks` = "dro_logo.png",
                  `City of Seaside` = "seaside_logo.png")
    paste0("<tr><center><img src='", res, "'></center></tr>")
  })
}
get_ordinance_row <- function(x) {
  sapply(x, function(y) {
    res <- switch(y, 
                  `County of Monterey` = "https://library.municode.com/ca/monterey_county/codes/code_of_ordinances?nodeId=TIT16EN_CH16.10DIEXFOFOOR",
                  `City of Monterey` = "https://monterey.municipal.codes/Code/9-73",
                  `City of Del Rey Oaks` = "https://library.municode.com/ca/del_rey_oaks/codes/code_of_ordinances?nodeId=TIT15BUCO_CH15.48DIEXFOFOOR_15.48.060PEPR",
                  `City of Seaside` = "https://www.codepublishing.com/CA/Seaside/html/Seaside15/Seaside1534.html")
    paste0("<tr><th><b>Digging and Excavation Ordinance: </b></th><td>",
           "<a href='", res, "' target ='_blank', id = 'link'> Here </a></td></tr>")
  })
}
get_metal_row <- function(x) {
  sapply(x, function(y) {
    res <- switch(y, 
                  `County of Monterey` = NULL,
                  `City of Monterey` = NULL,
                  `City of Del Rey Oaks` = NULL,
                  `City of Seaside` = "https://www.ci.seaside.ca.us/DocumentCenter/View/11248/2020-07-16-Seaside-Ordinance-1093---metal-detection-probition?bidId=")
    if (!is.null(res)) {
      paste0("<tr><th><b>Metal Detecting Ordinance: </b></th><td>",
             "<a href='", res, "' target ='_blank, id = 'link''> Here </a></td></tr>")
    } else("")
  })
}
