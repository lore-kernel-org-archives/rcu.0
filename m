Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262781;
	b=zAriGQJjAXMpzBL9YWgmw6uOlScceSyJS97KS74WQ4g8X3CVBB19zfCVhq9xNqhBl4/G
	 0lhs7GI/N/MeMJkzcTxOWE8HeQSELlJqUL5MQ1JmI4skrAUgKx82dQYs7wJ6kw7/olckG
	 /HxWdMEVdUw0jgu6+sIadOynEkj8KHHLdq5vX7foGdz5CCpu72mlO3fc7670AlLU3ZvnL
	 yPQxdSNlBF6wBYEgTyPtdS+4qWkD+XDusar+rYe4CyU2NzCCF9lgYeKOJpGV2YusPmlWk
	 eblTqNlIVX+KOQQGzWXwMsmNCTnMfsQBaLD/YWZJbXiIULugxamx0qtiHEis3l0Yfuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262781;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ieIwxx7aww9l648mtXdPCLcHQjOhw/DTkMOJRAxpEdU=;
	b=KQtPl7mNjNEMl8jq0iw3ru08Ykh8U5EZzAxqK5nAAeySuCL9kj4rGweak6NDw3bxGMBB
	 5YaY2WxCRis8SicsHJl30BQGFsEqCv3wv4YXukSB0EATltpQmZPafYqnVovglLXci7eoT
	 YbGJt74nhaU54wS/MqxnRPnx794FwoiVu7z/BqRt1XpoQUjOkNJVos79pLkcM6pOb4pxw
	 Dlau+fKZxjhvixyL1TY4DdF/0znCqiy77M2SOHxRe4E9vCKl30PHCtRLdsPquskv8HPJ1
	 twyN6BldBgIZIoLiy6Ba38hfAtanaDOpFBm+fPWphgk8PEbsZKyP/fJ/fjWISf0xXdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+bYfXyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66039606A333;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y+bYfXyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E27E1F008BD;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262781;
	bh=ieIwxx7aww9l648mtXdPCLcHQjOhw/DTkMOJRAxpEdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+bYfXygzrAg1w+bc2WSLfp4zREsjCyng7vmt0NA15o8TNEWFwv06x4Ox603qRNfP
	 ghiMeBVqkt8B0GEuod5EtISRjJoZYUDbYjqRb0Jx91kXVKNiHJ0gL7+jLRZdh9jp6X
	 YKs4Nduweee/eznd/Y1T6hZwkf8F2PWIfxkHsQx5870F+KJHtIQgFcoRd90DUzJecU
	 fdoYbExtHVqD3AVGMAIXYphQCZdaqUMwlJQwOCoiwARI1m6YWwvTlKQkkHF2HEc2GG
	 UsICsVgkT3QHstXV4v9UHt88LmwKMrIp6s4EKrr7qL/I9/qg7gZNcw44fzK8Do6dXH
	 bTe9xF7vPHGvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B3FA2CE0F2E; Mon,  9 Nov 2026 14:19:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/8] Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor test
Date: Mon,  9 Nov 2026 14:19:35 -0800
Message-Id: <20261109221939.2070171-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
References: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

If the synchronize_srcu_atomic() fastpath instead places its lock scan
before the grace-period anchor, the scan can miss a reader whose
increment was already visible before the anchor.  That reader already
existed when the grace period started, so completing the grace period
without waiting for it would violate the SRCU grace-period guarantee.

This litmus test models the reversed ordering, with the lock scan placed
before the grace-period anchor.  "seq" models the grace-period anchor in
->srcu_gp_seq and "ctr" models the per-CPU ->srcu_ctrs[].srcu_locks
counter.  P0 scans the lock counter before writing the anchor, with an
smp_mb() between them.  P1 models the reader-side counter increment.
P2 models an observer that sees the reader's increment before seeing
the anchor.

The same outcome is allowed with this ordering, and herd7 reports
"Sometimes".  The litmus-tests README is also updated to describe both
SRCU fastpath tests.

Tested with herd7 7.58 using linux-kernel.cfg.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/README             | 19 +++++++
 .../SRCU-fastpath-scan-before-anchor.litmus   | 52 +++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 6c666f3422ea3..4d4ec9c6f2cc7 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -78,3 +78,22 @@ RCU+sync+read.litmus
 RCU+sync+free.litmus
     Both the above litmus tests demonstrate the RCU grace period guarantee
     that an RCU read-side critical section can never span a grace period.
+
+SRCU (/srcu directory)
+----------------------
+
+SRCU-fastpath-anchor-before-scan.litmus
+    This models the synchronize_srcu_atomic() fastpath with the
+    grace-period anchor ordered before the lock-counter scan.  This
+    ordering prevents readers that existed before the grace period
+    from being missed by the scan.  See
+    SRCU-fastpath-scan-before-anchor.litmus for the reversed
+    ordering.
+
+SRCU-fastpath-scan-before-anchor.litmus
+    This models the synchronize_srcu_atomic() fastpath with the
+    lock-counter scan ordered before the grace-period anchor.  This
+    permits the scan to miss readers that existed before the grace
+    period, violating the SRCU grace-period guarantee.  See
+    SRCU-fastpath-anchor-before-scan.litmus for the opposite
+    ordering.
diff --git a/Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus b/Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus
new file mode 100644
index 0000000000000..7df0641b5470f
--- /dev/null
+++ b/Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus
@@ -0,0 +1,52 @@
+C SRCU-fastpath-scan-before-anchor
+
+(*
+ * Result: Sometimes
+ *
+ * If the synchronize_srcu_atomic() fastpath instead places its lock
+ * scan before the grace-period anchor, the scan can miss a reader whose
+ * increment was already visible before the anchor.  That reader already
+ * existed when the grace period started, so completing the grace period
+ * without waiting for it would violate the SRCU grace-period guarantee.
+ *
+ * This litmus test models the reversed ordering, with the lock scan
+ * placed before the grace-period anchor.  "seq" models the grace-period
+ * anchor in ->srcu_gp_seq and "ctr" models the per-CPU
+ * ->srcu_ctrs[].srcu_locks counter.  P0 scans the lock counter before
+ * writing the anchor, with an smp_mb() between them.  P1 models the
+ * reader-side counter increment.  P2 models an observer that sees the
+ * reader's increment before seeing the anchor.
+ *
+ * The same outcome is allowed with this ordering, and herd7 reports
+ * "Sometimes".  See SRCU-fastpath-anchor-before-scan.litmus for the
+ * opposite ordering, which forbids this outcome.
+ *)
+
+{}
+
+P0(int *seq, int *ctr)
+{
+	int r2;
+
+	r2 = READ_ONCE(*ctr);
+	smp_mb();
+	WRITE_ONCE(*seq, 1);
+}
+
+P1(int *ctr)
+{
+	WRITE_ONCE(*ctr, 1);
+}
+
+P2(int *seq, int *ctr)
+{
+	int r3;
+	int r4;
+
+	r3 = READ_ONCE(*ctr);
+	smp_mb();
+	r4 = READ_ONCE(*seq);
+}
+
+filter (0:r2 = 0)
+exists (2:r3 = 1 /\ 2:r4 = 0)
-- 
2.40.1

