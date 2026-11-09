Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262782;
	b=GNikkyBT0wKO+aBDhbyVMYIkmKfeAJfUk0egUGP3z70LmdceCbs0JhZ4d/LZX8QIRujT
	 QNUuscG784O9izWWSf79vuWew6loeMI6Muw5wxTmu4w9PmbXYqwJrJVSRc3trk7yQKDDJ
	 CkdwZmKeUeYHZfhDGNhTQVmwvpoFCxOaifgvpe6bhk1kIQVd4QvR0mevgskIndtfqYKb1
	 fmVv0mhSfw13vfwPpEi49HTukULYlYMxKiZjU6DkpcY5iZlshOZ/yc9BzPWtopyDFYWms
	 9tAD6OcFUJK/zQrTI2oJtJcDFyoBKLk3D9U5R4ervL69KWlXHUYabyZuw6DUEClyDEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262782;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Et4eyKxXxi9SYlXDL4SLt6lldc+qOrUFmEuC6N77CQ=;
	b=ViLNdABhBnQZ/Abmq6G4KWN7R+Uw/xw0JNldmHE9pUg64ocPwYCIieTMFr9eRQwUeh9A
	 Ry8WrFcMXfhQI9XknAOZs+BG0H8nuYkcO4zFpCVWm5jdDfTKFmxEqf4ms0B5GEY0uj3CN
	 8DvQHsD6YHsEbKx6tX3NOK5HDiyfqv1kMn0rmvarOrd34ZbtzI9eELYtOV9Sx9Hlyehmf
	 EAfd3kbrddwJifq0omU6gPi+a1rh/jCOhbezRTezQ9c+bIm/emembsXNhJtAvVm9YPC7U
	 UmH7N98e5N0Pmd46QXlF/dYLf+P5gGd1NVkx1se8Go2icwFnuDYZuOn1Q+TeUbVyClQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbmDFp8v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3B606A330;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbmDFp8v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069251F008A7;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262781;
	bh=3Et4eyKxXxi9SYlXDL4SLt6lldc+qOrUFmEuC6N77CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AbmDFp8voeKORZWXz1pEZqCMoXY7l4FfMB09qjJ964cs1wsGPzHwce4OpxhPFc6LH
	 rMC/f/8Nk4QNqkhhaxNcq1/aOpmvj6PJMjpzfgQ8+mZC6OmM/ZIn+TI16J8XctP3EE
	 gSgQRAeNKuAnR/lAGZa7ADImpjk0InU0oSCjwspnxam6I+yHCLjT2p4twoqUcwIRbx
	 oSqJwSYBnxLaZOrJvsNSk5qqUNAsroCoCRa/H39KUzYVqSGNyvjVIpZZTKO5yrO4IV
	 NEXOwWLMWnNStdnmhPFhWSmhq4PZDGaPwWKl/ZT6CUpUXKy/v+D0UWxS1gLrHJD3wE
	 0sEy/JbN6ossA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B149ECE0EE0; Mon,  9 Nov 2026 14:19:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/8] Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan test
Date: Mon,  9 Nov 2026 14:19:34 -0800
Message-Id: <20261109221939.2070171-3-paulmck@kernel.org>
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

synchronize_srcu_atomic() may end its grace period immediately when
its scan of the per-CPU lock counters finds no readers.  Correctness
requires the grace-period anchor written by srcu_gp_start() to precede
the smp_mb() ordering the lock scan.  This ordering ensures that any
reader whose lock increment is missed by the scan cannot have
incremented its lock counter before the grace-period anchor, and
therefore cannot be a pre-existing reader of this grace period.

This litmus test models the key ordering between the grace-period
anchor and the lock counter scan, where "seq" models the
grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
smp_mb() and the lock scan.  P1 models the reader-side counter
increment.  P2 models an observer that sees the reader's increment
before seeing the anchor.

The outcome is forbidden by LKMM, and herd7 reports "Never".  See
SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
which permits this outcome.

Tested with herd7 7.58 using linux-kernel.cfg.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../SRCU-fastpath-anchor-before-scan.litmus   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus

diff --git a/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
new file mode 100644
index 0000000000000..8028f2ade733d
--- /dev/null
+++ b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
@@ -0,0 +1,55 @@
+C SRCU-fastpath-anchor-before-scan
+
+(*
+ * Result: Never
+ *
+ * The synchronize_srcu_atomic() fastpath may end its grace period
+ * immediately when its scan of the per-CPU lock counters finds no
+ * readers.  Correctness requires the grace-period anchor written by
+ * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
+ * This ordering ensures that any reader whose lock increment is missed
+ * by the scan cannot have incremented its lock counter before the
+ * grace-period anchor, and therefore cannot be a pre-existing reader
+ * of this grace period.
+ *
+ * This litmus test models the key ordering between the grace-period
+ * anchor and the lock counter scan, where "seq" models the
+ * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
+ * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
+ * smp_mb() and the lock scan.  P1 models the reader-side counter
+ * increment.  P2 models an observer that sees the reader's increment
+ * before seeing the anchor.
+ *
+ * The outcome is forbidden by LKMM, and herd7 reports "Never".  See
+ * SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
+ * which permits this outcome.
+ *)
+
+{}
+
+P0(int *seq, int *ctr)
+{
+	int r2;
+
+	WRITE_ONCE(*seq, 1);
+	smp_mb();
+	r2 = READ_ONCE(*ctr);
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

