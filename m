Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE0161314;
	Wed, 26 Jun 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439971; cv=none; b=ezGbk9X5XCzmclAelDxxXNCsuldT7J8QFq8mxJ1zVu4VEWNk1UgK6dXtbPmjVf1SXh3c5PCSuDfZ1av5DF2xiD7H3Ji4kPsQjjSz0ChQdEQ24P/kA6ElMimLjCiGAU7USRRbcdA3Scs/IcpuG59RvXTSqN64teYsQSqFiHxy+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439971; c=relaxed/simple;
	bh=8B9eu37ujnhX9N/2MnvPnm85A6jj/mKyPtwvxBCsGiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7g6HKTWdqeTYbBeN+fNVwtUhEL26oWs02yqFvPLMiOdFsnWi08Tgbk8QdaYhju37x/a53o6SfCsaFCbqQZGx3MfTyWUyRpfMv8mWtR3xcj0QQKgWxn/Bti5UVJP1JyaFrB5gShGWEZzkpE4F6BgRbUHDZMk24Ih5M4hQvgkMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=touu1sfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="touu1sfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B6CC116B1;
	Wed, 26 Jun 2024 22:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719439971;
	bh=8B9eu37ujnhX9N/2MnvPnm85A6jj/mKyPtwvxBCsGiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=touu1sfkk9RUa/rSh1ynqEZJr+/bCfvghXQwiEwlEvXpGx+HEloLAfobCQY1fpFgN
	 jdOcmcEydJwXP98aFjqGohft+5lAc2DYdJs/XisILt6xEb8l7bAaa9cDGg0MJtl2e+
	 uqVlfnJb0ww66+04M6eym7WAmHiRevnqe2N3L75nWvWhz2aXGLeMpg/YpKs3IEmt3U
	 KAdaS1Mgm+UpbC2wEXWS6LlmM48j5NiHAMulAMEZesLVMl8LvJCF1XJN5/jSxuAP93
	 CoHRlkEabyPJCTh3U24Uoz6L0qW5rmXVEY+kPZ3BOWlHP6cX+dw8gbwNkIhBL8Mxdk
	 76HXihC+rAmHw==
Date: Thu, 27 Jun 2024 00:12:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 3/6] rcu/exp: Remove superfluous full memory barrier
 upon first EQS snapshot
Message-ID: <ZnySYEWMJpcfkmOr@pavilion.home>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-3-paulmck@kernel.org>
 <CAFwiDX_5BZ9e0odyJKTPJJ9BDkHJ6fcEzSwgs9rnjhuRk4qhhw@mail.gmail.com>
 <ZnwloG9xOrOHru4B@localhost.localdomain>
 <CAFwiDX8OE74e4ZVsy3wJbX5F4Huv0NR1w2EqM4xfeoa03JjCpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX8OE74e4ZVsy3wJbX5F4Huv0NR1w2EqM4xfeoa03JjCpg@mail.gmail.com>

Le Wed, Jun 26, 2024 at 10:49:58PM +0530, Neeraj upadhyay a écrit :
> On Wed, Jun 26, 2024 at 7:58 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Wed, Jun 12, 2024 at 02:14:14PM +0530, Neeraj upadhyay a écrit :
> > > On Wed, Jun 5, 2024 at 3:58 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > >
> > > > When the grace period kthread checks the extended quiescent state
> > > > counter of a CPU, full ordering is necessary to ensure that either:
> > > >
> > > > * If the GP kthread observes the remote target in an extended quiescent
> > > >   state, then that target must observe all accesses prior to the current
> > > >   grace period, including the current grace period sequence number, once
> > > >   it exits that extended quiescent state.
> > > >
> > > > or:
> > > >
> > > > * If the GP kthread observes the remote target NOT in an extended
> > > >   quiescent state, then the target further entering in an extended
> > > >   quiescent state must observe all accesses prior to the current
> > > >   grace period, including the current grace period sequence number, once
> > > >   it enters that extended quiescent state.
> > > >
> > > > This ordering is enforced through a full memory barrier placed right
> > > > before taking the first EQS snapshot. However this is superfluous
> > > > because the snapshot is taken while holding the target's rnp lock which
> > > > provides the necessary ordering through its chain of
> > > > smp_mb__after_unlock_lock().
> > > >
> > > > Remove the needless explicit barrier before the snapshot and put a
> > > > comment about the implicit barrier newly relied upon here.
> > > >
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree_exp.h | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index 8a1d9c8bd9f74..bec24ea6777e8 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -357,7 +357,13 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
> > > >                     !(rnp->qsmaskinitnext & mask)) {
> > > >                         mask_ofl_test |= mask;
> > > >                 } else {
> > > > -                       snap = rcu_dynticks_snap(cpu);
> > > > +                       /*
> > > > +                        * Full ordering against accesses prior current GP and
> > > > +                        * also against current GP sequence number is enforced
> > > > +                        * by current rnp locking with chained
> > > > +                        * smp_mb__after_unlock_lock().
> > >
> > > Again, worth mentioning the chaining sites sync_exp_reset_tree() and
> > > this function?
> >
> > How about this?
> >
> 
> Looks good to me, thanks!

And similar to the previous one, a last minute edition:

			/*
			 * Full ordering between remote CPU's post idle accesses
			 * and updater's accesses prior to current GP (and also
			 * the started GP sequence number) is enforced by
			 * rcu_seq_start() implicit barrier, relayed by kworkers
			 * locking and even further by smp_mb__after_unlock_lock()
			 * barriers chained all the way throughout the rnp locking
			 * tree since sync_exp_reset_tree() and up to the current
			 * leaf rnp locking.
			 *
			 * Ordering between remote CPU's pre idle accesses and
			 * post grace period updater's accesses is enforced by the
			 * below acquire semantic.
			 */

Still ok?

Thanks.
