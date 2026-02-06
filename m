Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502133B6D3
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361619; cv=none; b=bapkKma6/m6mQ4T2mjgIj6Z8ZqANHCJ/JJcUAHKvov5sNnXyH9lMVz8XSgYd0Gpa9G4jWzNHzotsq30ozylpd4IW0l8Ur8TsHQd3x6YBl1anl83YN1UE+ieAupkdxsaKlDVRSHcQiTpEGAfhtauogz1XVyAknzA0mmOsuJRcBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361619; c=relaxed/simple;
	bh=PRKDEd0DYfuHb9hL0NHmI1iyuE2ic2UZYJ1SCf8GC4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SAu4P9thjjz8vIBdVZtQYn2jWmyPHxrzXhgfl68nr9JF9VftvPDA7wdX6Y/i6bxK1lN5BOrBAmMepF4LKW4KKN7lP2RGu0uUzQDGN9u6TpGGdpGNe7f8RVQc7lISs1naaLLhqNNPtsK4WzmoKThIErbqBEARfBhZX/8zgbXeANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R17uleyv; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R17uleyv"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-124afd03fd1so481456c88.0
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361619; x=1770966419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po+cGkyQwauqMh1hjbbX16QLLaNcnoHPzcdRT786Xgc=;
        b=R17uleyvbgkHINzm2c3UIwuAAcqAX5NRsO4rHh8+WorBr0dC0ddc6PAyAtA0mOMT4v
         GHXmQXoU3gDFMFRIN1UJvJHQy4f6VnjXF+Q0bfyHW6atufx8QeQ5l8rwq3Pl2G9y1M6N
         2BbKPXbSiwcZuxZ5oLhKj3nM0hzExL15uTdW4vYYAY3ncBgxOKV1IyRP7X2FSoLljfKg
         X5xgnVKSPle1M5qgJ1jLz+nDTvI2/6H1WKwHR5E9QQVs8pi772yp8AdXSLNpa6Opzyw9
         uxU5u4FAvzf8fEwkFt3eMwQy3c8VTGvaAAW4kJmaJAeDIKC02NGHkLGbCkwJtNgrc9xf
         eRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361619; x=1770966419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=po+cGkyQwauqMh1hjbbX16QLLaNcnoHPzcdRT786Xgc=;
        b=GNnRGk4OafbUxB04Ghr42+Id/KPM8ZHPd1+VPQ4zm+J3GmFqpubRLo6+fP9L0Pg0a8
         l6f6dug6r9BQTX0Fl7dq7mdqU+FrYtThlfnqvQEZNpQ7Q+6gRJhEsOHGhGVYUTqGGZEv
         QUd1l15HMuHZcPvtiINi6bPrQwNthGf3K2RmP2G3L/VcMvdAH55e4omW9VGbNL5VbUts
         vFwG2rDmhKbj8qHuCiIEjYwxsyoDJ4KnLmnE0Uo6PgCvB11kcXZH1z2aSAf7YeiWpuY5
         8OWTQzbWrL08yMyh5tPE+1OLAh05cawXG7NOcwQAp15o/6q8wMfXhaFpU19gyR0HKhEo
         VnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcU6c2b8nYNIskGiogTXfjcqFHzSFFPz394Ck1bHuNaeQ82KX7KO4gszrfA22zOWhMk34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlYnwpxrmTJo9cOr1yWwfYX/tI+dNa0Gxc60eKswtMMcp7vz9h
	UadXnw7PNmUhIM0z0pwgcgi3vsqVVwbezUy9Gq0Br6S8o6vUnJEgwFEV
X-Gm-Gg: AZuq6aJhDFc3pP3y9L32xZS0bVJvNNjJUhVK9QQxfAh7r+f9tSk3h5QBbA+FLWD5Xyy
	VNWUx5fQZ80/5p3K+GnHCpxWj0Jd9rdN3Y6boxYPHpT/BlBL2DenQ3L+/5yimCunr/4/5x1+8Zs
	EIHWqMDF2xgIlUhyYKdUbp/4o4i9dsyz34/69joUVDaGsyHC6Q9XWZObVY9XYjj/Vo5BXLYJTAV
	c4C49prWCxlShIh3xM2rBpEniqCw/4TPhSI2vj+tCXxmlA471QzwOsoqPyJHxNXJEfmjPmBSybQ
	key0EtgOfUY1Za8TzXljQMwaOd0ueb5dPcpJnsYFOaEljW26EAIdWcKtpQuljbsdv5VQAJLqnHt
	g4h978asaAyNzF+sbrpqMb1eKolLciNu8jrUh3CwPwbXX3QYvSWxvMk0/KPrflSZlHgJHbPGLxo
	TCDbMsCNwHgQ==
X-Received: by 2002:a05:7022:660f:b0:11b:baa5:f4d1 with SMTP id a92af1059eb24-12703f54339mr757958c88.6.1770361618556;
        Thu, 05 Feb 2026 23:06:58 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:06:58 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:33 -0500
Subject: [PATCH RFC 12/12] sched/isolation: Bridge isolcpus and support
 runtime tick offload init
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-12-00a711eb0c74@gmail.com>
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

Bridge the boot-time 'isolcpus' and 'nohz_full' parameters with the
DHEI sysfs interface. Ensure that housekeeping_init() correctly
initializes the isolation state and that subsequent sysfs updates
can take over management even if no isolation was configured at boot.

Remove __init from sched_tick_offload_init() and update it to be
safe for multiple calls. This allows DHEI to initialize tick offload
infrastructure at runtime when the first tick-isolated core is
configured.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/core.c      | 5 ++++-
 kernel/sched/isolation.c | 3 +++
 kernel/sched/sched.h     | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 045f83ad261e..d155e1132d6b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5685,8 +5685,11 @@ static void sched_tick_stop(int cpu)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
-int __init sched_tick_offload_init(void)
+int sched_tick_offload_init(void)
 {
+	if (tick_work_cpu)
+		return 0;
+
 	tick_work_cpu = alloc_percpu(struct tick_work);
 	BUG_ON(!tick_work_cpu);
 	return 0;
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 30798e790b9f..76c039a01fb0 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -241,6 +241,9 @@ static ssize_t housekeeping_store(struct kobject *kobject,
 	housekeeping.flags |= BIT(type);
 	static_branch_enable(&housekeeping_overridden);
 	
+	if (type == HK_TYPE_TICK || type == HK_TYPE_TIMER || type == HK_TYPE_RCU)
+		sched_tick_offload_init();
+
 	housekeeping_update_notify(type, new_mask);
 	
 	err = count;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 93fce4bbff5e..0079e7210c38 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2867,7 +2867,7 @@ extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool sched_can_stop_tick(struct rq *rq);
-extern int __init sched_tick_offload_init(void);
+extern int sched_tick_offload_init(void);
 
 /*
  * Tick may be needed by tasks in the runqueue depending on their policy and

-- 
2.51.0

