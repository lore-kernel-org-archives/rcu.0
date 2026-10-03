Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E59484253
	for <rcu@vger.kernel.org>; Sat,  3 Oct 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791044253; cv=none; b=lhULet+LJ1EK5XKWACSJRsxv8iiJsyEui9SHE96D/mMRHGsFJ3EX5ysT0CUnSwgY+IcnqtbdNB8Fo9XyoW1KZiyf2tyvMxowfvPT6D1jr7la+oxs9ckkuWgDFyvUiwaY2m2iOf1RTR4PCAja+tiDpKqkN2F6wQfFG9entaa/Z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791044253; c=relaxed/simple;
	bh=wfH8wpo4fQkMWmhf7ecM6gIGRhKxXZRTeQqjn3CvMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aacilptf9kGVFgAzvmEg27mfhTo35taxEX+pc5I/Mt8PSHvQvSUelhVV6EA7W1O50CCFCp+OsIIaYsXbuLOzgZMD/W/lMFdQtUu5TMNb8i8NfsvilBc31kHOVjzjR1P52phJ252R+34k+yr5FCNvTZfVVPxQmJqRzWyP0zOvMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvhAZEsQ; arc=none smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvhAZEsQ"
Received: by mail-pz2-f36.google.com with SMTP id 41be03b00d2f7-cc7e7717676so73129a12.3
        for <rcu@vger.kernel.org>; Sat, 03 Oct 2026 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791044251; x=1791649051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HDIjwlR7Rtt/S3CXSZpUYfZHO7+anZ87U124wiaxA8M=;
        b=jvhAZEsQIfvAA2tCYrGC4QXhx4oI59k0lij6o3V+ppy54dIun4TO0g6MgMZII1zei8
         dBW0U6jPiLUGNOb98m6445JcLRWVfPtmW6eUtMUXdJTzQkSUqfOCBCDa0zbI0sj0oZHq
         9xzUXEYYicSpPuy7ollElqzrp1gWNtCEiVeNoKtscyZ6amdbkE03NbPiqp8IQ6dPw/7f
         HcSod3aaPyk2FdFZq/TaAEjgh8ym3YgB6HV4ro+uDTtTckwllWK1Odu607uZlDrPSMUh
         u93zuAAwgHd6y0Tck9HNeMIr1Nxj+DxxW5tQUa9vsBGEz0Eo2eYjCbVIBDMiN44Pn3Bc
         fERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791044251; x=1791649051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HDIjwlR7Rtt/S3CXSZpUYfZHO7+anZ87U124wiaxA8M=;
        b=Fyu/kBUucdukKkUgzhhHe37tqjK2YIpBhAq/3SocifDfIUscQ+4q0fSWG3PEC205Tn
         rur0tr5qJL1p/CJwpuCkWPaEiqnwt/xRZFkJ8ycw1VNeTy5itItopMzuQQaAavgrVqhK
         82X9yP4b8ij2JVL0zn5oC+z7Yb8KRZfTexAMsGmIm3FANz43LUZHXb7tCrF0xpDzbnPf
         HoGbAsjx4Mqd+PaSm8evq8TE0fScj4CrLcr9loXJli68uHg2Ccje0M8LbaX7CsodxUou
         6jRuBF4IpPRSW0eDzD3QawI3Teg4jrkX0YMfRNTFdRKfvfK2z8q1bpmFYhuaeGLEWmfw
         xUDQ==
X-Forwarded-Encrypted: i=1; AKwUvByQuVbTFC8D9Kl8Rp1nAD5Ceg1XHiLTeZyxAo/dQk73+vQX6waEzG/ebGpvx33CRAwoMZI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIdkfkPKOWau4wDu/9AEtB7IHSqteFBwsZ+1DCaaWBHzFhFAkqr
	ao7qH0s+t9yQObRUBJa5oOxBa9KVdFs8ENcRQLDxbS5i1t4YzvcRgjZj
X-Gm-Gg: AYBFou2forzYHWmwdSERACToY7dDh4mfNanqrzpXOT/PrBaRTt9ikXXMU7zrDO/Eno1
	ybNe7qAo4+V9G78hlih68aG9QTTd8QkRqFPEqb5010RXN7NridnpLCP/w+CBU5pXFGKA4hepR+S
	YaWbnqJbMS6nc7mbtMrg5gYBJPKbG7QCcesc9lzqZq1NlS2GA3/+GbVxXTAdJGulx48Slt3p3eC
	xIwLPZ+kao7q4dqs1oyL0ueIQWlhYqOYLl+8T1VnYeHpgVqvdVARlsIxjbSyAQUvtngPZ98ytm6
	2jqN+ecxoh6PYgmA2fCXaivVH2DUCyu7UGnCVqgdg4rK/CxiMalAn8E8VmsS3WcJZaWu1EHam/C
	JomkMz3SYq710puwJwAH1xnxvogM96gI3KPlhhAFdYVWiUKwE9te/BJl7azOuMvgu2kHci/qB1/
	dal7oEC5GoS+kiaqhzAhPMoiwyhXbbITUrw2pO1ynLAnZO/zWKJgLQiDDfMgkOD0LE5uF3jm7oM
	lK7oAAt0SQrCfclIwNFzbF+Bkmw
X-Received: by 2002:a17:90b:3e85:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3a783504695mr1759638a91.44.1791044250656;
        Sat, 03 Oct 2026 09:17:30 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a79a98e7c0sm2199935a91.0.2026.10.03.09.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 09:17:30 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v2] rcuscale: add srcua scale type
Date: Sun,  4 Oct 2026 00:17:19 +0800
Message-ID: <20261003161720.240855-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for scaling atomic SRCU grace periods using
srcu_read_lock_atomic()/srcu_read_unlock_atomic() and
synchronize_srcu_atomic().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
Changes since v1:
- Rename srcu_atomic_ctlp to srcua and reuse srcu_ctlp for
  SRCU operations, as suggested by Paul.
- Reuse the existing SRCU cleanup and completed helpers by
  initializing srcu_ctlp in srcu_atomic_scale_init().
- Add .stats using srcu_scale_stats().
- Use "srcua" to match the existing "srcu" and "srcud" scale
  type names.
- Use synchronize_srcu_atomic() for both normal and expedited
  scale tests.

v1: https://lore.kernel.org/all/20260927100359.3903688-1-kunwu.chan@gmail.com/
Tested with kvm.sh --torture rcuscale scale_type=srcua on x86_64 and
arm64, alongside gp_exp=1 and PROVE_LOCKING=y: no warnings or lockdep
splats.
---
 kernel/rcu/rcuscale.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 1097ec15879c..b172882824ac 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -293,6 +293,44 @@ static struct rcu_scale_ops srcud_ops = {
 	.name		= "srcud"
 };
 
+static struct srcu_struct srcua;
+
+static int srcu_scale_atomic_read_lock(void)
+{
+	return srcu_read_lock_atomic(srcu_ctlp);
+}
+
+static void srcu_scale_atomic_read_unlock(int idx)
+{
+	srcu_read_unlock_atomic(srcu_ctlp, idx);
+}
+
+static void srcu_scale_atomic_synchronize(void)
+{
+	synchronize_srcu_atomic(srcu_ctlp);
+}
+
+static void srcu_atomic_scale_init(void)
+{
+	srcu_ctlp = &srcua;
+	init_srcu_struct_atomic(srcu_ctlp);
+}
+
+static struct rcu_scale_ops srcua_ops = {
+	.ptype		= SRCU_FLAVOR,
+	.init		= srcu_atomic_scale_init,
+	.cleanup	= srcu_sync_scale_cleanup,
+	.readlock	= srcu_scale_atomic_read_lock,
+	.readunlock	= srcu_scale_atomic_read_unlock,
+	.get_gp_seq	= srcu_scale_completed,
+	.gp_diff	= rcu_seq_diff,
+	.exp_completed	= srcu_scale_completed,
+	.sync		= srcu_scale_atomic_synchronize,
+	.exp_sync	= srcu_scale_atomic_synchronize,
+	.stats		= srcu_scale_stats,
+	.name		= "srcua"
+};
+
 #ifdef CONFIG_TASKS_RCU
 
 /*
@@ -1110,7 +1148,8 @@ rcu_scale_init(void)
 	long i;
 	long j;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))

base-commit: d21906b0aa1e9573cdb5e7acaca44966b9d1dcd2
-- 
2.43.0

