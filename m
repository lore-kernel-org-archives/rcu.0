Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A5411F99;
	Wed,  7 Oct 2026 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407052; cv=none; b=hVFdyAPIq12Fxkm/VW9pwG4BMYBp5u9T9aozmgSPq2jFkuq6z3DWxMix/dYamkhvhdmVwbRsnuzVQrAZW0jhWcjGRrRLT0iA0vtcxDb1JQYcOHj/3ZBZGM41aflQQkQ92SXRn/j1uygrzZu1v1bRFayWScWr7yOkPJN/HeC4VHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407052; c=relaxed/simple;
	bh=EmlqCPFp6yCKH206XrZUaVN0nSPm3wNy+Wxsh1W0cSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSIov2+Haz1uYPZOkJozgn9n/WwgkMUhQq2W2WPcHOyYKVkml0SlVp3SA1XDLKuCI/KPadTE3tB1VOaIaGoz1pkjoOTRhvjOzTN/weEsBlHKYEAA6naYqMjHO7Scw5q2UlmSbFEozIwB3YI+vkf+WrxAxA0n/DiNlsVNzGDTSxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2TLq9F4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2TLq9F4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFDD1F0089E;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407049;
	bh=QU+32ULDBUw8n1Gfzs6k/QOe3NCDVN4b2Vn9bzl9Wx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2TLq9F4fuBXfw7PU8sKRYoq6z5Zov6bELzjNIUqyXU0vHN0Bt3rg52ezlgOA3nSY
	 GLS82PZ09N25Dc1h9HeKJRNNTgQVcyYrl+6x7cNLhTuO0FKFiScoKDkN84pgI5G3aA
	 o82pbXiooSDD6iRCogYLe619ToePFeqaAFP6s7uGL2Q/0wvGcJebRrvJ0FcWjITH/A
	 XcEngeervwJIyb1CkejdGdYPVwTzU1hGPjxAWgjkdUwEFfmBseuPUMtcINafYfhuO8
	 IzX3eUAdCu4stgoZpJKQqJ6HIxgI6CIzHHTJHzGXYVSe8JaVuKQitXONBkwx0lGEYS
	 qFzQp3fSY96Ng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5D2D7CE2724; Wed,  7 Oct 2026 14:04:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 6/8] selftests/rcutorture: Wire atomic SRCU into srcu_lockdep.sh
Date: Wed,  7 Oct 2026 14:04:06 -0700
Message-Id: <20261007210408.1983713-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
References: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Add testtypes 4 (atomic SRCU same-type deadlock) and 5 (atomic SRCU
+ raw_spinlock dependency cycle) to the deadlock-detection loop.
Add a separate loop for testtype 6 (rcu_read_lock() →
synchronize_srcu_atomic()), which also verifies via console.log that
no lockdep warning is triggered.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/srcu_lockdep.sh  | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 4e98c697def48..72791499dd96b 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -44,7 +44,7 @@ nerrs=0
 # Test lockdep's handling of deadlocks.
 for d in 0 1
 do
-	for t in 0 1 2
+	for t in 0 1 2 4 5
 	do
 		for c in 1 2 3
 		do
@@ -79,6 +79,43 @@ do
 	done
 done
 
+# Verify that synchronize_srcu_atomic() does not trigger lockdep
+# warnings when called inside rcu_read_lock().
+for c in 1 2 3
+do
+	err=
+	val=$((6*10+c))
+	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s \
+		--configs "SRCU-P" \
+		--kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" \
+		--bootargs "rcutorture.test_srcu_lockdep=$val" \
+		--trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+	ret=$?
+	mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
+	if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
+	then
+		echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING" \
+				"disabled in rcutorture SRCU-P scenario"
+		err=1
+	fi
+	if test "$ret" -ne 0
+	then
+		err=1
+		echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+	elif grep -qE "WARNING: possible (recursive locking|circular locking dependency)" \
+		"$RCUTORTURE/res/$ds/$val/SRCU-P/console.log"
+	then
+		err=1
+		echo -n Unexpected lockdep warning for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+	fi
+	if test -n "$err"
+	then
+		grep "rcu_torture_init_srcu_lockdep: test_srcu_lockdep = " "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log" | sed -e 's/^.*rcu_torture_init_srcu_lockdep://' >> "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+		cat "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+		nerrs=$((nerrs+1))
+	fi
+done
+
 # Test lockdep-enabled testing of mixed SRCU readers.
 for val in 0x1 0xf
 do
-- 
2.40.1

