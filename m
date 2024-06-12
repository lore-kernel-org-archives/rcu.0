Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48E10E3;
	Wed, 12 Jun 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203539; cv=none; b=UW/n/beozudGpUO7JzSUSeeqbBmXpCxKG9XdaTWNDF/Kw3XOFWVmjKbbKs44yjd6tzsln4NlWj613XJLq/99L9CjsWM6HFr8aB7JSRhEsjVVB6pT1HjAZI98uBPAbz+xPplJej5WS6Rkr6JpUVcCCIGCv+ExZ8RVfhgiFMObpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203539; c=relaxed/simple;
	bh=pOEh/kJuLjFT35DPlXE51th7dgbqYHf8hNYpg+yrC+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Io0JfEFGHKkoaJn0VJABEGLJqXWieuHWnhF4VIMbRVZfuOI6/1vfgBrAithbxpEZyCi6WIIXPmbFSY9cMVdqBHaT+TyuqVvZF0209ca4Is3uqCG30Bkq1t7D4rA4ZNYh1Xx7rBCTVSwsEgmvdAc9bR+SCUFQsIuDqJRyL0BK2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOoV2lLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOoV2lLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958AAC116B1;
	Wed, 12 Jun 2024 14:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718203538;
	bh=pOEh/kJuLjFT35DPlXE51th7dgbqYHf8hNYpg+yrC+w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AOoV2lLC6qkQ5PrzMsaGByKx4L7vHn4zphuiD5SbvWyNv2ra6uIQ+Ht0l2OpxTt+n
	 xmcBiyyk2hHoBx7xA2XVNOdCaxtQPlwaZeCd0EjI9GwO+wPC6A1jpgkLbhM3H6FAHD
	 4NEFdzNqZxcI98ewmJXhTmGsy9w+sKpix7BoVDHE+uNdRjUVCOqv/m4fbIgPEPpoAz
	 GJi8pRxjWzIZRK3sApUs1aZIJR8HmFBDgAz4b7tszNbJdjpt7Y7v1mGy2myKQsdBZM
	 ebTc+m1K/2HQTUN7JkQfHfOn+3mzSa6PylBHomkfCC5TEgg8+w8j+Htbh/IVM39bDH
	 uxCyMfgb3TN2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E604CE0886; Wed, 12 Jun 2024 07:45:38 -0700 (PDT)
Date: Wed, 12 Jun 2024 07:45:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH rcu 3/6] rcu/exp: Remove superfluous full memory barrier
 upon first EQS snapshot
Message-ID: <5bef03bd-84c4-4e9b-b045-ea023f91d772@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-3-paulmck@kernel.org>
 <CAFwiDX_5BZ9e0odyJKTPJJ9BDkHJ6fcEzSwgs9rnjhuRk4qhhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX_5BZ9e0odyJKTPJJ9BDkHJ6fcEzSwgs9rnjhuRk4qhhw@mail.gmail.com>

On Wed, Jun 12, 2024 at 02:14:14PM +0530, Neeraj upadhyay wrote:
> On Wed, Jun 5, 2024 at 3:58 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > From: Frederic Weisbecker <frederic@kernel.org>
> >
> > When the grace period kthread checks the extended quiescent state
> > counter of a CPU, full ordering is necessary to ensure that either:
> >
> > * If the GP kthread observes the remote target in an extended quiescent
> >   state, then that target must observe all accesses prior to the current
> >   grace period, including the current grace period sequence number, once
> >   it exits that extended quiescent state.
> >
> > or:
> >
> > * If the GP kthread observes the remote target NOT in an extended
> >   quiescent state, then the target further entering in an extended
> >   quiescent state must observe all accesses prior to the current
> >   grace period, including the current grace period sequence number, once
> >   it enters that extended quiescent state.
> >
> > This ordering is enforced through a full memory barrier placed right
> > before taking the first EQS snapshot. However this is superfluous
> > because the snapshot is taken while holding the target's rnp lock which
> > provides the necessary ordering through its chain of
> > smp_mb__after_unlock_lock().
> >
> > Remove the needless explicit barrier before the snapshot and put a
> > comment about the implicit barrier newly relied upon here.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree_exp.h | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 8a1d9c8bd9f74..bec24ea6777e8 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -357,7 +357,13 @@ static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
> >                     !(rnp->qsmaskinitnext & mask)) {
> >                         mask_ofl_test |= mask;
> >                 } else {
> > -                       snap = rcu_dynticks_snap(cpu);
> > +                       /*
> > +                        * Full ordering against accesses prior current GP and
> > +                        * also against current GP sequence number is enforced
> > +                        * by current rnp locking with chained
> > +                        * smp_mb__after_unlock_lock().
> 
> Again, worth mentioning the chaining sites sync_exp_reset_tree() and
> this function?

It might well be in both cases.  Could you and Frederic propose
agreed-upon appropriate changes (including the null change, if
appropriate)?

							Thanx, Paul

> Thanks
> Neeraj
> 
> > +                        */
> > +                       snap = ct_dynticks_cpu_acquire(cpu);
> >                         if (rcu_dynticks_in_eqs(snap))
> >                                 mask_ofl_test |= mask;
> >                         else
> > --
> > 2.40.1
> >
> >
