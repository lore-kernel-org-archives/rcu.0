Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197351356F
	for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061038; cv=none; b=WjwhQ9VIaxOahXX6aVF2QGaihKQGF6vVD8n6xs2cQGrd9hMV7+TSIS1i6QuExmyVEDJ6/6bD9oM3RMKfhIwwJ5Mz6qzbgFI9PR+Mhp5VqzysQCAX/P9cruatIuCZP9X3zlMwbP1bV62vUZaGQOw5/NJr7oM3LFShv24DcNlMFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061038; c=relaxed/simple;
	bh=m4OHMwMbzXlh2XQ6c0Igw8Fqh29mNUw6HniKWr6Zo5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0POIwhQm3nr5uSEw35gpVD6mgX77oB/z4YNeLM0f906cTdK1eXiJK23re6QeilKB2SsrrBSpQv/2RJUzYTYC03FMc6Zuif7/AorHH9X0vZ5Sg7SQNAmzIhQl0XMdvGSjyQzaJPkXSVkL+pxauu3TtT+bHJOiBShFzvN5EJX2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyHmGLyN; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyHmGLyN"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so3388337a91.0
        for <rcu@vger.kernel.org>; Tue, 22 Sep 2026 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061035; x=1790665835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y92+ar2Zyy71HW4Z81q+yVXNw3aTL5K091H9SB9aDmE=;
        b=RyHmGLyN8QNLpEWO+QQfYWhuCr2Qu9gBT3fJLDRzl9vgw/+nwS6Eh931FXXl9WiFX2
         C9OWnKIabkV8FlgrFoofY1OrcMr273G+PzaHpT8WxheKgvLPo7AqY9YnNrowYprQmFK2
         UGd6/m8fUbzSYiWCfxaORTKEcfsXnOX5w9DSeUS+dbJVpYQZl/dxatY+xZHY+u16SnnT
         Ovv+bEwZeGPv/B3HShGKwCUeYqOV+p892oMWxRcGCZApaUe6f/QGLp7cDx3NRmTwfBQY
         FOswVRT2HNxPoXJpCeIaJ77TBXh3RJkkqC4WuTDaMLIqG7LdeLytpm8cBxB0zryyuXst
         ESng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061035; x=1790665835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y92+ar2Zyy71HW4Z81q+yVXNw3aTL5K091H9SB9aDmE=;
        b=pxEydC4BCZZ7h0324/9x67vHiBNkRXvd99CEu4x/cGMRL4pdFzWUfx4M+al293ntcZ
         Fxyn32qmxT1v6B9bI3xeFzLOQMJxZstv2b3dcUde1d//u72LUpaspxzS3ndxNC54Gdu0
         vJos4jAUTkOwy+VXkG/YR9U0wRnk3br/pouLqNT9PgOHi4uE3hOXJ0x2Im3A0OXjwoW0
         nvzhObio+ahMcmGMfY0HTBO98idfEROK7S3QH7AHD2owNAT3FS/icxY8A2Yw0p8U+D9H
         bsGWOW+1h+SBbV0JC+N1oHhuTVZ54aWo6fWWa1VDpXjxXcLQaTBBNPOVvoLS7GFxscOR
         CZLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEYNLHLoGQgM01bjrtvYwveYttK3Qfv51jyF4sbvl2Qzui0QKdQyuI2MV1zS3IdHt5QAk=@vger.kernel.org
X-Gm-Message-State: AFuF++kEsfzNMtErX2PXqehPjMCkRY4V8XmSKkpuzE/iNHkSltGHdPQt
	cp3yBhcjEdPTQlLa6tAewg9assi7Zp/+I6seNbeKkYQOYCyJrMWZtLjI
X-Gm-Gg: AYBFou1O8M4OEnCFNy5Pf8HhZ4dOA0rcAa52NnzCefidMjqUJTqQQHeUz/8LpXkIlmw
	ifBNKH6ptklJV82R4D/3znLsT+jWJCjXcQGLzo9xPs0XetuKX90e+3R94EMQBUScX5YxP1AA5LK
	8aYQcirYN47wl9lUKpLQBvTXV4fwRvUFEl2Zx7u+jN+/Uvg2amz7QTL0oUN6QbMvsEF7hAUR54R
	kOOyX9WUNFge67iYbBLkKiKyaocdR2oqzcDgIOhkeZsB1Ymnaeqo3H8ZAbAMp/r4K1XnGscXhxs
	wjWDJO6RTgRJEqsIlt4zobi20QQG2jPwLi6dEUw6mkUq75Pn/kTzo0sE6e7RRx5kRKi+tKlLIj7
	+671PBlJX6jq1zoOQGKH6bRG5latKSSfXuN4OE2MxY5CzuagZE08/Ns1WwWGujLZyXVwd2fSoNw
	KI30aaS/gV9aVQHDrqYT67nICbxbt/6nEU5ekNkvmNsPqKGkZOo+FhfZcSnJOBI41wjZMT7Koo7
	IJQz3OrYoWmf0qZsQ==
X-Received: by 2002:a17:90b:3806:b0:39e:6c6a:2091 with SMTP id 98e67ed59e1d1-3a073235b91mr260254a91.50.1790061035059;
        Tue, 22 Sep 2026 00:10:35 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067409854sm3079414a91.7.2026.09.22.00.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:10:34 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	urezki@gmail.com
Cc: akiyks@gmail.com,
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
	include@grrlz.net,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	lianux.mm@gmail.com
Subject: [RFC/WIP PATCH 3/4] rcuscale: add hazptr scale type
Date: Tue, 22 Sep 2026 15:09:49 +0800
Message-ID: <20260922070950.4173245-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922070950.4173245-1-kunwu.chan@gmail.com>
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hazptr reader and synchronize operations so that synchronize
latency can be measured alongside RCU and SRCU.

The read side acquires the hazard pointer in readlock() and holds
it until readunlock(), matching the RCU/SRCU reader model.  The
address of a static object serves as the synchronize target, which
is stable and never reclaimed.  Both normal and expedited sync map
to hazptr_synchronize(), since hazptr has no expedited concept.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcuscale.c | 65 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 1097ec15879c..072ddf9526c3 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -39,6 +39,7 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/hazptr.h>
 #include <linux/sched/debug.h>
 
 #include "rcu.h"
@@ -418,6 +419,66 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 
 #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
 
+#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
+
+static int hazptr_scale_obj;	/* Stable, non-NULL, never reclaimed. */
+static void *hazptr_scale_ptr = &hazptr_scale_obj;
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
+
+	preempt_disable();
+	state->addr = hazptr_acquire(&state->ctx, &hazptr_scale_ptr);
+	return 0;
+}
+
+static void hazptr_scale_read_unlock(int idx)
+{
+	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
+
+	udelay(10);
+	hazptr_release(&state->ctx, state->addr);
+	preempt_enable();
+}
+
+static unsigned long hazptr_scale_completed(void)
+{
+	return 0;
+}
+
+static void hazptr_scale_sync(void)
+{
+	hazptr_synchronize(hazptr_scale_ptr);
+}
+
+static void hazptr_scale_sync_exp(void)
+{
+	hazptr_synchronize(hazptr_scale_ptr);
+}
+
+static struct rcu_scale_ops hazptr_scale_ops = {
+	.ptype		= 0,
+	.readlock	= hazptr_scale_read_lock,
+	.readunlock	= hazptr_scale_read_unlock,
+	.get_gp_seq	= hazptr_scale_completed,
+	.gp_diff	= NULL,
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
@@ -1110,7 +1171,9 @@ rcu_scale_init(void)
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

