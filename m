Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC134EEE3
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429814; cv=none; b=eTkAF2UFyunqSk/3edncKHkUfyCZOON7m2E7ohQt6yKZpR3jbjJYdcljkDhl03n3udF2pSEKXL95ItGfWtbWM2cfYnwXTu/z+mJH8+QqMtHJ/cRAxR5HhfAo/IH1J1YrmpWjXd1fSDaa+15EHGXNMhvf54DI+6tqRBv4J5M9iC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429814; c=relaxed/simple;
	bh=/0ovyB5zfodZHwmFZ8NkbanEJgNkXF5wQsXFoCBPlyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETOxrJg78WRtk7Uw7Q9urJgxc727QgWv83ylgtFl/X37of4HlgaOPwckw+LobTLsk8oZ3c0LCBTSFUQbslosi0q8tX/gMmeVO3MBmaiiYCc3ZiXjTp30OBE2IduT8+7bpdsbyPbYkhSJf2FTFAN4GU6q2MUTLBDNidv2xWgVVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJRBJNlj; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJRBJNlj"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso594995eec.0
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429812; x=1775034612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zwKknmbpTRf8fr0/fDVF5xzUAulDUeqLVmO9Qgf9Ag=;
        b=QJRBJNlja3cpXbnORXAUKxUiOCbhlmTSfGyK+41eW4pj8HyTyIQo3ly0dyVe5Pv0B9
         QKJ8nVoPIDy4nafYnnoQ4D8LIr188nZtCGTpPXL+hh1Cqo/FgC8B6Jj8HbHtI+x25y8j
         IcjaHO/Ki8en2aZjPjPhr3QGnw3wMRG/OY8JHMAsLhO/MKHrs5QLm1dMeg4VCSSC0H08
         m2gaLye5njHj6byGmsUn4DNHQPGq6WOxshHnCWLvjjDcm/gg2oCKtmfSVJo0WpfUnN/7
         hg+byW0ZxqijsGwkqxKyHG9TrYVWybBwMTYsVLxv9iZAd3Vss9h75JCsptvJF1AFV6DL
         wwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429812; x=1775034612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+zwKknmbpTRf8fr0/fDVF5xzUAulDUeqLVmO9Qgf9Ag=;
        b=ANb5TvGhbJk+MBYPwnGgN9j3tRmPkYbGmmGuSh0GPCs9rDWX6dvfNtM0KOp3nbaFAe
         xo0esDjwZbz+s7H2JU65vtf1MTssJUfVLakDYFmtcahEQ+clk95TjEhAsPf5FkFfVFKX
         dVyZgWLiI8EkNbVfilkpBDdsTlceNjTFg2JSrQ+TgBCZvHItGHzuICXRXlGy0yqui02/
         IZ9ANkE1yxSTfKe0NWR8fq77AgaBy6iNC6QUoo+ZSPxZkQC4++pOPe7J6p4aFlc1DexG
         rnByQR5ewUB7rnwVTt9BD24g5K1kT9k5vkiYP+wO5kNN7E6XI0HEXgexGf7/fjbdSJMJ
         edFw==
X-Forwarded-Encrypted: i=1; AJvYcCUL4oHbX1ZeUPmcYNMdAHdB4jR4rnhhGgndbiAEjIRvA83+e2WNuj0vjacN894H6m+9YN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrfbWQKi+5ZFAS+GsgvUfbW5pRKAk/HmUm94A0JZoDGgW4V8Q
	9WGUDrlUVLZtrRU1OTxyoHJevYFm09TJhuaG2HGcwmsXLFmwWOpHheBE
X-Gm-Gg: ATEYQzwex7VazA2LIeJvb/PhsPZxXjhAGXvEfH6nOlo/OV+22pdWqSjfZReKBHR8PK4
	Aa5cq/yiUQSf06RDtIXBfXx/B1RUhLVMYZxlY6RW0PBGHEFq2oWLcWkpz9BKMH1jro0d78TIOz4
	uxY/ppfHjIDYYC2GjHuNIWY9lHOJFWjhvaeN1+6DURTclzpDQTq+0DahPlhvyJS5+RIpUN0rw4P
	2KO+iB5A2Xo3LpYZ7iQYHP3ryHPQyEjISiSEb7GwXE8IbaYzL0y3iwXSWtniroDBK0yDZIrtvOT
	iQbfJO8KISX9Vj4RUOb9RpIYzoSzJpHzqZEzRN//zDCuuurz9u0eWqb4vCrPyyXLPLWmgboQhU2
	sbsTQVMqMlGpAG1FSPoMXZzAevmeQlfGIEjptkqBK4MP3+QXHphp3/Bqe4Jk5qv9K0jr5+O24La
	BEX/7lJqfM/jvLhk6u
X-Received: by 2002:a05:7300:7fa7:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2c14b58eb90mr2643092eec.11.1774429812245;
        Wed, 25 Mar 2026 02:10:12 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:10:11 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:35 +0800
Subject: [PATCH 04/15] genirq: Support dynamic migration for managed
 interrupts
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-4-919cca23cadf@gmail.com>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
In-Reply-To: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
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
 Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Managed interrupts currently have their affinity determined once,
honoring boot-time isolation settings. There is no mechanism to migrate
them when housekeeping boundaries change at runtime.

Enable managed interrupts to respond dynamically to housekeeping updates.

This ensures that managed interrupts are migrated away from newly
isolated CPUs or redistributed when housekeeping CPUs are added.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/irq/manage.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 349ae7979da0e..f2cba3d7ef624 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2811,3 +2811,52 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	return res;
 }
 EXPORT_SYMBOL_GPL(irq_check_status_bit);
+
+#ifdef CONFIG_SMP
+static int irq_housekeeping_reconfigure(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	unsigned int irq;
+
+	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_MANAGED_IRQ)
+		return NOTIFY_OK;
+
+	irq_lock_sparse();
+	for_each_active_irq(irq) {
+		struct irq_data *irqd;
+		struct irq_desc *desc;
+
+		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
+
+		scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+			irqd = irq_desc_get_irq_data(desc);
+			if (!irqd_affinity_is_managed(irqd) || !desc->action ||
+			    !irq_data_get_irq_chip(irqd))
+				continue;
+
+			/*
+			 * Re-apply existing affinity to honor the new
+			 * housekeeping mask via __irq_set_affinity() logic.
+			 */
+			irq_set_affinity_locked(irqd, irq_data_get_affinity_mask(irqd), false);
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

-- 
2.43.0

