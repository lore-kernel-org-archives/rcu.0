Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D568DC2BA83
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 13:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34842084E
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581774132;
	bh=e+K6J5Imwf8+3EtNhLEBthJf1zwhCeCSdnbwHieNtp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vXBWcml4VSCjEzKkkXNcf91GjDSHRb+r2/i6oSqlsBlb/PF80fU5ePv7T4WyoGqiu
	 wIP4dpvHTgYMrxQ8/O1T8XYVlJ8Ob/hAv3DwTqX5MtMGaJ8x3SNStMzP9AXgQoiXaY
	 dIqSLDigTMZj8dFr2ZmQM2MBqmm6XRHfnmouxky8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgBONmM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 15 Feb 2020 08:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgBONmM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 15 Feb 2020 08:42:12 -0500
Received: from paulmck-ThinkPad-P72.home (206-137-99-82.bluetone.cz [82.99.137.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF52C2083B;
        Sat, 15 Feb 2020 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581774130;
        bh=e+K6J5Imwf8+3EtNhLEBthJf1zwhCeCSdnbwHieNtp0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MJhb2fYJKHSuduvv8K0wfY4w+tZoSYL146GwKL5QgVYNwSM/jbvqtb9L/8wjaCN+I
         FzjtDF+spPLvmR2XegLKBSOcgq4ODOaKQtX6mi/JBNz7xo3a68il/UM+J33OSBtD1H
         XfB1wgZEqqIyKKM6D7hNLtYGRdWm3Ae/KczmRjUQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D9FC83520CAB; Sat, 15 Feb 2020 05:42:08 -0800 (PST)
Date:   Sat, 15 Feb 2020 05:42:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH tip/core/rcu 22/30] rcu: Don't flag non-starting GPs
 before GP kthread is running
Message-ID: <20200215134208.GA9879@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214235536.GA13364@paulmck-ThinkPad-P72>
 <20200214235607.13749-22-paulmck@kernel.org>
 <20200214225305.48550d6a@oasis.local.home>
 <20200215110111.GZ2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215110111.GZ2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Feb 15, 2020 at 03:01:11AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 14, 2020 at 10:53:05PM -0500, Steven Rostedt wrote:
> > On Fri, 14 Feb 2020 15:55:59 -0800
> > paulmck@kernel.org wrote:
> > 
> > > @@ -1252,10 +1252,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
> > >   */
> > >  static void rcu_gp_kthread_wake(void)
> > >  {
> > > -	if ((current == rcu_state.gp_kthread &&
> > > +	if ((current == READ_ONCE(rcu_state.gp_kthread) &&
> > >  	     !in_irq() && !in_serving_softirq()) ||
> > >  	    !READ_ONCE(rcu_state.gp_flags) ||
> > > -	    !rcu_state.gp_kthread)
> > > +	    !READ_ONCE(rcu_state.gp_kthread))
> > >  		return;
> > 
> > This looks buggy. You have two instances of
> > READ_ONCE(rcu_state.gp_thread), which means they can be different. Is
> > that intentional?
> 
> It might well be a bug, but let's see...
> 
> The rcu_state.gp_kthread field is initially NULL and transitions only once
> to the non-NULL pointer to the RCU grace-period kthread's task_struct
> structure.  So yes, this does work, courtesy of the compiler not being
> allowed to change the order of READ_ONCE() instances and conherence-order
> rules for READ_ONCE() and WRITE_ONCE().
> 
> But it would clearly be way better to do just one READ_ONCE() into a
> local variable and test that local variable twice.
> 
> I will make this change, and thank you for calling my attention to it!

And does the following V2 look better?

							Thanx, Paul

------------------------------------------------------------------------

commit 35f7c539d30d5b595718302d07334146f8eb7304
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jan 21 12:30:22 2020 -0800

    rcu: Don't flag non-starting GPs before GP kthread is running
    
    Currently rcu_check_gp_start_stall() complains if a grace period takes
    too long to start, where "too long" is roughly one RCU CPU stall-warning
    interval.  This has worked well, but there are some debugging Kconfig
    options (such as CONFIG_EFI_PGT_DUMP=y) that can make booting take a
    very long time, so much so that the stall-warning interval has expired
    before RCU's grace-period kthread has even been spawned.
    
    This commit therefore resets the rcu_state.gp_req_activity and
    rcu_state.gp_activity timestamps just before the grace-period kthread
    is spawned, and modifies the checks and adds ordering to ensure that
    if rcu_check_gp_start_stall() sees that the grace-period kthread
    has been spawned, that it will also see the resets applied to the
    rcu_state.gp_req_activity and rcu_state.gp_activity timestamps.
    
    Reported-by: Qian Cai <cai@lca.pw>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    [ paulmck: Fix whitespace issues reported by Qian Cai. ]
    Tested-by: Qian Cai <cai@lca.pw>
    [ paulmck: Simplify grace-period wakeup check per Steve Rostedt feedback. ]

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 62383ce..4a4a975 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1202,7 +1202,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
 	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
-	if (!rcu_state.gp_kthread) {
+	if (!READ_ONCE(rcu_state.gp_kthread)) {
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
 	}
@@ -1237,12 +1237,13 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
 }
 
 /*
- * Awaken the grace-period kthread.  Don't do a self-awaken (unless in
- * an interrupt or softirq handler), and don't bother awakening when there
- * is nothing for the grace-period kthread to do (as in several CPUs raced
- * to awaken, and we lost), and finally don't try to awaken a kthread that
- * has not yet been created.  If all those checks are passed, track some
- * debug information and awaken.
+ * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
+ * interrupt or softirq handler, in which case we just might immediately
+ * sleep upon return, resulting in a grace-period hang), and don't bother
+ * awakening when there is nothing for the grace-period kthread to do
+ * (as in several CPUs raced to awaken, we lost), and finally don't try
+ * to awaken a kthread that has not yet been created.  If all those checks
+ * are passed, track some debug information and awaken.
  *
  * So why do the self-wakeup when in an interrupt or softirq handler
  * in the grace-period kthread's context?  Because the kthread might have
@@ -1252,10 +1253,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
  */
 static void rcu_gp_kthread_wake(void)
 {
-	if ((current == rcu_state.gp_kthread &&
-	     !in_irq() && !in_serving_softirq()) ||
-	    !READ_ONCE(rcu_state.gp_flags) ||
-	    !rcu_state.gp_kthread)
+	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
+
+	if ((current == t && !in_irq() && !in_serving_softirq()) ||
+	    !READ_ONCE(rcu_state.gp_flags) || !t)
 		return;
 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
@@ -3554,7 +3555,10 @@ static int __init rcu_spawn_gp_kthread(void)
 	}
 	rnp = rcu_get_root();
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	rcu_state.gp_kthread = t;
+	WRITE_ONCE(rcu_state.gp_activity, jiffies);
+	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
+	// Reset .gp_activity and .gp_req_activity before setting .gp_kthread.
+	smp_store_release(&rcu_state.gp_kthread, t);  /* ^^^ */
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 488b71d..16ad7ad 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -578,6 +578,7 @@ void show_rcu_gp_kthreads(void)
 	unsigned long jw;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
 	j = jiffies;
 	ja = j - READ_ONCE(rcu_state.gp_activity);
@@ -585,8 +586,7 @@ void show_rcu_gp_kthreads(void)
 	jw = j - READ_ONCE(rcu_state.gp_wake_time);
 	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state,
-		rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL,
+		rcu_state.gp_state, t ? t->state : 0x1ffffL,
 		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
 		(long)READ_ONCE(rcu_state.gp_seq),
 		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
@@ -633,7 +633,8 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
-			 READ_ONCE(rnp_root->gp_seq_needed)))
+			 READ_ONCE(rnp_root->gp_seq_needed)) ||
+	    !smp_load_acquire(&rcu_state.gp_kthread)) // Get stable kthread.
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
 	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
