Return-Path: <SRS0=2Yb6=Q6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6C4C43381
	for <rcu@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02820652
	for <rcu@archiver.kernel.org>; Sat, 23 Feb 2019 06:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="s/78w0YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfBWGe5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:34:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38089 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfBWGe4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 23 Feb 2019 01:34:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id s1so5126645qte.5
        for <rcu@vger.kernel.org>; Fri, 22 Feb 2019 22:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9uaH19zzwr4OSX1n04BhljetL/RmyflP+g9OcvA0u0=;
        b=s/78w0YGTc2XtFwNSTGRH7EzLpdGadOr9CbcH16Ykl04d98Jj2wGbWSxhbnjOTpfrZ
         OIuG3RiwNiWryVdu02ArDq7KDyDswe9l8C+bgbkSuPtmL8rpmqfWW2ShIN1TGHSegkj6
         ErshRyL42Z8mIhldo1XK/Q7NCZuHNZKcERyNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9uaH19zzwr4OSX1n04BhljetL/RmyflP+g9OcvA0u0=;
        b=m3PxtlTG1EKrTrU3EOD5gKn3wlT74YnTE1nXJHl9QeMAG+c+Mof9US0gky9aeh6yi7
         Ncd0QkHjb2mqeNkQuF1vIt9m9mqpe7k2653usYbnn6dT2+jOxLMnNtm2YTqsdJLP1Mql
         bR8j/3LRkw5r/8qJW+3TgBBFVo4g99krRivZpOLp6NVjlwDMf0J1MRUd3bY0cFEon07Z
         4QOaehPUh4sd4935l+GUX8QT1If8ncD86Aac0P/jUXBEsKRDIMPwbETE6SrwE9P2kRCZ
         3g5VIPIgZKhe8AadLpbSH1WUeNP9gkNckH7/FoxM9g+W71ZxKOnFGcIFomz56/KJlLiP
         hlXA==
X-Gm-Message-State: AHQUAuat6LmYgo966xvNE63xzEXV4+liXvguatWPIaza+X54SINAG7pz
        U8qch7El/bEvjOQNstbLoL149g==
X-Google-Smtp-Source: AHgI3IbH9rbs5/xUnSBNzQ1jBth6cKcBV/4cG/qubG7uaPWUv4MRKW8heTjLFYj1yn326XSsWSWbXg==
X-Received: by 2002:ac8:29e8:: with SMTP id 37mr6232688qtt.153.1550903695498;
        Fri, 22 Feb 2019 22:34:55 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id d32sm2189408qtc.88.2019.02.22.22.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 22:34:54 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH v2 3/6] sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu
Date:   Sat, 23 Feb 2019 01:34:31 -0500
Message-Id: <20190223063434.6793-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190223063434.6793-1-joel@joelfernandes.org>
References: <20190223063434.6793-1-joel@joelfernandes.org>
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

Fix this by annotating cpufreq_update_util_data pointer with __rcu. This
will also help sparse catch any future RCU misuage bugs.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/cpufreq.c | 2 +-
 kernel/sched/sched.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 22bd8980f32f..e316ee7bb2e5 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -7,7 +7,7 @@
  */
 #include "sched.h"
 
-DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
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

