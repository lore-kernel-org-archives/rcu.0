Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7030AD06
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361592; cv=none; b=lOJGOEPekXDDnCTFTN92YFT7ZOEeK/8JMe4G8fWU7G4zfSdlTd+l9v7GPaEqM/D91yIX8AwMb2VyJQxWzv7k3Y8D9LnSVt5aIVqaffYhGzQTrw9pcokzBJMbI8+nuz93rtByHfocmobr3/YUfekjXSdXsrrdAIcCbJLxwc7LaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361592; c=relaxed/simple;
	bh=0oqbxcPwmQ5t2qh5YHGbOBPIaUL1kS8QlSZU9gar1mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGEryzSidre07A4u8dSqzSBgGrNZNqqi2RTXvxgeN9w5eB0MKy/LcADAti6IAswFRpPScmp5fOdBADYJCgP/YYqumQGE+jPxlGleNY9ABfVXJ6WUO/9xbCmO2Am5UzO1AWn7ezGaYqRDuD86Xp5mjEoZDJFoVRjFHKsSQuL6pJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhEdV8wA; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhEdV8wA"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b81ebac5d6so2345087eec.1
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361591; x=1770966391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9mXbrAaMtQHRTGDa3ewvpAsXiHuJtYFWMHk8lDDECc=;
        b=nhEdV8wAm8LCyL/K2fRETkMujedzYBHStEG2ueMYUD6YKZ1jbz5ksXhPCQN8Z++mz8
         Vb5kqK7MclKdo1/p+tKaQ+dKej5HBRCH10oPFglnkZy9DjG6QKe+off5joxKVhKqHPeM
         xjQXvcczHJmvWD011Zt5S0v8o1k1zMaxrYA0zPBwtW+1630j9UkuDpZSUTAB/2w5J6Ie
         8V+P++I0FjfhU77L3RUj+bqWAV6YxB193dA32ivjz8oJ3m1/y1xyM5ldG37593T9ZaZS
         PN/qCPcn/htDXhi5Q8BE30YS2XNrU8xwaUJ9PKVduK0uy8LJ5xz112FPOpAMx5Z7ceLS
         8wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361591; x=1770966391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9mXbrAaMtQHRTGDa3ewvpAsXiHuJtYFWMHk8lDDECc=;
        b=nX4GEGX1+Z3aJk/vTGSZV3P2GRBRAa+/ap19WZV/BI9IupwlIitczczx+ORxtH7rWb
         bWVdMDAgc1sUOg5zLqWQqbA6CRWxB4hTlKTVQIFyigtUYa4imPPC4hnsyYNH3kQJL8VM
         KVu8cz2CkcI+uyIGJmxFVvaTFqqSoUGtkUj1BrGgH3lqgHjvzDqGLinrA7mgWX6hlWhu
         hvOHRPe3kUIUIaf4DkRQaHFN1fcwZLPtTG2br6P8vKWpupLoEcQezq4XokGEl+CdMb3U
         rEqvEptTT10IgbgJ+FaxJ1vQ32024W2hVNyJZj/JzCrCV7ZvAUW0sJMMJPQosNPmkr2Q
         G2mw==
X-Forwarded-Encrypted: i=1; AJvYcCWJeQm55BfQafInvuDiQkHgcYLu/fCCjsQSs0I95EBFJloVz6MV/fyUvKM3oapt6aKNV7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHAWcr/1CcjB5LF0o5lSzCvaU6KNw0Q6LXNrOHihCk0EHy3vW
	VU2hU3RZb/bZH0X3gTyNJ9ma60nKcCg8rla0yPytkKYYkn0/QSnEl/fK
X-Gm-Gg: AZuq6aKUtpAodnzndpA4vUOcqE5IB2e1B6CfDzSf8W7P4DKPLPiUWHGhns5oBAhywaV
	0tad6z5+nhc3JxCly0sfDSgfx05biCOYN5n9/dkqOCtoUQuBrqI7Eje9UwqXaQJPN/qL0q4n0vT
	63tGcETind1qXt5Ay0LddkANztvpQpdxrodXbd5eTHte4xPFVWvnTttO+X7dB7zkJg3FGj9NLS1
	75K02p5621RkvTaNWc3dGflE4PYH803uMPihhsg/MYv2+lcqCXqX8ib5L0GJGDHM6RKUydn4ZBB
	+92VXkHTjroRudKsFcA5B6wePYFx/qTOmAc4DU6vG+8Kr8hPG0Ba8i1DhAPJ3P5EUavOSL2seC8
	sXkmHlgfHKAsToUE74X1wBKvy5ASIikeK57EGDa6MH9mqivLKD469SZXPs32q4CsAnFmGLmvoVj
	AN98XvsrNVxRVHBKruSIy/pg==
X-Received: by 2002:a05:7022:6612:b0:11b:9386:826c with SMTP id a92af1059eb24-1270405f72cmr986038c88.41.1770361591067;
        Thu, 05 Feb 2026 23:06:31 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:06:30 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:30 -0500
Subject: [PATCH RFC 09/12] sched/isolation: Separate housekeeping types and
 add sysfs interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-9-00a711eb0c74@gmail.com>
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

Currently, most housekeeping types (timer, rcu, misc, etc.) share the
same mask (HK_TYPE_KERNEL_NOISE), preventing fine-grained control over
CPU isolation. Additionally, there is no way to update these masks at
runtime.

Separate the housekeeping types into individual enum entries and expand
the cpumasks array to accommodate them. Introduce a sysfs interface at
/sys/kernel/housekeeping/ that allows users to view and update the
housekeeping masks for each type at runtime. When a mask is updated via
sysfs, a notifier is triggered to re-affine the relevant kernel
subsystems and services.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/sched/isolation.h |  20 +++---
 kernel/sched/isolation.c        | 134 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 140 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 5c07e3e9b8d1..e8fe1cfa5022 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -10,21 +10,17 @@
 enum hk_type {
 	HK_TYPE_DOMAIN,
 	HK_TYPE_MANAGED_IRQ,
-	HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_TICK,
+	HK_TYPE_TIMER,
+	HK_TYPE_RCU,
+	HK_TYPE_MISC,
+	HK_TYPE_WQ,
+	HK_TYPE_KTHREAD,
 	HK_TYPE_MAX,
-
-	/*
-	 * The following housekeeping types are only set by the nohz_full
-	 * boot commandline option. So they can share the same value.
-	 */
-	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
 };
 
+#define HK_TYPE_KERNEL_NOISE HK_TYPE_TICK
+
 struct housekeeping_update {
 	enum hk_type type;
 	const struct cpumask *new_mask;
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 97cc41626a33..d9ce26cf31fe 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -9,14 +9,26 @@
  */
 #include <linux/sched/isolation.h>
 #include <linux/mutex.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/slab.h>
+#include <linux/ctype.h>
 #include "sched.h"
 
 enum hk_flags {
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
-	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
+	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
+	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
+	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
+	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
+	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
+	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
 };
 
+#define HK_FLAG_KERNEL_NOISE (HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | \
+			      HK_FLAG_MISC | HK_FLAG_WQ | HK_FLAG_KTHREAD)
+
 static DEFINE_MUTEX(housekeeping_mutex);
 static BLOCKING_NOTIFIER_HEAD(housekeeping_notifier_list);
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
@@ -99,7 +111,7 @@ int housekeeping_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(housekeeping_unregister_notifier);
 
-static int __maybe_unused housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask)
+static int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask)
 {
 	struct housekeeping_update update = {
 		.type = type,
@@ -109,6 +121,124 @@ static int __maybe_unused housekeeping_update_notify(enum hk_type type, const st
 	return blocking_notifier_call_chain(&housekeeping_notifier_list, HK_UPDATE_MASK, &update);
 }
 
+static const char * const hk_type_names[] = {
+	[HK_TYPE_TIMER]		= "timer",
+	[HK_TYPE_RCU]		= "rcu",
+	[HK_TYPE_MISC]		= "misc",
+	[HK_TYPE_TICK]		= "tick",
+	[HK_TYPE_DOMAIN]	= "domain",
+	[HK_TYPE_WQ]		= "workqueue",
+	[HK_TYPE_MANAGED_IRQ]	= "managed_irq",
+	[HK_TYPE_KTHREAD]	= "kthread",
+};
+
+struct hk_attribute {
+	struct kobj_attribute kattr;
+	enum hk_type type;
+};
+
+#define to_hk_attr(_kattr) container_of(_kattr, struct hk_attribute, kattr)
+
+static ssize_t housekeeping_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct hk_attribute *hk_attr = to_hk_attr(attr);
+	const struct cpumask *mask = housekeeping_cpumask(hk_attr->type);
+
+	return cpumap_print_to_pagebuf(false, buf, mask);
+}
+
+static ssize_t housekeeping_store(struct kobject *kobject,
+				 struct kobj_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct hk_attribute *hk_attr = to_hk_attr(attr);
+	enum hk_type type = hk_attr->type;
+	cpumask_var_t new_mask;
+	int err;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpulist_parse(buf, new_mask);
+	if (err)
+		goto out_free;
+
+	if (cpumask_empty(new_mask)) {
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	mutex_lock(&housekeeping_mutex);
+	
+	if (!housekeeping.cpumasks[type]) {
+		if (!alloc_cpumask_var(&housekeeping.cpumasks[type], GFP_KERNEL)) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
+	}
+
+	if (cpumask_equal(housekeeping.cpumasks[type], new_mask)) {
+		err = 0;
+		goto out_unlock;
+	}
+
+	cpumask_copy(housekeeping.cpumasks[type], new_mask);
+	housekeeping.flags |= BIT(type);
+	static_branch_enable(&housekeeping_overridden);
+	
+	housekeeping_update_notify(type, new_mask);
+	
+	err = count;
+
+out_unlock:
+	mutex_unlock(&housekeeping_mutex);
+out_free:
+	free_cpumask_var(new_mask);
+	return err < 0 ? err : count;
+}
+
+static struct hk_attribute housekeeping_attrs[HK_TYPE_MAX];
+static struct attribute *housekeeping_attr_ptr[HK_TYPE_MAX + 1];
+
+static const struct attribute_group housekeeping_attr_group = {
+	.attrs = housekeeping_attr_ptr,
+};
+
+static int __init housekeeping_sysfs_init(void)
+{
+	struct kobject *housekeeping_kobj;
+	int i, j = 0;
+	int ret;
+
+	housekeeping_kobj = kobject_create_and_add("housekeeping", kernel_kobj);
+	if (!housekeeping_kobj)
+		return -ENOMEM;
+
+	for (i = 0; i < HK_TYPE_MAX; i++) {
+		if (!hk_type_names[i])
+			continue;
+
+		housekeeping_attrs[i].type = i;
+		sysfs_attr_init(&housekeeping_attrs[i].kattr.attr);
+		housekeeping_attrs[i].kattr.attr.name = hk_type_names[i];
+		housekeeping_attrs[i].kattr.attr.mode = 0644;
+		housekeeping_attrs[i].kattr.show = housekeeping_show;
+		housekeeping_attrs[i].kattr.store = housekeeping_store;
+		housekeeping_attr_ptr[j++] = &housekeeping_attrs[i].kattr.attr;
+	}
+	housekeeping_attr_ptr[j] = NULL;
+
+	ret = sysfs_create_group(housekeeping_kobj, &housekeeping_attr_group);
+	if (ret) {
+		kobject_put(housekeeping_kobj);
+		return ret;
+	}
+
+	return 0;
+}
+late_initcall(housekeeping_sysfs_init);
+
 void housekeeping_init(void)
 {
 	enum hk_type type;

-- 
2.51.0

