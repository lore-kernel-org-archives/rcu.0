Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB01DD9AD;
	Thu, 12 Dec 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029560; cv=none; b=Nv41HigzeM0J7mCf5oRdSOgHxTKQyh1+WVJBb49BUDqe/WMFN/c5cIsdSRgYaSI6Od0AU1AJa84wajt9xH/y6wNHMQRTVyesbyneGNsE6g2pJ4+IwP3BiVlGN8Ib2SajVAfkH+jxkZViDDH6b0KXEePSR3Ot0Qj3uLpjbIyhgE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029560; c=relaxed/simple;
	bh=frg43N4ckiQR94bt8W5L/f0AOwfPLrqry/O4FX4x8DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vD+exph5Ezr8mYUaecPU0DssgQokjLB3jaypPNT5s6DeRlQLyX0jB5WxJJwQ/SGYHbXQjstgT8C2aWq3p/lEqVe1lJ/r+/QgodX2Jv/Cp0YrVH6V548FXkncQfVCMxcsOGqAYPTyUTb7g8iJil6avDaUV7y5jREMbPVjCOutraU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwdyBtpZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwdyBtpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50230C4CED1;
	Thu, 12 Dec 2024 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029560;
	bh=frg43N4ckiQR94bt8W5L/f0AOwfPLrqry/O4FX4x8DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwdyBtpZVwqggpuPx0Q2iR0iqEjqV8+xHw0Oydwlx7pGgDwSSyBDGd7C6Dlaeij1z
	 5eDEkvCrQn8Tluf2V5k2FuhPZpvEztCFgONzbd49dTh0i/i0XFt5IoW96+Y7gkFUN4
	 soK3Mrqylyfj91zPLGqZ3e49g0iHs3sJHDxPRXn69WVm1FNG/2/8q8Othy/zPflXIZ
	 3DpxUSODHb1at6oEtA61mllqJfZEoq+VK0n0tu73OcNxcEajhA7lB2lAmTIjt4D7hR
	 Uq+PguwzDd9dtczOABQqiJQu+s4AW1ldAQmoByXtMHOXiDwv2bgMn/czwuhfagRc19
	 /HFt4OhnifRaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0CE08CE0F78; Thu, 12 Dec 2024 10:52:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/2] torture: Make kvm-remote.sh give up on unresponsive system
Date: Thu, 12 Dec 2024 10:52:38 -0800
Message-Id: <20241212185238.2207771-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9bb99e2-4369-4ff1-9ec7-4a403a0f496e@paulmck-laptop>
References: <f9bb99e2-4369-4ff1-9ec7-4a403a0f496e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a system that stops responding at the wrong time will hang
kvm-remote.sh.  This can happen when the system in question is forced
offline for maintenance, and there is currently no way for the user
to kick this script into moving ahead.  This commit therefore causes
kvm-remote.sh to wait at most 15 minutes for a non-responsive system,
that is, a system for which ssh gives an exit code of 255.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-remote.sh    | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index 134cdef5a6e08..48a8052d5dae3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -181,10 +181,11 @@ done
 
 # Function to check for presence of a file on the specified system.
 # Complain if the system cannot be reached, and retry after a wait.
-# Currently just waits forever if a machine disappears.
+# Currently just waits 15 minutes if a machine disappears.
 #
 # Usage: checkremotefile system pathname
 checkremotefile () {
+	local nsshfails=0
 	local ret
 	local sleeptime=60
 
@@ -195,6 +196,11 @@ checkremotefile () {
 		if test "$ret" -eq 255
 		then
 			echo " ---" ssh failure to $1 checking for file $2, retry after $sleeptime seconds. `date` | tee -a "$oldrun/remote-log"
+			nsshfails=$((nsshfails+1))
+			if ((nsshfails > 15))
+			then
+				return 255
+			fi
 		elif test "$ret" -eq 0
 		then
 			return 0
@@ -268,12 +274,23 @@ echo All batches started. `date` | tee -a "$oldrun/remote-log"
 for i in $systems
 do
 	echo " ---" Waiting for $i `date` | tee -a "$oldrun/remote-log"
-	while checkremotefile "$i" "$resdir/$ds/remote.run"
+	while :
 	do
+		checkremotefile "$i" "$resdir/$ds/remote.run"
+		ret=$?
+		if test "$ret" -eq 1
+		then
+			echo " ---" Collecting results from $i `date` | tee -a "$oldrun/remote-log"
+			( cd "$oldrun"; ssh -o BatchMode=yes $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval */qemu-affinity; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
+			break;
+		fi
+		if test "$ret" -eq 255
+		then
+			echo System $i persistent ssh failure, lost results `date` | tee -a "$oldrun/remote-log"
+			break;
+		fi
 		sleep 30
 	done
-	echo " ---" Collecting results from $i `date` | tee -a "$oldrun/remote-log"
-	( cd "$oldrun"; ssh -o BatchMode=yes $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu[_-]pid */qemu-retval */qemu-affinity; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
 done
 
 ( kvm-end-run-stats.sh "$oldrun" "$starttime"; echo $? > $T/exitcode ) | tee -a "$oldrun/remote-log"
-- 
2.40.1

