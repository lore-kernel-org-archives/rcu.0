Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED83370FF
	for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429870; cv=none; b=OTiNV/ijRoeI8eA/ifhY79tyOtO3ttPd9xearrJdVP8jaUd7HdLXdQw1cifiINo+voB+LQn6/jW0ASGVK+oJxtxL9QLMr5NfPCR0WkR0eTl8M9/VOfCMu0ais1m+h9+tNuTDqg8bpZX57VUz6EtTxwVXQhCJnOewyRqW0gs75dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429870; c=relaxed/simple;
	bh=VDl3mSv13UEmXW0CmH1Svs1ZFwxlhYyvejDTlM/v8n4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YaGGPN/IgUAypUu9DJYRMtEfZs8jhIw8tz730s+5yg7/pa0hjp8SgFvL7EiHT991Gqk6Q47W+rDIw21u7t7FBE0N/mcoeOX4rIBYMwqEaA8gmE9PzCkKcwCVUNgIsx3dseUftin349o0yM4NOBIdihCbisxABi8QIF2hjpvSW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8BOF/zr; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8BOF/zr"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0c955a481so45672eec.1
        for <rcu@vger.kernel.org>; Wed, 25 Mar 2026 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774429868; x=1775034668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZ5gRq9U07SXKnZs/b+mpems8hvXSmfr+O/2j6j26po=;
        b=F8BOF/zr6CnCRs1AyCj90X7QxQvIK2rU91MzjqObhvZ41qQBM7QEnsFxrQ5//H8S39
         OqLNs4aLOLxrkUNsFXU7iP9DXH8zhqMS5YlxEwEn9qSGLCPzpHFxzOr+KeDr7uQjgLT1
         8/IptrvV2nooDb/gkfkOjLQUWJmmm8P8EFqgk4cqjBPo7aBxkIVW9moBWRbyul7ot2en
         S4gPrf35SkDda+fHbUPph4id+xE0Q90Cw71L35n1chDPlgxzSjYxho6FcCNqlbgRtFlR
         7MtFfD8E5szYdPzbDVGIFdW7EbVKpR08SjBoxkTu7bQsfDj+f7D2al8YgPXYcIY+hdc9
         veBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774429868; x=1775034668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZ5gRq9U07SXKnZs/b+mpems8hvXSmfr+O/2j6j26po=;
        b=k2ACVIBZYM9aJLJu78r1HbOUGVZmqK/buyL4FP8pTceCZ8cw8Nxf7h30wEfhOLcpEG
         YxcV21i3lV7AG+x2p40JoNIl9YfHWeOEYHIKLtlNNLVVYaxZ6f35V8F+sAHKsno5Zmqy
         ttK2iF2qMRv/CSJ1FWHWMb95zQofl8F6p5BhjMuBqT85lIsaAQvwyHvWJZV1xuRoJl8l
         1wxo8W3xuT2vbJPZugKOzGdHW3WR+JInCf0qdEnc3BeD89KVsHW1Nnw7ZMGF76g6+7H+
         pjrKlb4bp1d9rHsVOss4TT1gvvmB9tdCRIQJw2m5Qd/L7npTsy/hyfRFMOAnwLk3rkLN
         scfg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Kvgq524fK3NF3jbFF/ScfB6KvB6FhhhBd3DfcRnBsARWP7plDNNSVqT5eoS5BAswRVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJuBk4Sl3VNBckZg0sOfDDXMCEfs8PmDFO98DCjlZTgA8htqR
	ZMaR27jR9Q20UaGwEpj7g1/qe+dfvIavuVlETu5J5eycmu7qlYQYL7ay
X-Gm-Gg: ATEYQzzgtDhQeBtgDs8fcq64dydGWM+9FFqC7I6E/3ttMzy9xITqPkHUmpctLMQbelQ
	mY0gfezUBo8gXkeDxLg9N6uvT3I/4uH+bLH3jYgnUW2xcuqVi7zNU7S8hm58kq0WTcQ3GmYV5lY
	5T9/HbWVPkYznx0+AQFQr4RSXa2BF3XNA94OFDA7M0rGvOO4xxYwnIhKBzRATHDCvK59kwiaipx
	5R1vZdn3CHrZnfrm6vHPtFTHGBZ5uyvlPuhcDu+Zd++Ww18F+C0GczOykPWuCzcRmL9w8/7dxef
	tLnYxcdGZ5mzYFPmxJR3Vx/4WrequKDrI3PacguCxGzwr6YvCiKtNkzA8WhPktRDedrbtJEaQOA
	8Rn+NLMIbNMUxBWCobiZs8vD18m6b8OiJRQvR0ytd+n013JRZYIBy4JAvXjFKFQvl3oVpigi4p4
	mq6hw700nqySux9I0z
X-Received: by 2002:a05:693c:3746:b0:2be:37d:3d6d with SMTP id 5a478bee46e88-2c15d41a548mr1430796eec.32.1774429867454;
        Wed, 25 Mar 2026 02:11:07 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c159e25dc7sm2786389eec.27.2026.03.25.02.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:11:07 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 25 Mar 2026 17:09:42 +0800
Subject: [PATCH 11/15] sched/isolation: Implement SMT-aware isolation and
 safety guards
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-dhei-v12-final-v1-11-919cca23cadf@gmail.com>
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

Manual isolation of single SMT siblings can lead to resource
contention and inconsistent performance. Furthermore, userspace might
accidentally isolate all available CPUs, leading to a system lockup.

Enhance DHEI with SMT-aware grouping and safety checks.

These enhancements ensure that hardware resource boundaries are
respected and prevent catastrophic misconfiguration of the system.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/sched/isolation.c | 180 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index e7a21023726df..4a5967837e8de 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -10,6 +10,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/topology.h>
 #include "sched.h"
 
 enum hk_flags {
@@ -29,6 +30,30 @@ struct housekeeping {
 };
 
 static struct housekeeping housekeeping;
+static bool housekeeping_smt_aware;
+
+static ssize_t smt_aware_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", housekeeping_smt_aware);
+}
+
+static ssize_t smt_aware_store(struct kobject *kobj,
+			      struct kobj_attribute *attr,
+			      const char *buf, size_t count)
+{
+	bool val;
+
+	if (kstrtobool(buf, &val))
+		return -EINVAL;
+
+	housekeeping_smt_aware = val;
+
+	return count;
+}
+
+static struct kobj_attribute smt_aware_attr =
+	__ATTR(smt_aware_mode, 0644, smt_aware_show, smt_aware_store);
 
 bool housekeeping_enabled(enum hk_type type)
 {
@@ -110,6 +135,161 @@ static int housekeeping_update_notify(enum hk_type type, const struct cpumask *n
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
+	return cpumap_print_to_pagebuf(true, buf, mask);
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
+	/* Safety check: must have at least one online CPU for housekeeping */
+	if (!cpumask_intersects(new_mask, cpu_online_mask)) {
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	if (housekeeping_smt_aware) {
+		int cpu, sibling;
+		cpumask_var_t tmp_mask;
+
+		if (!alloc_cpumask_var(&tmp_mask, GFP_KERNEL)) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
+		cpumask_copy(tmp_mask, new_mask);
+		for_each_cpu(cpu, tmp_mask) {
+			for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
+				if (!cpumask_test_cpu(sibling, tmp_mask)) {
+					/* SMT sibling should stay grouped */
+					cpumask_clear_cpu(cpu, new_mask);
+					break;
+				}
+			}
+		}
+		free_cpumask_var(tmp_mask);
+
+		/* Re-check after SMT sync */
+		if (!cpumask_intersects(new_mask, cpu_online_mask)) {
+			err = -EINVAL;
+			goto out_free;
+		}
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
+	if (ret)
+		goto err_group;
+
+	ret = sysfs_create_file(housekeeping_kobj, &smt_aware_attr.attr);
+	if (ret)
+		goto err_file;
+
+	return 0;
+
+err_file:
+	sysfs_remove_group(housekeeping_kobj, &housekeeping_attr_group);
+err_group:
+	kobject_put(housekeeping_kobj);
+	return ret;
+}
+late_initcall(housekeeping_sysfs_init);
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;

-- 
2.43.0

