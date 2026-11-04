Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811533;
	b=TnQNFrGqWhmZ8nZzRE6Ib1HMZNLqqnuBbCvDPLyZw8a+CD4RCm4ySzOAgIYw2W6G7fHO
	 lxOeizt8/d7urzXGdqJmM9Z/HTXoKc+vI3BOE8QRYsXhRX9TtkTowcxZ8zI7YH8irxuj5
	 f4ymFTd6Z792NGTwJMgAyrIamsQLzBKwRUerQEW9f5A+hpyDRkxjz4A+bt2tb23wpAZNm
	 F5hia/D+W4AksffRVPOD80exObVmx4L07M2fjfv8xHzlqi04sXta0BEmzSTFIPagIljyl
	 BUPZ3Z1RJwptPe3wmfLZZ3JoQrU80CnzlSwwjpS4idCHVGZvOPxQVJljMdNmYY/kubQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mOm43uVjDHc2zReKMHzQN6iIWpo1wHm4zcoGnRZJRRg=;
	b=3lkvaRakxe+4ogQZq22ik7jIJ0QobS189T2WoGpZJ6XxxiJdFpwNQ5QhxzghE74OmlYf
	 D3fjW9pQ4N7OOaTagpPoGF4C2PXJotAIiGmE0frEejAtKZ3TIKV9rYXyZgvQqIf/dBQV9
	 e8CXiFDr5nfMAz3w2pwSEV+r0PDw2bDKTXI8/EY0CfqnJuw99PlsqX+17zb0xPHm7DyRs
	 jp7XRIN4OkXhE/l7l5++RUfcSK6LhRPfusD8XP+qZrg+FTkJYJfjKX+HzguO73ODBeblY
	 mG42xpvhv2FOEsuaP0x3xc3GCG65xRUKygrkLdiPI6AExKYDxKeJwE9goPI7V3B74HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANygCtmE;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63458606EE93
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63458606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANygCtmE
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-19305bcb72cso881152c88.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811532; x=1794416332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOm43uVjDHc2zReKMHzQN6iIWpo1wHm4zcoGnRZJRRg=;
        b=ANygCtmEabL2DlL1vQlsQM2V0AtBPyADMKMlCJWmID9fbbwmQs5upuFgx6EU3yvhKo
         6caM3e2hkkYO5GJr7HHs+Js9ExbyddYDzxIlemrd8dAXA7Zu9APdFA1UHE8diifgdk8a
         lmdBb0VWG5nNoMzfJrINFe2jSCYp+laLzbezywwABqXJTWGEic2IdMbDjiSu5RV0+CVJ
         eIqDGjL4iNpOnsFQO7sePrDbbe2pzXFrEn6oNowXFyvwpyOWoIVbsF52+leys0IMgc2l
         DNaM0njeFmPb1ZBzxYZ6tHpA5QdzerC11YzE4j+NaXlXjJhySqwp7mgr6wcLnzJmPe3C
         ukow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811532; x=1794416332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOm43uVjDHc2zReKMHzQN6iIWpo1wHm4zcoGnRZJRRg=;
        b=LGXtLuDZGpnXaxUOTk88WYkVsIgSCrTJTRR7qM1Y9E8gN4O7VnSEDPoj9iZNKXYknY
         lJ5/YDf4ywqLqznSnOyg3xEgTLttN0nNQncnEvVP5a/USxlqN5Jp/j+wmuEL9NTaYPGe
         tPPXz9WfOrhu2Wlix/bZCpGaZNV6/ARnJk8UsoOeu80Dd583uFBoQYcunskmnuGG55nE
         j1Y+1QD0U0ya6i+U+Um4cmPPB+82wdaR3lC6N0/n6mF/+yd3sIoe1oGr8w28PnLNyGCB
         6xcLL2cOrnkLc03t4TFLbLmaeTgpXVH2ndE5pdyJxX1fdHrPf1Spt46AJA4fErusRWLl
         jaAw==
X-Forwarded-Encrypted: i=1; AKwUvBzMsxLzrWi5R5zB369191SwZXNlvZgCW81KRgbNI2v9wkhWWPzq4kPwLcw+/AM8ddIQYl8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rY7T4EhxR/JXg8j0tWXI//KxNJ4bofM+IcKR8/E4bm90m6x7N
	kdG1JUBEuiijCS68sb3g95Yq/jhyH7/YCyZp8OcyZJ3/atvyJhObb0c3
X-Gm-Gg: AYBFou3PDn8/YycliTEafyM/ukgBYe76vv8a3ek+LaeUG+GZUe/maA35qZ5BHUzIuOb
	jcngS4kAYTPUQDGCTgK5D9E2X2jVw+f9BwbhMjX9C1wgDLCBUk63nZ1eBoMCQiK3dB47y23W+AW
	ihYRUSyOfCeIYzsE132wHEbYq13tPhWrfTtmYj32rss8Z2DY1p3oLcrTi0OZDr9V73CijGrH6eS
	WFmTJBaumFHsy6N0POm9AcYwZy3r1RpCCuhlDiwQfOTdQcZsk1zA6yNOmVaj4D5utFJ3lLDa0mE
	4GdE664RJccWn7zxVt8tbNkwppthw9kwh1ArXv7uDmtRyYClNwbQL7qLKw8QDldMC5oEIGI1hfJ
	WchNT9hdvnhJ+/nEtzaM16QUSfEeikaAsd/W0ZSqFekhYSpq3r4QG5eJUArZBBf7pSMoWySbaXO
	hY1L07cxjFuUAHoM0/Z4ARiQtam6lb6Tm0zaJ+SdJNm8JoTAiNNBhWJsooCLpodl3ze54S+R6Vg
	JANvXGKlvaV2/Pnsyhvk06oOctjyBUWh4xK6Ae9iLXb2zxNfhtcJC3guXhKJvgOTgbpG8wDStO/
	7Rv65BD+p47kR5GQAQ1gqFYBoblcQrV8KI3ymeh7xx5Z8qfm23i/800lyn1q
X-Received: by 2002:a05:7300:5b89:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36a424c7b7dmr37599893eec.31.1793811531717;
        Wed, 04 Nov 2026 08:58:51 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:51 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 23/28] rcuscale: Add hazptr scale type
Date: Thu,  5 Nov 2026 00:54:41 +0800
Message-ID: <20261104165504.2430480-24-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
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

Add a hazptr scale type for per-writer hazptr_synchronize()
cost and per-reader hazptr_acquire()/hazptr_release() overhead.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcuscale.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 5659eaebc5c0..6e3e3f296f85 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -40,6 +40,7 @@
 #include <linux/vmalloc.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/sched/debug.h>
+#include <linux/hazptr.h>
 
 #include "rcu.h"
 
@@ -460,6 +461,71 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 
 #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
 
+#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
+
+#define HAZPTR_SCALE_NR_OBJS 8
+static int hazptr_scale_obj[HAZPTR_SCALE_NR_OBJS];
+static atomic_t hazptr_scale_sync_idx = ATOMIC_INIT(0);
+
+struct hazptr_scale_state {
+	struct hazptr_ctx ctx;
+	void *addr;
+};
+static DEFINE_PER_CPU(struct hazptr_scale_state, hazptr_scale_state);
+
+static int hazptr_scale_read_lock(void)
+{
+	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
+	int idx = smp_processor_id() % HAZPTR_SCALE_NR_OBJS;
+	void *ptr = &hazptr_scale_obj[idx];
+
+	state->addr = hazptr_acquire(&state->ctx, &ptr);
+	return 0;
+}
+
+static void hazptr_scale_read_unlock(int idx)
+{
+	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
+
+	hazptr_release(&state->ctx, state->addr);
+}
+
+static unsigned long hazptr_scale_completed(void)
+{
+	return 0;
+}
+
+static void hazptr_scale_sync(void)
+{
+	int idx = atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCALE_NR_OBJS;
+
+	hazptr_synchronize(&hazptr_scale_obj[idx]);
+}
+
+static void hazptr_scale_sync_exp(void)
+{
+	int idx = atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCALE_NR_OBJS;
+
+	hazptr_synchronize(&hazptr_scale_obj[idx]);
+}
+
+static struct rcu_scale_ops hazptr_scale_ops = {
+	.ptype		= 0,
+	.readlock	= hazptr_scale_read_lock,
+	.readunlock	= hazptr_scale_read_unlock,
+	.get_gp_seq	= hazptr_scale_completed,
+	.gp_diff	= NULL,
+	.exp_completed	= hazptr_scale_completed,
+	.sync		= hazptr_scale_sync,
+	.exp_sync	= hazptr_scale_sync_exp,
+	.name		= "hazptr",
+};
+
+#define HAZPTR_SCALE_OPS &hazptr_scale_ops,
+#else
+#define HAZPTR_SCALE_OPS
+#endif
+
 static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -1140,6 +1206,7 @@ rcu_scale_init(void)
 	static struct rcu_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
 		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		HAZPTR_SCALE_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.43.0

