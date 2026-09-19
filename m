Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F273164B7;
	Sat, 19 Sep 2026 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778241; cv=none; b=QKbWI3CaCl87SqMaqSJ4vGzQWnKSwg+xpuufn3qQxjdEOgOA4gk6AJJD5/t1wQkyZp8HrMJcXU7GjK5F4YB/1ZpSOSFs3xV6GUgaYwG5jvYDHwLrd3TSa9gFxdejh3caci5ftdX8WImHp7Z8ykUfRtCc9CasljLuXFX8mdePqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778241; c=relaxed/simple;
	bh=jzYj/9GytYa4D4Xf5PlhYm8fh2+ECkLvvvA9zPeH8Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j1nR5c1WyJ2jH4IKq/GgP58zNpkc9g0mjBFLFoGflMgXRReviiT+79eicnqEcPA2gGTXgj1ZIetjWYOy9F6CDQUlenqbFBM2bDle7X/cLX75QQ4jqpxvs3AQL4a5w0DNb9jIE2c9mnO+4GWJR9ysUzrjNBPSCMSOnu5cpCom8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPzOVgGN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPzOVgGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C228F1F00899;
	Sat, 19 Sep 2026 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778239;
	bh=+Ze4F/gsALayP+EUcv1giEsWJO6Vr9f7rxAhQt9e9eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aPzOVgGNciJ1CwqVKOCsHwykbP4nejtMysioW8JsILM5h63qz3QzP1c9oseUHon0z
	 W7dPk3shCM+2ZDQUEo/JMd+Itd+zrWm8TxKXuxKsSS/TqdYT2S6hkEwo3H6R1qY1w4
	 OLMR9C+htAy4e93KdhJfjL+FDRJSb+/FaTPpGgzR3CbBzn4YGDOo6ip2Bj7tXI9sA0
	 CwQdJ/aD2jKlkJlQGfg8FelCE3SHzmIGlh1rwfzZcDVB61gIPWo37QN4XhCXmql0xK
	 tRULPsD6pbBK+4dK+2HXukf2O745inNZ9XasBw7oFaTeT2t+v3A9bdG9/kEWG3fzLO
	 fKrE6E/xp/0gQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8228ACE17BD; Fri, 18 Sep 2026 17:37:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/3] torture:  Allow specifying alternative ssh command to kvm-remote.sh
Date: Fri, 18 Sep 2026 17:37:17 -0700
Message-Id: <20260919003717.3134738-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <860880d0-fb46-4039-a47c-33dd42a215d1@paulmck-laptop>
References: <860880d0-fb46-4039-a47c-33dd42a215d1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some environments require use of alternative commands to access the
test hosts.  This commit therefore adds a KVM_REMOTE_SSH environment
variable for this purpose.  If this variable is unset, ssh is used.
Any alternative ssh command must support the usual ssh arguments,
including the command to be executed remotely.  In some cases, you may
need a wrapper script to make the alternative ssh-like command look
enough like ssh to satisfy kvm-remote.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-remote.sh    | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 48a8052d5dae..a8397f86e49d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -6,6 +6,11 @@
 # Usage: kvm-remote.sh "systems" [ <kvm.sh args> ]
 #	 kvm-remote.sh "systems" /path/to/old/run [ <kvm-again.sh args> ]
 #
+# The caller may set the KVM_REMOTE_SSH environment in order to specify
+# an alternative ssh command, which is necessary in some environments
+# for authentication purposes.  This alternative ssn command must support
+# ssh's usual arguments.
+#
 # Copyright (C) 2021 Facebook, Inc.
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
@@ -13,6 +18,11 @@
 scriptname=$0
 args="$*"
 
+if test -z "${KVM_REMOTE_SSH}"
+then
+	KVM_REMOTE_SSH=ssh; export KVM_REMOTE_SSH
+fi
+
 if ! test -d tools/testing/selftests/rcutorture/bin
 then
 	echo $scriptname must be run from top-level directory of kernel source tree.
@@ -137,7 +147,7 @@ chmod +x $T/bin/kvm-remote-*.sh
 # Check first to avoid the need for cleanup for system-name typos
 for i in $systems
 do
-	ssh -o BatchMode=yes $i getconf _NPROCESSORS_ONLN > $T/ssh.stdout 2> $T/ssh.stderr
+	${KVM_REMOTE_SSH} -o BatchMode=yes $i getconf _NPROCESSORS_ONLN > $T/ssh.stdout 2> $T/ssh.stderr
 	ret=$?
 	if test "$ret" -ne 0
 	then
@@ -158,14 +168,14 @@ echo Build-products tarball: `du -h $T/binres.tgz` | tee -a "$oldrun/remote-log"
 for i in $systems
 do
 	echo Downloading tarball to $i `date` | tee -a "$oldrun/remote-log"
-	cat $T/binres.tgz | ssh -o BatchMode=yes $i "cd /tmp; tar -xzf -"
+	cat $T/binres.tgz | ${KVM_REMOTE_SSH} -o BatchMode=yes $i "cd /tmp; tar -xzf -"
 	ret=$?
 	tries=0
 	while test "$ret" -ne 0
 	do
 		echo Unable to download $T/binres.tgz to system $i, waiting and then retrying.  $tries prior retries. | tee -a "$oldrun/remote-log"
 		sleep 60
-		cat $T/binres.tgz | ssh -o BatchMode=yes $i "cd /tmp; tar -xzf -"
+		cat $T/binres.tgz | ${KVM_REMOTE_SSH} -o BatchMode=yes $i "cd /tmp; tar -xzf -"
 		ret=$?
 		if test "$ret" -ne 0
 		then
@@ -191,7 +201,7 @@ checkremotefile () {
 
 	while :
 	do
-		ssh -o BatchMode=yes $1 "test -f \"$2\""
+		${KVM_REMOTE_SSH} -o BatchMode=yes $1 "test -f \"$2\""
 		ret=$?
 		if test "$ret" -eq 255
 		then
@@ -239,7 +249,7 @@ startbatches () {
 		then
 			continue # System still running last test, skip.
 		fi
-		ssh -o BatchMode=yes "$i" "cd \"$resdir/$ds\"; touch remote.run; PATH=\"$T/bin:$PATH\" nohup kvm-remote-$curbatch.sh > kvm-remote-$curbatch.sh.out 2>&1 &" 1>&2
+		${KVM_REMOTE_SSH} -o BatchMode=yes "$i" "cd \"$resdir/$ds\"; touch remote.run; PATH=\"$T/bin:$PATH\" nohup kvm-remote-$curbatch.sh > kvm-remote-$curbatch.sh.out 2>&1 &" 1>&2
 		ret=$?
 		if test "$ret" -ne 0
 		then
@@ -281,7 +291,7 @@ do
 		if test "$ret" -eq 1
 		then
 			echo " ---" Collecting results from $i `date` | tee -a "$oldrun/remote-log"
-			( cd "$oldrun"; ssh -o BatchMode=yes $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval */qemu-affinity; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
+			( cd "$oldrun"; ${KVM_REMOTE_SSH} -o BatchMode=yes $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval */qemu-affinity; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
 			break;
 		fi
 		if test "$ret" -eq 255
-- 
2.40.1

