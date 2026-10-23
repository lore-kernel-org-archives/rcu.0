Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792784325;
	b=xKyOaK4KFaU1T8uFozJVJaCLQN0/CNYxPEBrNxwhvTeP3zQkPhjthdvMgghYcKxLm49v
	 9rHVfXyn2bij/sS2tejjU8zuwr5hwpHAve+kRjZBUlRTQjiqE7I7P5GvQX4qbnGHiocKa
	 4DiOHWqHKKhZXBrRb4DCnnjqatd76BeNOreN5le284GTeqJMi1Ki4SjBTkh0otE/kJKr9
	 wdFLcrYjBtE0ie9xdcI7Q5q3EmplA4mcwoz68MwTMSI2cF/MXwH5PoRzHXZZtVNu8YmH8
	 TKRz06AC96wkRDLitDq0l71mF5mOLUWjUhAE212yr6rYo9LGUrcDT3YzD6Gx2cPCQow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792784325;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7CHhHPSWY+FFf8ngDqbLFkrA9k0bCJf56is/f1ol2IM=;
	b=dI/14shThT6KJCWebBWSMt3kRIIHn6dahBDRrWA+jnNDK7q16sFXnU+jDhI0AT5mSySS
	 E/tYQOzyfWcvanarGssDp5gIoGg2VqP0cZHRDpx2QIgphGs3avsufjJhnremHEyn6KGks
	 5gOxsfANsQV1Bzsb4gzIHmJbgiiW9MhU8oHixeKaHV9dzYlL+RrwVg8A1Y5FliRuhsATj
	 bv2KUxsxk3maqQP67Axe1oaxYMKpdFMh7hNw9MlLj1PXCZ90SyVRxvwJVARARKBo69nJZ
	 3xmNEKW21m+p6ti3fLMEouC6mU/59rD6JwVfkSuNYI/eOT2jR8k/FhV6u4+M2zKGlYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3UEdUZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4D606A31A;
	Fri, 23 Oct 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3UEdUZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314841F01825;
	Fri, 23 Oct 2026 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792784325;
	bh=7CHhHPSWY+FFf8ngDqbLFkrA9k0bCJf56is/f1ol2IM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=V3UEdUZmnzQSycrPUuS40yOguOL+z3iZJtjSH/dt3K5xOl23VTRZtywF+rzOs/VHD
	 4j7WAcmGPTElMPDAT+58heLKq9NsH+CQdktVlbiLrUW8VfxY7gYi60OJMy3+0NgFF8
	 Vk66M+MSjtkQB9hDgYnV3Cvd4un6XQkRCYSzomPP8vKZV1c//UeiOMLkl3V4xfk/7T
	 ZApWZ+qXQKMujxP6T46oNxvn4Ue82KspO3PvsIsBHd3Dg/w1XGRYBFkzJgZnv9oEpx
	 SAcuVLvD7EQg9hQko3dFSumFvyexC3W+tuh/FVx45w5yNYXV8iCvtwsSYU5Z6xuP5e
	 HpFNm7te7EFJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E38F2CE0811; Fri, 23 Oct 2026 12:38:44 -0700 (PDT)
Date: Fri, 23 Oct 2026 12:38:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, work@onurozkan.dev,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, boqun@kernel.org, urezki@gmail.com,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	qiang.zhang@linux.dev, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 7/9] srcu: Detect duplicate callback enqueue at
 registration
Message-ID: <b5c84b27-5e66-44f1-b95a-d7c1655df69d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261023101841.2910719-1-kunwu.chan@gmail.com>
 <20261023101841.2910719-8-kunwu.chan@gmail.com>
 <60e6148e-b7e1-4f2f-a665-24567305956f@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60e6148e-b7e1-4f2f-a665-24567305956f@paulmck-laptop>

On Fri, Oct 23, 2026 at 12:30:57PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 23, 2026 at 06:18:39PM +0800, Kunwu Chan wrote:
> > Move the duplicate-callback check from srcu_do_enqueue() to
> > __call_srcu() entry so that detected duplicate registrations
> > are rejected before they reach the deferred-list enqueue path.
> > Report the callback address, function symbol, and object
> > information, rate-limited to the first three occurrences.
> > 
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> Getting the stackof the call_srcu() once double-enqueue is detected
> would be a very good thing!
> 
> One question below.
> 
> > ---
> >  kernel/rcu/srcutree.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 1993ddbdb828..3838d9fdf532 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/smp.h>
> >  #include <linux/delay.h>
> >  #include <linux/module.h>
> > +#include <linux/mm.h>
> >  #include <linux/slab.h>
> >  #include <linux/srcu.h>
> >  
> > @@ -1511,12 +1512,6 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >  static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
> >  			    rcu_callback_t func, bool do_norm)
> >  {
> > -	if (debug_rcu_head_queue(rhp)) {
> > -		/* Probable double call_srcu(), so leak the callback. */
> > -		WRITE_ONCE(rhp->func, srcu_leak_callback);
> > -		WARN_ONCE(1, "call_srcu(): Leaked duplicate callback\n");
> > -		return;
> > -	}
> >  	rhp->func = func;
> >  	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
> >  }
> > @@ -1529,6 +1524,8 @@ static void srcu_do_enqueue(struct srcu_struct *ssp, struct rcu_head *rhp,
> >  static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> >  			rcu_callback_t func, bool do_norm)
> >  {
> > +	static atomic_t doublefrees;
> > +
> >  	/* Misaligned rcu_head! */
> >  	WARN_ON_ONCE((unsigned long)rhp & (sizeof(void *) - 1));
> >  
> > @@ -1539,6 +1536,16 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> >  	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
> >  		return; // Leak the callback rather than corrupt SRCU state.
> >  
> > +	if (debug_rcu_head_queue(rhp)) {
> > +		if (atomic_inc_return(&doublefrees) < 4) {
> 
> Why this hard-coded 4?  Why not 3 or 5?  Should this be adjustable via
> Kconfig or kernel boot parameter?  Or, alternatively, should the below
> pr_err() instead be pr_err_ratelimited()?
> 
> > +			pr_err("%s(): Duplicate call_srcu() CB %p->%pS()\n",
> > +			       __func__, rhp, rhp->func);
> > +			mem_dump_obj(rhp);
> 
> Does any of this automatically dump out the stack that was recorded
> in earlier patches in this series?

As in shouldn't there be a kasan_print_aux_stacks() in there somewhere?
I did not see an call from mem_dump_obj(), but I could easily have
missed it.

							Thanx, Paul

> > +		}
> > +		WRITE_ONCE(rhp->func, srcu_leak_callback);
> > +		return;
> > +	}
> > +
> >  	/* Record the caller: the irq_work's stack says nothing about it. */
> >  	kasan_record_aux_stack(rhp);
> >  
> > @@ -1554,6 +1561,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
> >  		if (READ_ONCE(sndp->draining) && !in_nmi()) {
> >  			WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU),
> >  				  "call_srcu() re-entered during callback drain; leaking callback\n");
> > +			debug_rcu_head_unqueue(rhp);
> >  			return;
> >  		}
> >  		sdp = this_cpu_ptr(ssp->sda);
> > -- 
> > 2.43.0
> > 
