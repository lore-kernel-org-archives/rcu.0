Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8652D379C5F
	for <rcu@vger.kernel.org>; Sun,  4 Oct 2026 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791076474; cv=none; b=RxdjCge+e4Z+Yz/gsPP2IyaP2joBLYJN9B3nqzfcykIWGyjiJ4bxMv3kXARjSmutysXr94xujHB2JO4ZKWt8AmYoIJMuKhC8ZqBR2lUSGdcSRzs3p1t/T8dz8UPXCv0lvq5JrSaljjDXQ1N7z1rxu7ggipbm2kNaYySBod+j1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791076474; c=relaxed/simple;
	bh=xzgGogefLIBOk20OTv5qxBNFZ6L0cQ+BPs2rO/PdlZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dXwt79D9ykCItKWiq2T6QEBDfJMhqb3aSYpWOmuemb5RXjC2ydZV15Jesw1B618UVdPmMYTuZ+D3zqnGz1+zvhCfn7IUnsZrqpPJMwFILJR9p4qh255MpFdgGs4kdYN3JM0/KXJLvq6Z0oMqha8F7Ko0hK8W+IexJ8skfw0Rrt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHpd3tM3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHpd3tM3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6e954afbdso2516135ad.2
        for <rcu@vger.kernel.org>; Sat, 03 Oct 2026 18:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791076473; x=1791681273; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=afo71om4JzqVHMhk3du9qO8MnTFC19axaFER2aBsyXU=;
        b=MHpd3tM3hgdqVns1ivtwIK0oNZs5KIVPwYRIahLi5Dj2cB/zOlOYLg4KYBlUYoMutD
         qwZK7ozm/WmKBN0cXMkCtPmKY3GbYXCPDZglaA7eX15nYtrIa/VOtr4aGvQsJzASMqgF
         5lJ5jeYVoap2bx4ZBXX9d+oVV+lsE4TOemDmpTTzI55JG9Ac6i/Gx3zX1Mf9Nfd21/iT
         ciXiTsNAkdKwAkXn95BF6tCFnPKb0ncaD6QGPxEg+O1NIqPG9XclN/08w6zrnNY3Qitz
         lyMV3XNIghU0O55ddU1Ei7npoOxk+HEpNlJCc2a1SoxQ/3b9oP71t6yLSxycO2nZRAe0
         yC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791076473; x=1791681273;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=afo71om4JzqVHMhk3du9qO8MnTFC19axaFER2aBsyXU=;
        b=oPQxCu75RTiasF5BoI+8WVg6c8w6yS4++FPY3DD/t9CTOgogBJojikDVfAJVhslU6h
         1MWng9t/NOw77GjuV/Udc6vHgHi0ItyF9StsIsBO4sZNGQpYGOY8r6KZegzG8lzfu0PU
         e/37dALUNYTBvQ/43ki5JPO268tf6b8YjEyxjTz2Grhh/zDctPlvIaXmvbSgDD5nhCWx
         H93cR56xONdR+JQPI8rcj3tG10AIqujXhzw/d/pz2TGjY9vCBrefzgE+w2mDA9098Nik
         QZT4+wo4AzIP2TPC9V9IZUJRImDDWaKP7pUdrnDY4eEHP8dZgm4zeeE4NRP2xpnEzRII
         pnmA==
X-Forwarded-Encrypted: i=1; AKwUvByp/8KYJAWte2D2uu+c+7EI7Iq/Tv7uLMmdaYjmK60eGPE9HUX4ZbMcXXSlUpxNsXwVNvc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ62UuRplWYllaCXmMilFBG9CYenIkbF1ZNTrtjOxoamSKdglPm
	oBTQsD8NzSYsYpEFRdoyasExtVNvyray11qboIo7zepu82MfQbUlybXx
X-Gm-Gg: AYBFou12ryYV9942EQ8jI1V/ovAgufqyGaCfItZ4xRB8Xv+1xoZtnomPosxblGPqOas
	2K6Uica2rGe4dJGTc5Q/jZSll/mlRySxMJgEOkQE6FyR431QB5EoNUBpzEYVfgDtMf/y3+fJW6z
	X+ZxASyV6FzeKKn0PT0DKgKsJnCaSyEdIqEFFroI+nu5w2MA4KZ2CZdfd2/kMohnSrv7pgh6cIT
	qJhT5NWoSHI2fCQDildlrEboxsFW2If2r/Ww1if3wX/wUoo1VUH19yMW97xJhSRY6BvCoDtAjUy
	FlP9ei2csEwYGswFOjQQXv35RpQd8JyeIAdxhJEafDtLaVK4lo3oOd8lkLqmqsnNMnJrMEWpbHr
	QATHEhYGH9NNgPwGnY+g66CUaszx7N/RY+w8wlLgCw0S7QJudW6sK2VtWjXzCjpaSTcRpG8Cj+D
	Ua8ZeQ2S/I92SXx8p5FgyXTARA9SaKGPc2I+Z9J/xzQVuZBVAU///w/3wHtVaALZnnGfvY
X-Received: by 2002:a17:90b:17c9:b0:3a7:250:3342 with SMTP id 98e67ed59e1d1-3a7873e0180mr3135688a91.43.1791076472717;
        Sat, 03 Oct 2026 18:14:32 -0700 (PDT)
Received: from [127.0.1.1] ([8.139.245.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4262f0sm5185311a91.4.2026.10.03.18.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 18:14:32 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
Date: Sun, 04 Oct 2026 09:14:25 +0800
Subject: [PATCH] rcu: Enable runtime reset of the RCU stall panic count
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-rcu-v1-1-3799a44367f1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHCowWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNj3aLkUl1jc1MTS7MUc3MDk1QloMqCotS0zAqwKdGxtbUAfB2241U
 AAAA=
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, Cunlong Li <shenxiaogll@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791076467; l=4559;
 i=shenxiaogll@gmail.com; s=20261003; h=from:subject:message-id;
 bh=xzgGogefLIBOk20OTv5qxBNFZ6L0cQ+BPs2rO/PdlZg=;
 b=Q6r7VhPOyJfceqTfcsRg9PrNRI7EMgRT/GI7WL36MPoqD1HlsXqXftzEf0Roj8iAJQ2QY+0qF
 Y8RXcKww1LSCOy7f2pHzqZ1e2z5aPE2LLJb6S3B/+XqJjvyROd80yaJ
X-Developer-Key: i=shenxiaogll@gmail.com; a=ed25519;
 pk=gOfQfj+CDR8dO1uRGPprj8yMOyqeLaSs21zUJZXFJtA=

The kernel.panic_on_rcu_stall and kernel.max_rcu_stall_to_panic sysctls
count RCU CPU stalls since system boot, and invoke panic() once
max_rcu_stall_to_panic stalls have elapsed.  This count is never reset,
so stalls caused by transient incidents keep consuming the budget of a
long-running system, and a later unrelated stall can immediately
trigger panic() instead of allowing the intended fresh window of
stalls.

This commit therefore introduces the kernel.rcu_stall_panic_count
sysctl.  Reading this file reports the number of stalls counted so far,
and writing 0 to it resets the count.  This allows the cumulative stall
history to be cleared after an incident has been resolved, and also
allows userspace to clear the count periodically, so that panic() is
only triggered by a burst of stalls occurring within a short period.

Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 15 ++++++++++++++-
 kernel/rcu/tree_stall.h                     | 28 ++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ffea61d448eb..64fe2985e358 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -959,7 +959,20 @@ max_rcu_stall_to_panic
 When ``panic_on_rcu_stall`` is set to 1, this value determines the
 number of times that RCU can stall before panic() is called.
 
-When ``panic_on_rcu_stall`` is set to 0, this value is has no effect.
+When ``panic_on_rcu_stall`` is set to 0, this value has no effect.
+
+rcu_stall_panic_count
+=====================
+
+Indicates the number of RCU CPU stalls that have been counted since
+system boot or since the counter was reset. When ``panic_on_rcu_stall``
+is set to 1, this count is compared against ``max_rcu_stall_to_panic``
+to decide whether panic() should be called.
+
+Writing 0 to this file resets the counter to zero, which restarts the
+``max_rcu_stall_to_panic`` window of stalls. This allows system
+administrators to clear the cumulative stall count after an incident
+has been resolved, without requiring a system restart.
 
 perf_cpu_time_max_percent
 =========================
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 091e7850ab6e..a80f03e1c7ea 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -19,6 +19,20 @@
 /* panic() on RCU Stall sysctl. */
 static int sysctl_panic_on_rcu_stall __read_mostly;
 static int sysctl_max_rcu_stall_to_panic __read_mostly;
+static unsigned long sysctl_rcu_stall_panic_count;
+
+/* Reset the RCU stall panic count when written to. */
+static int proc_do_rcu_stall_panic_count(const struct ctl_table *table, int write,
+					 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (!write)
+		return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
+
+	WRITE_ONCE(sysctl_rcu_stall_panic_count, 0);
+	*ppos += *lenp;
+
+	return 0;
+}
 
 static const struct ctl_table rcu_stall_sysctl_table[] = {
 	{
@@ -39,6 +53,13 @@ static const struct ctl_table rcu_stall_sysctl_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_INT_MAX,
 	},
+	{
+		.procname	= "rcu_stall_panic_count",
+		.data		= &sysctl_rcu_stall_panic_count,
+		.maxlen		= sizeof(sysctl_rcu_stall_panic_count),
+		.mode		= 0644,
+		.proc_handler	= proc_do_rcu_stall_panic_count,
+	},
 };
 
 static int __init init_rcu_stall_sysctl(void)
@@ -161,7 +182,7 @@ early_initcall(check_cpu_stall_init);
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
 static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
 {
-	static int cpu_stall;
+	unsigned long count;
 
 	/*
 	 * Attempt to kick out the BPF scheduler if it's installed and defer
@@ -170,7 +191,10 @@ static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
 	if (scx_rcu_cpu_stall(stalled_mask))
 		return;
 
-	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
+	/* A lost RMW update only delays the panic by one stall. */
+	count = READ_ONCE(sysctl_rcu_stall_panic_count) + 1;
+	WRITE_ONCE(sysctl_rcu_stall_panic_count, count);
+	if (count < (unsigned long)READ_ONCE(sysctl_max_rcu_stall_to_panic))
 		return;
 
 	if (sysctl_panic_on_rcu_stall)

---
base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
change-id: 20261003-rcu-375496d7704e

Best regards,
-- 
Cunlong Li <shenxiaogll@gmail.com>

