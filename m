Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E611E52A;
	Wed, 26 Jun 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411213; cv=none; b=CJhgvPKff+irJxPx6TAsFqOKy5JfQCLijmWUbPvUCFXdxww0pqrYKcRj8q1EbRT0JVSdFq173qCtWHUAwwYVOEVf9rrRwnngW+HAf8em5SsdpBW0qKDS5baJ3X0xFQS83Kpw8zDjCMPlkugJszGUKpU8xTpHov4YKn0G4TRPhDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411213; c=relaxed/simple;
	bh=V0ZOKzVCQZZ9ZeEBAHlxb0Z++KOVCNbb60YWE77q8dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBRKM60uMQKm0pZhcs8veP803HgmgHfL+dyWMPL8dXg+mxoQH4Uy+t1W515dBIiURHpQEp2uDuIBjbydEzxuNjOnQj4FWP+rShdqy2/RrgkV5jHo6k8isJAaE5Zxz55DyXupcEuJUCzoBGGPjG2Rr+mtL1AwpgnfNfzHxYy3DZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5DQDAJt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5DQDAJt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A36C116B1;
	Wed, 26 Jun 2024 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719411212;
	bh=V0ZOKzVCQZZ9ZeEBAHlxb0Z++KOVCNbb60YWE77q8dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5DQDAJtV9H4BKd8JP1sRITBrGdZQe0wyiiqSVqtxVE+D3OaA0JN0V4jgiY2Q9MSz
	 eVztwlai7YDPVHaQ9SmMQFID17Pi27/P7/DNgae+ApgcVx7pum9z9x/dxCreRClsf3
	 8NNim47LdhV9DLYjSPI6Kd4P/ZL/slpSePQn1idUYs/RtI6smZSEAjqjdo+bVXd0s4
	 63QPhpmxdTDV0ef4UVCIZuQDyNro7D6DD1uqBGDksFpOGQ5FjcPNbGwk4b2uHT1Jy4
	 o35CJnRT1DREScHJJUp4s1Xd8JpfTx0VAf9woTRSNl9ygfqmKu7xQhtXiGBKKM1yMn
	 oQdLY/4HtAwtg==
Date: Wed, 26 Jun 2024 16:13:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Neeraj upadhyay <neeraj.iitr10@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 2/6] rcu: Remove superfluous full memory barrier upon
 first EQS snapshot
Message-ID: <ZnwiCsor-cku3ETF@localhost.localdomain>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-2-paulmck@kernel.org>
 <CAFwiDX9ynNpmU_Au=J7geJYjE8NLLM-p2x8QDyjmZ1qNBkLXZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFwiDX9ynNpmU_Au=J7geJYjE8NLLM-p2x8QDyjmZ1qNBkLXZQ@mail.gmail.com>

Le Wed, Jun 12, 2024 at 01:57:20PM +0530, Neeraj upadhyay a écrit :
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
> >  .../Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst    | 6 +++---
> >  kernel/rcu/tree.c                                          | 7 ++++++-
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > index 5750f125361b0..728b1e690c646 100644
> > --- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > +++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
> > @@ -149,9 +149,9 @@ This case is handled by calls to the strongly ordered
> >  ``atomic_add_return()`` read-modify-write atomic operation that
> >  is invoked within ``rcu_dynticks_eqs_enter()`` at idle-entry
> >  time and within ``rcu_dynticks_eqs_exit()`` at idle-exit time.
> > -The grace-period kthread invokes ``rcu_dynticks_snap()`` and
> > -``rcu_dynticks_in_eqs_since()`` (both of which invoke
> > -an ``atomic_add_return()`` of zero) to detect idle CPUs.
> > +The grace-period kthread invokes first ``ct_dynticks_cpu_acquire()``
> > +(preceded by a full memory barrier) and ``rcu_dynticks_in_eqs_since()``
> > +(both of which rely on acquire semantics) to detect idle CPUs.
> >
> >  +-----------------------------------------------------------------------+
> >  | **Quick Quiz**:                                                       |
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index f07b8bff4621b..1a6ef9c5c949e 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -769,7 +769,12 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
> >   */
> >  static int dyntick_save_progress_counter(struct rcu_data *rdp)
> >  {
> > -       rdp->dynticks_snap = rcu_dynticks_snap(rdp->cpu);
> > +       /*
> > +        * Full ordering against accesses prior current GP and also against
> > +        * current GP sequence number is enforced by current rnp locking
> > +        * with chained smp_mb__after_unlock_lock().
> > +        */
> 
> It might be worth mentioning that this chained smp_mb__after_unlock_lock()
> is provided by rnp leaf node locking in rcu_gp_init() and rcu_gp_fqs_loop() ?

Right!

How about this?

    /*
     * Full ordering against accesses prior current GP and also against
     * current GP sequence number is enforced by rcu_seq_start() implicit
     * barrier and even further by smp_mb__after_unlock_lock() barriers
     * chained all the way throughout the rnp locking tree since rcu_gp_init()
     * and up to the current leaf rnp locking.
     */

Thanks.
