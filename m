Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A230CD80;
	Wed, 15 Jul 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148209; cv=none; b=SZP4ocP2FUl+gCIOEQvWI5Lqxrsima01qDKD9KGkCUrJKWskVhjlYAGk3K1gAZTTggYbyPNVYFoRp0BtYVw+NDQolq4hyYQyN57pIYsHvBL9gu3CCZz6KypSvOp0Gnax1O8nX17/6yxLdBXpbbwHv22Vx8rtc39izP/hteekKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148209; c=relaxed/simple;
	bh=mZLnv6zqhkTn6UcrGWp5BUX5+RUGsurX4eH6hX7rt7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+vX8hVFFwxdmS9w3Q/EI3HGLavUWethQFJ9uREfg7LWRnffvsn/QVHdFm72fXSYulSKZkmBEADgGrw+W//4dzIp63sCfzQCJREJ1rp940cOVxrSvoSHHAPBsaAgyLRg56pm7wy9Ch1amCYDLG21E4SC3ePwuUDE5GjUG9LW/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j16xgbjC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j16xgbjC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A248E1F000E9;
	Wed, 15 Jul 2026 20:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784148207;
	bh=1qblDQBGYI57dt90EbKRT93BAOpAk1l6wTolgLkgrv0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=j16xgbjCy4FpjiDA6mlnBXDCAMcIB4a0ZR1FafRZ46JlQhrbuSs+XMVt9qxnhPEIb
	 W1ngzTPIAOboqD1mqmj5y0ckvwww76nMHn1VAon1ePjzmIfcWXNfJGuJeMq8iC2h3/
	 QYDPuWcK/URg7u3Ntdec4JeXY//MTn2loGiDYipb7du/Y8eCPyFQ/rYDYJ+Hs0jQ14
	 ljjMGzC/JQMYMlmws2RhTYBcjzPOMMmoNOoLvH6Et6wMEVXYpPgDjrX8JzC9lqUaB2
	 2lDQQe7WJMUXHNsN/ORW3RSv8ghqjnTnN8aeBtxUjWsgYmqbvXOsq0Uy0xqZqHpFSO
	 CxkX1lXqw4PTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 824A5CE0AD3; Wed, 15 Jul 2026 13:43:27 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:43:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	rcu@vger.kernel.org
Subject: Re: [PATCH v4 1/8] rcu: introduce rcu_defer_qs_clear() helper
Message-ID: <bd5d4420-e478-4d1a-bdc3-46cfcd757578@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260626004301.1632168-1-joelagnelf@nvidia.com>
 <20260626004301.1632168-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626004301.1632168-2-joelagnelf@nvidia.com>

On Thu, Jun 25, 2026 at 08:42:54PM -0400, Joel Fernandes wrote:
> Currently rdp->defer_qs_pending transitions from DEFER_QS_PENDING to
> DEFER_QS_IDLE at two sites: rcu_preempt_deferred_qs_irqrestore() and
> rcu_preempt_deferred_qs_handler() (depth>0 reset).  Both write the
> IDLE value directly.
> 
> Introduce a single inline helper rcu_defer_qs_clear() in tree.h and
> route both sites through it.  This becomes the single
> PENDING->IDLE transition point for upcoming work.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

No argument here, and I have pulled this in for further review and
testing.  I don't see any reason why thing cannot go into the upcoming
merge window.

							Thanx, Paul

> ---
>  kernel/rcu/tree.h        | 5 +++++
>  kernel/rcu/tree_plugin.h | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 750b98f0c6bc..dc03231b2d46 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -311,6 +311,11 @@ struct rcu_data {
>  	int cpu;
>  };
>  
> +static inline void rcu_defer_qs_clear(struct rcu_data *rdp)
> +{
> +	WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
> +}
> +
>  /* Values for nocb_defer_wakeup field in struct rcu_data. */
>  #define RCU_NOCB_WAKE_NOT	0
>  #define RCU_NOCB_WAKE_BYPASS	1
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c22f033e0136..7555022bf38a 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -582,7 +582,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  
>  	rdp = this_cpu_ptr(&rcu_data);
>  	if (rdp->defer_qs_pending == DEFER_QS_PENDING)
> -		rdp->defer_qs_pending = DEFER_QS_IDLE;
> +		rcu_defer_qs_clear(rdp);
>  
>  	/*
>  	 * If RCU core is waiting for this CPU to exit its critical section,
> @@ -725,7 +725,7 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  	 * 5. Deferred QS reporting does not happen.
>  	 */
>  	if (rcu_preempt_depth() > 0)
> -		WRITE_ONCE(rdp->defer_qs_pending, DEFER_QS_IDLE);
> +		rcu_defer_qs_clear(rdp);
>  }
>  
>  /*
> -- 
> 2.34.1
> 
