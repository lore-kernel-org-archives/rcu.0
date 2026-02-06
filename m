Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06872D781B
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361600; cv=none; b=YYwwMtu5J4jpCLXDPItzP8xEaIu2WoR8JOzKgV6jbT+LF3TcTDGxxcES0Z5KtzZgAWR3wt+Z7TFZbThF7shKtMcCIFz8jKuLs9+hQcDNJVrUwhbVVsDL8FJKugEeYlddUYAAlUbD8YdQu+saEP235X9mnmfnbetu1NqT92T1+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361600; c=relaxed/simple;
	bh=cRGXAJ9NhW/NzVEKCmA+1l7ZHGfhEHYfUt6gp9Z4JXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+xAOsI6vcuHf37O3gLFo8divnVc+IYzqQB/7IenRXrR6S6NIQMrHYTD/0KcPo2dyMDXlurPd55viAW6qqHk50ZFASVpHrSs2ihUGouVXxeEEQMhR5qBea6J5XXAVF54IZu4rInVjcSwGOTh8D6jRrbXcqEFoLntq9iaJqcgpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXtl1wCf; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXtl1wCf"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1233c155a42so2439870c88.1
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361599; x=1770966399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdBkyzLJQCBMuraYhS3VTvGUYkyPg06X/JmuXKPVjWg=;
        b=cXtl1wCfz1Sqom3s4sJ/ZuMQxCuwJfil53ss55CqrkLwNGjTFkN3mp8y727ReWjWhy
         RJwv+S/8iGcxWQiHDudqSyyPUHsTiCx/y1kzQ/Em6n2cRhlkZxs2h7D1Kt3Yz52TCIT3
         Eu5sboJ4NvF8wmOI5tZMMfQqyIUucVpSnf5+fBCppNRTLbfdE/Eijskya9c3cSdDYmyR
         /moXSaBlwLl+IDlMfs4H3dj2YKckjE2h0tEyWZvmDg9N6FC4XTgah7IuX/9wkI+v1zgD
         iTXDZklf153XVWlDNz0U99iNN+NBjOpRZvqFLrDs6ZdOkQyEl4Fn4uKkL2+D7RYsOE+n
         LNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361599; x=1770966399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WdBkyzLJQCBMuraYhS3VTvGUYkyPg06X/JmuXKPVjWg=;
        b=IAK7gu1QkY5fcOHPb2KO/xYjTlDu0vYZkglbf4LfQC4YI0PxxLm4ViGcbd6BHHRdYF
         OJ6e4IUrN4UeQBBLEkktdJ8iMDA1c2rzHl5elbIbTEkYG1YQbqvpbKxDNsjxyy4rMLgP
         LN7ckCkpo0v0Ph9As3QYjZQh7yrh2RJw+zjXWYRlIdLvH2GZABR0XQlzkE3pPbwRJoh1
         vXKw158VTm/H/r/fRScLBpiw+YWnXP6p7YsfqKS7mLh0rODVxLecXO2j1EQ8GxdaqskF
         quIpG9fuyl2rjt8sFp8JMl9jqk6InQ7mC4+MoBuDU/7UV82waDAS9pHr/cj4lkRT+Vml
         K7xA==
X-Forwarded-Encrypted: i=1; AJvYcCW5rULu2cFAO1OSmhDTkcvz8vtyaQsXimUrLxZdoFX7fpIwjMQuqQ4GkdoYx1IOfbgT1oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqQ62GXQIwFnZr92bys25iQW9wfT+Eq0ox6WIunnUDr2feecq
	oErld/qK9gRz0nWWAyIfFaw7QyGoVjVO5yMKC5pKQI6PBkj6atgl3GYs
X-Gm-Gg: AZuq6aIuhkaoSUe1leRRd4fx9+4fUx3TD39r2aWW6wWn0Weq7CUnUXntr97hRwcXE9y
	5TdbEGEIOA1OfHo+dScikhvTxC33Fb4NrgJeOu3uvdrAcNxbjwrsrf3dLmguXrSyyHf4JMCALSZ
	7qhVIQ4o34UaffrmMo4nWxS7YwRiZPb9Rd6Js3xwjHS6eEKBvCUb20wLtnCyj960zRf2FZ0hrYc
	kYjJT8hn3b90B+YloVNFowMAu3dirXF9wARks07NjLYdlleWUPQkUDyCAHVjchfE++Bw9bJSE6a
	Pzb7P+wzAo22jt1AALFmp4e9ICAewDZDITrY/oLv3TXtZQNQ1kAnVd6vzs6AtLHuJZeJvv1qYk/
	rQQVKgOaQC+4OL8jfSW5AlhscPYJy9GCR0RkeAtSRzgd6LlTW6MB43SYNAU/uo4QPA2zw1q7Ddi
	t3fWnwQ+e+Zg==
X-Received: by 2002:a05:7022:4597:b0:119:e56b:98a4 with SMTP id a92af1059eb24-12703fe5655mr919986c88.11.1770361599017;
        Thu, 05 Feb 2026 23:06:39 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:06:38 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:31 -0500
Subject: [PATCH RFC 10/12] tick/nohz: Implement dynamic nohz_full state
 update
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-10-00a711eb0c74@gmail.com>
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

The nohz_full state (tick_nohz_full_mask) is currently a boot-time
configuration that cannot be changed at runtime. This prevents
dynamic CPU isolation from being fully effective, as the scheduler tick
continues to run on newly isolated CPUs.

Remove the __init restriction from tick_nohz_full_setup() and
tick_nohz_init(). Implement a housekeeping notifier in the tick-sched
subsystem to handle HK_TYPE_TICK updates. When the mask is updated,
the new isolation mask is calculated and applied, and all online CPUs
are kicked to re-evaluate their tick dependency.

This allows the kernel to dynamically enter or exit full dynticks mode
on any CPU at runtime.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/tick.h     |  2 +-
 kernel/time/tick-sched.c | 63 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index ac76ae9fa36d..40047523ec8c 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -271,7 +271,7 @@ static inline void tick_dep_clear_signal(struct signal_struct *signal,
 
 extern void tick_nohz_full_kick_cpu(int cpu);
 extern void __tick_nohz_task_switch(void);
-extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
+extern void tick_nohz_full_setup(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2f8a7923fa27..01d62dfc153f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -27,6 +27,7 @@
 #include <linux/posix-timers.h>
 #include <linux/context_tracking.h>
 #include <linux/mm.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/irq_regs.h>
 
@@ -619,9 +620,14 @@ void __tick_nohz_task_switch(void)
 }
 
 /* Get the boot-time nohz CPU list from the kernel parameters. */
-void __init tick_nohz_full_setup(cpumask_var_t cpumask)
+void tick_nohz_full_setup(cpumask_var_t cpumask)
 {
-	alloc_bootmem_cpumask_var(&tick_nohz_full_mask);
+	if (!tick_nohz_full_mask) {
+		if (system_state < SYSTEM_RUNNING)
+			alloc_bootmem_cpumask_var(&tick_nohz_full_mask);
+		else
+			zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL);
+	}
 	cpumask_copy(tick_nohz_full_mask, cpumask);
 	tick_nohz_full_running = true;
 }
@@ -643,10 +649,61 @@ static int tick_nohz_cpu_down(unsigned int cpu)
 	return tick_nohz_cpu_hotpluggable(cpu) ? 0 : -EBUSY;
 }
 
-void __init tick_nohz_init(void)
+static int tick_nohz_housekeeping_reconfigure(struct notifier_block *nb,
+					     unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	int cpu;
+
+	if (action == HK_UPDATE_MASK && upd->type == HK_TYPE_TICK) {
+		cpumask_var_t non_housekeeping_mask;
+
+		if (!alloc_cpumask_var(&non_housekeeping_mask, GFP_KERNEL))
+			return NOTIFY_BAD;
+
+		cpumask_andnot(non_housekeeping_mask, cpu_possible_mask, upd->new_mask);
+
+		if (!tick_nohz_full_mask) {
+			if (!zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL)) {
+				free_cpumask_var(non_housekeeping_mask);
+				return NOTIFY_BAD;
+			}
+		}
+
+		/* Kick all CPUs to re-evaluate tick dependency before change */
+		for_each_online_cpu(cpu)
+			tick_nohz_full_kick_cpu(cpu);
+
+		cpumask_copy(tick_nohz_full_mask, non_housekeeping_mask);
+		tick_nohz_full_running = !cpumask_empty(tick_nohz_full_mask);
+
+		/* Kick all CPUs again to apply new nohz full state */
+		for_each_online_cpu(cpu)
+			tick_nohz_full_kick_cpu(cpu);
+
+		free_cpumask_var(non_housekeeping_mask);
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block tick_nohz_housekeeping_nb = {
+	.notifier_call = tick_nohz_housekeeping_reconfigure,
+};
+
+void tick_nohz_init(void)
 {
 	int cpu, ret;
 
+	if (!tick_nohz_full_mask) {
+		if (system_state < SYSTEM_RUNNING)
+			alloc_bootmem_cpumask_var(&tick_nohz_full_mask);
+		else
+			zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL);
+	}
+
+	housekeeping_register_notifier(&tick_nohz_housekeeping_nb);
+
 	if (!tick_nohz_full_running)
 		return;
 

-- 
2.51.0

