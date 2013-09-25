import com.dscleaver.sbt.SbtQuickFix.QuickFixKeys._

resolvers += Resolver.sonatypeRepo("releases")

addCompilerPlugin("org.brianmckenna" % "wartremover" % "0.4" cross CrossVersion.full)

scalacOptions ++= Seq("-encoding", "utf8", "-target:jvm-1.6", "-deprecation", "-feature", "-unchecked", "-Xlog-reflective-calls", "-Ywarn-adapted-args", "-P:wartremover:traverser:org.brianmckenna.wartremover.warts.Unsafe")

vimEnableServer := false
