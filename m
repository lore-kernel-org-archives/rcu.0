Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26D13D628
	for <rcu@vger.kernel.org>; Tue, 23 Jul 2024 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721763516; cv=none; b=ASfnWFbt7GGsFWbQIWvC/OakvNMECJc98Dw5pnuLAqdXvQPXtSG+4itk06J94weECyCJgt0xN67f6X0WzV8/wYgMjVIMDSWVdBVGGTYGtkN4i3x4TkTiKy3TBQbdZJRcedA99yHwZUyDtMu0I0Wgf3WFABKYeANyT2YU4oePITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721763516; c=relaxed/simple;
	bh=jRj2pvqyU4imS/IXBIM7W3TnKWnbZpbvxO22rhcAebQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgDLYSVi1akSJLOqN92nM8kqdlChdCrg76ieSZh82mKd+/Z1NexQLsUQ9TTlxKIMzh+GWlYXvOxJBEFwd64u+xPbJ9U0cEX6ju2ArW9XeM46805sIxvOYBeWesMY2WrkuX0EYLN7aegRstiUD8W+4DbCw5Tw3NhuOSEl6Fdbojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDrDiIj2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDrDiIj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23358C4AF0A;
	Tue, 23 Jul 2024 19:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721763516;
	bh=jRj2pvqyU4imS/IXBIM7W3TnKWnbZpbvxO22rhcAebQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NDrDiIj2TnU00sASm4x1JEs6Y5gQWtwpQckluQqDTdbHxJvbH6TfwoxJ2jse5E0Xw
	 On70zOdEPOTCU2Vu467k/uhPSBpGOo7Ux2E4hZUqqZLLCM7aarpSMLBsW8zUuFvtPO
	 a8mlLrs8fI+PXXKnmwVpMIpqyvNBinh/lF1t0ehsYDhYQsxRclAMC8Dc/8/dydW4FN
	 Mt/VFFbLXcKS2vI7L4FVM9QTOk0Od3PPhd0cwsZOtPoaRsc+LfdwEQ3AyiegbRZdRP
	 Y17rVjHRuYAOryTRL879Us5PHidPbKQGk7+b35/CYiG4Qs6QMKoJa5QgUQobdH27qy
	 UDZQp5c+Q988Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AE2B7CE0EA6; Tue, 23 Jul 2024 12:38:35 -0700 (PDT)
Date: Tue, 23 Jul 2024 12:38:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Neeraj.Upadhyay@kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] srcu: faster gp seq wrap-around
Message-ID: <191db3ea-f1aa-4e13-b919-0ca4a00dc89e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240715232324.52384-1-inwardvessel@gmail.com>
 <62700706-bf21-489b-b956-7947a9b1886f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62700706-bf21-489b-b956-7947a9b1886f@paulmck-laptop>

On Thu, Jul 18, 2024 at 03:04:49PM -0700, Paul E. McKenney wrote:
> On Mon, Jul 15, 2024 at 04:23:24PM -0700, JP Kobryn wrote:
> > Using a higher value for the initial gp sequence counters allows for
> > wrapping to occur faster. It can help with surfacing any issues that may
> > be happening as a result of the wrap around.
> > 
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> 
> Much nicer, thank you!
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

Unfortunately, extended testing [1] triggered this warning:

do_rtws_sync: Cookie check 3 failed srcu_torture_synchronize+0x0/0x10() online 0-3.
WARNING: CPU: 2 PID: 57 at kernel/rcu/rcutorture.c:1347 do_rtws_sync.constprop.0+0x1e3/0x250

This is in the following code:

  1 dopoll = cur_ops->get_gp_state && cur_ops->poll_gp_state && !(r & 0x300); 
  2 dopoll_full = cur_ops->get_gp_state_full && cur_ops->poll_gp_state_full && !(r & 0xc00);
  3 if (dopoll || dopoll_full)
  4         cpus_read_lock();
  5 if (dopoll)     
  6         cookie = cur_ops->get_gp_state();
  7 if (dopoll_full)
  8         cur_ops->get_gp_state_full(&cookie_full);
  9 if (cur_ops->poll_need_2gp && cur_ops->poll_need_2gp(dopoll, dopoll_full))
 10         sync();
 11 sync();
 12 WARN_ONCE(dopoll && !cur_ops->poll_gp_state(cookie),
 13           "%s: Cookie check 3 failed %pS() online %*pbl.",
 14           __func__, sync, cpumask_pr_args(cpu_online_mask));
 15 WARN_ONCE(dopoll_full && !cur_ops->poll_gp_state_full(&cookie_full),
 16           "%s: Cookie check 4 failed %pS() online %*pbl",
 17           __func__, sync, cpumask_pr_args(cpu_online_mask));
 18 if (dopoll || dopoll_full)
 19         cpus_read_unlock();

The cookie collected from get_state_synchronize_srcu() at line 6
apparently had not yet expired by line 12.

Adding some debugging got me this:

do_rtws_sync: Cookie 4/-388 check 3 failed srcu_torture_synchronize+0x0/0x10() online 0-3.
WARNING: CPU: 2 PID: 57 at kernel/rcu/rcutorture.c:1347 do_rtws_sync.constprop.0+0x1e3/0x250

The "4/-388" is the value returned by get_state_synchronize_srcu()
(which that ->->get_gp_state() points to) at line 6, namely "4", and that
returned by another call to that same function at line 12, namely -388.

What is happening is that this rcutorture scenario uses an srcu_struct
structure from DEFINE_STATIC_SRCU(), which initializes the various
grace-period sequence numbers to zero.  Therefore, the first call to
get_state_synchronize_srcu() returns 4 (the number of the first grace
period following the mythical grace period #0).  But the intervening
call to synchronize_srcu() (which that sync() points to) invokes
check_init_srcu_struct(), which initializes all of those grace-period
squence numbers to negative numbers.  Which means that the call to
poll_state_synchronize_srcu() on line 12 (which ->poll_gp_state() points
to) sees a negative grace-period sequence number, and concludes that the
grace period corresponding to that positive-4-values cookie corresponds
to a grace period that has not yet expired.

My guess is that we will have to do this the hard way, by making
DEFINE_STATIC_SRCU() another counter to an impossible value, for example,
->srcu_gp_seq_needed_exp to 0x1.  Then get_state_synchronize_srcu()
can check for that value, returning (SRCU_GP_SEQ_INITIAL_VAL +
RCU_SEQ_STATE_MASK + 1) or similar.

Note that start_poll_synchronize_rcu() does not (repeat, *not*) need
adjustment because it already invokes check_init_srcu_struct().

But is there a better way?

For more detail, there is [2].  And welcome to the exciting world of RCU!
This is why we have long and repeated rcutorture runs.  Though "long"
does not help here because this happens at boot or not at all.  ;-)

						Thanx, Paul

[1] tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 90s --configs "400*SRCU-N" --bootargs "rcutorture.gp_sync=1 rcutorture.nfakewriters=70"
[2] https://docs.google.com/document/d/1FHVI1-kjCgLWajSVq8MlBtoc0xxoZNsZYuQsUzW7SIY/edit?usp=sharing

> > ---
> >  kernel/rcu/srcutree.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index bc4b58b0204e..907c4a484503 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -30,6 +30,9 @@
> >  #include "rcu.h"
> >  #include "rcu_segcblist.h"
> >  
> > +/* Start with a gp sequence value that allows wrapping to occur faster. */
> > +#define SRCU_GP_SEQ_INITIAL_VAL ((0UL - 100UL) << RCU_SEQ_CTR_SHIFT)
> > +
> >  /* Holdoff in nanoseconds for auto-expediting. */
> >  #define DEFAULT_SRCU_EXP_HOLDOFF (25 * 1000)
> >  static ulong exp_holdoff = DEFAULT_SRCU_EXP_HOLDOFF;
> > @@ -247,7 +250,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >  	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
> >  	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
> >  	ssp->srcu_idx = 0;
> > -	ssp->srcu_sup->srcu_gp_seq = 0;
> > +	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
> >  	ssp->srcu_sup->srcu_barrier_seq = 0;
> >  	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
> >  	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
> > @@ -258,7 +261,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >  	if (!ssp->sda)
> >  		goto err_free_sup;
> >  	init_srcu_struct_data(ssp);
> > -	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
> > +	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
> >  	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
> >  	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
> >  		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
> > @@ -266,7 +269,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
> >  		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
> >  	}
> >  	ssp->srcu_sup->srcu_ssp = ssp;
> > -	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
> > +	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed,
> > +			SRCU_GP_SEQ_INITIAL_VAL); /* Init done. */
> >  	return 0;
> >  
> >  err_free_sda:
> > -- 
> > 2.45.2
> > 
> 
