Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C21A08B1;
	Thu, 27 Feb 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677201; cv=none; b=syyI7UMvgLm1gvWmZ50XnnxzElAeWvARBWTeiVfQGc4irVtGXyZBRJhpFGWAsCOxFeny7CgntgDvJuRZCI8tAkwyklvVwlKjo4hsmZBqorIRIDASzjknKXjMARszh/rmiQTrDKaoC1u7plBZQx963FP0wrw+WEABiLRLM2thNO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677201; c=relaxed/simple;
	bh=EL5qmbfDecAAkENf6EuP4jZVLrTznPY05PZNhRIWt7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqQbc1Unm5im6k/REGsElH29vStII5ffqSYJlI9Is6+YLCFGNgL2LCGVSreGF3EAI0JWg7p6ffFL1K4bPfNok9lpsME+cWUq/+/P24zs8sG+t2xhTWG2jEfy9eJ6mzLT7noRYkjXZ8/B1bk9n/Jz8JIYTPKrfSB/xIVpHYMhpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EusWscYM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EusWscYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3521C4CEDD;
	Thu, 27 Feb 2025 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740677200;
	bh=EL5qmbfDecAAkENf6EuP4jZVLrTznPY05PZNhRIWt7k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EusWscYMMIbPGrpiz8cBeqMfVWSkXjNMXjKCmtLjoMS/9lnt0JEo5t9RZI+sXeOXm
	 a7s+I6f+EumsdjoJsPGncxWeou0qh90pnxMiahZJpP742+em+xEmidRJft2BLthIk1
	 3IGm/UM2gOEXSOVUcV28iO8C2qTeFzKSOhdjLdpdnSe1a4tK7F1iqrOjZhOsUr7nG+
	 HcuivcbRNmmlZn7SoJeBWg+P3psU0iiji+F8tUhYI0HB62MOPzh9nZk/qkB8qcgr1k
	 HzNOYLPIOsOm86sB/4IqNuVT9VsCA4HhGwpzL4RLi89HEKo1V38VsxbrjI+MF6q6gJ
	 AuHP0HrmSuWjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 69422CE0799; Thu, 27 Feb 2025 09:26:40 -0800 (PST)
Date: Thu, 27 Feb 2025 09:26:40 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8CdB0Hzvdu5ZVSI@Mac.home>

On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> Hi Ulad,
> 
> I put these three patches into next (and misc.2025.02.27a) for some
> testing, hopefully it all goes well and they can make it v6.15.
> 
> A few tag changed below:
> 
> On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > Switch for using of get_state_synchronize_rcu_full() and
> > poll_state_synchronize_rcu_full() pair to debug a normal
> > synchronize_rcu() call.
> > 
> > Just using "not" full APIs to identify if a grace period is
> > passed or not might lead to a false-positive kernel splat.
> > 
> > It can happen, because get_state_synchronize_rcu() compresses
> > both normal and expedited states into one single unsigned long
> > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > run.
> > 
> > To address this, switch to poll_state_synchronize_rcu_full() and
> > get_state_synchronize_rcu_full() APIs, which use separate variables
> > for expedited and normal states.
> > 
> > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> 
> I switch this into "Closes:" per checkpatch.
> 
> > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> Would you or Paul double-check the Reviewed-by should be here?

I am good with keeping my Reviewed-by tags.

							Thanx, Paul

> Regards,
> Boqun
> 
> > ---
> >  include/linux/rcupdate_wait.h | 3 +++
> >  kernel/rcu/tree.c             | 8 +++-----
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/rcupdate_wait.h b/include/linux/rcupdate_wait.h
> > index f9bed3d3f78d..4c92d4291cce 100644
> > --- a/include/linux/rcupdate_wait.h
> > +++ b/include/linux/rcupdate_wait.h
> > @@ -16,6 +16,9 @@
> >  struct rcu_synchronize {
> >  	struct rcu_head head;
> >  	struct completion completion;
> > +
> > +	/* This is for debugging. */
> > +	struct rcu_gp_oldstate oldstate;
> >  };
> >  void wakeme_after_rcu(struct rcu_head *head);
> >  
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8625f616c65a..48384fa2eaeb 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1632,12 +1632,10 @@ static void rcu_sr_normal_complete(struct llist_node *node)
> >  {
> >  	struct rcu_synchronize *rs = container_of(
> >  		(struct rcu_head *) node, struct rcu_synchronize, head);
> > -	unsigned long oldstate = (unsigned long) rs->head.func;
> >  
> >  	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) &&
> > -		!poll_state_synchronize_rcu(oldstate),
> > -		"A full grace period is not passed yet: %lu",
> > -		rcu_seq_diff(get_state_synchronize_rcu(), oldstate));
> > +		!poll_state_synchronize_rcu_full(&rs->oldstate),
> > +		"A full grace period is not passed yet!\n");
> >  
> >  	/* Finally. */
> >  	complete(&rs->completion);
> > @@ -3247,7 +3245,7 @@ static void synchronize_rcu_normal(void)
> >  	 * snapshot before adding a request.
> >  	 */
> >  	if (IS_ENABLED(CONFIG_PROVE_RCU))
> > -		rs.head.func = (void *) get_state_synchronize_rcu();
> > +		get_state_synchronize_rcu_full(&rs.oldstate);
> >  
> >  	rcu_sr_normal_add_req(&rs);
> >  
> > -- 
> > 2.39.5
> > 
