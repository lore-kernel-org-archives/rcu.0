Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7B4DA9C7
	for <rcu@vger.kernel.org>; Mon,  5 Oct 2026 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220671; cv=none; b=Ybb5JFO+KqDO5sAd/OL5ZgbLhc9X3xgIZtsllP0sOP4QijYRHQYtbnRPyuoi9TzMBDLYLk7f1BorlcCuFwiZdkRwRbFf3SwCNpZa4XqsPmMToFcG1xYiibZFzTuHgj5JHo7q/qLKysrnCNVX4buttC7YcEZEEjd7G+TBbJDliNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220671; c=relaxed/simple;
	bh=9oP9VQ+JM/9PdWJ+5+ZGbwB85sJAY1eTAyp/fwZIqqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/njje1dKro9/Mt2EeNmaq3tEw40vrDpet3dSkceIz3apy/iQVzCw7lk7Fv4+ZsG0OpQyulp1RyqvoDuBpFfgTId89J02kWI2vY4UJJwwwKqbcq9E1mgTMK4IP7b8DC8sJ32vvB/aGw+USOvOzlg3adX+t5OvHvZFsc20wcu2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns7XeNDB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns7XeNDB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24afso757641a91.3
        for <rcu@vger.kernel.org>; Mon, 05 Oct 2026 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220668; x=1791825468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAD1Y95K173b5qZp91CTYZls79sZInjIuGPu7Lg5CCM=;
        b=ns7XeNDBEiEeUI6DMxj/Lo+OKLE2ftneMsq1CGeZTzWJRXOKh56hBIMnCvzzCvJgU+
         u5szmqm6erw6fCCc8Hs3KGvR8Rak60TxHSEBaYSSTzVoxI0+Bn/DaNuBq/vuk2hUI7sC
         T5gEDkLnnar+fyq/sr0SrB45DqULc6J6418sm+qEfA2KDhHo8+7F1c3XzDp34qkSXmIv
         xawx4JmY4YmKW0vvV/nFuajInG/3W7b7gFEnLEDxoQ+SLTVndRg9AsGhL9HADg0H1kSh
         sJXr4JDrKcW4xhkCgvQpoAnBFmO9OzrHMXCg+Fz6tKWihM6jzVqWYhTYtkPdCIdRo/gp
         i7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220668; x=1791825468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAD1Y95K173b5qZp91CTYZls79sZInjIuGPu7Lg5CCM=;
        b=c6aPeB8RlVAQR1ZfjqtD3LfrV2iOGGxpOpUCB6EBDJydDkqKYtLJKyrQxlJwXU998x
         IEyhCrrCgCGYJmBGlh7Y4dE7ICEqBlS54Ke4lAyvLZN7WBAPUVB/hZOGe+/bg5L1B8uz
         y1ljdmvpaxlSy/H6goyLuEZ8N1JKaVRTnpQwznqzhrpQeKQfSTns2wpU1bF1peBZO98U
         Ugi5ijopu8rqzqFC1Rspsp24kDfSHhJVDq3VzJgm7gq4+joqOjmlvJejNA6YzujVq2Rt
         RAYN59RQJGdQEnJl8S2CDYgdhPor7gcE2v8LpPIrgKk7gvSALpZcdZv1qClGePBMG5GE
         rs0g==
X-Forwarded-Encrypted: i=1; AKwUvBwe6zlyh5RD8GIjNXFsXkUQ/4bineeSsywDMDu5XOKD/9RXana6T8O1iKjKLT3FNJ5XG94=@vger.kernel.org
X-Gm-Message-State: AFq9FYInFIY32pd745HxXPIxYn3Bu/EiF8M10kKC+/LuMySAxYuTDcH7
	Orf4I6VU8PASQsEPWEd/0BpqqxkKmfDanFCdpMHiPiiYvD2TsG/jU2Vb
X-Gm-Gg: AYBFou2tty19lUpKiidnePs0KYyaLoPIC9OtT6JvFGvJFcU+5d1fUaLko+TT5ePeU0Z
	mDdjGGFWjpWjdq+9G2JDRMLoye1ruxAtIhjHTRU7d+0d44lP1hmuQiO3uQzhrt8nSwTfRzfiLLk
	UoVEVXkVWRf/MDyPZRny82dh1i9fu++6ssqug8bLNKCvCOLVxZJ0q4wVLUXubC9OQ3dB2nqqKGt
	qFbzgYHC3811g7nhrezFkM/C/ZaGcS1z14PVmvoVBNCj1fzJHKTN0tqVKoJG7Xbz2AtM8oCZtx3
	iUiJXhZ8MY7Ol52qB/sZoRTiVAqWThg3D7UpMEqXJTScFAcBorU33qcWsj4NQaXFqmsFXZW2x2H
	aTH8m7zPYCBrsfjHzT9EV5ghV1BvGZLuH4vYDx0TKgAahOS+CMvoD+OSTn2fnWiATvFsfCLd0Wg
	jFKkg5g9H71CpPZcSi5RgaT0ICFhaPb2sbo/90KX05Q8TsOq89IxcRo+UtlAt6BOPv9Y6JFOOKB
	OYGIbD3Bq9HLiJ5IGTc0jTdc8wpDXF45GdyBzF4
X-Received: by 2002:a17:90a:2ce1:b0:3a6:dc2f:f087 with SMTP id 98e67ed59e1d1-3a6dc2ff4ffmr2745576a91.53.1791220667397;
        Mon, 05 Oct 2026 10:17:47 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:17:46 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
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
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v3 09/15] rcuscale: add hazptr scale type
Date: Tue,  6 Oct 2026 01:15:23 +0800
Message-ID: <20261005171529.1378809-10-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005171529.1378809-1-kunwu.chan@gmail.com>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hazptr reader and synchronize operations so that synchronize
latency can be measured alongside RCU and SRCU.

Use a small set of objects so readers do not always protect the
same target.  Each reader protects the object selected by its CPU,
while the updater round-robins through the objects.

Use hazptr_synchronize() for both normal and expedited scale
operations, since hazptr has no separate expedited operation.

Link: https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmail.com/
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcuscale.c | 70 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 1097ec15879c..5aca31c3c01d 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -39,6 +39,7 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/hazptr.h>
 #include <linux/sched/debug.h>
 
 #include "rcu.h"
@@ -418,6 +419,71 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 
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
@@ -1110,7 +1176,9 @@ rcu_scale_init(void)
 	long i;
 	long j;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		&rcu_ops, &srcu_ops, &srcud_ops,
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		HAZPTR_SCALE_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.43.0

