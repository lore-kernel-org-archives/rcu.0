Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D5FC433E0
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B67964E04
	for <rcu@archiver.kernel.org>; Fri, 29 Jan 2021 20:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbhA2UJC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Jan 2021 15:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbhA2UGZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Jan 2021 15:06:25 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3BDC061574;
        Fri, 29 Jan 2021 12:05:19 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a25so11923887ljn.0;
        Fri, 29 Jan 2021 12:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdjJrKQhzE2TWExsHlW+QvetXvCrNxjN7feqxHHUUNI=;
        b=RvuJySpW/K+FXVXjdLSmvi2C7LXK4YwEX3WNbnvRrM7FLqWUenkl7/hX6Nhk0pYHVz
         xjZl+hZmHaIERPXwCjfgpr/Au6d6tQqx33E9g0OwhRK37jfus+LSDuRMNsgJQnX9i5Ld
         H/n9VzKqfJnZ0e9ryvZYszZrFf56D948HsRVI/Fa9CwPJPGBwGsRQU1K5c219CJcNgJp
         taPwGqwIjWBrumMPsFctfr2ioAD7k4+QQIMReq6mt0amyscTLbJnt9j+Ql+u7luDezpV
         g+ryOTFkldYwWT5ngwDUZxyh8g3i6Z8WtgJz7tmPVr4IzOS+en5OtXAO6UuwiXwYWIu/
         RHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdjJrKQhzE2TWExsHlW+QvetXvCrNxjN7feqxHHUUNI=;
        b=cQ+y75hQ3l30WhawtNsgo9Dj82UCqzAVi6wc5fKrC2d293tgGeWQsCibWK6nx5aF90
         XH5u7hIGlvqiS3mVDplxF5QB2cxf/uJGwxi2V+WpbRimjqu1i63C2ETfKANnkKm2ol5l
         NYM151itNYoFYh2gFIZRExFk19D7CKUtvQFvcM+CRYMuxFfzUVmdnMvteA3F5mvDzoy+
         wASq0QJp52wdZ7mBRF70DohBayqWQ8ChDsfSlZtFFrNTclXkvn08vSqeuzVAX6NHkRMB
         lnWFdYC4xkIXXVtCJyh9dcjrnrtAyRM6BPHonc07f+uChTTFha9Klusjo6PA/JQDBopV
         6v+Q==
X-Gm-Message-State: AOAM532WC89Pcac3ginY/cCkSOMtuKJPayLlr8DawgHW9El4X4ifpvjq
        eFfbLW8AUTKi7z2DhP6bDo6Uqy5DWLOWEw==
X-Google-Smtp-Source: ABdhPJygSeYpH/KPM6Z4mlmnScRsY3o++8bc7OUi4xPJ23pebwyfwrNe0yOuFvOwBQ9hBgudhsyjew==
X-Received: by 2002:a2e:9910:: with SMTP id v16mr3407130lji.153.1611950717570;
        Fri, 29 Jan 2021 12:05:17 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n2sm2127387lfu.274.2021.01.29.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 12:05:16 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 2/2] kvfree_rcu: Use same set of flags as for single-argument
Date:   Fri, 29 Jan 2021 21:05:05 +0100
Message-Id: <20210129200505.5273-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210129200505.5273-1-urezki@gmail.com>
References: <20210129200505.5273-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Running an rcuscale stress-suite can lead to "Out of memory"
of a system. This can happen under high memory pressure with
a small amount of physical memory.

For example a KVM test configuration with 64 CPUs and 512 megabytes
can lead to of memory after running rcuscale with below parameters:

../kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig CONFIG_NR_CPUS=64 \
--bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 \
  rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot" --trust-make

<snip>
[   12.054448] kworker/1:1H invoked oom-killer: gfp_mask=0x2cc0(GFP_KERNEL|__GFP_NOWARN), order=0, oom_score_adj=0
[   12.055303] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
[   12.055416] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
[   12.056485] Workqueue: events_highpri fill_page_cache_func
[   12.056485] Call Trace:
[   12.056485]  dump_stack+0x57/0x6a
[   12.056485]  dump_header+0x4c/0x30a
[   12.056485]  ? del_timer_sync+0x20/0x30
[   12.056485]  out_of_memory.cold.47+0xa/0x7e
[   12.056485]  __alloc_pages_slowpath.constprop.123+0x82f/0xc00
[   12.056485]  __alloc_pages_nodemask+0x289/0x2c0
[   12.056485]  __get_free_pages+0x8/0x30
[   12.056485]  fill_page_cache_func+0x39/0xb0
[   12.056485]  process_one_work+0x1ed/0x3b0
[   12.056485]  ? process_one_work+0x3b0/0x3b0
[   12.060485]  worker_thread+0x28/0x3c0
[   12.060485]  ? process_one_work+0x3b0/0x3b0
[   12.060485]  kthread+0x138/0x160
[   12.060485]  ? kthread_park+0x80/0x80
[   12.060485]  ret_from_fork+0x22/0x30
[   12.062156] Mem-Info:
[   12.062350] active_anon:0 inactive_anon:0 isolated_anon:0
[   12.062350]  active_file:0 inactive_file:0 isolated_file:0
[   12.062350]  unevictable:0 dirty:0 writeback:0
[   12.062350]  slab_reclaimable:2797 slab_unreclaimable:80920
[   12.062350]  mapped:1 shmem:2 pagetables:8 bounce:0
[   12.062350]  free:10488 free_pcp:1227 free_cma:0
...
[   12.101610] Out of memory and no killable processes...
[   12.102042] Kernel panic - not syncing: System is deadlocked on memory
[   12.102583] CPU: 1 PID: 377 Comm: kworker/1:1H Not tainted 5.11.0-rc3+ #510
[   12.102600] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
<snip>

Having a fallback mechanism we should not go with "GFP_KERNEL | __GFP_NOWARN"
that implies a "hard" page request involving OOM killer. Replace such set with
the same as the one used for a single argument.

Thus it will follow same rules:
    a) minimize a fallback hitting;
    b) avoid of OOM invoking;
    c) do a light-wait page request;
    d) avoid of dipping into the emergency reserves.

With this change an rcuscale and the parameters which are in question
never runs into "Kernel panic".

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1e862120db9e..2c9cf4df942c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3435,7 +3435,7 @@ static void fill_page_cache_func(struct work_struct *work)
 
 	for (i = 0; i < rcu_min_cached_objs; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
-			__get_free_page(GFP_KERNEL | __GFP_NOWARN);
+			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
 		if (bnode) {
 			raw_spin_lock_irqsave(&krcp->lock, flags);
-- 
2.20.1

