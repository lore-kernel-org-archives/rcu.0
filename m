Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B3C433B4
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 10:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C2F61182
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 10:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhEPK3R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 06:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhEPK3R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 06:29:17 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDCC06174A
        for <rcu@vger.kernel.org>; Sun, 16 May 2021 03:28:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h127so3013889pfe.9
        for <rcu@vger.kernel.org>; Sun, 16 May 2021 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbMOOU3YXkzKpViU/BNYsIIslIJYBaw4bWcUGZh38z4=;
        b=nuH1SOY8jLayV/0SILWX8WJi+zCZQg3ZfRbkMsNngurWJoKTpbndhy12rmlf5lvxiM
         t6x1W+6uyKgAVnzRun4/sRSe90Nqrpvj/ypj/ioMq2pWKDbY9UTrM66Y0P+7ooBXsT36
         sjYv4MpIMpBP8StvhLc8OGYEXLZcisKQYShVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BbMOOU3YXkzKpViU/BNYsIIslIJYBaw4bWcUGZh38z4=;
        b=UFbFkUwtYOS2TpNnTpQ+zDnHBJN1sKZt/gFgcN+bbI02Gnq09/zXF7MDZVH+Z/C+XV
         2gZyC5FjAv/6AtbnFwk08XWmSz6WFfcpmsiGavZw9MlVGEQtkn3NjPISfTU21TuOO6d/
         E3ZqscxtsbPBsMDjg1kIe0IrHI8TCth3mQm0H6Upw3WXc3uOf0OjuL6naXH4jOunSM1h
         2gBm5Fbl9HAR7lbVx3gwKIONw9QVo8z2vss2gU/jpinqgxgIQwRwmRy2fso+0qY+nII1
         EvP/wV+kkskEOTVxdcorYWOba7RLnT6coVrpFhgadcGzt4EQzUFhGVjyM4JgAI1ytnfQ
         W/Pg==
X-Gm-Message-State: AOAM533e2diOf07fYb96R4+UAWxBMyeIH6/iFPbjyUSVTw0WAnSKcPMp
        QOdgV/dnleymTh0asaIw4FFjXA==
X-Google-Smtp-Source: ABdhPJzfscamgoRA6gyz4lfFbHUDJ/awE7jAi7S5HK5rFqWAkErOtlHkkvnTZ9GbVoG5aVNJqtFBoQ==
X-Received: by 2002:a65:6705:: with SMTP id u5mr56616058pgf.418.1621160882296;
        Sun, 16 May 2021 03:28:02 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:4596:acad:c782:2f52])
        by smtp.gmail.com with ESMTPSA id h1sm7761729pfh.72.2021.05.16.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 03:28:01 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] rcu/tree: consider time a VM was suspended
Date:   Sun, 16 May 2021 19:27:16 +0900
Message-Id: <20210516102716.689596-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Soft watchdog timer function checks if a virtual machine
was suspended and hence what looks like a lockup in fact
is a false positive.

This is what kvm_check_and_clear_guest_paused() does: it
tests guest PVCLOCK_GUEST_STOPPED (which is set by the host)
and if it's set then we need to touch all watchdogs and bail
out.

Watchdog timer function runs from IRQ, so PVCLOCK_GUEST_STOPPED
check works fine.

There is, however, one more watchdog that runs from IRQ, so
watchdog timer fn races with it, and that watchdog is not aware
of PVCLOCK_GUEST_STOPPED - RCU stall detector.

apic_timer_interrupt()
 smp_apic_timer_interrupt()
  hrtimer_interrupt()
   __hrtimer_run_queues()
    tick_sched_timer()
     tick_sched_handle()
      update_process_times()
       rcu_sched_clock_irq()

This triggers RCU stalls on our devices during VM resume.

If tick_sched_handle()->rcu_sched_clock_irq() runs on a VCPU
before watchdog_timer_fn()->kvm_check_and_clear_guest_paused()
then there is nothing on this VCPU that touches watchdogs and
RCU reads stale gp stall timestamp and new jiffies value, which
makes it think that RCU has stalled.

Make RCU stall watchdog aware of PVCLOCK_GUEST_STOPPED and
don't report RCU stalls when we resume the VM.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/rcu/tree_stall.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b95cc5cbdf..cb233c79f0bc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,8 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <asm/kvm_para.h>
+
 //////////////////////////////////////////////////////////////////////////////
 //
 // Controlling CPU stall warnings, including delay calculation.
@@ -695,6 +697,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
+		/*
+		 * If a virtual machine is stopped by the host it can look to
+		 * the watchdog like an RCU stall. Check to see if the host
+		 * stopped the vm.
+		 */
+		if (kvm_check_and_clear_guest_paused())
+			return;
+
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
@@ -704,6 +714,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
+		/*
+		 * If a virtual machine is stopped by the host it can look to
+		 * the watchdog like an RCU stall. Check to see if the host
+		 * stopped the vm.
+		 */
+		if (kvm_check_and_clear_guest_paused())
+			return;
+
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
-- 
2.31.1.751.gd2f1c929bd-goog

