Return-Path: <SRS0=muXe=RY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2229C43381
	for <rcu@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADA720835
	for <rcu@archiver.kernel.org>; Thu, 21 Mar 2019 00:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="F+wz+KBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCUAex (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:34:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37658 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfCUAew (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Mar 2019 20:34:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id z16so3412874qtn.4
        for <rcu@vger.kernel.org>; Wed, 20 Mar 2019 17:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXwps16vASwoCwctvt+c7hXAgg4xM5xUnznKf8pbr4E=;
        b=F+wz+KBU6c5XYVr/XcGDyV8lbJqiOM6t2n2UMRjLGYEIzbqDnCXLYtyMgsA1jQ2bQn
         GgFFejHln14tX5vHSLeCEAW1tHV/ESEx6IoFxdMXP2NMF/jY59mukSwgijpo+z5nJTPk
         3qL6iVy/YQQWkqwwADVfoo7cDFIVUbNehoA3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXwps16vASwoCwctvt+c7hXAgg4xM5xUnznKf8pbr4E=;
        b=fGqE4CFlxurqmuYnzgNTrb5frLGWwP0GHDzFyuHBqKDoNtkrjVzmh/PPVM+0HTFamg
         dvbpg//x0GKPNdxdXEwrzqNGFy2wcGFevJhWSFUvyjixmvpWmbKQ9YisK/WaUmt/4I1+
         vfw8Qqa+QdJym2i51KJDp6h0tdd/iU1gjkpjt0/hA1b70I7++aAyV84jrVoiHkLdXVaa
         zVuFyTbOf4p1vddHTIWAhRmjZRUEgqbAM82skK4eD9iIARFCvcrlgRR/PceTQi7KgM5J
         3MSAhYz4bX/ZznziDF+HREJ7m+hP8dY6eRBuzl2ikOjfdHMDRezdxvBynujKkrAeYPnH
         o0OQ==
X-Gm-Message-State: APjAAAVXnHFLyislkJY8TA9/iAYVZNRBtWrlBoDKDPmznq5V0XYOolNG
        XJqxZFPfViGZXfcIe/KaVRKCRw==
X-Google-Smtp-Source: APXvYqxOrY9pxSJR9LMG73HalrbnXN5RofP5xjcWc9GfONoexUhjKRrzzIdMjcZl5HeL2MvlhfK9NQ==
X-Received: by 2002:aed:20e3:: with SMTP id 90mr624928qtb.357.1553128491194;
        Wed, 20 Mar 2019 17:34:51 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id u15sm2908475qth.54.2019.03.20.17.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 17:34:50 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 1/4] sched/cpufreq: Annotate cpufreq_update_util_data pointer with __rcu
Date:   Wed, 20 Mar 2019 20:34:23 -0400
Message-Id: <20190321003426.160260-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190321003426.160260-1-joel@joelfernandes.org>
References: <20190321003426.160260-1-joel@joelfernandes.org>
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

[From an RCU perspective]
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/cpufreq.c | 2 +-
 kernel/sched/sched.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 835671f0f917..b5dcd1d83c7f 100644
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
index efa686eeff26..713715dd00cf 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2185,7 +2185,7 @@ static inline u64 irq_time_read(int cpu)
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
-- 
2.21.0.225.g810b269d1ac-goog

