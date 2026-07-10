Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F41367B92
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654182; cv=none; b=qwIyS2Bv7EGyu9A5LtI277225JzsdeCJwHn/pg+rWqmJ0YOc8kxD/1nHj7ILBAOH482vpvjEJrRGOj8qk8ACU5Sf97YEKjNwY1F+x/UY4CWRdGiJTuD13ep7mwTwYz4NurekQ+KAcUZQgKH9cjO2XiYHfBDjzW1bsM37uU36IZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654182; c=relaxed/simple;
	bh=0kVUx60+5alzmI6kgDLzOujtVEhari+4UwkUd1VMwS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqoAWFUbpt900+eaRddoaG35Hk20z2WLL65Z7wRA+BAHu0nSza2LGjd0BoiT7aAqKA0bdliWL/a+x1y+vGVAS8KQrG6ebZgw0yTby0jxcdx0tEYWb2W2PN7wg+lyR15CVVwmBD/qlKMwQAiDB4BomMVcMcHo06UqP6jYs8fvx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt8EBiUI; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bt8EBiUI"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso5858445ad.3
        for <rcu@vger.kernel.org>; Thu, 09 Jul 2026 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654179; x=1784258979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mrKXut03HXmQzwP+VjNkq+G+JdZqPXgKjkWKKkzd7+Y=;
        b=Bt8EBiUI2V1wO/K1l4Lhczu1qbvAKxWWLcDVIaRqro2iD8040Zp0B29lShkQSOZqIF
         RaOhkFfd1jw/2JevWdAHN8MDl5/Rz0LVgkys/NG3qmkDACsvZMr340yo6cR/p02sVzfa
         Wk9sXELAFSfRZ5D4FDm71dyKQu+mri5cQXtazs71jcl8Mm9Yjp/z6zpCtpJ9GVDo1TVn
         RpxfAuT8075tF4tdEsYCPsgxzgZGLVEixqLXb1RCniZ7rBI2z7gnaoRFyKFDhjnNO0j5
         L8Y1cQ1BlE36/M4ZUDZCg3C5jESYopsnCGY1gF8nyvHYKsqEr6NamSU+iOItO9Pg8Wa+
         4WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654179; x=1784258979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrKXut03HXmQzwP+VjNkq+G+JdZqPXgKjkWKKkzd7+Y=;
        b=mp19VzOtXv6lPPHJv5Z+Z+Pa8YF8z1WQtZXsQ3iV3b+ulfB/ZrIoDGGSO9iiVPzYtQ
         ByqJf3W75kypglxt/QdiogbltD6bpMAOJ+9GRv4zo4t1Ni70O9gg7cFWe3+haDPIigIf
         +zlhdCvRHRNTFyTmir96As7R5qpseXJHedkSZ/EyvFspCKuUBzOwuII3Uu0cZO2fMKy0
         47YGb24330k2fU7pZuD51OM0Axn0Ak5cOXxKOS4x1b6JDnC4y09ESdF9WoXI5iP3PckK
         FKrDnsAI/7WYfNzjJ41DcsfJdXz8bLZ85h9zUqIjKEBPNpaE9NnoHPmt2duGJMVq0gQL
         uBJQ==
X-Forwarded-Encrypted: i=1; AHgh+RqR35L0DqASo8ixlokeqFdgKkV911ej4apBmqtDQPyMDHNzAMfQpvRTRyXtyPE4fdCSQos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx1MUPDjQ0F+tmmmEg89k7kZv+z4ohwo9iioBImCuvQH3uW/8c
	iyH2QclVmxpio2Z+hMyJ2qnZ8XtJSIg7+hM5dRvB35M7ApdxbzJTO6Kv
X-Gm-Gg: AfdE7cl5MbQv6+I9u5g2OKGH0nfnOv0wPpibvUuOblORwcgziASNgsgTJvP7DqyB7DE
	eBon3IiU2SFsuu9xfv70x65W0cLGWjUZ1u3GPxm8rn7E/SrQY61i+GqmL6QLonl1zvivnQPLIPz
	N3VKrXOE2ABiWKQux5PTQEGDhkqpyUBZT3ctX9qEJz84JoXenqRQ7oEmolrDaIkOUOyK/6uHiRd
	SKnHzMGHBaeeMBUhsFHOo8QINXQMp1jljkhO3yOxAbnSaJgewW8gsFN6VehthX8p9/tQmFSHMsV
	cV5+F/OaAmlBBAISIHxHmkmyE+8Iq00PpqcUHvlhxxV3UPprLZyjrI5mdZR0vrN0Uq6YELR2uNc
	vb8/d1Ax+hgMwfRLX1m0d8mCLre+hEzdO0tuh9QFL3B5LvV4iEPzyqoIyHpS26JvT0VjT/NnJTt
	Km15TH1Xdc7TF//4OBR046vw==
X-Received: by 2002:a17:903:2411:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2ccea394d5dmr102447495ad.12.1783654178893;
        Thu, 09 Jul 2026 20:29:38 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:38 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:19 +0800
Subject: [PATCH v4 08/11] cpuset: add dhm_cycling_cpus mask to suppress
 transient invalidation
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-8-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
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
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0

When the cpuset code cycles a CPU through hotplug to apply kernel-noise
isolation (remove_cpu followed by add_cpu), the CPU disappears from
cpu_active_mask temporarily. cpuset_hotplug_update_tasks() sees an
empty effective CPU set on the isolated partition and issues
partcmd_invalidate, tearing down the partition. The subsequent add_cpu
brings the CPU back online, but the partition has already been marked
invalid and requires manual user intervention to restore.

Add a global dhm_cycling_cpus cpumask protected by dhm_cycling_lock.
The isolation cycling path sets the bits for CPUs being cycled before
calling remove_cpu(), clears them after add_cpu() completes.
cpuset_hotplug_update_tasks() checks whether any of the cpuset's
effective exclusive CPUs are in dhm_cycling_cpus and skips the
invalidation command when they are, treating the transient empty-CPU
state as expected rather than an error.

A global cpumask avoids the need to walk the cpuset tree to find the
owning cpuset during the cycling loop which runs without cpuset locks.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 80f43a24d3c8a..62eb6798a0c3e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -156,6 +156,14 @@ static bool		update_housekeeping;	/* RWCS */
  */
 static cpumask_var_t	isolated_hk_cpus;	/* T */
 
+/*
+ * CPUs currently being cycled through hotplug for kernel-noise isolation.
+ * Protected by dhm_cycling_lock; read in cpuset_hotplug_update_tasks() to
+ * suppress transient partition invalidation during the offline step.
+ */
+static DEFINE_SPINLOCK(dhm_cycling_lock);
+static cpumask_var_t	dhm_cycling_cpus;
+
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -3708,6 +3716,7 @@ int __init cpuset_init(void)
 	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_hk_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&dhm_cycling_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
@@ -3804,6 +3813,20 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (remote && (cpumask_empty(subpartitions_cpus) ||
 			(cpumask_empty(&new_cpus) &&
 			 partition_is_populated(cs, NULL)))) {
+		bool cycling;
+
+		/*
+		 * Suppress transient invalidation when the offline is part
+		 * of a hotplug cycling step for kernel-noise isolation.
+		 */
+		spin_lock(&dhm_cycling_lock);
+		cycling = cpumask_available(dhm_cycling_cpus) &&
+			  cpumask_intersects(cs->effective_xcpus,
+					     dhm_cycling_cpus);
+		spin_unlock(&dhm_cycling_lock);
+		if (cycling)
+			goto unlock;
+
 		cs->prs_err = PERR_HOTPLUG;
 		remote_partition_disable(cs, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
@@ -3821,8 +3844,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (is_local_partition(cs) &&
 	    (!is_partition_valid(parent) ||
 	     tasks_nocpu_error(parent, cs, &new_cpus) ||
-	     cpumask_empty(subpartitions_cpus)))
-		partcmd = partcmd_invalidate;
+	     cpumask_empty(subpartitions_cpus))) {
+		bool cycling;
+
+		/*
+		 * Suppress transient invalidation when the offline is part
+		 * of a hotplug cycling step for kernel-noise isolation.
+		 */
+		spin_lock(&dhm_cycling_lock);
+		cycling = cpumask_available(dhm_cycling_cpus) &&
+			  cpumask_intersects(cs->effective_xcpus,
+					     dhm_cycling_cpus);
+		spin_unlock(&dhm_cycling_lock);
+		if (!cycling)
+			partcmd = partcmd_invalidate;
+	}
 	/*
 	 * On the other hand, an invalid partition root may be transitioned
 	 * back to a regular one with a non-empty effective xcpus.

-- 
2.43.0

