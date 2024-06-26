Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C8482FE;
	Wed, 26 Jun 2024 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439399; cv=none; b=lFe4NkvQ6ub87XQrG1I1n+Z6WGZXSDCmNr1PE9FJo81vggkex0Bl/M5BYlN4Rodt4qb/k1wzKUU1m7qnBZPmyzbzvPCLbD1us3N1Jp8Nmzr0FoGD2ozv554eBCuEfR/UWtLNlG9x2wYxO7ZMfptZbF1qi5U+SkaI/2yyaWRRh0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439399; c=relaxed/simple;
	bh=U+uz0XLNdDwxkcgFdvAHOzYHgj6wcdQxkiGU/K7ilx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpbko+WGzbV7mJgCxesl4QdQ9Me2viurpptATVwrfZ02MBXNXya5tbghVfzJFX0Caiul+5pkT41b5lF0NteqU5cB6rnSAItldM9gJfLjNzcDvNGd2rfMUjHRlsc74B5WxJCIYMKLacyIU+CqQ6NH/GM8ZEtnTgAlz34vgbyqSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2aH49ek; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2aH49ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FB7C116B1;
	Wed, 26 Jun 2024 22:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719439399;
	bh=U+uz0XLNdDwxkcgFdvAHOzYHgj6wcdQxkiGU/K7ilx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i2aH49ekwmZgvIvqA4RyZB4v8dJcvuflGXH3st3Zjbiclczeol9qzG7cystiwNNxC
	 KnQZHMt1k3m3rUAVzowWCQWi1cpcTG6wbddljpWOEyTPG/nWg4UZk+xWrGKiSM0dFt
	 JNXWQ12gb4n6rovKVlWqWJJng5XDD9IEuganMaE95wGHZEUWaFWP7QpveYNogfq/WZ
	 u4yONJJC0/yOXssqC7eXxSL9ug9nXXHVOxF0o7M6dFQzKGQLfe8lZyaT+V5Ae8moQV
	 Bt0qTMZsRMp+xPtMi0efL5GC0NTc/mKFe0t3gP3s0B1oGd9iSPgXTrLF17mq0HrA/X
	 INUONQS14f2PQ==
Date: Thu, 27 Jun 2024 00:03:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
Message-ID: <ZnyQJGJGeAbTSEhv@pavilion.home>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-2-paulmck@kernel.org>
 <CAFwiDX9ynNpmU_Au=J7geJYjE8NLLM-p2x8QDyjmZ1qNBkLXZQ@mail.gmail.com>
 <ZnwiCsor-cku3ETF@localhost.localdomain>
 <CAFwiDX8EL8q-ihiXR8GSu5AxmRGs8w4z682nWMMMqDe2phLjuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX8EL8q-ihiXR8GSu5AxmRGs8w4z682nWMMMqDe2phLjuQ@mail.gmail.com>

Le Wed, Jun 26, 2024 at 10:49:05PM +0530, Neeraj upadhyay a écrit :
> On Wed, Jun 26, 2024 at 7:43 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > Le Wed, Jun 12, 2024 at 01:57:20PM +0530, Neeraj upadhyay a écrit :
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
> > > >  .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6 +++---
> > > >  kernel/rcu/tree.c                                          | 7 ++++++-
> > > >  2 files changed, 9 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > > > index 5750f125361b0..728b1e690c646 100644
> > > > --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > > > +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > > > @@ -149,9 +149,9 @@ This case is handled by calls to the strongly ordered
> > > >  ``atomic_add_return()`` read-modify-write atomic operation that
> > > >  is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
> > > >  time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
> > > > -The grace-period kthread invokes ``rcu_dynticks_snap()`` and
> > > > -``rcu_dynticks_in_eqs_since()`` (both of which invoke
> > > > -an ``atomic_add_return()`` of zero) to detect idle CPUs.
> > > > +The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
> > > > +(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
> > > > +(both of which rely on acquire semantics) to detect idle CPUs.
> > > >
> > > >  +-----------------------------------------------------------------------+
> > > >  | **Quick Quiz**:                                                       |
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index f07b8bff4621b..1a6ef9c5c949e 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -769,7 +769,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
> > > >   */
> > > >  static int dyntick_save_progress_counter(struct rcu_data *rdp)
> > > >  {
> > > > -       rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
> > > > +       /*
> > > > +        * Full ordering against accesses prior current GP and also against
> > > > +        * current GP sequence number is enforced by current rnp locking
> > > > +        * with chained smp_mb__after_unlock_lock().
> > > > +        */
> > >
> > > It might be worth mentioning that this chained smp_mb__after_unlock_lock()
> > > is provided by rnp leaf node locking in rcu_gp_init() and rcu_gp_fqs_loop() ?
> >
> > Right!
> >
> > How about this?
> >
> 
> Looks good to me, thanks! Minor comment (ditto for the other patch) below
> 
> 
> >     /*
> >      * Full ordering against accesses prior current GP and also against
> 
> Nit: "prior to current GP" ?

Thanks. On a second thought and just to make sure we don't forget why we did
what we did after a few years, I expanded some more, still ok with the following?

	/*
	 * Full ordering between remote CPU's post idle accesses and updater's
	 * accesses prior to current GP (and also the started GP sequence number)
	 * is enforced by rcu_seq_start() implicit barrier and even further by
	 * smp_mb__after_unlock_lock() barriers chained all the way throughout the
	 * rnp locking tree since rcu_gp_init() and up to the current leaf rnp
	 * locking.
	 *
	 * Ordering between remote CPU's pre idle accesses and post grace period's
	 * accesses is enforced by the below acquire semantic.
	 */

Thanks.
