Return-Path: <SRS0=q3PZ=3Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49764C33CB1
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB4D214D8
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 14:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="XdBfqwKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgA0ODt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:03:49 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:52470 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgA0ODs (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 27 Jan 2020 09:03:48 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B8B912E0EE4;
        Mon, 27 Jan 2020 17:03:45 +0300 (MSK)
Received: from sas2-3e4aeb094591.qloud-c.yandex.net (sas2-3e4aeb094591.qloud-c.yandex.net [2a02:6b8:c08:7192:0:640:3e4a:eb09])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id GvPU8Sj2TX-3iamNSWn;
        Mon, 27 Jan 2020 17:03:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1580133825; bh=rWO+pqoXgW5yqvcPcqbiWtbWQJgJM6IEA14o0BsyOF4=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=XdBfqwKMRfeDxiZrlppDiBKnPSzqK2bFtBeI2vu1LaYjpmxa3QOCxK7cJ1EKsSCLr
         rVm2V7yBh0sNw31ajOFW2EI2SLivUHTz+1WPXGgOw6tTzQjWSUS3TRRrnQdz2E3d7Y
         WcZXoXT2Tsjy3ydAEkYF/o7l1+pF9t9H39a3Jt4o=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by sas2-3e4aeb094591.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id x7h0qwLzMk-3iYeQPfD;
        Mon, 27 Jan 2020 17:03:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 2/3] kernel: set taint flag 'L' at any kind of lockup
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 27 Jan 2020 17:03:44 +0300
Message-ID: <158013382455.1528.13267155216574129417.stgit@buzz>
In-Reply-To: <158013382063.1528.13355932625960922673.stgit@buzz>
References: <158013382063.1528.13355932625960922673.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Any lockup or stall detector notifies about unexpected lack of progress.
It's better to know about these splats at investigating further problems.

This patch set TAINT_LOCKUP at:
- softlockup (CONFIG_SOFTLOCKUP_DETECTOR)
- hardlockup (CONFIG_HARDLOCKUP_DETECTOR)
- RCU stall (Documentation/RCU/stallwarn.txt)
- hung task (CONFIG_DETECT_HUNG_TASK)
- stuck in workqueues (CONFIG_WQ_WATCHDOG)

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Paul E. McKenney <paulmck@kernel.org> (RCU part)
Link: https://lore.kernel.org/lkml/157503370645.8187.6335564487789994134.stgit@buzz/ (v1)
---
 Documentation/admin-guide/tainted-kernels.rst |    4 ++++
 kernel/hung_task.c                            |    2 ++
 kernel/rcu/tree_stall.h                       |    1 +
 kernel/watchdog_hld.c                         |    1 +
 kernel/workqueue.c                            |    1 +
 5 files changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 55d45211cb41..13249240283c 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -153,6 +153,10 @@ More detailed explanation for tainting
      module signature.
 
  14) ``L`` if a lockup has previously occurred on the system.
+     - soft/hardlockup, see Documentation/admin-guide/lockup-watchdogs.rst
+     - RCU stall, see Documentation/RCU/stallwarn.txt
+     - hung task detected, see CONFIG_DETECT_HUNG_TASK
+     - kernel workqueue lockup, see CONFIG_WQ_WATCHDOG
 
  15) ``K`` if the kernel has been live patched.
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c16cb3..521eb2fbf5fc 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -139,6 +139,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		hung_task_show_lock = true;
 	}
 
+	add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
+
 	touch_nmi_watchdog();
 }
 
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c0b8c458d8a6..181495efff80 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -74,6 +74,7 @@ early_initcall(check_cpu_stall_init);
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
 static void panic_on_rcu_stall(void)
 {
+	add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
 	if (sysctl_panic_on_rcu_stall)
 		panic("RCU Stall\n");
 }
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..f77256f47422 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -152,6 +152,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
 			trigger_allbutself_cpu_backtrace();
 
+		add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cfc923558e04..1b3c81d87a0d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5774,6 +5774,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 			pr_cont_pool_info(pool);
 			pr_cont(" stuck for %us!\n",
 				jiffies_to_msecs(jiffies - pool_ts) / 1000);
+			add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
 		}
 	}
 

