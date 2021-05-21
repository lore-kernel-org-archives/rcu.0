Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643D3C04FF3
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 21:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C29613C8
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 21:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhEUVkU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 17:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhEUVkS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 17:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 408BB61073;
        Fri, 21 May 2021 21:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621633135;
        bh=XeujWDJqb9Ao582ktX0ngehKZ+Cjysw8EJ5HtBC0FiQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bj9PIvIDe4on2SjEhrqUnRsm641czgVuiw8VFXDYQp3EfMZeqq5hQ9Z63eCPfiGI+
         2050BXAG+TrJmCu4O0maX0QjFGesuigCZw6Uuxin5DFNTgsREa/ANyjWjRXSOknJuW
         CphKczvx2ZsFIGVEyh/ivfbikMHzPt9goNPAI6dNeL9iG0gV9p5OYlo0YtE1SUkDFG
         ZgQW2LdNOAMBmdtrWhj/4AjZFmYCAmNP4JBIB+QzcOhznZ9Fv8E8Tf32STwUkKB+0i
         tmAdhgYZuBFstg/jDDPzLmM2gKd07BSpFE8WFJwJx8Zt8WAWJCkLJ3co5c8rQ8+Yr9
         XP6Cx4+yWszfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 07A4E5C0164; Fri, 21 May 2021 14:38:55 -0700 (PDT)
Date:   Fri, 21 May 2021 14:38:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Message-ID: <20210521213855.GA3437356@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521155624.174524-1-senozhatsky@chromium.org>
 <20210521180127.GD4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521180127.GD4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 21, 2021 at 11:01:27AM -0700, Paul E. McKenney wrote:
> On Sat, May 22, 2021 at 12:56:23AM +0900, Sergey Senozhatsky wrote:
> > Soft watchdog timer function checks if a virtual machine
> > was suspended and hence what looks like a lockup in fact
> > is a false positive.
> > 
> > This is what kvm_check_and_clear_guest_paused() does: it
> > tests guest PVCLOCK_GUEST_STOPPED (which is set by the host)
> > and if it's set then we need to touch all watchdogs and bail
> > out.
> > 
> > Watchdog timer function runs from IRQ, so PVCLOCK_GUEST_STOPPED
> > check works fine.
> > 
> > There is, however, one more watchdog that runs from IRQ, so
> > watchdog timer fn races with it, and that watchdog is not aware
> > of PVCLOCK_GUEST_STOPPED - RCU stall detector.
> > 
> > apic_timer_interrupt()
> >  smp_apic_timer_interrupt()
> >   hrtimer_interrupt()
> >    __hrtimer_run_queues()
> >     tick_sched_timer()
> >      tick_sched_handle()
> >       update_process_times()
> >        rcu_sched_clock_irq()
> > 
> > This triggers RCU stalls on our devices during VM resume.
> > 
> > If tick_sched_handle()->rcu_sched_clock_irq() runs on a VCPU
> > before watchdog_timer_fn()->kvm_check_and_clear_guest_paused()
> > then there is nothing on this VCPU that touches watchdogs and
> > RCU reads stale gp stall timestamp and new jiffies value, which
> > makes it think that RCU has stalled.
> > 
> > Make RCU stall watchdog aware of PVCLOCK_GUEST_STOPPED and
> > don't report RCU stalls when we resume the VM.
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> I have queued both for testing and further review, thank you!

And on that otherwise inexplicable refetch of the jiffies counter within
check_cpu_stall(), the commit below makes it more effective.

If check_cpu_stall() is delayed before or while printing the stall
warning, we really want to wait the full time duration between the
end of that stall warning and the start of the next one.  Of course,
if there is some way to learn whether printk() is overloaded, even more
effective approaches could be taken.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit b9c5dc2856c1538ccf2d09246df2b58bede72cca
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri May 21 14:23:03 2021 -0700

    rcu: Start timing stall repetitions after warning complete
    
    Systems with low-bandwidth consoles can have very large printk()
    latencies, and on such systems it makes no sense to have the next RCU CPU
    stall warning message start output before the prior message completed.
    This commit therefore sets the time of the next stall only after the
    prints have completed.  While printing, the time of the next stall
    message is set to ULONG_MAX/2 jiffies into the future.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 05012a8081a1..ff239189a627 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -648,6 +648,7 @@ static void print_cpu_stall(unsigned long gps)
 
 static void check_cpu_stall(struct rcu_data *rdp)
 {
+	bool didstall = false;
 	unsigned long gs1;
 	unsigned long gs2;
 	unsigned long gps;
@@ -693,7 +694,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    ULONG_CMP_GE(gps, js))
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
-	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
+	jn = jiffies + ULONG_MAX / 2;
 	if (rcu_gp_in_progress() &&
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
@@ -710,6 +711,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		print_cpu_stall(gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
+		didstall = true;
 
 	} else if (rcu_gp_in_progress() &&
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
@@ -727,6 +729,11 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		print_other_cpu_stall(gs2, gps);
 		if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
 			rcu_ftrace_dump(DUMP_ALL);
+		didstall = true;
+	}
+	if (didstall && READ_ONCE(rcu_state.jiffies_stall) == jn) {
+		jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
+		WRITE_ONCE(rcu_state.jiffies_stall, jn);
 	}
 }
 
