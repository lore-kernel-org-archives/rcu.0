Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC514A614;
	Wed, 26 Jun 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414186; cv=none; b=VWTOtTDRHalVqMj54a4/P6/htUcVKRe7Q9sAY8d986PATuotlDBj1bgEbjcLBaCZHFR1j0XC889Gd9+Uu+601ISjU8lkE6oY5l0rzbLoGtDDdXpoTxB0MIDc2exaBDSjca0OrFENZTDtTN6zNvMQIgbgSbn0OMVU1UxJmKkr0TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414186; c=relaxed/simple;
	bh=K2Nvf+xU3tFR5sso/efVf5QZGdAqKAxqinCxi5UIV8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHdoV+hkkBo1KPY3NTnSwa19oKN9qyWzJG2onJZ/SxZ9Q22j5rCqEp3Dx7VwKNUjrWdlGcz27kqzSK53o3WJrn7yq5vGC90lPHviCPPVLIoD8ocXd2kutdEO0Zu5weLfGbsHLTKZGFZmI48jJVedVzTecNUbErxhEeDBYmBm7B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCty31+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCty31+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B92C116B1;
	Wed, 26 Jun 2024 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414185;
	bh=K2Nvf+xU3tFR5sso/efVf5QZGdAqKAxqinCxi5UIV8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCty31+RONxoZYsKqQex3KpchcgumeWvwFkl9vOmh8E1clKCjijBA6nhwgQ+wg+vv
	 Sfj8279WCkt36V2zM72jnFnwltvNxi8utClnOAzV0KgR5WiUv23k9HVnAWUdGkePtW
	 cWnvcn/J6FxExzIjhp7usA3zpSwgsOXF7OyOjW+EpWCtd42u5yUQKjBefBDMDtqLpu
	 mRxgDPM4gQrei1IvIm5BgOuV8awak4H+Np7HqM9tC6pWLwMH2Zla6NTuU2/s0bDMXp
	 UVOaROVt1rx3wLMkyfso5Gi8HncgZW8+fxrfNJzkhb4TatuH3jSR9/4is6W06yFPVs
	 W8sc2v2cQ/j2g==
Date: Wed, 26 Jun 2024 17:03:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 1/6] rcu: Remove full ordering on second EQS snapshot
Message-ID: <Znwtpmu9Vs8R6iAV@localhost.localdomain>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-1-paulmck@kernel.org>
 <ZmBYOaQQQKapFGZo@localhost.localdomain>
 <26b85288-dd54-4ace-978d-39681de8fcad@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26b85288-dd54-4ace-978d-39681de8fcad@paulmck-laptop>

Le Wed, Jun 05, 2024 at 11:44:42AM -0700, Paul E. McKenney a écrit :
> On Wed, Jun 05, 2024 at 02:21:13PM +0200, Frederic Weisbecker wrote:
> > Le Tue, Jun 04, 2024 at 03:26:47PM -0700, Paul E. McKenney a écrit :
> > > From: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > > When the grace period kthread checks the extended quiescent state
> > > counter of a CPU, full ordering is necessary to ensure that either:
> > > 
> > > * If the GP kthread observes the remote target in an extended quiescent
> > >   state, then that target must observe all accesses prior to the current
> > >   grace period, including the current grace period sequence number, once
> > >   it exits that extended quiescent state. Also the GP kthread must
> > >   observe all accesses performed by the target prior it entering in
> > >   EQS.
> > > 
> > > or:
> > > 
> > > * If the GP kthread observes the remote target NOT in an extended
> > >   quiescent state, then the target further entering in an extended
> > >   quiescent state must observe all accesses prior to the current
> > >   grace period, including the current grace period sequence number, once
> > >   it enters that extended quiescent state. Also the GP kthread later
> > >   observing that EQS must also observe all accesses performed by the
> > >   target prior it entering in EQS.
> > > 
> > > This ordering is explicitly performed both on the first EQS snapshot
> > > and on the second one as well through the combination of a preceding
> > > full barrier followed by an acquire read. However the second snapshot's
> > > full memory barrier is redundant and not needed to enforce the above
> > > guarantees:
> > > 
> > >     GP kthread                  Remote target
> > >     ----                        -----
> > >     // Access prior GP
> > >     WRITE_ONCE(A, 1)
> > >     // first snapshot
> > >     smp_mb()
> > >     x = smp_load_acquire(EQS)
> > >                                // Access prior GP
> > >                                WRITE_ONCE(B, 1)
> > >                                // EQS enter
> > >                                // implied full barrier by atomic_add_return()
> > >                                atomic_add_return(RCU_DYNTICKS_IDX, EQS)
> > >                                // implied full barrier by atomic_add_return()
> > >                                READ_ONCE(A)
> > >     // second snapshot
> > >     y = smp_load_acquire(EQS)
> > >     z = READ_ONCE(B)
> > > 
> > > If the GP kthread above fails to observe the remote target in EQS
> > > (x not in EQS), the remote target will observe A == 1 after further
> > > entering in EQS. Then the second snapshot taken by the GP kthread only
> > > need to be an acquire read in order to observe z == 1.
> > > 
> > > Therefore remove the needless full memory barrier on second snapshot.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/rcu/tree.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 28c7031711a3f..f07b8bff4621b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -321,7 +321,7 @@ static bool rcu_dynticks_in_eqs(int snap)
> > >   */
> > >  static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
> > >  {
> > > -	return snap != rcu_dynticks_snap(rdp->cpu);
> > > +	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
> > 
> > I guess I'm going to add a comment here to elaborate on the fact
> > it relies on the ordering enforced before the first snapshot. Would
> > you prefer a delta patch or an updated patch?
> 
> Either works, just tell me which you are doing when you submit the patch.
> Either way, I will arrange for there to be a single combined commit.

Ok before I resend, how does the following comment look like?

/*
 * The first failing snapshot is already ordered against the accesses
 * performed by the remote CPU after it exiting idle.
 *
 * The second snapshot therefore only needs to order against accesses
 * performed by the remote CPU prior it entering idle and therefore can
 * solely on acquire semantics.
 */

Thanks.

> 
> 							Thanx, Paul
> 
