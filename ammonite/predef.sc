// cats
import $ivy.`org.typelevel::cats-core:2.10.0`
import $ivy.`org.typelevel::cats-effect:3.5.3`
// circe
import $ivy.`io.circe::circe-core:0.14.1`
import $ivy.`io.circe::circe-generic:0.14.1`
import $ivy.`io.circe::circe-parser:0.14.1`
// fs2
import $ivy.`co.fs2::fs2-core:3.9.3`
import $ivy.`co.fs2::fs2-io:3.9.3`
// actual imports
import cats._
import cats.data._
import cats.syntax.all._
import cats.implicits._
import cats.effect._
import io.circe._
import io.circe.syntax._
// Copy-paste sbt dependency into Ammonite, add forAmmonite () and run it
//
implicit class PrintImport(deps: coursierapi.Dependency) {
  def forAmmonite(mock: Any): Unit = println(s"import $$ivy.`${deps.getModule.getOrganization}:${deps.getModule.getName}:${deps.getVersion}`")
  def fetch(mock: Any): Unit = interp.load.ivy(deps)
}
