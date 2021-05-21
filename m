Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B77C47076
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C676D613DB
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 15:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhEUP57 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 11:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhEUP56 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 11:57:58 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01629C0613CE
        for <rcu@vger.kernel.org>; Fri, 21 May 2021 08:56:34 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so7565719pjb.3
        for <rcu@vger.kernel.org>; Fri, 21 May 2021 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zztYf9XfUtWeHWTD7m+lPtPVQ8eesduNWWwZRn0fOIk=;
        b=YpnlMvhTixMEKNQmLIrp0kUAvB7zDOf2Cr03hYy+nVVvDKLhltgpyoQOXO95OMfWAf
         mM/CQ+CSNkIuCpKyFtInMlflMHnnubXQi1C0dqdp0/ps9ZVNIOvtnlOF7pcMWxM2AJGh
         PGWkRdCwuhwv2FG4A3kDJJUboRy6J/o0+yVGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zztYf9XfUtWeHWTD7m+lPtPVQ8eesduNWWwZRn0fOIk=;
        b=UwWfMkEAV2jAd3rBDdWGU6DsgEYN8WUytSFv2pKMlSsGnc/THosXgKzUVafGTCYZNc
         RkW1Nfjp7RiRmDZ0oQireybbNrYR2oBsLenxy2AGxjGR4eRc4n5ddp4gEpPbhBFOBqhR
         YFLhFf973TIQFKIdRKWvSh99NBTP0/zEb+Ye5vhjzYVfD8Q+hz86JiuBTR19GoScWCFH
         WxmINJWVTU3VGvmpPrRyLG/7CG+yp8Ptsc8LpCNfER3p9BMnj0RvIjNhDRJDojeJ0sku
         BagOyXJ9bcRzEE3syc5JnHymNX3rWmEb9t92sWJll5FlC78BRqYffIw3HKEneXvwMAbY
         cbBQ==
X-Gm-Message-State: AOAM533KKC5iMScizDyFLJl9SnzTTbUcakaMoQNMl2sOjjnQc1hFvec+
        yzPTDVMQXdd5s4avdy8+jhivag==
X-Google-Smtp-Source: ABdhPJzKNratLuKlzZwSfhaXM+6qpl4oSpPYq9X5BJeYu2n6luBLNPfoZyCGCn1RRas0m2ACANyCAA==
X-Received: by 2002:a17:90a:514e:: with SMTP id k14mr11463634pjm.72.1621612593494;
        Fri, 21 May 2021 08:56:33 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id k15sm4767123pfi.0.2021.05.21.08.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:56:32 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Date:   Sat, 22 May 2021 00:56:23 +0900
Message-Id: <20210521155624.174524-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
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

v2: fixed powerpc build breakage

 kernel/rcu/tree_stall.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d574e3bbd929..bc689911a81d 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,6 +7,8 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
+#include <linux/kvm_para.h>
+
 //////////////////////////////////////////////////////////////////////////////
 //
 // Controlling CPU stall warnings, including delay calculation.
@@ -698,6 +700,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
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
@@ -707,6 +717,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
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
2.31.1.818.g46aad6cb9e-goog

