Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66B185091;
	Wed, 26 Jun 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412131; cv=none; b=ZmiEZID+vl8hSbpCBkBaCFnrLA3vwu7mGKuo8OAVp8+1H0xab8c9XvmPa556bz6JIr+E4ygJMiHeVNiElszTeKb5RSm4EWe5vZeUBeWbMvbE19g6ficIu/A6ri1WDhIgp+m1tR8rLy4OzC/rqasbVmfgQmYxc2ky0Nt8OaDd94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412131; c=relaxed/simple;
	bh=ZWHIPidE5USRmxsE4CrRem4oMewJdmGkXzT3eWY/mYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEkhahxEVpMURpBftWU+sHdBBc5ikiL73kBYE0Quu2oT8BNZJnzrA01FjO7iiffmSjPZ5DTzUh9TOc/svZe29Zm7JXBr4ispaHBxiEm8nlwCotyB1BFwGUI/xBwMVxgACHh6eSQVxDsw3XswSAbTUxzH9EPjDu/Z+weNjxPKVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb6FG/TY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb6FG/TY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B157C116B1;
	Wed, 26 Jun 2024 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719412130;
	bh=ZWHIPidE5USRmxsE4CrRem4oMewJdmGkXzT3eWY/mYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fb6FG/TYxVDDlbbui5Np51JXNUtkbQS/mkh2aiI/1Uz76L+is3MtCw4IkHfcCCYgD
	 kBz8cw5urxKboeVEflAyv+RA4g3sP2yOgsDTPxWbgtj5r3CutK7Oznl6zaFw7d3KGx
	 2i9HnGsihjO45hWvb1v+bHuUuT62Q37mOBhfI8MHoNgjZ4dazH4ixuI5ZZh2ddVDNO
	 hQ+b+ZjQ7q8lpbDy3//FyN+38UJy2xZWc7sIrRFOTx9I/Hk5mh4x6RRZt+WC6yKylR
	 iDysWLW/OiH+UWv2Msl/P8Iy0t5futTeA+XE0DxiZsJz4EKQDhCjydzdH3oVfj7TmZ
	 hGMCbeC7jVRUA==
Date: Wed, 26 Jun 2024 16:28:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 3/6] rcu/exp: Remove superfluous full memory barrier
 upon first EQS snapshot
Message-ID: <ZnwloG9xOrOHru4B@localhost.localdomain>
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

Le Wed, Jun 12, 2024 at 02:14:14PM +0530, Neeraj upadhyay a écrit :
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

How about this?

    /*
     * Full ordering against accesses prior current GP and also against
     * current GP sequence number is enforced by rcu_seq_start() implicit
     * barrier, relayed by kworkers locking and even further by
     * smp_mb__after_unlock_lock() barriers chained all the way throughout
     * the rnp locking tree since sync_exp_reset_tree() and up to the current
     * leaf rnp locking.
     */

Thanks.

> 
> 
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
