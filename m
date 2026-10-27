Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793085074;
	b=jtvsCTa2pcc+jlfvHY8E3YPRbBdA5U5u17offts2NtdVlVnJ6hzOn34Np+4Li864RaO+
	 mEQLcLVR9x31SWkNr2IPKS/Ndg78MUa7vBOLO03eq5GpzkRuEIVNquHS96cqakwMZQTvJ
	 B6Q07StGjeBXR3vGKl4RqavGRKAAxZnOq+9zSyu+JSrjUTyyquMu0+he4HI2mKXrDg3us
	 mAAhIQw7q1RWkTjM50ZUEFPasa4NbQoEbDbpFkUA2jA4XW8ynLnKGOIxbSbxOhe+93TrM
	 5mMaHkj14/bDxo70qyiM4yUZh9dGVuplpKWunSXqEuC+qXN31j56YNxgZYVbn2rrPHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EX2mJSpl72ktyH+OGtj4F4ld0yqDuHLPm1BrtlwUfBE=;
	b=25ykOsIDCv10U64YPvyRUyPmOd8AgW/rTlEtnR4ToBmpXDLh+cSsuhdmzu3SLsGMTW2c
	 A3n6os+rP4+xb0zLRyB6qCGiaegRUKWdOhVw4FhaK/AnWngIol+GE7D+n2mVgekPyktRz
	 s4LJX15OBIyU6quR/pF3KzOwkDDdVFsxqoqiAKw3ao8FHy9iRUX7inae7mkfQz9epc0jE
	 /v3Ea9kpbAis2mz0y7TKbOVC54nAA49yaMQBZm6SZNuyfs5SU8z0A7dqurYQDWUdfQjuY
	 7wNK9bExu9cIIYxpnTWWUd7H2kkz2wcBmCb9n0ZcoaUZTT6GeY5sG7/8dKzR1ImWqFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IkbBoUhb;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AE606A322
	for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 07:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A31AE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IkbBoUhb
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so2049750a12.1
        for <rcu@vger.kernel.org>; Tue, 27 Oct 2026 00:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793085073; x=1793689873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EX2mJSpl72ktyH+OGtj4F4ld0yqDuHLPm1BrtlwUfBE=;
        b=IkbBoUhbnco4i2rJ35omtvuqyQN2EiO55AjB+mrSuW42fwW32vjhrRJwsNGstOtAWS
         /VbIxWjVN+WJV4U/7cePkmMIRbQYtg9lE+e5sTg5lPoLiZM/3Ugv6bgeklOnfzkQqjE8
         ljX82KRyknwBVANf8STvySoie0V+u/mZ174patxZJ3efYPEQQXE8PYh74CFgo88E7Y14
         PcY7TQNrE5omyMYPH4q0LB4EqS8v3CjzHKVaHQ8xH/lmzvRRvIF6LgDbZfV2Y6h0QaYO
         FrEgbOIzOpXxX7lOxMWqwFupDuAQWKwdsMT1DwNP/Jk129eTR3EDeE9ksO4FDb20rF9N
         /yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085073; x=1793689873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EX2mJSpl72ktyH+OGtj4F4ld0yqDuHLPm1BrtlwUfBE=;
        b=pGMsnTfSR6KWMGoIcYlW4y5UepdPCSzRRGvMBC6JVzuZxeaehrnaW0otsnXckIt6Q4
         DQvqmIAe+GBJaewKdqPszjbo6jriJ+uMcjLbvczWPNyw2FNx1/Gzmsxv+FWCr8HWXaVi
         xsF/sOU2ETr0n2EJHn0pbM9N6cRtN4siddR8DJo+1mWUxoPRIymbiKzKC00eYLUpMKHt
         r+s+m2xMGbWMgMf3FZAS3lEAB3JL33wcyRAxY2DLVActAHST4eqapR7yssCyMjWHxweh
         XYAEYdp7evrc63kcFpbtJHD706A5RirdWOCIAqzRHSbQ61GLaCNKXWgYpxRMqBY5SrGq
         bVJw==
X-Forwarded-Encrypted: i=1; AKwUvBxjQUKYg8FAWF6hO6b3R7E9T82ZZAXFF68Ti7co0SxXc6srQojCs7UYobNUAhU3AhhGxEM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCZ1y3a9hbEoKJ8ETqptryhFfg4Qs0xgveSu0qfAJFOAxZ+rP7
	CdTSrnztSZ02t0b+4mAvMLUxX9GhOKJiE/d3jMjNnozEs4FCDfRSTFu6
X-Gm-Gg: AYBFou0aIk8e817RSffYyfmt1FbxbVmAbQ3tfA2b/SztOvFO/V3f0TH7ialPs2iEWPz
	nqgC0yX39oUyJ5GUe+bcBlqWVz44j4h6vEeUl44hY25YSDGl4Hme2niPBmjyv4T/Mvk0a0SYBUy
	86dCVGmMBQ7egB92cDw7rQ78S4alHy7oprONWg8x4A3IzljlwaIovkFe1qVlDoJGTgSvH2VoBIS
	9B/P3Dp4F2/fKRYNNhgINFaFJeYHtdDE5qWr72dhzGWIJn+pvsZ+WUrBGIgJGKY9YNSmfoZfYVc
	YIV9uqu85X7XfVH4yAofSMWgDUu9WF2Analg5QxLh/EkDcI/7et1YRHp+BKG+yLqa4wAXzyZXLk
	llK5tX4i+kDhC905rAD/tZ9hZWCoxgqh85PyxcF182xdRy0BGYF8sA96YMnFoYbBBhl4Ushxgvy
	VZngSUHTurMkyI9/i4SDBigzmW984wyFpIcwwpwY3W+l5Xd3AQ//Rt+QacV6AIb0MCV9mds6qas
	Sn9sOzOAKHWHrNEGUfPq6cNZsni7xHviVhI0h9wpECDONdI0DTNPzPwjcSNg+LjhpP3FjGzUA==
X-Received: by 2002:a17:90b:1a92:b0:3a8:211b:6c8c with SMTP id 98e67ed59e1d1-3adeaae6e15mr7986056a91.22.1793085072791;
        Tue, 27 Oct 2026 00:11:12 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21274sm2277512a12.8.2026.10.27.00.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:11:11 -0700 (PDT)
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
Subject: [PATCH v2 08/10] srcutiny: Detect duplicate callback enqueue
Date: Tue, 27 Oct 2026 15:09:21 +0800
Message-ID: <20261027070923.3054462-9-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027070923.3054462-1-kunwu.chan@gmail.com>
References: <20261027070923.3054462-1-kunwu.chan@gmail.com>
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
entry, before the deferred list can be corrupted.  Use
__ratelimit() for the diagnostic output group.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/srcutiny.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 98864977bed2..4c1e8d8595b3 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -12,9 +12,11 @@
 #include <linux/irq_work.h>
 #include <linux/kasan.h>
 #include <linux/llist.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate_wait.h>
+#include <linux/ratelimit.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/srcu.h>
@@ -178,6 +180,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	while (lh) {
 		rhp = lh;
 		lh = lh->next;
+		debug_rcu_head_unqueue(rhp);
 		debug_rcu_head_callback(rhp);
 		local_bh_disable();
 		rhp->func(rhp);
@@ -235,6 +238,8 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
  * Also called by __srcu_defer_drain() to re-issue a deferred callback, so it
  * must not re-check the deferral condition.
  */
+static void srcu_leak_callback(struct rcu_head *rhp) { }
+
 static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
 			    rcu_callback_t func)
 {
@@ -272,6 +277,8 @@ static void __srcu_defer_drain(struct srcu_struct *ssp)
 	llist_for_each_safe(node, next, llist_del_all(&ssp->defer_cbs)) {
 		struct rcu_head *rhp = (struct rcu_head *)node;
 
+		/* Bounds a node self-linked by a double call_srcu(). */
+		rhp->next = NULL;
 		srcu_do_enqueue(ssp, rhp, rhp->func);
 	}
 	local_irq_restore(flags);
@@ -288,6 +295,10 @@ void srcu_defer_drain(struct irq_work *iw)
 }
 EXPORT_SYMBOL_GPL(srcu_defer_drain);
 
+static DEFINE_RATELIMIT_STATE(rcu_srcutiny_dup_rs,
+			      DEFAULT_RATELIMIT_INTERVAL,
+			      DEFAULT_RATELIMIT_BURST);
+
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
 {
@@ -298,6 +309,17 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	if (WARN_ON_ONCE(!func))
 		return;
 
+	if (debug_rcu_head_queue(rhp)) {
+		if (__ratelimit(&rcu_srcutiny_dup_rs)) {
+			pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
+			       __func__, rhp, rhp->func);
+			mem_dump_obj(rhp);
+			dump_stack();
+		}
+		WRITE_ONCE(rhp->func, srcu_leak_callback);
+		return;
+	}
+
 	/* Record the caller: the irq_work's stack says nothing about it. */
 	kasan_record_aux_stack(rhp);
 
@@ -306,6 +328,7 @@ void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		if (READ_ONCE(srcu_defer_draining) && !in_nmi()) {
 			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
 				  "call_srcu() re-entered during callback drain; leaking callback\n");
+			debug_rcu_head_unqueue(rhp);
 			return;
 		}
 		rhp->func = func;
-- 
2.43.0

