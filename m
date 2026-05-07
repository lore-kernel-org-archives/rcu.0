Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75213016E1
	for <rcu@vger.kernel.org>; Thu,  7 May 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175448; cv=none; b=ZguGB4hVWHfkebCVpSDLEuVwzSaKdXpiuAe99J9zzwVDMU/H18lhhQlmlg9RLgJegpsoaRW+emyKs1pfaFGNdr9+ltvxgLr2dwa7fQ/Q2gcM2txxWYQSgUVQXSyp4O5hff3V/nFt/i9G6BhmmQVZgA9vjNvuk2Kq2aqgEW7FFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175448; c=relaxed/simple;
	bh=l7KGEw/jIvRFRP4JsY7iWYkaxDnkz7gre6btZ5ip+6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C3t4FO60OLfTcIf2Vn2VGZPe1/BwcAbGQQBW2/aL74VogTU8Y9p2XZmfmj/6qRlsnYFNSXCYq5Ysq4GzuKPh2ALZhkU2uTa73GwelcKKxLnt7WKjeEUIM4zXawTyGdP2aZzk4aCMJV+V/dnxIExPtuv8WJloJWfx778jmxJP1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrBT2vLC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrBT2vLC"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891b02a0acso1203645e9.3
        for <rcu@vger.kernel.org>; Thu, 07 May 2026 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778175445; x=1778780245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VghPIaZzCAjxosZReVf3XTbKbvkZLjDIPPTIuyF9bg=;
        b=CrBT2vLCrVUTDc7uz7LhB7xXh7Kr/0C0IpFH5OlO0pGnU/JsgLfJTcyoNjyHhrH+ks
         7BchJynWeLMhcFZFPuGRQkDQTfgPU10B/nWrXcB5R6Ywch0YaZn7arcuquHQ0wMiSB99
         xnxX11nD/mhI3KmVcvV0NLoYBKaOC6rWemtAHxiA0ffVOb4vQMBkycGs2MfiHM71HYQK
         pko0g48WnqZEiA3RedtcuJWM1u3BBWyRcmClRd1bSU9xzZneqXE8OTTTuNsKFnJRnwdv
         69dvZ6EnUVL6jmZZIndxZJtH38hlKaJERqjQq7PIBVg12ZjX6E/cZp63K6P9kJMDuELO
         mNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175445; x=1778780245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7VghPIaZzCAjxosZReVf3XTbKbvkZLjDIPPTIuyF9bg=;
        b=HcAwnIQWGhtPTr3GAdTCJQ8Mi8ydNwfaAoIM9W0+k+UIrsfTIa/TB3uT1CEclZHtbq
         4sHSuSFp+jEEtfJtIX1tFzEDZNYT1PkdZu6kWkBn4sC9n8xqP72qU0CcZi8Z2UzGuWn8
         j+j4z9H3nvThe4pkA1+LjSA2INoGfDm3K95q8XeYfoHsYr7r409dJ+Urf8ny7Pl0EzYp
         FY2FbU2a4lEigtjzxUBcBfpHznkaoL386NNTzb3kEUezMIGQLiUBZBFq5qAC59iwnNP/
         Efz7oH0JLeWy88C6sSx1DwaB5XdBxN+6gM0ZLtxeYf4ZqLY96mqOMuD+iz8QQh664/1C
         LoFw==
X-Gm-Message-State: AOJu0Yyol8giNCSjij1JaP9mRjPzAwN4BIm+Cn1dkX33q/8+sSCSnJ9q
	N/zFi+bC811NBDDR17wFhLAkJgrPj1FSnGFrQ7W+bi0sKWqN5nGyGUgD
X-Gm-Gg: AeBDieteR6I8/tw7YIX9DKy9DTByknhG1QX3FODzQCCdAW5AKDbAT67PyYGNNF1AdKB
	WPSGA6Ezux/DksUNE7/SihAwfSILmp9gUQlzyy0RO4v9Fkq3zlcZieV8v285d8I6QlsbRtVOPmI
	yVYKr9kerwWAZ4HN3XhQXL5+wr6/e6UhpCZTjjYZhx07ZX/BrAvu5RFcP6AVTcvO1L0GDZPN5H0
	8/dpY8G6jg8gRyC4EtC8IvZZqDVQXcs2U7PE7hI57FCs7NJ5JDGtPMdbxmOXeUZtHc3RhFYcBk+
	zvANLTZxU8ExDs3WCb5DbG6fZXomoq7AbTFPIL7oeKfWQa3KrnmgHobEXW63ZHkUXOkg1jJx8su
	dnUXkPDos8TtbI9aUIFl5J+tbT6PldMdD95vsQFEsAohpcPR7lv5gpRibbS5PdM6/xHD0e+kZsr
	v5Wifcghc/MCmfPoq6/fWbI9lrA53hBHqkn1HnbW5dc3jkllDj
X-Received: by 2002:a05:600c:4f82:b0:489:1dc6:d6e with SMTP id 5b1f17b1804b1-48e5325025fmr65770315e9.1.1778175445266;
        Thu, 07 May 2026 10:37:25 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2a::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e64300592sm896785e9.13.2026.05.07.10.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:37:24 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 07 May 2026 10:37:08 -0700
Subject: [PATCH RFC 2/2] rcu: Include kfree_rcu/kvfree_rcu batched counts
 in pending_cbs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-rcu-pending-cbs-stats-v1-2-8f4eb3553bc9@gmail.com>
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

The batched kfree_rcu()/kvfree_rcu() path (CONFIG_KVFREE_RCU_BATCHED)
manages its own per-CPU queues in struct kfree_rcu_cpu, bypassing the
main RCU segmented callback list.  Objects queued through this path
were not visible in the debugfs pending_cbs file.

Add a kfree_rcu_pending() helper that returns the number of objects
waiting in the kfree_rcu batching layer for a given CPU, and include
this count as a "kfree_rcu" column in the debugfs output.

Example output:

  cpu            done       wait next_ready       next       lazy  kfree_rcu
  0                 0          0          0          5          5         12
  1                 0          0          0          3          3          8
  total             0          0          0          8          8         20

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 kernel/rcu/rcu.h        |  1 +
 kernel/rcu/tree_stall.h | 17 +++++++++++------
 mm/slab_common.c        | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index fa6d30ce73d1..a28c3c7dc4da 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -652,6 +652,7 @@ void rcu_fwd_progress_check(unsigned long j);
 void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
 extern struct kthread_worker *rcu_exp_gp_kworker;
+int kfree_rcu_pending(int cpu);
 void rcu_gp_slow_register(atomic_t *rgssp);
 void rcu_gp_slow_unregister(atomic_t *rgssp);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d9fc9bfdaf96..5fd63730d5f5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -84,14 +84,17 @@ late_initcall(kernel_rcu_stall_sysfs_init);
 static int rcu_pending_cbs_show(struct seq_file *m, void *v)
 {
 	int cpu;
+	int kfree;
 	long done, wait, nxtrdy, nxt, lazy;
 	long total_done = 0, total_wait = 0, total_nxtrdy = 0;
 	long total_nxt = 0, total_lazy = 0;
+	int total_kfree = 0;
 	struct rcu_data *rdp;
 	struct rcu_segcblist *rsclp;
 
-	seq_printf(m, "%-8s %10s %10s %10s %10s %10s\n",
-		   "cpu", "done", "wait", "next_ready", "next", "lazy");
+	seq_printf(m, "%-8s %10s %10s %10s %10s %10s %10s\n",
+		   "cpu", "done", "wait", "next_ready", "next", "lazy",
+		   "kfree_rcu");
 
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -105,20 +108,22 @@ static int rcu_pending_cbs_show(struct seq_file *m, void *v)
 		nxtrdy = rcu_segcblist_get_seglen(rsclp, RCU_NEXT_READY_TAIL);
 		nxt    = rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
 		lazy   = READ_ONCE(rdp->lazy_len);
+		kfree  = kfree_rcu_pending(cpu);
 
-		seq_printf(m, "%-8d %10ld %10ld %10ld %10ld %10ld\n",
-			   cpu, done, wait, nxtrdy, nxt, lazy);
+		seq_printf(m, "%-8d %10ld %10ld %10ld %10ld %10ld %10d\n",
+			   cpu, done, wait, nxtrdy, nxt, lazy, kfree);
 
 		total_done   += done;
 		total_wait   += wait;
 		total_nxtrdy += nxtrdy;
 		total_nxt    += nxt;
 		total_lazy   += lazy;
+		total_kfree  += kfree;
 	}
 
-	seq_printf(m, "%-8s %10ld %10ld %10ld %10ld %10ld\n",
+	seq_printf(m, "%-8s %10ld %10ld %10ld %10ld %10ld %10d\n",
 		   "total", total_done, total_wait, total_nxtrdy,
-		   total_nxt, total_lazy);
+		   total_nxt, total_lazy, total_kfree);
 
 	return 0;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index d5a70a831a2a..93b5d64399f2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1280,6 +1280,11 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
+int kfree_rcu_pending(int cpu)
+{
+	return 0;
+}
+
 void __init kvfree_rcu_init(void)
 {
 }
@@ -2216,4 +2221,17 @@ void __init kvfree_rcu_init(void)
 	shrinker_register(kfree_rcu_shrinker);
 }
 
+/**
+ * kfree_rcu_pending() - Return number of objects pending in kfree_rcu batches.
+ * @cpu: CPU number to query.
+ *
+ * Returns the number of objects queued in kfree_rcu()/kvfree_rcu() batches
+ * on @cpu that are waiting for a grace period.  These objects are tracked
+ * separately from the main RCU callback list.
+ */
+int kfree_rcu_pending(int cpu)
+{
+	return krc_count(per_cpu_ptr(&krc, cpu));
+}
+
 #endif /* CONFIG_KVFREE_RCU_BATCHED */

-- 
2.53.0-Meta

