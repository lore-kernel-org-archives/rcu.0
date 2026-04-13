Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94432397E9D
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066228; cv=none; b=O/5JjbtmLzWXdEcaMf/TQ0Nd09tA8wFYWsQyU1pSblRYHYCObvqjLH8/M6dd3G5RmcK/3pKitud8egoAL4bXk6ZQw/sNXyli3c8NRLERroePLzAz5Ge0A3SwasB2TS1SL6g0WzQiP0HnI2nyuxjPsaj5Hb/nS6/RdGdfinTznWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066228; c=relaxed/simple;
	bh=MShK07QngNcPAGv1iPWC1iUlxvhu3WgkHxBSDLvs5+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7z5otdX2djTpIuVs3n6A4de3TwZ/l5IZuRRPcyt3qpJviLO3vo2BM2l/DqWnVSHbK6Yo7hpofSG6/vs4m4OYuKJef9bErWVYYGuTjTSSDc9y9z6yiCdSc44FaxJOtclU2UWbkpa+EDy6AeedYvbb8iNrsoKDjgH3VALdIPJ/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMq/tAXi; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMq/tAXi"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c1fcce8f8so6903075c88.1
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 00:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066225; x=1776671025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuagEmmraWwH0d8g+cKuhFh1+5bCP0hdNVypbGGgG6g=;
        b=aMq/tAXi0PqDKyDp4TwV7FgMTwJs1orFXxdpfpU4r0iMHCcjv9Ix+Hd6l8Ic6wUad9
         SE07Ug6ec1I2KWgnc05UL/FGA0Kb7MmbUZQfSw0ViNlBWPr23wBTmVowH9WCSrxETAa8
         0uCDHukGCwhWeWrEfH1UcRrCyUwVrrBVaRnl562Xs8sQ7LSRlbskcHmT8XHQoTnDkoIj
         6i5o5OgBXvOI9kgjH4HHA0XUJ1bvXg2pxl2+uumWDVh/ns7YbeBjSGy2Zbs04FVAyQT/
         RRrWcgcj244+eNVxo6uEriJYFOBHmfFjdzVSqsUSWQsonnVovFL2uN61/qMVo1sHxX9E
         cCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066225; x=1776671025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LuagEmmraWwH0d8g+cKuhFh1+5bCP0hdNVypbGGgG6g=;
        b=Uekpxh7RXABm4UFCErsWNcgRSZN8bUJYeNF2StIThtKcjD2lW97GzwMSzCPbA+tdB3
         ZBrvFu5Cbjlh8sz0c8Cu83d2gPhO0ZxnMNBeS3HrdCArtxaHALjx3O3cntwyLc0kLXcR
         /CfnZ/P2H40T+UD1GflP/fjGAGYlMGuhtDSvDfBrQB/Vpnl0fIhyFSYnreCIjmPP8EAX
         aV/bI18i1MatRfmwxdPF1qY1ivPQPXpJB8bbilzC4U/bj3im4bBWX0YLf1v27kNCp5Ld
         eWUDWLGF6R666AALQTZ54QjkaJCArZCgeGGMb90/3WJXbyaMnZFH/EJgwbVeKnSubIxW
         vZDg==
X-Forwarded-Encrypted: i=1; AFNElJ9l77PrQTczNqi1NB2htQo5M7/do8Ci3faKjVlIxMVFDOSz2kj3Dycm56fKVVPolVV4pf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPo/HhKjMXGLzqzF4mfLXgi2ivnh709pl11dR1LyBc23jGELJo
	GXozVxR0e6s5suUjvJViXr+50mGjgIA7E6cKRXIaIwNQp5W0soGQVYWS
X-Gm-Gg: AeBDievXnCQDo9CRXrLdASBu7JdW5mSwkjmF56ci4NQCXb3JsXH8FdMFBPTYhBM0kQb
	xXGOp4KWsWWsQ5j2gBXP7IphV92ZIMUIG5i3SNGSqmSxLQ0YNWvdHtw1jkkCTwz8fmEHPmNCTOq
	UzZtqRWSKIho49MDqyds/ThOYwZqkCom5m5O2yLjacqObJIBBZjqIZVyIiuLkVjdjUGtoQx/bWD
	I8Uywf3dUAmK4/ccuIJwdfMNanrZ2BiBWpB/fzwCkv2QnyyQbier/G6jSYtbgr7K2h4oP7/Pmei
	A4fI4wR3n0KeJcwyi9OE+5FxkX8Sby4b3KWxMVIvWuOL9SaKXX6H8mmfjinNS+VD6h/YZ5FoCL0
	funoU3Ifr4ejrjmGfkl6d3Ueg2seBUbgiTRkBGaaIIsLSYdzzYnZ4blDYRt3eVCFXLZOEdQXSZs
	CmtDBo6NUeJz1T0yQS
X-Received: by 2002:a05:7022:2528:b0:127:33e0:ea44 with SMTP id a92af1059eb24-12c34eec8d0mr7477882c88.29.1776066224747;
        Mon, 13 Apr 2026 00:43:44 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:43:44 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:08 +0800
Subject: [PATCH v2 02/12] sched/isolation: Introduce housekeeping notifier
 infrastructure
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-2-06df21caba5d@gmail.com>
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

Subsystems currently rely on static housekeeping masks determined at
boot. Supporting runtime reconfiguration (DHM v2) requires a mechanism
to broadcast mask changes to affected kernel components.

Implement a blocking notifier chain for housekeeping mask updates. This
infrastructure enables subsystems like genirq, workqueues, and RCU to
react dynamically to isolation changes triggered by cpusets.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 include/linux/sched/isolation.h | 21 +++++++++++++++++++++
 kernel/sched/isolation.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index b9a041247565c..aea1dbc4d7486 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -4,6 +4,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/tick.h>
+#include <linux/notifier.h>
 
 enum hk_type {
 	/* Inverse of boot-time isolcpus= argument */
@@ -28,6 +29,13 @@ enum hk_type {
 
 #define HK_TYPE_KERNEL_NOISE HK_TYPE_TICK
 
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
@@ -38,6 +46,9 @@ extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern int housekeeping_update(struct cpumask *isol_mask);
 extern void __init housekeeping_init(void);
 
+extern int housekeeping_register_notifier(struct notifier_block *nb);
+extern int housekeeping_unregister_notifier(struct notifier_block *nb);
+
 #else
 
 static inline int housekeeping_any_cpu(enum hk_type type)
@@ -65,6 +76,16 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 
 static inline int housekeeping_update(struct cpumask *isol_mask) { return 0; }
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
index e05ed5118e651..0462b41807161 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -10,6 +10,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/pci.h>
 #include "sched.h"
+#include <linux/notifier.h>
 
 enum hk_flags {
 	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
@@ -26,6 +27,8 @@ enum hk_flags {
 #define HK_FLAG_KERNEL_NOISE (HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | \
 			      HK_FLAG_MISC | HK_FLAG_WQ | HK_FLAG_KTHREAD)
 
+static BLOCKING_NOTIFIER_HEAD(housekeeping_notifier_list);
+
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 
@@ -170,6 +173,29 @@ int housekeeping_update(struct cpumask *isol_mask)
 	return 0;
 }
 
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
+int housekeeping_update_notify(enum hk_type type, const struct cpumask *new_mask)
+{
+	struct housekeeping_update update = {
+		.type = type,
+		.new_mask = new_mask,
+	};
+
+	return blocking_notifier_call_chain(&housekeeping_notifier_list, HK_UPDATE_MASK, &update);
+}
+EXPORT_SYMBOL_GPL(housekeeping_update_notify);
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;

-- 
2.43.0

