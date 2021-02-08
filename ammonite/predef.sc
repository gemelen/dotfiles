// Copy-paste sbt dependency into Ammonite, add forAmmonite () and run it
//
implicit class PrintImport(deps: coursierapi.Dependency) {
  def forAmmonite(mock: Any): Unit = println(s"import $$ivy.`${deps.getModule.getOrganization}:${deps.getModule.getName}:${deps.getVersion}`")
  def fetch(mock: Any): Unit = interp.load.ivy(deps)
}

// log implicits
//
interp.configureCompiler(_.settings.XlogImplicits.value = true)
