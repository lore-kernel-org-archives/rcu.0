Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2C302756
	for <rcu@vger.kernel.org>; Fri,  6 Feb 2026 07:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361519; cv=none; b=A6Ty2o/xYhV7H8+5bZSClf2oqpBVJ7DucTIdTjEBJXqJd2ZZbc8dPkx3Vf2shMgg3sRLT332r16U0RaLBOZED3J7DXoV3x8MKYSOJFYregAqpfrvTgLZ9ryDUHaiAMYoXGxXmIL5P2Ka3lnCCs2/3n5dlGHGINn08E2ILhHuz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361519; c=relaxed/simple;
	bh=n0omYtl0xIEte7JAbbG8OBLHZ+FrvgEEEjgJhdigEL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FKxzWShWFVNt0+JU6o9yYgrC+jIPm9z9shHhZ8svn/2KV1kIpBdHH8szCsAFhfIoyLMExr7rBURUs1nRWCad0i1tCujx1pQnufxQRD5ZFywvWICZaEhB04ZxtZrv8R+AchyUblt3qH5FHg+/2gNYQHGkvvcidHmwCdBpcgw/0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKcEwFIu; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKcEwFIu"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124566b6693so975118c88.0
        for <rcu@vger.kernel.org>; Thu, 05 Feb 2026 23:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770361519; x=1770966319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOd/UWGDzn8jr9iF17p1rTKmc8F1m4wqgpJ+mmp6cko=;
        b=OKcEwFIun//Ar3ia//9lf13140nKTqJFHEYCZRZlQVLMad4Nq/ql8BTBrDZuQqJa/8
         Z9gE/rFSn4+9JSqVJLMNq7b+PPels43W01C6jCMgSR11X4cZBYluFqLPCFD9G1KRHTsT
         D3NM+ESJFo1DMlKg/Bzm3A64kSX+CwiwYQVt1oMQA4jRYsEcKDTQ/rdMq4OWn0oQCMUW
         VGev0tAtFw2tkG5Kjzu1HvL0B8AHKaFSdEcbBE17s9h+wFUh3V5h7gSzL8l1TGeOp8Wg
         hMBVT5lNPI9IQuHMtK2Dly80Kl4v8u75tuf1e73/rlt098fls0dsGfnO6OSN6UP5/uyx
         0p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770361519; x=1770966319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pOd/UWGDzn8jr9iF17p1rTKmc8F1m4wqgpJ+mmp6cko=;
        b=HtunU/mcNpjJYGn8mt2/elB3bx0H81sqyY2+v1chLYOMsCma7UkL4nJizNaOp2HiKy
         eyWLyjlkKOA8gnMzOqNwL9O7+ZY0EuMJogULlje8QyDjRjm3PEJWc9cC3J2Zk5gvjtpz
         xL5xVQ7TAB7sKU6iPbe5t84qw37AGP4tC6/n0EMy46qCUAoDpy1vop2ugwZQppM8iBJR
         4HBH3q9+2b6/JTBLe7wFtT4vmQeF8PhJ06Y2C92UZgsQ5RLfmQoAgAA6+QKm4MgV3YTJ
         i4mY93OKKzxpLiMHI8BoSjYdeNoRrDykFG2EoO0U1Jw5uEWJDO0l30Rg2QO+sw+YxUSB
         stDg==
X-Forwarded-Encrypted: i=1; AJvYcCWduX7U/UvPR6Mu91d/ZtlzUaRkvn27IOKY78VS0u3O/eGusLFgpeXjpDGCACUp/X6Go3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTYLuV1ul936APuL/ZTFQq3mckMXhBKRC6C3n9FMBfuUSXXx6
	aWM6nIwF44TRL5uA3/tUd1B/E3qNeZR4/5T6e2KvUUDMcpRxhtw+sxL8
X-Gm-Gg: AZuq6aKB6G28pIg4JQo4e9BwVoZHcMJzPjh29ogYt4ANJ42d6KPPTDXFqkZPu9nla5Z
	ofZHP4QTEm7rb4SHtU+jVm/Id+0PCMxJfxdCNu0YGr2CzZkd68b0ETGmSGLOyrSjYTUJyHfOUva
	/FxbrpL+i0FODIr/edHDlJ3QthwM8RGB4qwAmvFBaO8tMKL1nAk4VyYoMMdXLCZx4kCffr66wss
	QWCjwAgNMgrRLeMFJ0kJkRWFfjEV4sd0GOqVlW2tbpEdI44bM/ZIjQ/Kicp/qvW/WN+2N1/PjbJ
	HbUZI3yG0Oz6ZSBFCwkcpkE4bOE0mp1NBrs4AN9Kli25bLZ2edC85UKPpwZj4SfpBblAYJj1uyT
	gbasksgm7I6VjaJSdbbl9zjFI8+0pBiXJ+DzjdRG8YQhGJx5/6N+h3qFrzpTcFJl9IMHkZz2jC5
	HAAixF2M31bpI5Ue7CaFsy
X-Received: by 2002:a05:7022:492:b0:119:e569:f262 with SMTP id a92af1059eb24-12703ff13cemr1009542c88.11.1770361518689;
        Thu, 05 Feb 2026 23:05:18 -0800 (PST)
Received: from [127.0.1.1] ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e61b9sm1592601c88.8.2026.02.05.23.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 23:05:18 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Fri, 06 Feb 2026 02:04:23 -0500
Subject: [PATCH RFC 02/12] sched/isolation: Introduce reconfiguration
 notifier chain
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-feature-dynamic_isolcpus_dhei-v1-2-00a711eb0c74@gmail.com>
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

Introduce a blocking notifier chain for housekeeping to support dynamic
reconfiguration of masks. Subsystems like RCU, Timers, and IRQ
management need to be notified when the isolation state of a CPU
changes at runtime.

1. Define 'struct housekeeping_update' and 'HK_UPDATE_MASK' in
   isolation.h to pass update event details (type of housekeeping and
   the new mask).
2. Implement housekeeping_register_notifier() and
   housekeeping_unregister_notifier() to allow subsystems to subscribe
   to updates.
3. Provide an internal housekeeping_update_notify() helper to trigger
   the chain.

This signaling mechanism enables other kernel subsystems to adapt their
internal state (e.g., migrating kthreads or timers) dynamically when
housekeeping masks are modified via upcoming sysfs interfaces.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/sched/isolation.h | 20 ++++++++++++++++++++
 kernel/sched/isolation.c        | 23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index cecb80b09120..5c07e3e9b8d1 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -5,6 +5,7 @@
 #include <linux/cpuset.h>
 #include <linux/init.h>
 #include <linux/tick.h>
+#include <linux/notifier.h>
 
 enum hk_type {
 	HK_TYPE_DOMAIN,
@@ -24,6 +25,13 @@ enum hk_type {
 	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
 };
 
+struct housekeeping_update {
+	enum hk_type type;
+	const struct cpumask *new_mask;
+};
+
+#define HK_UPDATE_MASK	0x01
+
 #ifdef CONFIG_CPU_ISOLATION
 DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
 extern int housekeeping_any_cpu(enum hk_type type);
@@ -32,6 +40,8 @@ extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern void housekeeping_init(void);
+extern int housekeeping_register_notifier(struct notifier_block *nb);
+extern int housekeeping_unregister_notifier(struct notifier_block *nb);
 
 #else
 
@@ -59,6 +69,16 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 
 static inline void housekeeping_init(void) { }
+
+static inline int housekeeping_register_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int housekeeping_unregister_notifier(struct notifier_block *nb)
+{
+	return 0;
+}
 #endif /* CONFIG_CPU_ISOLATION */
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 811bf6cbe68d..97cc41626a33 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -18,6 +18,7 @@ enum hk_flags {
 };
 
 static DEFINE_MUTEX(housekeeping_mutex);
+static BLOCKING_NOTIFIER_HEAD(housekeeping_notifier_list);
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 
@@ -86,6 +87,28 @@ bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
+int housekeeping_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&housekeeping_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(housekeeping_register_notifier);
+
+int housekeeping_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&housekeeping_notifier_list, nb);
+}
+EXPORT_SYMBOL_GPL(housekeeping_unregister_notifier);
+
+static int __maybe_unused housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask)
+{
+	struct housekeeping_update update = {
+		.type = type,
+		.new_mask = new_mask,
+	};
+
+	return blocking_notifier_call_chain(&housekeeping_notifier_list, HK_UPDATE_MASK, &update);
+}
+
 void housekeeping_init(void)
 {
 	enum hk_type type;

-- 
2.51.0

