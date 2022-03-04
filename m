Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BCDC433FE
	for <rcu@archiver.kernel.org>; Fri,  4 Mar 2022 11:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiCDLIq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Mar 2022 06:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239293AbiCDLIh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Mar 2022 06:08:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E7A1DA43
        for <rcu@vger.kernel.org>; Fri,  4 Mar 2022 03:07:29 -0800 (PST)
Date:   Fri, 4 Mar 2022 12:07:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646392047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bT3oClD8MP0y5HS5jPPFEH7cNQDlPyrUAR2Hfzk0WAo=;
        b=HCokkVfPl+LL56XcOKVNc0fCMbecOu4JmxepLY8gPemqGli7olk6CX2WdWhSEUNTPovyS9
        kLSEx0Sz1spXBDUqy1shyyR+66EjkY40JU1EjwIIGcnHxDrY+niyDz+8sFkq91pm5jHlSX
        IxLLXe4EUBTFhB3SD/k/6M60TNWeiL9PpNBUrOUmP3m2aP1WLyumfhIT9CjXwdOAyF/wxF
        E332mkbdCAOQp1EasPbmVuaANheK/n96vAX5R6g1G4Z3SAaD69JqKu4JT2MXSR10MzhO+w
        5N7ywnWLMkbuPNAGR7wd3L9iew+vUT0ZdjuXwPI4LQeILV9FNY4U0pRP4F0h+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646392047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bT3oClD8MP0y5HS5jPPFEH7cNQDlPyrUAR2Hfzk0WAo=;
        b=Ty/YhR+FfWEesriHl/+8e7fg+Ba/bkdc8lxggQd4vz8JF0dI5aMfbnhRr4DvO0OVOUIkVh
        OyUi6gLa4ZcuOQDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] rcu-tasks: Use rcuwait for the rcu_tasks_kthread().
Message-ID: <YiHy7Y5fTU3jRdMi@linutronix.de>
References: <Yh5bJZmAXXGtgTIl@linutronix.de>
 <20220302054217.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <Yh9QdtWL+MBXTY7x@linutronix.de>
 <20220303043650.GA4285@paulmck-ThinkPad-P17-Gen-1>
 <YiCT/i3jlgg9LX/r@linutronix.de>
 <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303200237.GE4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The waitqueue used by rcu_tasks_kthread() has always only one waiter.
With a guaranteed only one waiter, this can be replaced with rcuwait
which is smaller and simpler. With rcuwait based wake counterpart, the
irqwork function (call_rcu_tasks_iw_wakeup()) can be invoked hardirq
context because it is only a wake up and no sleeping locks are involved
(unlike the wait_queue_head).
As a side effect, this is also one piece of the puzzle to pass the RCU
selftest at early boot on PREEMPT_RT.

Replace wait_queue_head with rcuwait and let the irqwork run in hardirq
context on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2022-03-03 12:02:37 [-0800], Paul E. McKenney wrote:
> There is indeed only ever one waiter.  
> 
> But rcuwait is going to acquire scheduler locks, correct?  It would be
> better to avoid that potential deadlock.

This is what I had in mind. Does this work for you?

 kernel/rcu/tasks.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d64f0b1d8cd3b..f804afb304135 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -46,7 +46,7 @@ struct rcu_tasks_percpu {
 
 /**
  * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
- * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
+ * @cbs_wait: RCU wait allowing a new callback to get kthread's attention.
  * @cbs_gbl_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
@@ -77,7 +77,7 @@ struct rcu_tasks_percpu {
  * @kname: This flavor's kthread name.
  */
 struct rcu_tasks {
-	struct wait_queue_head cbs_wq;
+	struct rcuwait cbs_wait;
 	raw_spinlock_t cbs_gbl_lock;
 	int gp_state;
 	int gp_sleep;
@@ -113,11 +113,11 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
 	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
-	.rtp_irq_work = IRQ_WORK_INIT(call_rcu_tasks_iw_wakeup),			\
+	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),			\
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
-	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),			\
+	.cbs_wait = __RCUWAIT_INITIALIZER(rt_name.wait),				\
 	.cbs_gbl_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_gbl_lock),			\
 	.gp_func = gp,									\
 	.call_func = call,								\
@@ -261,7 +261,7 @@ static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp)
 	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct rcu_tasks_percpu, rtp_irq_work);
 
 	rtp = rtpcp->rtpp;
-	wake_up(&rtp->cbs_wq);
+	rcuwait_wake_up(&rtp->cbs_wait);
 }
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
@@ -509,7 +509,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
 		/* If there were none, wait a bit and start over. */
-		wait_event_idle(rtp->cbs_wq, (needgpcb = rcu_tasks_need_gpcb(rtp)));
+		rcuwait_wait_event(&rtp->cbs_wait,
+				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
+				   TASK_IDLE);
 
 		if (needgpcb & 0x2) {
 			// Wait for one grace period.
-- 
2.35.1

