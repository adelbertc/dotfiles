import com.dscleaver.sbt.SbtQuickFix.QuickFixKeys._

scalacOptions ++= Seq("-encoding", "utf8", "-target:jvm-1.6", "-deprecation", "-feature", "-unchecked", "-Xlog-reflective-calls", "-Ywarn-adapted-args")

vimEnableServer := false
