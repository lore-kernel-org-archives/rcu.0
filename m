Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F209143874;
	Thu, 16 May 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875709; cv=none; b=B2Mc3zFp0oNzZZHQYXdVElSJI9lK9UWc1PrLCM5qm2cW6/XdQO/dxVIMwfzW22mZev7046V4/AQqxFbAwEYtStryOM6BuTq0bdEcbPS0eyl2tVzShaFx0+izmHT/hiCaz+N9l6Xnd9QQuljg9L4NUkWBivX90e+QSc+fUBEqGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875709; c=relaxed/simple;
	bh=d8/EvAf4yHxNQSMPnoKJkKTtilEr1elItCh+nLIaYSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4sIgi0XsZmFl85BTdkF0bipuuYcfKaTmGJKRAIpzldMLzl+nL5bg6rf06XOAADjjqbylkHDQ8k01KZcl2bxaLEZ+6tIk8fwUKrj+tVCgHZ6NQDB9Ruluwdak5I1xxTzZ5erP7qwpltyp+dvxfdt1PeO/tkfjhyhJyYUu6w3rgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmwD+eXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmwD+eXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E113C113CC;
	Thu, 16 May 2024 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715875708;
	bh=d8/EvAf4yHxNQSMPnoKJkKTtilEr1elItCh+nLIaYSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmwD+eXxssf5j+5x5z68QXN0AwLYlujL0dW/KrM6HPGATV+lXXsKpGeQY/8FwM6Oy
	 AJoP4vwY1hVKb4+p8f7hqlUgC0aWPCNCx/3cTCGTP6ewHqWvboHz6DiaKlhLJauVZE
	 hBuyKJ2+M1imXF2D8JkFBZcDwzonmFHUsCjlNNKEYtxmIokQVfbGC9Qn2PnfvfSfqS
	 oP6nBjjSQIx8DsWrWbv8l7fcIJ0EdvCPxjn7isGzx3BDYPI1riOWcdrQB9wW0utoUu
	 k5RV1ABsx1Do7SOWRRpMpHu+aL2lfVi99MPXalyeFJqtpczcrG6JbtmQiiE3s0s04s
	 cMmkjuZ9KMeUw==
Date: Thu, 16 May 2024 18:08:26 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
Message-ID: <ZkYvemdrEOVFNtVu@lothringen>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-3-frederic@kernel.org>
 <xhsmhfruhhixv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhfruhhixv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Thu, May 16, 2024 at 05:31:40PM +0200, Valentin Schneider wrote:
> On 15/05/24 14:53, Frederic Weisbecker wrote:
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 58415cdc54f8..f5354de5644b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -773,7 +773,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
> >   */
> >  static int dyntick_save_progress_counter(struct rcu_data *rdp)
> >  {
> > -	rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
> 
> So for PPC, which gets the smp_mb() at the lock acquisition, this is an
> "obvious" redundant smp_mb().
> 
> For the other archs, per the definition of smp_mb__after_unlock_lock() it
> seems implied that UNLOCK+LOCK is a full memory barrier, but I wanted to
> see it explicitly stated somewhere. From a bit of spelunking below I still
> think it's the case, but is there a "better" source of truth?
> 
>   01352fb81658 ("locking: Add an smp_mb__after_unlock_lock() for UNLOCK+BLOCK barrier")
>   """
>   The Linux kernel has traditionally required that an UNLOCK+LOCK pair act as a
>   full memory barrier when either (1) that UNLOCK+LOCK pair was executed by the
>   same CPU or task, or (2) the same lock variable was used for the UNLOCK and
>   LOCK.
>   """
> 
> and
> 
>   https://lore.kernel.org/all/1436789704-10086-1-git-send-email-will.deacon@arm.com/
>   """
>   This ordering guarantee is already provided without the barrier on
>   all architectures apart from PowerPC
>   """

You seem to have found the accurate informations! But I must admit
they are hard to find and it would be welcome to document that properly, for example
in Documentation/memory-barriers.txt

I think the reason is that it's not supposed to be used outside RCU, perhaps
because its semantics are too fragile to use for general purpose? Even that
could be stated along in Documentation/memory-barriers.txt

Another thing is that its semantics are similar to smp_mb__after_spinlock()
(itself badly documented), although slightly different. I'm not even completely
sure how. I assume that smp_mb__after_spinlock() can be just used once to
produce the required ordering and subsequent lock on that spinlock don't need
to repeat the barrier to propagate the ordering against what is before the
smp_mb__after_spinlock. However IUUC smp_mb__after_unlock_lock() has to be
chained/repeated on all subsequent locking of the spinlock...

Thanks.


> 
> > +	/*
> > +	 * Full ordering against accesses prior current GP and also against
>                                           ^^^^^
>                                           prior to
> 
> > +	 * current GP sequence number is enforced by current rnp locking
> > +	 * with chained smp_mb__after_unlock_lock().
> > +	 */
> > +	rdp->dynticks_snap = ct_dynticks_cpu_acquire(rdp->cpu);
> >       if (rcu_dynticks_in_eqs(rdp->dynticks_snap)) {
> >               trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
> >               rcu_gpnum_ovf(rdp->mynode, rdp);
> > --
> > 2.44.0
> 
