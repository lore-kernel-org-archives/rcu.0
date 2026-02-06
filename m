Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8651A2C0B
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361609; cv=none; b=YcHCASABAC4zKV5ZHEFCw1vD/y90sq0hrLUUEAJAGj4p/lF7pCl1+hYz2rj900kV02QC6Vw+R2A5OD1yy0LBWJ1lQpmZLOw36J0BL2/Ng9nrJ5DoChYjtw3S89Y0aBcHNBifEk9jN2hN4W0KJq0+UW2IApupV0HIQ0DprIoyv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361609; c=relaxed/simple;
	bh=28SwfWNF2pPonaYGLUdwZIYTQscIfrvAugzJGAuI9IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cCQDc6kdyBGCkhCRaE+ztDWGP09D5UGTEQvl0o6Xys09gHFZrslVa3tNX+vI+v5uKtdfSj+mTHe5xXMJUcceTqyNh7QIytCDPhbGNz9Ark+eVxDD8Y/0kCZjy1Fu+0j+P+GWuNL9rs/HDja8q5cwDD4uoZPvS2j5kbGGjG6Xdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbmSbw2h; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbmSbw2h"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b82c605dbdso3645815eec.0
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361608; x=1770966408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1sUxC0YZUR64lsfhayk4QokW4yT43rWvxMvoedrPqg=;
        b=kbmSbw2hYbNlmGl2Mxuslh85IqgJWXCS/FJhL2vamxdul5q3tQScKtxSjSqDPtZVAy
         rNDmNNm+FMC0E2KfBBZ5Ak8A7/2PqR5xX/kJiV/2kFcXEsRCi+c49/g/4l5pqR3uOeln
         kCCQxrCGeipPN+ZvJOS3clLOELJcY925JbsWj18EyzkhK8NQLNAc50/vK7HseeEIy7A5
         sduMilg3NzYso180ISqK+UNwSW+e28dJGkbZhvclSIQ4E/IOQ2KQTbv4Q+qYMQAwV2vp
         DH5x6AC57lBrX7RYeEU2OqY15T2qfs6PE1/0ET8iYWjWBlVuVnz4AGQMNL778fZ0nI4r
         nxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361608; x=1770966408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e1sUxC0YZUR64lsfhayk4QokW4yT43rWvxMvoedrPqg=;
        b=Owv+xuZFFUH3R/G+D9bSSk2e6UA9i/cQo0fwzdYukhQGciyUj9k/AphOyFGUOngWZc
         /Gl8mBYMowH6zgVwJ0u8D7Z6spfNgCXUV7IDGJ0CZ0YkO9i1BnAEKlCdPUl/1HQ9ftW7
         5D18x90m8zpCW2CoWSABm+6N76iH3wVHOuGoJ4U164dStuvaSiNK0iasJvIwrzooY+tA
         f/XySBn4J6+aV8ARRwrBJef1jqs4bGK4uXbk41Z47SY6UX27zqQH60brrDqc1bhw/Odm
         LcOahdXF9ZigHtPzfU5h07XlyPYxOKqVbL/ApbO+BCq34WRaxvoNoxKI2lUHLcnBSm6F
         GjMg==
X-Forwarded-Encrypted: i=1; AJvYcCWik5a10J0UUBm/qt3lgv1ojtHCnyjYVb++YA6BjE/6s8mIs/NGWvXKy3NzczuwzH89nec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jpIw0KnvVX4A3/qIvQCG+UhmxjlHHrcd3SwIgXdkneZos+t6
	PKsgcB38zW3dk9yq8npKN8JKlI02GTuNbBs0wOAQW6WqfDdBoTtxRN/d
X-Gm-Gg: AZuq6aJib5JsdAf/zsJ9iAOraZjZqlGBlwuSQqiHvf5/EVEPZx+aXPuNk5vqeW7megO
	EiEM0MOIHjfhCbaZxszn5t12NNKFrKMYVjzqzIaHewM/ah7cLLbyIUXviyXr/jWyKmVoWRsEYD1
	DKTM+Yg2O5VI8pmdISOzOd1u0eC0wmjT1BmcOeHLbveo/L6Vv1X6cJNUn+Kw0c2T3UkX0na8VQ2
	cMO/k7YXc2OtY3kOOciB+0EpzSBSC7DuoNTLxLmjCdzj6EbsRlDalJHtHPiTpdeQBr1l+TehLOv
	nHkOdw0umUtcnowK0IHN3xChZ6a+XE0LPRWynK10SRCZ0lN9k9u6GkYOdoipSLAQhcziYOn6N78
	CD2Uyn3c72Zev8SuQA83ym/I9q/fZ5VvQfweP5YKAdNGLVGKkCuzaECRh9PRzh83tk8TIiw8OY8
	wQYtc6EKGNIw==
X-Received: by 2002:a05:7300:4352:b0:2ae:59dd:cfd1 with SMTP id 5a478bee46e88-2b856722ff3mr747970eec.22.1770361608102;
        Thu, 05 Feb 2026 23:06:48 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:06:47 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:32 -0500
Subject: [PATCH RFC 11/12] sched/isolation: Implement SMT sibling
 auto-isolation and safety check
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-11-00a711eb0c74@gmail.com>
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

Implement SMT sibling auto-isolation logic via 'smt_aware_mode' sysfs
node. When enabled, writing to housekeeping masks will automatically
ensure that all siblings of a physical core stay together in the same
isolation state.

Also implement a safety check in housekeeping_store() to ensure that
at least one online CPU remains as housekeeping, preventing the user
from accidentally isolating all CPUs and locking up the system.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/isolation.c | 72 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index d9ce26cf31fe..30798e790b9f 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -13,6 +13,7 @@
 #include <linux/sysfs.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
+#include <linux/topology.h>
 #include "sched.h"
 
 enum hk_flags {
@@ -40,6 +41,30 @@ struct housekeeping {
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
@@ -164,11 +189,40 @@ static ssize_t housekeeping_store(struct kobject *kobject,
 	if (err)
 		goto out_free;
 
-	if (cpumask_empty(new_mask)) {
+	/* Safety check: must have at least one online CPU for housekeeping */
+	if (!cpumask_intersects(new_mask, cpu_online_mask)) {
 		err = -EINVAL;
 		goto out_free;
 	}
 
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
 	mutex_lock(&housekeeping_mutex);
 	
 	if (!housekeeping.cpumasks[type]) {
@@ -230,12 +284,20 @@ static int __init housekeeping_sysfs_init(void)
 	housekeeping_attr_ptr[j] = NULL;
 
 	ret = sysfs_create_group(housekeeping_kobj, &housekeeping_attr_group);
-	if (ret) {
-		kobject_put(housekeeping_kobj);
-		return ret;
-	}
+	if (ret)
+		goto err_group;
+
+	ret = sysfs_create_file(housekeeping_kobj, &smt_aware_attr.attr);
+	if (ret)
+		goto err_file;
 
 	return 0;
+
+err_file:
+	sysfs_remove_group(housekeeping_kobj, &housekeeping_attr_group);
+err_group:
+	kobject_put(housekeeping_kobj);
+	return ret;
 }
 late_initcall(housekeeping_sysfs_init);
 

-- 
2.51.0

