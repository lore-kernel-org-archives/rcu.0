Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC223314B;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631892; cv=none; b=m+TRRHB+aGz5fIEyw9YGgPbmZDSyprzrmhzOckeiO8bN1gye8PeBo4gXETj38TgP1vWRpDBhDHVfCrjE7IFo9DvRSdaTqCbie0rYb/4D94R6MGloUTcKYJj/q3LnWN9QUEXD+cSZmzI4fFrbjD2P8OzN81VPaLmh8j5PYi1MXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631892; c=relaxed/simple;
	bh=77AYLHKjJDUAxlPSNSjE5Yx8FldJR4VJKjnY8y5KFC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glNHExND8i3Wmunv00L1lTO64p3H52iZ74ivssblO0yHsk1bV/oBlbeAiVE2Xgg4LKMGW6/D//3+9qiVvTBwJMqo6eGGMdUvNRa3SLCL4ptmnZz1Qb8O7XPluGIknzYyp4EnEjIjZztRCP8prmIWv3drIqyz20EJ1Ji/On6rGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8NzDphX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8NzDphX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2665C4CEE5;
	Mon, 10 Mar 2025 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631891;
	bh=77AYLHKjJDUAxlPSNSjE5Yx8FldJR4VJKjnY8y5KFC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8NzDphXo/nNkSy2eE9KbOus63p6o6k/4t1IVYntijYbmyxZJlVJ2lX3dtAU41WeM
	 OLLR6SREBaAvk1MWsGMqCErLVHdM/CmaJ9Vj+Vif2CHNER9hb3BuZTCJeDQgpVP4xw
	 JwHYOM9emfgViENCO1xd6Ijvjt0zFjGcNogIRWaQ8WNGjKVURkhWttDS8qRXyvafUA
	 HInMTI/wluAjpPCG5O7v7FcGCpDRptgfQrTKTR7EMRmirja357w7S+TlHYX/7+N2dP
	 UqIymHEnO86xnuKklz9D6sqf12qlLVA0iTAiXqLc67ombhVHtYM1/c19ST1Hm1gN+3
	 WNOMrYvdWpCHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8DBAACE079A; Mon, 10 Mar 2025 11:38:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/9] rcutorture: Make srcu_lockdep.sh check kernel Kconfig
Date: Mon, 10 Mar 2025 11:38:01 -0700
Message-Id: <20250310183809.3576320-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The srcu_lockdep.sh currently blindly trusts the rcutorture SRCU-P
scenario to build its kernel with lockdep enabled.  Of course, this
dependency might not be obvious to someone rebalancing SRCU scenarios.
This commit therefore adds code to srcu_lockdep.sh that verifies that
the .config file has lockdep enabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/srcu_lockdep.sh  | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 2db12c5cad9c6..b94f6d3445c6c 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -39,8 +39,9 @@ do
 	shift
 done
 
-err=
 nerrs=0
+
+# Test lockdep's handling of deadlocks.
 for d in 0 1
 do
 	for t in 0 1 2
@@ -52,6 +53,12 @@ do
 			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x2" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
 			ret=$?
 			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
+			if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
+			then
+				echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
+				nerrs=$((nerrs+1))
+				err=1
+			fi
 			if test "$d" -ne 0 && test "$ret" -eq 0
 			then
 				err=1
@@ -71,6 +78,8 @@ do
 		done
 	done
 done
+
+# Set up exit code.
 if test "$nerrs" -ne 0
 then
 	exit 1
-- 
2.40.1

