Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06D33A6E9
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752339; cv=none; b=b/a57P5XBJSEZsVMQp0TPZY+iT2MhEnkNN3SD0XDUJpCrj76JeiJJt6/FtOrKDYyXZkQlNR/bt4m9Vr3pya4arJf2KAv5k+V1ycF7YXCe8pDis2SMmphlqRqCgYvyZ4Bv0WEOLprBz1hTTSr1RRAK7EbvTghk1zH4c71LsKNS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752339; c=relaxed/simple;
	bh=3HjydHuBQc8Yz/ieYczKmbxBkWvFg657XPocXx3aUSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YeII6LIivDEb42ElshAoMGfx661vxAJ7NyUes8xg3EM/gMLrWVFgFmKOHOuozyxSMymf9IFpFNQsRQSk7phQ+7mfv/43WnfDh5JZxgEm9dWIadRYy1wSMx9xqY6Iu30jWMZjs3L6b19Mp/K0n98f7uQtDNd+hHsNvg4vWAN+dkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/uq9dbg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/uq9dbg"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf2247e38eso5329475ad.3
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2026 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752336; x=1782357136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POSLMoWO52pf9/fOCCs2lrXk8F61Uty8Y4SKc9fV888=;
        b=r/uq9dbgmTSTgBtkQQFEDXdDvYL4SmgILgJ4iqOB5Uvjw1LpHYc2zeB1zrVw5ZvyVk
         u8SPn77jlToZzZLatU9Nbsin7wIImhw2+kThl4Louxqe6QPZaQ7EOqueg16cASSWmVjR
         HJmw2amKIE57qK3SWfLHjDWs+3iXJOVS4pGsidLOlEDb5oXUngZrdZI2KJrqYSxLCHxy
         Mihi0Plt733FUpYw6g0jRoa4L+NguZKhotv5RRP8vxak0goBovFNP+yOo5YM0tK0MruU
         BSq1qMKxYbDOtnwBDSGNxYoEBQUFPJ1C/7P7bFKnu+XNwIzBOINNVrThMACVY/1AORS2
         eWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752336; x=1782357136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POSLMoWO52pf9/fOCCs2lrXk8F61Uty8Y4SKc9fV888=;
        b=VK14/eteXwcBmPbbvdp2+ivjHSnJGqdDa3W3CJKn8bDJ1PsMVPjzLwy3JQV3hbT58s
         Ce69CmcTM+hyBUNhH5/BdJA/b8ora1bp5uK/+uzUYHDriHEEVPBkCMPOa1QGshV4fXF3
         fc1jY6rgG4x5PBvkbfQRmH+Bwc/qMLZz4VOqNa3lqTrmR5glQYngPbuSGQwv6/a7KVCa
         1fRNi3w5soUrLWd/fHGF3EoL0WoPMjITj/Zyk3uNmbdLoHeaC3HGuSHSst0usC8tmvTI
         jum52ssjTueGYFFETB0P5hOmCBUhqabvaAvb8JljzEURiHHzRAeuSqLBfpc0I0G5LrYH
         jFZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ODg6HGfTOn4ZQGqJwGb87P5o7Qo/40y9i2P6C++Cd1kQlb/kd2E/rUgCQK7GNMwCxd/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8uExS7xMFi9DfOFH2h3kx1KcsPYr0dBH1YmdNPnf4XUqMffe
	TllLFQFkH9QcSZEkRPb0cLTQgvEH/PLVDT9i0jDaNvlGwQU9kJ+RZgys
X-Gm-Gg: AfdE7cl72b9HxF73dIC85mRAwb0JThgMWYscMYypHpR4ovEkoi18Z0d66N66+MDrOOW
	UgQZY1M8wA4bAYFnIkad68xqE6uXduqF6Z/7v+EqBYbOqIRhCFBeFAsvnhCWrquWEb2eKcKFcKU
	VkhUIbxCHTVGEWIzX2C7M6lnDtw90l2karK9apIQ6VRtcRm7cSLjNaMpZDHBZgOdZgCg3q2WVDg
	fywBbjoOMFBpIcuZVxgl12Y1tYQMCtQvqt5VdcqR6KPQfWnJn9k2fABnXShnA3Q/A7doJ+HCPlW
	OSKcF1QpghvUUlg3YFAa/zf9ClrbYKpvxzExq+telX1w0M4TiZEgAtpJfTeJFqbLPu9yoem2JIZ
	HigfPUrgL3g5F0MDaIrUw5/d2HJdbPBqDEw7fP76Y0G36fackA7e+zm8oafUN+p24XdLJEPN+JW
	FIZvHfuzbJIJ0=
X-Received: by 2002:a17:903:b85:b0:2c6:cf7b:d34d with SMTP id d9443c01a7336-2c6cf7bd4fdmr41476075ad.13.1781752335960;
        Wed, 17 Jun 2026 20:12:15 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:15 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:19 +0800
Subject: [PATCH v3 08/13] genirq: Add explicit housekeeping callback for
 managed IRQ migration
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-8-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

Register a housekeeping callback for HK_TYPE_MANAGED_IRQ.  When the
mask changes, iterate all active managed interrupts, intersect their
current affinity mask with the new housekeeping mask, and re-apply
with irq_do_set_affinity().  Managed interrupts on CPUs removed from
the housekeeping set are migrated to remaining housekeeping CPUs.

Only managed interrupts (IRQF_AFFINITY_MANAGED) are selected because
the kernel owns their affinity; user-controlled IRQ affinities must
not be overridden by the housekeeping layer.

The new HK_TYPE_MANAGED_IRQ cpumask is snapshotted once under an RCU
read lock before the IRQ loop, satisfying the lockdep annotation in
housekeeping_cpumask() for runtime-mutable types.

When the intersection of the IRQ's current affinity and the new
housekeeping mask is non-empty, irq_do_set_affinity() moves the IRQ
to the restricted set.  If the intersection is empty (all CPUs that
were serving this IRQ are now isolated), the affinity update is skipped
and the IRQ continues to run on the isolated CPU temporarily.  Full
support for the IRQ shutdown / re-startup path (when all serving CPUs
become isolated) is left for follow-up work.

Guarded by irq_lock_sparse() and per-descriptor raw_spin_lock to
prevent races with concurrent affinity changes.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/irq/manage.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2e80724378267..ea97f455eab2a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2801,3 +2801,89 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	return res;
 }
 EXPORT_SYMBOL_GPL(irq_check_status_bit);
+
+/*
+ * Managed IRQ housekeeping callback: iterate all managed IRQs and ask
+ * the chip to move them off CPUs newly removed from HK_TYPE_MANAGED_IRQ.
+ */
+static void irq_hk_apply(enum hk_type type)
+{
+	cpumask_var_t hk_mask;
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	if (!alloc_cpumask_var(&hk_mask, GFP_KERNEL))
+		return;
+
+	/*
+	 * Snapshot the new HK_TYPE_MANAGED_IRQ mask under an RCU read lock
+	 * before iterating IRQ descriptors.  The lockdep annotation in
+	 * housekeeping_cpumask() requires an RCU read-side critical section
+	 * for runtime-mutable types.
+	 */
+	rcu_read_lock();
+	cpumask_copy(hk_mask, housekeeping_cpumask_rcu(HK_TYPE_MANAGED_IRQ));
+	rcu_read_unlock();
+
+	irq_lock_sparse();
+
+	for_each_active_irq(irq) {
+		desc = irq_to_desc(irq);
+		if (!desc || !desc->action)
+			continue;
+
+		/*
+		 * Only managed interrupts are selected: they have
+		 * IRQF_AFFINITY_MANAGED set, meaning the kernel owns their
+		 * affinity.  User-controlled IRQs are intentionally skipped.
+		 *
+		 * When the intersection of the current affinity mask and the
+		 * new housekeeping mask is non-empty, re-apply the restricted
+		 * affinity to migrate the IRQ away from newly isolated CPUs.
+		 * If the intersection is empty (all serving CPUs are now
+		 * isolated), the IRQ is left on its current CPU temporarily;
+		 * handling that case (IRQ shutdown / re-startup) is left for
+		 * a follow-up.
+		 */
+		if (irqd_affinity_is_managed(&desc->irq_data)) {
+			const struct cpumask *mask;
+			struct cpumask *tmp = this_cpu_ptr(&__tmp_mask);
+
+			raw_spin_lock_irq(&desc->lock);
+			mask = irq_data_get_affinity_mask(&desc->irq_data);
+			cpumask_and(tmp, mask, hk_mask);
+			if (cpumask_intersects(tmp, cpu_online_mask))
+				irq_do_set_affinity(&desc->irq_data, tmp, false);
+			raw_spin_unlock_irq(&desc->lock);
+		}
+	}
+
+	irq_unlock_sparse();
+	free_cpumask_var(hk_mask);
+}
+
+static int irq_hk_validate(enum hk_type type,
+			   const struct cpumask *cur_mask,
+			   const struct cpumask *new_mask)
+{
+	if (!IS_ENABLED(CONFIG_SMP))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+static struct housekeeping_cbs irq_hk_cbs = {
+	.name		= "genirq/managed",
+	.pre_validate	= irq_hk_validate,
+	.apply		= irq_hk_apply,
+};
+
+static int __init irq_hk_init(void)
+{
+	int ret;
+
+	ret = housekeeping_register_cbs(HK_TYPE_MANAGED_IRQ, &irq_hk_cbs);
+	if (ret)
+		pr_info("genirq: managed IRQ runtime migration disabled (%d)\n", ret);
+	return 0;
+}
+late_initcall(irq_hk_init);

-- 
2.43.0

