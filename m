Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69FA93D;
	Wed, 26 Feb 2025 00:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528484; cv=none; b=R12wVp+JFlnksSwqbQIxLuYC5ka88SfFcLmgirEZ+GJbFMY2rZMTdhxeY2qgubWIB2Ao2ah55/XhlnwG1w3EnHCJFlm2Rsrbbd4wtANaQ+tdHGpInw1XIXabbiI3Aq6X2optp3AKmPOaizwCW8H4XERug2hhAtF9Xrqmoeoc40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528484; c=relaxed/simple;
	bh=uzH4sg8sEy7Ki0PJaM6Y2hLhbwD62ZHmh9IaBKjdWp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfOl5nTP76ZSFPaumTyw/eqv5D0zSTdr8MGri+xJiEOJ0rpKkgUwKGbCFlV7yNi/d24NsI4oKbXlXrS81sN3uY7WaYxuyh7xneT98qnyT6J6lp66hi/J6PFIGiR8yUttRCmEUCw50X9PQ02CBQTyvYuyik462c/8PWwZzY/IxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPaNoGDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPaNoGDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183A5C4CEF1;
	Wed, 26 Feb 2025 00:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740528484;
	bh=uzH4sg8sEy7Ki0PJaM6Y2hLhbwD62ZHmh9IaBKjdWp8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OPaNoGDCMqzKPnS+RNQqreB9pIto9JK9TFw2MnLSJxuV2/knfbYVkbw121MGHYqQU
	 H7j08S/lPaqx/1ZInM8j7aUjyduswuT3Igm8mTgV6LqE1azVqnVXIHMX//jzSBMy06
	 PRdR7+9Xar6DGOXCY+4bIwnJoLMnpQ5v8LhVr9M4EW+QIGwDUFBKZxLDEj9iFXpr7o
	 c5V8CJJH74tizGZjTK4lYMAPDnPEu0tOupPswf1wOJkRBHOHwalPeJ+eUBOgLREdRr
	 HKi+LxUMrCh7JPUJHn4XEwDlLN8r9RaFcorRY4IaoHdAJp1MEkuvhN3MVNK4D6E/i6
	 UlJqRXaDTej/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 561C8CE0B75; Tue, 25 Feb 2025 16:08:03 -0800 (PST)
Date: Tue, 25 Feb 2025 16:08:03 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu/exp: Remove confusing needless full barrier on
 task unblock
Message-ID: <f75ce493-f23e-4f55-b32f-77a7868f4e2d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-3-frederic@kernel.org>
 <20250225215908.GA1812344@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225215908.GA1812344@joelnvbox>

On Tue, Feb 25, 2025 at 04:59:08PM -0500, Joel Fernandes wrote:
> On Fri, Feb 14, 2025 at 12:25:58AM +0100, Frederic Weisbecker wrote:
> > A full memory barrier in the RCU-PREEMPT task unblock path advertizes
> > to order the context switch (or rather the accesses prior to
> > rcu_read_unlock()) with the expedited grace period fastpath.
> > 
> > However the grace period can not complete without the rnp calling into
> > rcu_report_exp_rnp() with the node locked. This reports the quiescent
> > state in a fully ordered fashion against updater's accesses thanks to:
> > 
> > 1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
> >    locking while propagating QS up to the root.
> > 
> > 2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
> >    the root rnp to wait/check for the GP completion.
> > 
> > 3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
> >    before the grace period completes.
> > 
> > This makes the explicit barrier in this place superflous. Therefore
> > remove it as it is confusing.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  kernel/rcu/tree_plugin.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index 3c0bbbbb686f..d51cc7a5dfc7 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -534,7 +534,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> >  		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
> >  			     (!empty_norm || rnp->qsmask));
> >  		empty_exp = sync_rcu_exp_done(rnp);
> > -		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
> 
> I was wondering though, this is a slow path and the smp_mb() has been there
> since 2009 or so. Not sure if it is super valuable to remove it at this
> point. But we/I should definitely understand it.
> 
> I was wondering if you could also point to the fastpath that this is racing
> with, it is not immediately clear (to me) what this smp_mb() is pairing with :(

My guess was one of the lock acquisitions or dyntick checks in
__sync_rcu_exp_select_node_cpus(), but I am not seeing anything there.
In this context, "fastpath" would be one of the early exits, for example,
the "continue" statements in the second for_each_leaf_node_cpu_mask()
loop.

But again, I am not seeing anything that appears to need that smp_mb().
As you say, that smp_mb() is not on a fastpath, so we need to check
carefully before removing it.

						Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> 
> 
> 
> >  		np = rcu_next_node_entry(t, rnp);
> >  		list_del_init(&t->rcu_node_entry);
> >  		t->rcu_blocked_node = NULL;
> > -- 
> > 2.46.0
> > 
