Return-Path: <SRS0=0ICO=3L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CBFC32771
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 05:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F0D217F4
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 05:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579669650;
	bh=8Nu9Pb22w6dRMdAVgGdEgo3UZrwgOd3sDJZaaaLHjOg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=coKJnwuG2GMUnde6nbUicZtsSrTJVMsGnmCbTlp6Iau47pe12s9i0RBodUmVAew7i
	 Ve55l2Ptu60+ClYidTu0AbwCXR3G3bTS2w2aSGAn+7JlES0QCbb3SinPY1dlbVt3Wk
	 UOEmX1521OSwLJojnTCGvtpfWdp5YsUTcPdo+sJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgAVFHa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jan 2020 00:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgAVFHa (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jan 2020 00:07:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01AB217F4;
        Wed, 22 Jan 2020 05:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579669649;
        bh=8Nu9Pb22w6dRMdAVgGdEgo3UZrwgOd3sDJZaaaLHjOg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XG8wrQPKgQQ8BnJrdmYQHEWGBuqWdV+kKHNomo5WEGkdVHGt6tMmqVDfBBuumharM
         VNIQ2N56DLkHMMK6hvQs2VXgAyvYknZzCw8erHjzrUQSfki9o7bTyQuEyDmci2Lk1J
         wQKr4zIQcgr+KQaVisf66Q0BdwKsIa+nV7Z6V41Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B62793520DC0; Tue, 21 Jan 2020 21:07:28 -0800 (PST)
Date:   Tue, 21 Jan 2020 21:07:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Boot warning at rcu_check_gp_start_stall()
Message-ID: <20200122050728.GF2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200121141923.GP2935@paulmck-ThinkPad-P72>
 <A230E332-07D0-40A8-A034-33ADB4BFB767@lca.pw>
 <20200121161533.GT2935@paulmck-ThinkPad-P72>
 <6A6B0325-64C4-4470-91B4-37104CF8DA1A@lca.pw>
 <20200121204606.GZ2935@paulmck-ThinkPad-P72>
 <65A22475-C7EA-4A5F-A4EC-F92EF8CC17F8@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65A22475-C7EA-4A5F-A4EC-F92EF8CC17F8@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 21, 2020 at 11:16:06PM -0500, Qian Cai wrote:
> 
> 
> > On Jan 21, 2020, at 3:46 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > On Tue, Jan 21, 2020 at 02:09:05PM -0500, Qian Cai wrote:
> >>> On Jan 21, 2020, at 11:15 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> On Tue, Jan 21, 2020 at 09:37:13AM -0500, Qian Cai wrote:
> >>>>> On Jan 21, 2020, at 9:19 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>> 
> >>>>> One approach would be to boot with rcupdate.rcu_cpu_stall_timeout=300,
> >>>>> which would allow more time.
> >>>> 
> >>>> It works for me if once that warning triggered,  give a bit information about adjusting the parameter when debugging options are on to suppress the warning due to expected long boot.
> >>> 
> >>> Indeed.  300 seconds as shown above is currently the maximum, but
> >>> please let me know if it needs to be increased.  This module parameter
> >>> is writable after boot via sysfs, so maybe that could be part of the
> >>> workaround.
> >>> 
> >>>>> Longer term, I could suppress this warning during boot when
> >>>>> CONFIG_EFI_PGT_DUMP=y, but that sounds quite specific.  Alternatively,
> >>>>> I could provide a Kconfig option that suppressed this during boot
> >>>>> that was selected by whatever long-running boot-time Kconfig option
> >>>>> needed it.  Yet another approach would be for long-running operations
> >>>>> like efi_dump_pagetable() to suppress stalls on entry and re-enable them
> >>>>> upon exit.
> >>>>> 
> >>>>> Thoughts?
> >>>> 
> >>>> None of the options sounds particularly better for me because there could come up with other options may trigger this, memtest comes in mind, for example. Then, it is a bit of pain to maintain of unknown.
> >>> 
> >>> I was afraid of that.  ;-)
> >>> 
> >>> Could you please send me the full dmesg up to that point?  No promises,
> >>> but it might well be that I can make some broad-spectrum adjustment
> >>> within RCU.  Only one way to find out…
> >> 
> >> https://cailca.github.io/files/dmesg.txt
> > 
> > Interesting.
> > 
> > Does the following (very lightly tested) patch help?
> 
> Yes, it works fine.

Very good, thank you!  May I apply your Tested-by?

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > commit fb21277f8f1c5cc40a8d41da2db4b0c499459821
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Tue Jan 21 12:30:22 2020 -0800
> > 
> >    rcu: Don't flag non-starting GPs before GP kthread is running
> > 
> >    Currently rcu_check_gp_start_stall() complains if a grace period takes
> >    too long to start, where "too long" is roughly one RCU CPU stall-warning
> >    interval.  This has worked well, but there are some debugging Kconfig
> >    options (such as CONFIG_EFI_PGT_DUMP=y) that can make booting take a
> >    very long time, so much so that the stall-warning interval has expired
> >    before RCU's grace-period kthread has even been spawned.
> > 
> >    This commit therefore resets the rcu_state.gp_req_activity and
> >    rcu_state.gp_activity timestamps just before the grace-period kthread
> >    is spawned, and modifies the checks and adds ordering to ensure that
> >    if rcu_check_gp_start_stall() sees that the grace-period kthread
> >    has been spawned, that it will also see the resets applied to the
> >    rcu_state.gp_req_activity and rcu_state.gp_activity timestamps.
> > 
> >    Reported-by: Qian Cai <cai@lca.pw>
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 04718bc..d9d619d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1209,7 +1209,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
> > 	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
> > 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
> > 	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
> > -	if (!rcu_state.gp_kthread) {
> > +	if (!READ_ONCE(rcu_state.gp_kthread)) {
> > 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
> > 		goto unlock_out;
> > 	}
> > @@ -1259,10 +1259,10 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
> >  */
> > static void rcu_gp_kthread_wake(void)
> > {
> > -	if ((current == rcu_state.gp_kthread &&
> > +	if ((current == READ_ONCE(rcu_state.gp_kthread) &&
> > 	     !in_irq() && !in_serving_softirq()) ||
> > 	    !READ_ONCE(rcu_state.gp_flags) ||
> > -	    !rcu_state.gp_kthread)
> > +	    !READ_ONCE(rcu_state.gp_kthread))
> > 		return;
> > 	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
> > 	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
> > @@ -3619,7 +3619,10 @@ static int __init rcu_spawn_gp_kthread(void)
> > 	}
> > 	rnp = rcu_get_root();
> > 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > -	rcu_state.gp_kthread = t;
> > +	WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > +	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
> > +	// Reset .gp_activity and .gp_req_activity before setting .gp_kthread.
> > +	smp_store_release(&rcu_state.gp_kthread, t);  /* ^^^ */
> > 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > 	wake_up_process(t);
> > 	rcu_spawn_nocb_kthreads();
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 476458c..75f6e9f 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -578,6 +578,7 @@ void show_rcu_gp_kthreads(void)
> > 	unsigned long jw;
> > 	struct rcu_data *rdp;
> > 	struct rcu_node *rnp;
> > +	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
> > 
> > 	j = jiffies;
> > 	ja = j - READ_ONCE(rcu_state.gp_activity);
> > @@ -585,8 +586,7 @@ void show_rcu_gp_kthreads(void)
> > 	jw = j - READ_ONCE(rcu_state.gp_wake_time);
> > 	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
> > 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
> > -		rcu_state.gp_state,
> > -		rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL,
> > +		rcu_state.gp_state, t ? t->state : 0x1ffffL,
> > 		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
> > 		(long)READ_ONCE(rcu_state.gp_seq),
> > 		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
> > @@ -633,7 +633,8 @@ static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
> > 
> > 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
> > 	    ULONG_CMP_GE(READ_ONCE(rnp_root->gp_seq),
> > -	    		 READ_ONCE(rnp_root->gp_seq_needed)))
> > +	    		 READ_ONCE(rnp_root->gp_seq_needed)) ||
> > +	    !smp_load_acquire(&rcu_state.gp_kthread))
> > 		return;
> > 	j = jiffies; /* Expensive access, and in common case don't get here. */
> > 	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
> 
