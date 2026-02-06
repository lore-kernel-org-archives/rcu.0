Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3A30AACF
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361528; cv=none; b=sRV++DrNod3Z5wo4IEeYEXNbXZnrE4R3mrmlEzjR57hDiX8rM4/bbRqRMq2FiTIJmj0CPrtTpnfRYTyOGg4Dtdgfliudb6krc4vSzkX8dAkUiRWN4SMDwiyzxbW9tf7QnqSTfwQSsZhZ0WadO4cwmWc60rCn9zJALWgBKtTTbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361528; c=relaxed/simple;
	bh=jQlgM95JazGPee4Uxm5VsMs1dWBVBeceOIcoQGdsSOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLa6AS64awHznPBZS5XF1iTOEd/8Nfs2Q+PAGOe7Q/0f+lWMEQCFisUT5o/RBRgMzz2Bd4AMouWC99aIrYtzgZlvV9GgqcuVoM7J5uA4C+ke+h7IsWYHSEsI+0WfpKnmCZHBvP56yL1t+d33o325mPIXd56mVuayZs1o6OkvwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+YHvZZ+; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+YHvZZ+"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124a1b4dd40so2149392c88.0
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361527; x=1770966327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YEyu0s9ArePSjQ+ivxTOHvq670EsiUwyYwwidqduHM=;
        b=H+YHvZZ+kjA0FqfemVYPcHFHGxGaoA+zs7ULeKkfe4V5gCGu35Trnz5OVnRo68V2Hv
         hVMB9RzqLX02PvgAlIKu4QpmNwLJh452HTFlRAnnY5NIaxOFx6OMDrSfz21MbF2yQnTj
         qIMenKih62LfgEc6chQJeZKxwwY3ov16Q801tnkxw/Z5b9RaKDwwvR5zEPAah5OZN1os
         a9MJivXtUvmkw8dtFTkuKLBKp3xPF5HDpEjD+HoZR0nb79CXN4qQq5geWh69se8mJylk
         yDDticJ+CmHkEsYULIgeC/K2dFufKxEDvvnPqaJWk4BFyP2fG0tkS2Qb2xSiK7e2S3F1
         p7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361527; x=1770966327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5YEyu0s9ArePSjQ+ivxTOHvq670EsiUwyYwwidqduHM=;
        b=AvQ00uZOxIBM3CPMg2gfd1fVd4aWXifvSiAAP+Oqu1MEbwNxQHJSeyccELK6RKJvJI
         1ablXbwhDbmin+sWwnhe2LewWSjTojSshGyAdedjEdlPKziUJGmdRsFWYEtpAw29QDBK
         kGSA2b4RBzsvUVQMs9j3zyuAR27qIBeIWaZvhyB2zALTR8ijs49RgjnUEtL8pWw1Sb48
         GeZqEHcCGGqE4pFsdvAt4n7eZeaVfIIcY536Nh9ZD73ZrJqUzlEXq+oxUomqARVY+ZAN
         HdJzqiGDdOoNmUmiXH52OgZFeQ+mnox8UwvN7Eupwi7ErQXUXcACgkaz7fmQk2ss23X+
         FgtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm1uZBxmYnoTLvciV6uFdzx19Cdf04WsOBEeQJTBJmLGQSwx+Uwgg6z8sAdqKTq8WRT9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhgn4EsH/TSLdoVysdrZ1Wg6XP6VKKYmxEVF30Vio7smGooopn
	tUJxzfNYqUMl7qKj842OX2L38JjxF7ZfScBwMQUnn+2ybbzDzLdr5uegebfRQtro
X-Gm-Gg: AZuq6aLhlr/pvQEQBaA/SwVe6wMgoV4A9Hc0BrZDfhNjrBZqq+TyIuQH3NZHQlwEeQq
	5h5+qhN180R/WXyzTGwwfIupX0OwkEyZSYaN16xUF7Eiy/X34sZ464n37NwAf8jP/UGdyLOkBOJ
	CfdzoGToDX4CByXlK1IimSp92i8b9WNzCYBzOdo0SJ/XkdVXpB113J7r8HVOrFHbXhe9qexn11+
	HzMb+RBGs6CE+ka9NL4j2poJvBXUU6VKhDIPO0uK+Ncm8cOmPI9eE5mh+dEJNkANyuFMtB/U07a
	K84Xxy93tfFtOys/sD9KJRJGO9v1XflX4Ehtvs/Nz4AnpRF2vg4w156kk5vEoUYq3qLhxAXFGJ4
	o6vO1k27OZkNn33xTs8S23uf/8B3MBqVcKOaS+cLsum+waUP23ij19bnIGnPnKGWUFYsZ8Eg2y0
	U09jMdI+lwHg==
X-Received: by 2002:a05:7022:222a:b0:11b:9386:825c with SMTP id a92af1059eb24-1270402ea16mr1071439c88.41.1770361526887;
        Thu, 05 Feb 2026 23:05:26 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:05:26 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:24 -0500
Subject: [PATCH RFC 03/12] genirq: Implement dynamic migration for Managed
 IRQs
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-3-00a711eb0c74@gmail.com>
References: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
In-Reply-To: <20260206-feature-dynamic_isolcpus_dhei-v1-0-00a711eb0c74@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 Qiliang Yuan <realwujing@gmail.com>, Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.14.3

Support dynamic reconfiguration of CPU isolation by making the managed
interrupts responsive to housekeeping mask changes at runtime.

1. Register a housekeeping notifier in the genirq subsystem to listen
   for HK_TYPE_MANAGED_IRQ updates.
2. Iterate through all active interrupts when a mask update occurs.
3. Re-apply affinity for managed interrupts to ensure they honor the
   newly configured housekeeping mask.
4. Use irq_set_affinity_locked() to trigger migration away from newly
   isolated CPUs or towards newly designated housekeeping CPUs.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/irq/manage.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 349ae7979da0..9523f0655b12 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -21,6 +21,7 @@
 #include <linux/sched/isolation.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/task_work.h>
+#include <linux/cpuhotplug.h>
 
 #include "internals.h"
 
@@ -2811,3 +2812,54 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	return res;
 }
 EXPORT_SYMBOL_GPL(irq_check_status_bit);
+
+#ifdef CONFIG_SMP
+static int irq_housekeeping_reconfigure(struct notifier_block *nb,
+					unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_MANAGED_IRQ)
+		return NOTIFY_OK;
+
+	irq_lock_sparse();
+	for_each_active_irq(irq) {
+		struct irq_data *id;
+
+		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
+
+		scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+			id = irq_desc_get_irq_data(desc);
+			if (!irqd_affinity_is_managed(id) || !desc->action ||
+			    !irq_data_get_irq_chip(id))
+				continue;
+
+			/*
+			 * Re-apply existing affinity to honor the new
+			 * housekeeping mask via __irq_set_affinity() logic.
+			 */
+			irq_set_affinity_locked(id, irq_data_get_affinity_mask(id), false);
+		}
+	}
+	irq_unlock_sparse();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block irq_housekeeping_nb = {
+	.notifier_call = irq_housekeeping_reconfigure,
+};
+
+static int __init irq_init_housekeeping_notifier(void)
+{
+	housekeeping_register_notifier(&irq_housekeeping_nb);
+	return 0;
+}
+core_initcall(irq_init_housekeeping_notifier);
+#endif
+
+

-- 
2.51.0

