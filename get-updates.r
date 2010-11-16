#-  R source code

#-  get-updates.r ~~
#                                                           ~~ SRW, 15 Nov 2010

library(rjson)

user_pkgs <- (function() {
  pkg <- as.data.frame(installed.packages(), stringsAsFactors = FALSE)
  pkgs <- pkg$Version
  names(pkgs) <- pkg$Package
  as.list(pkgs)
})()

repo_pkgs <- (function() {
  webfile <- "http://updatr.couchone.com/testing/_design/latest/pkg-info.json"
  pkgs <- fromJSON(file = webfile)
})()

common <- intersect(names(user_pkgs), names(repo_pkgs))

updates <- (function() {
  for (i in 1:length(common)) {
    pkg <- common[[i]]
    user <- user_pkgs[common][[i]]
    repo <- repo_pkgs[common][[i]]
    if (user != repo) {
      cat("Update available:", pkg, repo, "( you have", user, ")\n", sep = " ")
    }
  }
})()

#-  vim:set syntax=r:
