Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDD4BEE52;
	Fri, 11 Sep 2026 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789168347; cv=none; b=TpSjahZTB9ZwmH8wR0ivKD7W3l0RfNPuYOwxUOOSN0ESuGLz7nLWHTXoH81Peo7goqm3ox2VlT9vM0QvjqSzDctc8GXSbGYqI8fV6e1gtB0LKOyI5riRmbjvnQx2bCtjDQLXVTqNLBUK/vvrNQThLoWgTUAWFsg3o0eTLZaj8ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789168347; c=relaxed/simple;
	bh=vwdhFLiiFXFpJXXFf/mC4Js6K51JYWYGOQo5Icf08ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyR2IPp0Z3D6foIWAG73ruFa9AThpDMjjAt5uQo6wEBQsNGJG5TEm3uBMfhvZNcNw6npy+GpuocWVkRayzPuOzqDNlwAUhaRAkObVCnRLPVF2nT/K2ArWKx8GScp6pJmyAgUrm3gMNMxGbUI3mQVnzL8ypQfZIx/hbuwVcvrO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF6IubXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF6IubXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE0B1F000FF;
	Fri, 11 Sep 2026 23:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789168346;
	bh=uQud4ieluhBVeYNAJIcg8se4H7ZEJ9wCHqQH7aqrcfU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=iF6IubXcuqUw6KKTVR09tNzbCzp7ef7l5aiIzri2J5+J+V7k9NQUu8MJpUCjBTTfr
	 lY/GegcPjYxEccFA9pUplkR6MeTVKj9lAVEnsZ3EwtA26baLHTWlig6syF38U+gwBZ
	 ybUtDDTbCFs0xL/uBGXwX5YWB3UnUmAjPNM0N9zHFpnDrSHMpPDnTH4ppEfClt1uXf
	 k6ii5UxKoGBqqocodOCZDO2WO00t9kggKcDmtG6daMQu8LTmIHBap7kUwEBSmiYuYB
	 61E716LrxdwbA1ZIldY+X2VufcxqCDioDQ2gnY7on3EqutxFuBa1iTCs4EuHwLXf3h
	 77GJZyIQu5z1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E707ECE09DD; Fri, 11 Sep 2026 16:12:25 -0700 (PDT)
Date: Fri, 11 Sep 2026 16:12:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: kunwu.chan@gmail.com, jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH] srcutiny: Add lockdep and early-boot checks to
 synchronize_srcu_atomic()
Message-ID: <5383fa3d-7d3f-4baf-b72e-cfb1b1e7a815@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911160913.2859713-1-kunwu.chan@gmail.com>
 <3CFBAB18-70BF-48DA-9CE2-77F7C89F2DCC@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3CFBAB18-70BF-48DA-9CE2-77F7C89F2DCC@mainlining.org>

On Fri, Sep 11, 2026 at 10:18:04PM +0100, Bradley Morgan wrote:
> On 11 September 2026 17:09:13 BST, Kunwu Chan <kunwu.chan@gmail.com> wrote:
> >Add the RCU_LOCKDEP_WARN and early-boot check that the Tree version
> >gained, srcu_lock_sync() was already present.
> >
> >Suggested-by: Zqiang <qiang.zhang@linux.dev>
> 
> Ok.
> 
> Reviewed-by: Bradley Morgan <brads@mainlining.org>

Applied, thank you!

> >Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> >---
> > kernel/rcu/srcutiny.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> >index 99f8bfd98b04..76411562366f 100644
> >--- a/kernel/rcu/srcutiny.c
> >+++ b/kernel/rcu/srcutiny.c
> >@@ -361,6 +361,12 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
> > 
> > 	srcu_lock_sync(&ssp->dep_map);
> > 
> >+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
> >+			 "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
> >+
> >+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> >+		return;
> >+
> 
> Wow!

If you think that this one is fun, take a look at the implementation of
synchronize_rcu() in kernel/rcu/tiny.c.  ;-)

							Thanx, Paul

> > 	if (IS_ENABLED(CONFIG_PREEMPTION))
> > 		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
> > 				   // And in Tiny RCU, it is near zero cost and doesn't block.
> >
> 
> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
