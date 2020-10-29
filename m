Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC6DC2D0A3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87BA214DB
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpFXoieL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgJ2Quv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgJ2Qut (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77214C0613D6;
        Thu, 29 Oct 2020 09:50:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k25so3827581lji.9;
        Thu, 29 Oct 2020 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IsH9yC8F75AIDnukyrzdzEbcu0gHi0ys1e+1LduTDdw=;
        b=DpFXoieL4NxBxht9e+3kxB43nTXn7zr//Dl/JUny0nvGBvcRZRULLbaKBlEIqRltqF
         /in0ln6AnRDXJqms2CYGzKBugGXip4wgTMrFxZ1G4Uhfz2K9OyakW2JF64FqtanAiBhN
         4dsgJ4AIbLQEbrzELAv+/oVFpz0m2zUcvHiW6MRh3rYAnFjKzERYui4cv1asTxaalLth
         xa+NIM0qJ54PwTMOYXqYKX8NpAOKDCtz4crGB7d5e31kVwFRR141k2joClvleCqe7yqg
         t9SMyoMwVZ850x9Ag10xXvrF6YmvHKALCEKy/gQ1DFcPgkx7o8moll4xV1FJzAcRavl8
         yxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IsH9yC8F75AIDnukyrzdzEbcu0gHi0ys1e+1LduTDdw=;
        b=tLYivQgeoAK1QHNn1nseUZkPhiMGQJyQ2nstCBcOGrZvO8+mZu1dvSjaF+0hYW2Bdr
         RZUBdbAX0rHYzD/fzRMDuGrYtP8eDnakrrVKCXfRyvSdWqB7AaEz39A0HXRIHhf0y4hS
         M6agxCZFeKh9FtEGWgfIgNblNvdN6zC9OPWkoGp7+/99Nef/9XXLEakL55XOJu48nCWT
         aI81BVAvENoKtMxCzUzlJJ8soVOJ6vAe/ykiY92+IC0ybX40SkYVuxbGJ4PX8I46yHGf
         RqbvrYifB4xPqVy/PtfJz4HF/0q6A3+K6ZcVctcdVUdFH9NkADPyNW4nBHE9ex7nUxL/
         CJUQ==
X-Gm-Message-State: AOAM533J5pX9bvxbfCC7hAeTcPqZvo3y7jalL50MITyWZ+xSe/ZJfKt4
        1zTjeqc0akYMksS8GLodLpAcbWve+KBEzQ==
X-Google-Smtp-Source: ABdhPJza9Q+1ed5evBYwNEI7KCiWw0W6OTRSjEYBUCpXTakis/yIyCgLVv9zWuiXISkWvzFyKDeP5A==
X-Received: by 2002:a2e:87c6:: with SMTP id v6mr2370709ljj.233.1603990245284;
        Thu, 29 Oct 2020 09:50:45 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:44 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 09/16] sched: Cleanup PREEMPT_COUNT leftovers
Date:   Thu, 29 Oct 2020 17:50:12 +0100
Message-Id: <20201029165019.14218-9-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/sched/core.c | 6 +-----
 lib/Kconfig.debug   | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7d5ab5..e172f2ddfa16 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3702,8 +3702,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * finish_task_switch() for details.
 	 *
 	 * finish_task_switch() will drop rq->lock() and lower preempt_count
-	 * and the preempt_enable() will end up enabling preemption (on
-	 * PREEMPT_COUNT kernels).
+	 * and the preempt_enable() will end up enabling preemption.
 	 */
 
 	rq = finish_task_switch(prev);
@@ -7307,9 +7306,6 @@ void __cant_sleep(const char *file, int line, int preempt_offset)
 	if (irqs_disabled())
 		return;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return;
-
 	if (preempt_count() > preempt_offset)
 		return;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 03a85065805e..d62806c81f6d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1318,7 +1318,6 @@ config DEBUG_LOCKDEP
 
 config DEBUG_ATOMIC_SLEEP
 	bool "Sleep inside atomic section checking"
-	select PREEMPT_COUNT
 	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, various routines which may sleep will become very
-- 
2.20.1

