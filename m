Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89640FD9B;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407051; cv=none; b=SDFzDyF9JvkL9xpGU0rvI7B5MB0FAKD2cY5RePV/Kp0WIpmUiem+8zEnYmPnK67ND7Ll3dj2pQXJUxPA4NF2Tfp+kreGj8GDMRA+tZXy+MGr684pnUGjQIaEqAVc0fa5OvwndSLINmYPXjYSRz7FMBtePrxrmdioBkaC8cfjkA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407051; c=relaxed/simple;
	bh=oJIHJ+z4tZ6+hkFkS1+/2XXJJ5MyCooor3V2AZYN6+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmPbUImuCfUfHzCvAtEgPKSXsyuInzRV8JCGmHTYKCoITpbQ1cEncPNj9BHdODhsHkXWqgoyK3pt2vzNu5JNxu0ubWA/zVWU0jp2DR518KGH5G9lvTYDNNsoQkT3G1N5qHF+kDtUT2urw8v7lDM1upXKoUq58IQbwjIt9AUIK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfIOHlrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfIOHlrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF4D1F00899;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407049;
	bh=Ne9BOFbSMUw42loHLJcaipGKKqg9l7oH73ciTuvEmfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfIOHlrKAMsH+dear2zqtQP3sKeMTusJ7uxqMPQD7dqu0CT6QUyQtGEcBWmJuX2sw
	 gyrLn1XTCQBXzCdE5Bqr43pqJJZSCZLCIP/wEiGQyceoJrlDGr07pjxwrZtKwkOnks
	 oZXFe5vgIsZZWSvNB0GLU4QHgJ1SDHOzB/n3hbD3/1HGR/6zWbqiAc3rbRxh+P0uBE
	 S//QV1fqTkLgtB++YS4isNP1GGF94rGJ9pFRljoOGndlHi1JIMoPY1gyRVPZgCxEna
	 7laOfC4FSEI7FlSxQVySKoPZAwEiXyr6QfBdldAaF+20kvGWbxT5aRh7KePb+cfkfk
	 uAVVL8lWObgzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5522CCE1735; Wed,  7 Oct 2026 14:04:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 3/8] torture:  Allow specifying alternative ssh command to kvm-remote.sh
Date: Wed,  7 Oct 2026 14:04:03 -0700
Message-Id: <20261007210408.1983713-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
References: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
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
index 48a8052d5dae3..a8397f86e49dc 100755
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

