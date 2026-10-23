Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750794;
	b=S+KISmzA3OogBg5Up96PVLO+pCdut2ekdKzXczABzLoVRDNuncV2CJ7Kl3pA+lqmQ+Xx
	 Wj/f59yknbjq01nkh9KBRpTrwVg09liOPtE+cydjCuLEpxBRzPiRLPqCnEq5lr+lY72Iz
	 BdRl6pL5BwOIW4HLoQecdia/Gl8XM0P5uxsstI0SDfAZWP9cicEi7bHk7ACPP7uZKGsLO
	 sG0Kw47XRJQlBX0Xds5uycQZ/ufaIFUBxfcj+GFwla/NiOXvKsCxl+SOjNB5YeFrSyrSO
	 GHObaPSO4DM2E28CrF8gO1t1tsAkbKFo7j2rtwTtKDXXZCiRcXy1FdTFmbvo/lgOvRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=izQYqenlmRZdKic0Yp0ZzZXha0umLPvPXCsVuFxI4c8=;
	b=CgUebQDf0iD3TGr4KnHl1Dd6sWniBLOqk8gEoypPIm9MJz9oAJWpvIe8Itn5Tde/iTsj
	 IdPwSFdVXE2hg9m3JkT3IlDnopLAHtDUJDCWB6q1L0v0Qc6FlbNswEZcJoppNw8LPZaF0
	 VyG6nR2smnTzHd3SHjP4b+p7alH8BP2uG2Yn5gHETjyRatGLRX84achcbESE7uYTlgy71
	 fAOSLJToRDHwfZcD4c62IatRCJ92eITKIHGdvir0LCmdRen9X7qhL7qgSGqiDvoIHlSpz
	 izBeH3EMkc+ohdq3kP6mDvK+QtJCFL4kv/A9zr41cx9nEN6UOAsWwWKXQR1Hq5yQOqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gOcpVE4a;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B8606A324
	for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 10:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A38B8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gOcpVE4a
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so1641865eec.1
        for <rcu@vger.kernel.org>; Fri, 23 Oct 2026 03:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792750793; x=1793355593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=izQYqenlmRZdKic0Yp0ZzZXha0umLPvPXCsVuFxI4c8=;
        b=gOcpVE4aXsdNXh2tJr4XzL3D+XS93XG7iMBwmQTUfws3mr8TCKmqwH9QqV71oNyxuX
         5Y2jjOs5lTchChKf+M6DYL6gr79O1U7Mzd2lxImjcOGMqGFRlU1K1FOj38d+xPhViVqV
         XLoHih7N94uuug2q0x38MhUCwc/wnxYsNfa/o00YxVXIKfpDQnUXVpITjzZKUUCQphL9
         QqjHNkf1ki3R2dCfZtjmS87p9Qhz5Me2zNxRD7UlFQFg7nA4iTqbnJPdA6+Wn0Jjptxd
         Mzirq0AZKnZpf3uV9My8JL0I+PxizL7qmmttcf9cKOUueYUCALJ3cN+0lFZtj4tfb5UD
         ZeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750793; x=1793355593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=izQYqenlmRZdKic0Yp0ZzZXha0umLPvPXCsVuFxI4c8=;
        b=veJ2fnte4r6fKZSWXZqn0f4l/w5jsudG0YPr8YXepkgav0TVztOUE2tCJka+We6BRx
         HMk2xti6OpXc2pLI4Ow2bCXtDsGVzO62pKAeSjISRnKqkFitQcWv/5YmY5zsJ6laMH5A
         U9TsP6MDSGpy6QLlQQEwRUt4G+8zaeVMsvoikOAn/ZeTk19si+v6fdoqL71GpHODY5HC
         oTXxhGSvFMA2uH9WZX3Ads4yGJp3vBqqa/6KpOCUsFJnvdYmmQd0mDVfMltVBWOJbrnQ
         hTmtIlHRdR8OMFy8V8QDtLkbqwaFqnfIQwfmEZ4Mum+i01tRLOw0A+RBqYeq0TirOr53
         nYUA==
X-Forwarded-Encrypted: i=1; AKwUvBxR4a8S4D2G1IrauXaoeYm0a0RbOK13KX9V0IGa2YfXFDJpn3lmLKjgPO3MfEcjkJmcYqk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUbNG8bO+FtAYLHp5W25+ZN5Q50NSCI9nr+pC6pEh/PWL28t/k
	fbbIXuJRkabXQVWzorDIAa9FkAijascLMnNDMvMggxydtcrdMmhKN0w3
X-Gm-Gg: AYBFou0gqm7jnt5theUFUzm51zjqMR7eVNK4UsMA/Jav/RE95pyDPlIg7uTNyRgaDKF
	8XzlwczxZN2zovJL8cIM65hLfrlmh/MrV7HAi2Xzuy9Kv0ZJQtnGKW3ofNEWKYrEfaNhuL6sRaZ
	lc2xZwGFF8HrJ0OMhvS9HQPh6EPFNwq9naCjYkxjNue+j5js140hIUfCl1MlBWtyagLc7BZYCyR
	zFOa2mBnvVWN8XRREo6+vvOGwXqzOYgXRP93Ca0wNON+XZKkHrnxbvafzg+R5NdUDEQ8nTeUufs
	Z864IugCApgGLGhlX8PB3vQUfhD4kFJmU6m9ehx1tH/zoILTpkyWduIhC1ZIogHtn2aofZH0dPR
	RE1EZqrxXkcuxsM84ocG8I8PyR7BOzrEnOXqkbIM5gFGHAF5PQI7Q4V/JvqqqMhotb9KvztIqtI
	esI4zzZkEkLYxaSAn7tvK6tF0WI6yjyXaKczZS53F9OJpEG1SFmNn2oo0S7khW7P/nFrGCWsu/e
	xPOpSq7ekzDZa678ry4XNkA7Mgsjsoy3v0LMicWTR8SEvSz+mkGx4ZcK9GMbUzkKkmNDDa32A==
X-Received: by 2002:a05:693c:87d6:20b0:34d:755b:d60b with SMTP id 5a478bee46e88-369d98be2c9mr2402046eec.34.1792750792522;
        Fri, 23 Oct 2026 03:19:52 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9deef9bsm5852176eec.22.2026.10.23.03.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:19:52 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	work@onurozkan.dev,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 8/9] srcutiny: Detect duplicate callback enqueue
Date: Fri, 23 Oct 2026 18:18:40 +0800
Message-ID: <20261023101841.2910719-9-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023101841.2910719-1-kunwu.chan@gmail.com>
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
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

Detect duplicate callback enqueue attempts at call_srcu()
entry, before the deferred list can be corrupted.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/srcutiny.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 98864977bed2..4400fd2b41b7 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -12,6 +12,7 @@
 #include <linux/irq_work.h>
 #include <linux/kasan.h>
 #include <linux/llist.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate_wait.h>
@@ -178,6 +179,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	while (lh) {
 		rhp = lh;
 		lh = lh->next;
+		debug_rcu_head_unqueue(rhp);
 		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
@@ -235,6 +237,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
  * Also called by __srcu_defer_drain() to re-issue a deferred callback, so it
  * must not re-check the deferral condition.
  */
+static void srcu_leak_callback(struct rcu_head *rhp) { }
+
 static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
 			    rcu_callback_t func)
 {
@@ -272,6 +276,8 @@ static void __srcu_defer_drain(struct srcu_struct *ssp)
 	llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
 		struct rcu_head *rhp = (struct rcu_head *)node;
 
+		/* Bounds a node self-linked by a double call_srcu(). */
+		rhp->next = NULL;
 		srcu_do_enqueue(ssp, rhp, rhp->func);
 	}
 	local_irq_restore(flags);
@@ -291,6 +297,8 @@ EXPORT_SYMBOL_GPL(srcu_defer_drain);
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
 {
+	static atomic_t doublefrees;
+
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
 
@@ -298,6 +306,16 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	if (debug_rcu_head_queue(rhp)) {
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
+			       __func__, rhp, rhp->func);
+			mem_dump_obj(rhp);
+		}
+		WRITE_ONCE(rhp->func, srcu_leak_callback);
+		return;
+	}
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(rhp);
 
@@ -306,6 +324,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
 			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
 				  "call_srcu() re-entered during callback drain; leaking callback\n");
+			debug_rcu_head_unqueue(rhp);
 			return;
 		}
 		rhp->func = func;
-- 
2.43.0

