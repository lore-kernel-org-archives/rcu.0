Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01537C4363A
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FE8214DB
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 16:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uo9/yslu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgJ2QvA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgJ2Qu7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 12:50:59 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC9DC0613D6;
        Thu, 29 Oct 2020 09:50:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id p15so3837055ljj.8;
        Thu, 29 Oct 2020 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnJgsrqj24e3iKwCYsEfizVAgHlFQ27IS+H4AUjM3Gc=;
        b=uo9/ysluJLEptzHR78M22LA1Y4lB4izmLXp+WcqhIEQA9J1bCJuixFY0VFWlp0bx8T
         21vY0ZPdywE/w9wZWarjB9T0pro1FmD8ZUZsjuB00o3wKd3BwTjmsDUvuy9nLQ5gsTQl
         vz4LMHv1KkB+daJzM2gXC/DmB0nEScF3HHZ2bE/022zccqSwjlRYepNXxcodnm5FVGAd
         gM6Mgvt6YtIePFL1YRR+7PEZ1HzymyuUG205ZGmbOdsdldVsNZI8VXlWet/rPhK8pOPe
         x0p7Y/qMD9dGGX7Ltq3sDacArSdEfb9jf+HOOdyKkKXbb9MzpZVFyYVXkE2H97erfoMy
         8mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnJgsrqj24e3iKwCYsEfizVAgHlFQ27IS+H4AUjM3Gc=;
        b=OC2hKx37lZulLgYq8CNpv9QK+DIJzJoZJjAtR6k/FB5wFmR0/b9rbM+yOsyrQtlq1w
         3UiSaoSasVmzjkGqD06l9s6so4y3RUUd//I5zrVCkZEBwyJKRs2VqKltH2J4rkQ6Z+F2
         LEO0m1p42FjR6cz9h4Qa3VNXRoESF0cmdTpSDGqQu993kHsfPB0f6SNntvu7qcTvJjWF
         z4gvhKzLz7chVUjALSJJaI3DwmD6slJ9QCSAn2tfLevjlB0cT+6rGg+FEYnU0yG2bdTm
         53TgRA0BACS/AYMsfJLhqtN8wYm6CuNBmI9CddxKzhvj3NqQXXWX2HHO/kYmlrB4tMDj
         8VZQ==
X-Gm-Message-State: AOAM530vjoB7Uoy48pY6OJ+vfr906c6a/SnBC5zPHJ9D0X8A07AooPpx
        L6ld4Cgrw4ZWIXZ5t2XttKCbqO1lZp1URA==
X-Google-Smtp-Source: ABdhPJzCunEHzvKoeJOSoyyhv7Yap8Ueao83IktkLr08p2Z+Ndmkr4UdqXx2aPGJ3/sE0nZV8IFwJQ==
X-Received: by 2002:a2e:947:: with SMTP id 68mr1698607ljj.464.1603990257061;
        Thu, 29 Oct 2020 09:50:57 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s1sm331832lfd.236.2020.10.29.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:50:56 -0700 (PDT)
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 16/16] rcu/tree: Use delayed work instead of hrtimer to refill the cache
Date:   Thu, 29 Oct 2020 17:50:19 +0100
Message-Id: <20201029165019.14218-16-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201029165019.14218-1-urezki@gmail.com>
References: <20201029165019.14218-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

A CONFIG_PREEMPT_COUNT is unconditionally enabled, thus a page
can be obtained directly from a kvfree_rcu() path. To distinguish
that and take a decision the preemptable() macro is used when it
is save to enter allocator.

It means that refilling a cache is not important from timing point
of view. Switch to a delayed work, so the actual work is queued from
the timer interrupt with 1 jiffy delay. An immediate placing a task
on a current CPU can lead to rq->lock double lock. That is why a
delayed method is in place.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3f9b016a44dc..9ea55f800b4b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3086,7 +3086,6 @@ struct kfree_rcu_cpu_work {
  *	per-cpu lock.
  * @page_cache_work: A work to refill the cache when it is empty
  * @work_in_progress: Indicates that page_cache_work is running
- * @hrtimer: A hrtimer for scheduling a page_cache_work
  * @nr_bkv_objs: number of allocated objects at @bkvcache.
  *
  * This is a per-CPU structure.  The reason that it is not included in
@@ -3104,9 +3103,8 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	int count;
 
-	struct work_struct page_cache_work;
+	struct delayed_work page_cache_work;
 	atomic_t work_in_progress;
-	struct hrtimer hrtimer;
 
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
@@ -3355,22 +3353,12 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
-static enum hrtimer_restart
-schedule_page_work_fn(struct hrtimer *t)
-{
-	struct kfree_rcu_cpu *krcp =
-		container_of(t, struct kfree_rcu_cpu, hrtimer);
-
-	queue_work(system_highpri_wq, &krcp->page_cache_work);
-	return HRTIMER_NORESTART;
-}
-
 static void fill_page_cache_func(struct work_struct *work)
 {
 	struct kvfree_rcu_bulk_data *bnode;
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work);
+			page_cache_work.work);
 	unsigned long flags;
 	bool pushed;
 	int i;
@@ -3398,12 +3386,8 @@ static void
 run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
-			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-		krcp->hrtimer.function = schedule_page_work_fn;
-		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
-	}
+			!atomic_xchg(&krcp->work_in_progress, 1))
+		schedule_delayed_work(&krcp->page_cache_work, 1);
 }
 
 // Record ptr in a page managed by krcp, with the pre-krc_this_cpu_lock()
@@ -4503,7 +4487,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
-- 
2.20.1

