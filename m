Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258E393DDB
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 07:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066301; cv=none; b=P/ILYBWzTOq61XsePESCG98Ne5pgZYqeGEQXjBmaYXbDyfsa4HfyrVV1vwcgeUdv85C6MP2uILofDYlSw+LUhiiAaU/f1+xDLv7dUBknU42ErRDoyOMCTlLsYa6+AcvlNvW4aupSlXQNJUbffu3j83KZItAFqFPtYW+2uQv/I60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066301; c=relaxed/simple;
	bh=eaKGgV2EnLtxmq33JJLj/dYzBmiozYO1bQPRfgQi93o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSgenZJVNWc/VXtvV4CnSlhcydruAtseeO2iqfPZDQQG63gFe2mS0UzqKIkAvpysirjzHEkIENwJZuVwzmWcomHhWVnM4Se2f1Q0J9YQb/I88MYwncRl+7j72KrwkuAIsUSut8upaksR3K8twJlzfYyYBWpzEb8e0COLxsHIi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aumniG8d; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aumniG8d"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12713e56abdso2616434c88.1
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066299; x=1776671099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n2Y5xzqBT13fCT8NafM8IZJKMHdw2LLWT217qys08w=;
        b=aumniG8dlLVXg4rH0KFGoI/yqlxJ2pTZsIJyhFG/2/0ZYbHVpzdvawnZLMKqgJPS7V
         odyDq73wFRieT9I7d5MGNwUE0XMGnx5XTW5UN8kQ/px2v+CjIfKZ8SmEr7TbQrWIhdoi
         yjkEwS9UxhQxtr918L0qTINsLWtPNAY3ywmZvDTFLVwXM7iKxFZCIhbdg2zfe3T56Lvu
         //L2v93Ai5TDGIyh0Zfq5cDiUPv1UfA6fEvQ6s19w4hVRmyNWEgp0JkQqYmcRM91gXFp
         r3f+ayi7BGBrWoWZbPF8Zbc9hPj65KfLwqrBhoC1RW9Dm4oIh3Pf/y5YeJORwFyFnuLl
         PmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066299; x=1776671099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3n2Y5xzqBT13fCT8NafM8IZJKMHdw2LLWT217qys08w=;
        b=BGkReTFXrOQ29SKIU3RmWJOGe8PZyfriA3K0kpn70ddqWrPRk2K6WpaNvfwP4m/ODA
         hKFwF9NhG1Da1gJ4SmWmgyFxZi2mtD6pEbw2U6NvjpWvNQByBWV8bNKFHd2dbKGhj7Wk
         wbbEJf5CleAA9nqYe7PzV7GDNI/F4xOEsuHKPUajDbeb8aXu64tBWtbnCqSgTim7rclk
         TrlqIo/XBXTpsvp1D8n93nJOMzntjcKCMmAjtvuaqM0AERNl4AlKokg3nsPhbhOrI4EW
         25mIObBK6fALFVCWYEiJOCoXSlGKKGLVjcwGv4I4QcQtlEu/g8Mh+b/3sDTlyr1D+beN
         jM9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Glqyx6FKE593ipnF2/Hx6Fm8FpDqtuWWbLBxiGkBxHRfjqFBdwH6dtlSoBhOCDwheAIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMf84c6f14X8hB8nCdU3vuucncligCjNkGNool1y+RyImLIgY
	1BuruG+x4iVuqxc9+TAx1z//7w9Q87K3ybIYEV1Wr5hdtAMB+tjvDXpg
X-Gm-Gg: AeBDieuELcxGGyh5y+QwLmKAA3gATS5pGdT5PqoGkZkawbJxg9zHPOYEK32QRqemcB2
	E+/wa6pr29kQg7EScGppnq9YLDXdmjgIQAeo3Hk3r39X6LHXC4HUT04d6F9fmID8R27PKtbkRnQ
	Dgcw7Atz8i4oF3t4xzqj9gNNNy56ijShXW/kgfijL9ORir6OqMdctmf6sP5s5fgpdyRq9vHeaoe
	Kgx34cVQxfcBqlxACVYGzIMbywSjz5XjNS8j6xhORF2A5tanLx8JQ74fV9nBfbYKhNvqVvgBZ9E
	ZXrjwc0aPVfRlakGpXZcG+37GwBmhSOsvRz9f35/mEJFcUYvJxXd2EKFON2/J2n00GvTHnB5FBR
	HQHCWiZZP6l+2/PRYhG+u5PaxP1UPRibUiK6ERbBxthZ1i56+bjjxIIIxMObFtfLXZdiwj+ooE3
	cFFmrGZvOIG25oqBnU
X-Received: by 2002:a05:7022:e1d:b0:119:e569:f874 with SMTP id a92af1059eb24-12c35300841mr5317906c88.17.1776066298973;
        Mon, 13 Apr 2026 00:44:58 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:44:58 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:15 +0800
Subject: [PATCH v2 09/12] cgroup/cpuset: Introduce CPUSet-driven dynamic
 housekeeping (DHM)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-9-06df21caba5d@gmail.com>
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

Currently, subsystem housekeeping masks are generally static and can
only be configured via boot-time parameters (e.g., isolcpus, nohz_full).
This inflexible approach forces a system reboot whenever an orchestrator
needs to change workload isolation boundaries.

This patch introduces CPUSet-driven Dynamic Housekeeping Management (DHM)
by exposing the `cpuset.housekeeping.cpus` control file on the root cgroup.
Writing a new cpumask to this file dynamically updates the housekeeping
masks of all registered subsystems (scheduler, RCU, timers, tick, workqueues,
and managed IRQs) simultaneously, without restarting the node.

At the cpuset and isolation core level, this change implements:
1. `housekeeping_update_all_types(const struct cpumask *new_mask)` API inside
   `isolation.c` to safely allocate, update, and replace all enabled hk_type masks.
2. The `cpuset.housekeeping.cpus` attribute in `dfl_files` for the root cpuset.
3. Hooking the write operation to iterate over enabled housekeeping types
   and invoke `housekeeping_update_notify()` (the DHM notifier chain) to
   push these configuration changes live into individual kernel subsystems.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 include/linux/sched/isolation.h | 12 ++++++++++++
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 36 ++++++++++++++++++++++++++++++++++++
 kernel/sched/isolation.c        | 38 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index aea1dbc4d7486..299167f627895 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -48,6 +48,8 @@ extern void __init housekeeping_init(void);
 
 extern int housekeeping_register_notifier(struct notifier_block *nb);
 extern int housekeeping_unregister_notifier(struct notifier_block *nb);
+extern int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask);
+extern int housekeeping_update_all_types(const struct cpumask *new_mask);
 
 #else
 
@@ -86,6 +88,16 @@ static inline int housekeeping_unregister_notifier(struct notifier_block *nb)
 {
 	return 0;
 }
+
+static inline int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask)
+{
+	return 0;
+}
+
+static inline int housekeeping_update_all_types(const struct cpumask *new_mask)
+{
+	return 0;
+}
 #endif /* CONFIG_CPU_ISOLATION */
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index fd7d19842ded7..3ab437f54ecdf 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -60,6 +60,7 @@ typedef enum {
 	FILE_EXCLUSIVE_CPULIST,
 	FILE_EFFECTIVE_XCPULIST,
 	FILE_ISOLATED_CPULIST,
+	FILE_HOUSEKEEPING_CPULIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
 	FILE_MEM_HARDWALL,
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1335e437098e8..5df19dc9bfa89 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3201,6 +3201,30 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	mutex_unlock(&cpuset_mutex);
 }
 
+/*
+ * DHM interface: root cpuset allows updating global housekeeping cpumask.
+ */
+static ssize_t cpuset_write_housekeeping_cpus(struct kernfs_open_file *of,
+					      char *buf, size_t nbytes, loff_t off)
+{
+	cpumask_var_t new_mask;
+	int retval;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	buf = strstrip(buf);
+	retval = cpulist_parse(buf, new_mask);
+	if (retval)
+		goto out_free;
+
+	retval = housekeeping_update_all_types(new_mask);
+
+out_free:
+	free_cpumask_var(new_mask);
+	return retval ?: nbytes;
+}
+
 /*
  * Common handling for a write to a "cpus" or "mems" file.
  */
@@ -3290,6 +3314,9 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_ISOLATED_CPULIST:
 		seq_printf(sf, "%*pbl\n", cpumask_pr_args(isolated_cpus));
 		break;
+	case FILE_HOUSEKEEPING_CPULIST:
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(housekeeping_cpumask(HK_TYPE_DOMAIN)));
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -3428,6 +3455,15 @@ static struct cftype dfl_files[] = {
 		.flags = CFTYPE_ONLY_ON_ROOT,
 	},
 
+	{
+		.name = "housekeeping.cpus",
+		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_housekeeping_cpus,
+		.max_write_len = (100U + 6 * NR_CPUS),
+		.private = FILE_HOUSEKEEPING_CPULIST,
+		.flags = CFTYPE_ONLY_ON_ROOT,
+	},
+
 	{ }	/* terminate */
 };
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 0462b41807161..a92b0bb41de3a 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -27,6 +27,7 @@ enum hk_flags {
 #define HK_FLAG_KERNEL_NOISE (HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | \
 			      HK_FLAG_MISC | HK_FLAG_WQ | HK_FLAG_KTHREAD)
 
+static DEFINE_MUTEX(housekeeping_mutex);
 static BLOCKING_NOTIFIER_HEAD(housekeeping_notifier_list);
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -196,6 +197,43 @@ int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask
 }
 EXPORT_SYMBOL_GPL(housekeeping_update_notify);
 
+int housekeeping_update_all_types(const struct cpumask *new_mask)
+{
+	enum hk_type type;
+	struct cpumask *old_masks[HK_TYPE_MAX] = { NULL };
+
+	if (cpumask_empty(new_mask) || !cpumask_intersects(new_mask, cpu_online_mask))
+		return -EINVAL;
+
+	if (!housekeeping.flags)
+		static_branch_enable(&housekeeping_overridden);
+
+	mutex_lock(&housekeeping_mutex);
+	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
+		struct cpumask *nmask = kmalloc(cpumask_size(), GFP_KERNEL);
+
+		if (!nmask) {
+			mutex_unlock(&housekeeping_mutex);
+			return -ENOMEM;
+		}
+
+		cpumask_copy(nmask, new_mask);
+		old_masks[type] = housekeeping_cpumask_dereference(type);
+		rcu_assign_pointer(housekeeping.cpumasks[type], nmask);
+	}
+	mutex_unlock(&housekeeping_mutex);
+
+	synchronize_rcu();
+
+	for_each_set_bit(type, &housekeeping.flags, HK_TYPE_MAX) {
+		housekeeping_update_notify(type, new_mask);
+		kfree(old_masks[type]);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(housekeeping_update_all_types);
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;

-- 
2.43.0

