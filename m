Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD32258CD1;
	Wed, 26 Feb 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574332; cv=none; b=AnfQGaDCj5L5jytRJS1R6FVRx3sFcVHLoyq11NKlUvjIa6dRYqYjvuug3YKt5nQ1nFoolGvMEOpDZYXB1o6p44STr3KcuGvsEjmm2++qXzrKlRFUHS3IYZdvEAox6MMCZoXHOQJOdhke4W94dwaeI1dR2FHejI/2lKdmdTNgWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574332; c=relaxed/simple;
	bh=JGlk4/4dQ34bJu4CjCMr5WRqinwgziK4sNHqtXrh+ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLEtMjdPsMuTYOUx26ln+g1UJ2BwCh04MzakT6nEMKAAosDt8Md4CjCIZk35iYxd3ZDVlujixUBYU28ws3zo9Ka3U8/AQIx5M4K7VaGOPjhbANPr4CplewP6CekhqyhniUnWRfR2HOoMM2xuNE5UrVIkDkcseFxHAadXbmlVC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPLq2lv7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPLq2lv7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F043C4CED6;
	Wed, 26 Feb 2025 12:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740574332;
	bh=JGlk4/4dQ34bJu4CjCMr5WRqinwgziK4sNHqtXrh+ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPLq2lv79TwtWjDM21fe2SkmG1VW6txtJvF8LgdsDJswnignJcKUGfM14yYJYOKNA
	 KQ0Dff+RcE4fENAOaS71Olw64vgN0hhgQPuuFNj2BAHHSHOqg6Q5/vdtt2Jp05lj4S
	 BAITyDsgNNdvYcypfZ6jBdNleJllNpe5IfovuiSv6PQfHo8HxMrbht2wJJCsW2gV5S
	 dBuzvDllkg0dhpR+dyvm5kf+5WhhGJVd1Xn1Ns3BF4TTl1GoXnJykmAzVeTuVq1fVv
	 w4BV45y2TbGsPDiXiszS+77loffjHqkp69U4Aly8bH2lRlWbxkytC/jQn4O8d4KKpp
	 PPAn1h9YuWg8A==
Date: Wed, 26 Feb 2025 13:52:09 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/3] rcu/exp: Remove confusing needless full barrier on
 task unblock
Message-ID: <Z78OeeyarjDB63Dj@localhost.localdomain>
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-3-frederic@kernel.org>
 <20250225215908.GA1812344@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225215908.GA1812344@joelnvbox>

Le Tue, Feb 25, 2025 at 04:59:08PM -0500, Joel Fernandes a écrit :
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

The point is indeed not to improve performance because this is a slowpath
(although...). The main goal is to maintain a clear picture of the ordering
without needless barriers that leave a taste of doubt to reviewers.

> I was wondering if you could also point to the fastpath that this is racing
> with, it is not immediately clear (to me) what this smp_mb() is pairing with
> :(

It is supposed to pair with the barrier in sync_exp_work_done() but then again
this is already enforced by the smp_mb__after_unlock_lock() chained through
rnp locking.

Thanks.

> 
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
