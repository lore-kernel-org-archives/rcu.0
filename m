Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D863988E8
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066288; cv=none; b=A3pNlrOztEh3KIZsbdB8wlM0b6IEFtq6dwSsT+0NSDMFijeZfSCntSqJVNbqLslq+UfB8rcPjbdoFt0+p5fqSvPRkgChO/NRadeWGiMgW/hqFSwcGIL4K3ruPdB4jeVfhjwTO3KSh4okgDP5A3U/VqBQBIjaJlsufj1HPOqTYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066288; c=relaxed/simple;
	bh=kiArkSt0flIs7bU/fXEY7xT5bOeGaqUbcFrMu1wIeUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4OOBvbrnAvkBqwD+MvwHzIgkRtvt4nn/hoLUWvZ6dP9ZGPHBxtu4tAT5rGo+nqc6ddpb1LHtD4qmE88c88gseGJL3Hr1KqfF8iThTmhBd0T+wnzRxZ42AJsez/5WTYnG5n9IUInn6HQfJbWr5UQMK3Zv3mAxLBtCi7lp8aHUrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgnwjA3T; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgnwjA3T"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c42a23c8eso1497790c88.1
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066286; x=1776671086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyDvJikQxepnDoa9At7D55yqji9L3lHPWXvHJrxbFWg=;
        b=lgnwjA3TLeboVOt7tdBB7T2Z/AXluc+LVd2DZ6NLe5wr4foxO2TQapCKhLZt0YH0be
         T+ZYkABD3ysqa/LweE+RXd+eUEgTor2n+X+gUFM+/QYv0oTmkTyr14bD7IgSrMrrzdjW
         mpoHKgALSgQzPqfJHANCccwE7vS7+QQEeSUOgKsdEbJLbJ+OweLbJXW9Sk0kfce2E1ib
         MWWIbPqmgg5dNvtsLb2ZgdlRdxYo8I3nSRY4T3J2fc7C3VEMCfbHprhE6kTzVflo/wL9
         BbqOm+Z/pBstDD60zpS6YewnhcTDPCbPAO/Jre1woxVaEkYPy849EpuqasTS7OfaPNeM
         ejVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066286; x=1776671086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CyDvJikQxepnDoa9At7D55yqji9L3lHPWXvHJrxbFWg=;
        b=W0sNMdvSDGAovEmh90vp1szQ97BCq5nBkDLPZ7oTivLuNt7UN59jO8xlVuqbBwOzch
         82bRYsh5YsyBw/wdO2XsLDMuDA8qg/33/h5huJbhObrsu47cGLaKbNe9Iye/Nn4LdfpZ
         n65e8xx6eh6oM1TJhFov42IfSHvebk6Uo7z8vywOF8GrVrwuobGUVnAxFXQA0Mb5YhYM
         PR0rxGExTOfwvbVoSRKoG+ArVA9/djtAn95fg7bdWeubbiGYx/N34ydls8uKPKOpLfCl
         lMCgZaiZluhK4jBMMcDd1ZM9J7hqlSty38mE5aP3+ey5bJODwtv3pxXxpg6G42uFUUbd
         rjbw==
X-Forwarded-Encrypted: i=1; AFNElJ/o8NQrEkIi7zZmSh/aoymMf3fug3O1MM0hBXNy/emfo8MEK/egWTN8cRqraz7DuBbKcsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTt3RRyFWREBs1bVJrIV4jLhJUax/ac+TehqwlAvF48bNJaHho
	xD1UaWCAptQYXcxtVY4BgEfiLTHRZe7BGwH8CdQi03qScBq9dfPklSrx
X-Gm-Gg: AeBDievsYFZTGddz12nzcuewGYi0p627YBAV/qYTNgcHQ4ek5qk7+Nx4GGfVHdCAvPi
	qB+Cd1CwpudJ+3oEQC3iV2q8e8Ia8CORyuuw1yxByzTwj9jksF9GfT6YoWFZCNj2h4+DCgD1+dr
	IrcJVwZzKAk0rbcykpSr5jNIdr1tDA6ct3jgilS/IonOfO4HibJbMTdCYbLb8NspEasm1CJpOF7
	gGSl3NN0iKyAOFDIk9V7NdcXlyUmL3X9lS+6BjWvI6wjo0rLMqjJyny91uUW15uV4E3Kf5YzI1q
	N3NX+Qz25GoytsY7cG6UM399BW/os0Ge4T94dSu56QmMloEFxSmlQ2df4Hroy5G3u1PvE0TfWYe
	GTdbh2JcisbL2v5loXZu5t55LQE52nK0nzeEe7eA/E71RtTeJI5mnuBPfz/UJ7N63vGMs+ZllgB
	CsKARhHv5rMkmqjQHD
X-Received: by 2002:a05:7022:61a2:b0:128:d51a:5157 with SMTP id a92af1059eb24-12c34f1449emr6389794c88.33.1776066286323;
        Mon, 13 Apr 2026 00:44:46 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:44:46 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:14 +0800
Subject: [PATCH v2 08/12] workqueue, mm: Support dynamic housekeeping mask
 updates
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-8-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
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
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Unbound workqueues and kcompactd threads determine their default CPU
affinity from housekeeping masks (HK_TYPE_WQ, HK_TYPE_DOMAIN, and
HK_TYPE_KTHREAD) at boot. Currently, these boundaries are static and
are not updated if housekeeping is reconfigured at runtime.

Implement housekeeping notifiers for both workqueue and mm compaction.

This ensures that unbound workqueue tasks and background compaction
threads honor dynamic isolation boundaries configured via sysfs or
cpuset at runtime.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/workqueue.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 mm/compaction.c    | 27 +++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index eda756556341a..354e788004b48 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -8008,6 +8008,47 @@ static void __init wq_cpu_intensive_thresh_init(void)
 	wq_cpu_intensive_thresh_us = thresh;
 }
 
+static int wq_housekeeping_reconfigure(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	if (action == HK_UPDATE_MASK) {
+		struct housekeeping_update *upd = data;
+		unsigned int type = upd->type;
+
+		if (type == HK_TYPE_WQ || type == HK_TYPE_DOMAIN) {
+			cpumask_var_t cpumask;
+
+			if (!alloc_cpumask_var(&cpumask, GFP_KERNEL)) {
+				pr_warn("workqueue: failed to allocate cpumask for housekeeping update\n");
+				return NOTIFY_BAD;
+			}
+
+			cpumask_copy(cpumask, cpu_possible_mask);
+			if (!cpumask_empty(housekeeping_cpumask(HK_TYPE_WQ)))
+				cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_WQ));
+			if (!cpumask_empty(housekeeping_cpumask(HK_TYPE_DOMAIN)))
+				cpumask_and(cpumask, cpumask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+
+			workqueue_set_unbound_cpumask(cpumask);
+
+			if (type == HK_TYPE_DOMAIN) {
+				apply_wqattrs_lock();
+				cpumask_andnot(wq_isolated_cpumask, cpu_possible_mask,
+						housekeeping_cpumask(HK_TYPE_DOMAIN));
+				apply_wqattrs_unlock();
+			}
+
+			free_cpumask_var(cpumask);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block wq_housekeeping_nb = {
+	.notifier_call = wq_housekeeping_reconfigure,
+};
+
 /**
  * workqueue_init - bring workqueue subsystem fully online
  *
@@ -8068,6 +8109,7 @@ void __init workqueue_init(void)
 
 	wq_online = true;
 	wq_watchdog_init();
+	housekeeping_register_notifier(&wq_housekeeping_nb);
 }
 
 /*
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c6..574ee3c6dc942 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -24,6 +24,7 @@
 #include <linux/page_owner.h>
 #include <linux/psi.h>
 #include <linux/cpuset.h>
+#include <linux/sched/isolation.h>
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
@@ -3246,6 +3247,7 @@ void __meminit kcompactd_run(int nid)
 		pr_err("Failed to start kcompactd on node %d\n", nid);
 		pgdat->kcompactd = NULL;
 	} else {
+		housekeeping_affine(pgdat->kcompactd, HK_TYPE_KTHREAD);
 		wake_up_process(pgdat->kcompactd);
 	}
 }
@@ -3320,6 +3322,30 @@ static const struct ctl_table vm_compaction[] = {
 	},
 };
 
+static int kcompactd_housekeeping_reconfigure(struct notifier_block *nb,
+					      unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	unsigned int type = upd->type;
+
+	if (action == HK_UPDATE_MASK && type == HK_TYPE_KTHREAD) {
+		int nid;
+
+		for_each_node_state(nid, N_MEMORY) {
+			pg_data_t *pgdat = NODE_DATA(nid);
+
+			if (pgdat->kcompactd)
+				housekeeping_affine(pgdat->kcompactd, HK_TYPE_KTHREAD);
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kcompactd_housekeeping_nb = {
+	.notifier_call = kcompactd_housekeeping_reconfigure,
+};
+
 static int __init kcompactd_init(void)
 {
 	int nid;
@@ -3327,6 +3353,7 @@ static int __init kcompactd_init(void)
 	for_each_node_state(nid, N_MEMORY)
 		kcompactd_run(nid);
 	register_sysctl_init("vm", vm_compaction);
+	housekeeping_register_notifier(&kcompactd_housekeeping_nb);
 	return 0;
 }
 subsys_initcall(kcompactd_init)

-- 
2.43.0

