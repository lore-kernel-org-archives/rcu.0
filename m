Return-Path: <SRS0=rKhI=Q4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D18FC4360F
	for <rcu@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB762084F
	for <rcu@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uoqFMMbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfBUFub (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:50:31 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39975 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfBUFuD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Feb 2019 00:50:03 -0500
Received: by mail-qk1-f196.google.com with SMTP id h28so3595011qkk.7
        for <rcu@vger.kernel.org>; Wed, 20 Feb 2019 21:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJQh9OTMcc8GKjMOMevDLRheK40LG7vhJJv8Mr0Iw/w=;
        b=uoqFMMbjjyp/Ye2yvo+ESfFkN4f+MztM+/NmqQuFjSGfOx7yPbiRx71jZUAVQnxPxy
         0REAyP5KXc4D7bmiEU7b/79C3M7DLd85cHRWrQfm2ti6u7zrQJG8eW2N+sxtTnkFj0Ux
         5ccIv/xRONCSuio88pfmb02DI+AS6hzE2cfD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJQh9OTMcc8GKjMOMevDLRheK40LG7vhJJv8Mr0Iw/w=;
        b=njl1QuT6MbmowLx7uftyuz6NGCBlU/oVa9KiHeIMZDyKQyVzsGobm/lK/LxExfOKI5
         RtARdtJOXPb92/W7xaV0Kq6oaiBvhmSITJCQGJ1AEesjilF69ZbJlxpk7I8HtWEdrp8T
         hyMmqTNXirRErifUJte62s6qrSxmpKApbsgGYCFX5rVSV3IDzZhY328v93aX6e47xWUM
         7TUKnGUj9lfN5Meq6nxAZ8fCHmJtwFV+RL6fQWJqfmh0fEU7OoF6yYNumSQRnM3SCNzp
         9xfeYp+kLnVWqd4VFgBDtAaQ41+kz3m2l6qFt+OtvMAOhGy3UcBpostVeOpXH5Wj+LoF
         D8MQ==
X-Gm-Message-State: AHQUAua+nqJG2s262eX0do4rNDwS21RyEaENo11p6iB9xdYybicqmasE
        BdgMrrcabirK83Xs2VOONwhfrA==
X-Google-Smtp-Source: AHgI3Iah2BBNad0wXiymDZmJBDHzs14if7tgY8VwDYE9gs3+e3rurxaYWcDkNNqyQRz1Mp1KaW/X/w==
X-Received: by 2002:a37:9682:: with SMTP id y124mr14167594qkd.288.1550728202015;
        Wed, 20 Feb 2019 21:50:02 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id k185sm11561219qkd.62.2019.02.20.21.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:50:01 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH RFC 3/5] sched/cpufreq: Fix incorrect RCU API usage
Date:   Thu, 21 Feb 2019 00:49:40 -0500
Message-Id: <20190221054942.132388-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221054942.132388-1-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Recently I added an RCU annotation check to rcu_assign_pointer(). All
pointers assigned to RCU protected data are to be annotated with __rcu
inorder to be able to use rcu_assign_pointer() similar to checks in
other RCU APIs.

This resulted in a sparse error: kernel//sched/cpufreq.c:41:9: sparse:
error: incompatible types in comparison expression (different address
spaces)

Fix this by using the correct APIs for RCU accesses. This will
potentially avoid any future bugs in the code. If it is felt that RCU
protection is not needed here, then the rcu_assign_pointer call can be
dropped and replaced with, say, WRITE_ONCE or smp_store_release. Or, may
be we add a new API to do it. But calls rcu_assign_pointer seems an
abuse of the RCU API unless RCU is being used.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/cpufreq.c | 8 ++++++--
 kernel/sched/sched.h   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 22bd8980f32f..c9aeb3bf5dc2 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -7,7 +7,7 @@
  */
 #include "sched.h"
 
-DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
@@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 	if (WARN_ON(!data || !func))
 		return;
 
-	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
+	rcu_read_lock();
+	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
+		rcu_read_unlock();
 		return;
+	}
+	rcu_read_unlock();
 
 	data->func = func;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04530bf251f..2ab545d40381 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2166,7 +2166,7 @@ static inline u64 irq_time_read(int cpu)
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
-- 
2.21.0.rc0.258.g878e2cd30e-goog

