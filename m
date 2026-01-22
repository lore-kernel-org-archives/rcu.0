Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300243BE489;
	Thu, 22 Jan 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769118913; cv=none; b=Kb04mZScH9TN+PuaEtBlU+V8PLjknWLV8/kVBLNJ04zuuC98/zUuUwiFq9j+tslmwXXZkCJMQ6NoSyAKsCWjVe/+/+KF+3N9taE90ibRvK6Il01yb5KOQr3AJbJaArF5W/yXTuSI7uxQBUn8Qh+ubiw85T0ltgal3otUKJFluj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769118913; c=relaxed/simple;
	bh=vqtYEvV2seBUcfmcXKWQAMg0mhPMWK271SNOrmujjiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2bmz2XOaCNlVo5u4AzKBFrzKcFzMJO1EkRNbPSNifQbj5RIQyABGAIFKVDdICQOR2kGxi9uaWv6na4XUlMNqTTrxmn9HnoIfRCYP2f+maj1hOI+z0yUjlFO4/l0Db5VEV3GRGgS4kpmEdMnKnqiI3TE9JgLqZGaiOB5tkfQduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ1uwMx9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ1uwMx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41255C116C6;
	Thu, 22 Jan 2026 21:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769118912;
	bh=vqtYEvV2seBUcfmcXKWQAMg0mhPMWK271SNOrmujjiI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NQ1uwMx9JnEKFxCs+dyv/794bpeYc2XsdYx8n4V3o1k5lXleziHcbAhpYyPiipdnj
	 0LErBLdCOIRCcaSrMWj/Wrxo2gRuvMkVm2NkV1XPoIfqCEOdA37vv3cja/Puocg196
	 BrU1R9HffsYcVk2DXKosVPVAAkMPD22q8HYNttwctbQrC0HGDOXq8XDqkv00FQB8Zy
	 l2T9vvJugvAUbdXMRQ5+HUb20LxIleukt4XVHdE1Rbbw0PDbTdZgtgIcnsBg9GL/9u
	 hxM4nLrDkqX6yb6h1KuwxeFUU5P2cyuOEhbpm+j/LtNeZSzRkN8tgCLHnUgyhnZqZA
	 JdXQ3rdx8KfuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D8398CE0B94; Thu, 22 Jan 2026 13:55:11 -0800 (PST)
Date: Thu, 22 Jan 2026 13:55:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 2/3] rcu/nocb: Remove dead callback overload
 handling
Message-ID: <986b4f25-5fbf-45b1-8475-721bc3e95223@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
 <20260119231223.989409-3-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119231223.989409-3-joelagnelf@nvidia.com>

On Mon, Jan 19, 2026 at 06:12:22PM -0500, Joel Fernandes wrote:
> During callback overload (exceeding qhimark), the NOCB code attempts
> opportunistic advancement via rcu_advance_cbs_nowake(). Analysis shows
> this entire code path is dead:
> 
> - 30 overload conditions triggered with 300,000 callback flood
> - 0 advancements actually occurred
> - 100% of time blocked because current GP not done
> 
> The overload condition triggers when callbacks are coming in at a high
> rate with GPs not completing as fast. But the advancement requires the
> GP to be complete - a logical contradiction. Even if the GP did complete
> in time, nocb_gp_wait() has to wake up anyway to do the advancement, so
> it is pointless.
> 
> Since the advancement is dead code, the entire overload handling block
> serves no purpose. Remove it entirely.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_nocb.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index f525e4f7985b..64a8ff350f92 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -526,8 +526,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  				 __releases(rdp->nocb_lock)
>  {
>  	long bypass_len;
> -	unsigned long cur_gp_seq;
> -	unsigned long j;
>  	long lazy_len;
>  	long len;
>  	struct task_struct *t;
> @@ -562,16 +560,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  		}
>  
>  		return;
> -	} else if (len > rdp->qlen_last_fqs_check + qhimark) {
> -		/* ... or if many callbacks queued. */
> -		rdp->qlen_last_fqs_check = len;
> -		j = jiffies;
> -		if (j != rdp->nocb_gp_adv_time &&
> -		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&

This places in cur_gp_seq not the grace period for the current callback
(which would be unlikely to have finished), but rather the grace period
for the oldest callback that has not yet been marked as done.  And that
callback started some time ago, and thus might well have finished.

So while this code might not have been executed in your tests, it is
definitely not a logical contradiction.

Or am I missing something subtle here?

						Thanx, Paul

> -		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
> -			rcu_advance_cbs_nowake(rdp->mynode, rdp);
> -			rdp->nocb_gp_adv_time = j;
> -		}
>  	}
>  
>  	rcu_nocb_unlock(rdp);
> -- 
> 2.34.1
> 
