Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDEA44E045
	for <rcu@vger.kernel.org>; Thu,  7 May 2026 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175447; cv=none; b=a0QZLwdbzs1TkITc7JMO5TC+bzkPmDFIMcoZsdGvDR9sl8kFf+3O9aodelFR2ZzB2BQ4yVATjNTno3Cr7AS8byp7LBTryT3gmF+06WtpiJrzGQgrk+7iwW0473LEAqNpYiQTSf2EvdkuletMxJOYqRwxKlFWaWaYpqcMvSyeOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175447; c=relaxed/simple;
	bh=4z/1dmBLjBhdxfo/+CaTY6REGE9UNUbRRcoALV01/lI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyGR8cPGfgVbNMNHOvnpRj6IecZoVV9EVDUW71mgqytJi7IevMxyPwYXz2DcrFrOgEilsEQQBDzJufPaWO5t45FEjy9u15hv5DbO8qmT2TbIIEVfPXeyuo2KtKQgQt2CFZPMZY8K3xRzUcmC2cuTOXZamFWpHfhovNJFm0K1aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg/gbNaq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg/gbNaq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44c44af71f8so135925f8f.1
        for <rcu@vger.kernel.org>; Thu, 07 May 2026 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778175444; x=1778780244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4m72sXmjSg5D7jXc6/EKa8YJmIxljirw3qApIHaCe8=;
        b=cg/gbNaqN3pnfi/JCDo9JF0f67Wh+2tJYOTJnaOttt+31xpnfLNsy+I8zUJWHYm0ry
         LWkKQsUrVxpAzksarTPqCdbV8+TSx8cv2P5PR+q+ye+PS5+h6Oyy9TOWb4wBVxdjupZm
         EXEW211e0ZTRq5RqVAVSC4N90QnrnF27v/wH5u0JE3GcEonFFgsXkV2VnlBH73Xv0ySK
         /k9fc3nl7QJXqk2omeiRPbEN03baTGt8LnkESY73KPs7KE4oaD1JQO4UAVXaQ/BALV8Y
         XBRVs1F1JcC3guRsrs0xFlRGMbhM/YA7PGSPpjrS6YzHbC5Z1wbEdHLk5iEGGnVF0VII
         V5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175444; x=1778780244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T4m72sXmjSg5D7jXc6/EKa8YJmIxljirw3qApIHaCe8=;
        b=YR1k/sBCgRmiPyKhYq+IDsv/yw4Cof7+RGAk0sU3bA1s4Z8bO9tIIeiI0S8NUX+jBs
         +hIQNANwnHrezV9llfMcrkum9As4cByu0/8Yc3Jrx3nDT8Cg15Q58TMwW5tlgBkG5Drt
         M8B4lXiKMfjOehSHP5SsL0lO0LwYdiDUDUuPkt2/13jzBTWTozsh7KyNydjYU4R+sSwR
         5pMJbrMEo5mDVsXE/2uNzUC7vFnu9g0qPV3gaswiEgGSr/FtF9hTbh8wWnO9OeWiQmE9
         stYw8LZFYhM3FCq8U3Jjv8R4rfPNC/JoVg9ZCEO4JEHfsJL6s9yGIlQ0pJ7dnlvtGm3V
         eiCg==
X-Gm-Message-State: AOJu0YzF4/nCYcAcCtRl03oroOcOp/9oDAIM9dxa0TbeBTS+ztGzkEUJ
	GfERBSnCHsS0VaP+xjV0k53wvEWXp0PATBUsVFKH4OeXZSzMjTXUmlge
X-Gm-Gg: AeBDiesM9g+4/6LgDYQTtWm5FxTvaZtmK/838Zdl1ZdSkApXNoNVmt/8cstpnc3W0Y9
	7KSmxia7epW0KGjMg+ezN7def2957K+yP5t3f50WZ3qkjZ875Y+uSsQRqEhwbcOLlOOaYxypS7P
	DjNGlxNvZ8e4MMCAhdDZfLRTrSrVBVtCifQKsa6ZFcBmg+sbuiazyGJ5V1e4LTFJOvqoWpb2Twi
	cVmKhcBdCAhjPRCzYBtKKJURFFFniyNSDa9GxLKv8g7epgnqLejMv9yVFeG13e4oMVxakpQVq3Y
	dshAbTDC52nq1TQg3LKQY0NBnDnvNKtcT08mPGJrgaMmBeLXn/Ed9CjDOi1sIK8tI4v4s2ZF3mJ
	NxNXtPCuns3bk9ZoISFEu0Kbf9EUskpkqTadVAmP/olSgsYP6oj9i79bUBeOWebdf1AEzqyb4O9
	cyr7b2AGE3DjlurgIf6Po+7bUApwVy7watQhtj8kI2QUN+7r6Y
X-Received: by 2002:a05:600c:4f82:b0:489:1dc6:d6e with SMTP id 5b1f17b1804b1-48e5325025fmr65769755e9.1.1778175443552;
        Thu, 07 May 2026 10:37:23 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:31::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e642e2b29sm1783655e9.1.2026.05.07.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:37:23 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 07 May 2026 10:37:07 -0700
Subject: [PATCH RFC 1/2] rcu: Expose per-CPU segmented callback counts via
 debugfs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-rcu-pending-cbs-stats-v1-1-8f4eb3553bc9@gmail.com>
References: <20260507-rcu-pending-cbs-stats-v1-0-8f4eb3553bc9@gmail.com>
In-Reply-To: <20260507-rcu-pending-cbs-stats-v1-0-8f4eb3553bc9@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Breno Leitao <leitao@debian.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

The existing rcu_segcb_stats tracepoint requires active tracing, so
there is no always-on, low-overhead way to inspect how many callbacks
are pending on each CPU and at which stage of the grace-period
pipeline.

Add a debugfs file at /sys/kernel/debug/rcu/pending_cbs
that prints per-CPU callback counts broken down by segcblist segment,
plus a "total" row aggregating across CPUs:

  - done:       Callbacks ready to invoke (GP completed).
  - wait:       Callbacks waiting for the current GP.
  - next_ready: Callbacks to be handled by the next GP.
  - next:       Newly queued callbacks not yet assigned a GP.
  - lazy:       Callbacks deferred via the RCU lazy mechanism.

The interface has zero steady-state overhead: it reads the existing
per-CPU rcu_segcblist.seglen[] counters on demand. These counters are
already maintained by the RCU callback infrastructure for its own
bookkeeping, so no new runtime accounting is introduced.

Example output:
  cpu            done       wait next_ready       next       lazy
  0                 7         11          0          0          0
  1                 0          3          2          0          0
  2                 0          1          8          0          0
  3                 0          1          1          0          0
  total             7         16         11          0          0

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 kernel/rcu/tree_stall.h | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b67532cb8770..d9fc9bfdaf96 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -71,6 +71,73 @@ late_initcall(kernel_rcu_stall_sysfs_init);
 
 #endif // CONFIG_SYSFS
 
+#ifdef CONFIG_DEBUG_FS
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+/*
+ * Debugfs interface for displaying per-CPU RCU callback counts broken down
+ * by callback-list segment.  This allows monitoring how many callbacks are
+ * waiting for grace periods without any steady-state overhead.
+ */
+static int rcu_pending_cbs_show(struct seq_file *m, void *v)
+{
+	int cpu;
+	long done, wait, nxtrdy, nxt, lazy;
+	long total_done = 0, total_wait = 0, total_nxtrdy = 0;
+	long total_nxt = 0, total_lazy = 0;
+	struct rcu_data *rdp;
+	struct rcu_segcblist *rsclp;
+
+	seq_printf(m, "%-8s %10s %10s %10s %10s %10s\n",
+		   "cpu", "done", "wait", "next_ready", "next", "lazy");
+
+	for_each_possible_cpu(cpu) {
+		rdp = per_cpu_ptr(&rcu_data, cpu);
+		rsclp = &rdp->cblist;
+
+		if (!rcu_segcblist_is_enabled(rsclp))
+			continue;
+
+		done   = rcu_segcblist_get_seglen(rsclp, RCU_DONE_TAIL);
+		wait   = rcu_segcblist_get_seglen(rsclp, RCU_WAIT_TAIL);
+		nxtrdy = rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL);
+		nxt    = rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
+		lazy   = READ_ONCE(rdp->lazy_len);
+
+		seq_printf(m, "%-8d %10ld %10ld %10ld %10ld %10ld\n",
+			   cpu, done, wait, nxtrdy, nxt, lazy);
+
+		total_done   += done;
+		total_wait   += wait;
+		total_nxtrdy += nxtrdy;
+		total_nxt    += nxt;
+		total_lazy   += lazy;
+	}
+
+	seq_printf(m, "%-8s %10ld %10ld %10ld %10ld %10ld\n",
+		   "total", total_done, total_wait, total_nxtrdy,
+		   total_nxt, total_lazy);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(rcu_pending_cbs);
+
+static struct dentry *rcu_debugfs_dir;
+
+static int __init rcu_debugfs_init(void)
+{
+	rcu_debugfs_dir = debugfs_create_dir("rcu", NULL);
+	debugfs_create_file("pending_cbs", 0444, rcu_debugfs_dir,
+			    NULL, &rcu_pending_cbs_fops);
+
+	return 0;
+}
+late_initcall(rcu_debugfs_init);
+
+#endif // #ifdef CONFIG_DEBUG_FS
+
 #ifdef CONFIG_PROVE_RCU
 #define RCU_STALL_DELAY_DELTA		(5 * HZ)
 #else

-- 
2.53.0-Meta

