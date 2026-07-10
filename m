Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD028373;
	Fri, 10 Jul 2026 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783708500; cv=none; b=jzuzd72NRhthceBOerSZmvHQeZ2qasfYFc7JIdj0aRs0uXlvlheu2bL25iHr44oj+mPTOkX3ikC8zLetGGX0Rp1v5M+IG0Q/Lv6QE6LPcsCOoMQXJ0WiXnLEOsRtCSSJrm+ApX987Y13AknhlacrbQwYEeLhNgZnlmVi5rtlJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783708500; c=relaxed/simple;
	bh=77llPFpRWdCIXbg+KrBxrygRKrWPzXLhHKuqUb+Ge2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWwsFNbmlB/Ivm8Zo5GrenB2tN0tZ3nEXDP+FyLSB4iF3KT2VM3Rqf9JF5t8tJCEHgpn1fvZQXM90UJTc34BFIdkQHlTIQ1+bbnpXMp7Mo244QfG6O2G+D/XHf5oYVuTIKecEpp4CDkBLD4hATwuYVqPP2f4CYQmfUp7u242RyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dseu/24D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dseu/24D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FAC1F000E9;
	Fri, 10 Jul 2026 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783708498;
	bh=IRdwhV8P0MxC+t0uc52H/DAloh5jHYdj7TOGQBF98tY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=dseu/24DYyCy3wSeHSJBaeH2F+9ixJUXaBVx8p5shtGx9GdgUshX3DIQW3o44ji2N
	 2uyf9xsL1nawidPvvgBpQE3AJVIr8+uhKN68gyLsB/rRPNDIygxXRE0mRUYh6FiNgR
	 gkb9sR5m7d9unT4EhaNyVrcm5cutWzX7D2jryLMXRcU/J3anE1wrzIjm1+eInwV+4E
	 hIOm7DyEYKb7vnxBPkTl926F/o9Mea3kK/FWB4iqUUslhp3gG5VIL1Sa/LtiY0T5HH
	 9xXSmfM8nAhgMzg5yaja4wsmXa91IEylOXRdfYa8L6kiknxobVJwUeVLVsMZvlVvXp
	 UDT01r1NbFm7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A005FCE084A; Fri, 10 Jul 2026 11:34:58 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:34:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	urezki@gmail.com, boqun@kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Queue sdp->work when the delay timer is
 successfully deleted
Message-ID: <8b0f9909-1eff-4ae2-a005-93581dbcc865@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260709100602.821-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709100602.821-1-qiang.zhang@linux.dev>

On Thu, Jul 09, 2026 at 06:06:02PM +0800, Zqiang wrote:
> In the cleanup_srcu_struct(), when iterating over per-cpu's srcu_data,
> the timer_delete_sync(&sdp->delay_work) is called to cancel the delay
> timer before flush_work(&sdp->work).
> 
> However, if the timer_delete_sync() returns 1 means that it successfully
> deleted an pending timer before it had a chance to fire, also means that
> the sdp->work cannot be queued, the subsequent flush_work(&sdp->work)
> will returns immediately without waiting for anything, this causes SRCU
> callbacks to not be processed.
> 
> Fix this by checking the return value of timer_delete_sync(), if it
> returns 1, explicitly queue sdp->work so that the following flush_work()
> can correctly wait for the work to complete.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Good catch!  I updated the commit log and comment as shown below.  Does
that work for you?

						Thanx, Paul

> ---
>  kernel/rcu/srcutree.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 7c2f7cc131f7..02c322b7c6f1 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -725,7 +725,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
>  	for_each_possible_cpu(cpu) {
>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
> -		timer_delete_sync(&sdp->delay_work);
> +		//In most scenarios, calling srcu_barrier before cleanup
> +		//will not trigger WARN_ON().
> +		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
> +					rcu_cpu_beenfullyonline(sdp->cpu))
> +			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
>  		flush_work(&sdp->work);
>  		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>  			return; /* Forgot srcu_barrier(), so just leak it! */
> -- 
> 2.17.1

------------------------------------------------------------------------

commit d0b7ba8ff706ad1e3a51ffa46ee79b60ff0203f3
Author: Zqiang <qiang.zhang@linux.dev>
Date:   Thu Jul 9 18:06:02 2026 +0800

    srcu: Queue sdp->work when the delay timer is successfully deleted
    
    In the cleanup_srcu_struct() function, when iterating over per-cpu's
    srcu_data, timer_delete_sync(&sdp->delay_work) is called to cancel the
    delayed work before doing flush_work(&sdp->work).
    
    However, suppose that timer_delete_sync() returns 1, which means that it
    successfully deleted an pending timer before it had a chance to fire.
    But this also means that the sdp->work will not be queued, so that the
    subsequent flush_work(&sdp->work) will returns immediately without waiting
    for anything.  Taken together, all of this means that any recently queued
    SRCU callbacks to not be invoked, which can result in memory leaks,
    hangs, or worse.
    
    Fix this by checking the return value of timer_delete_sync(), if it
    returns 1, explicitly queue sdp->work so that the callbacks will be
    invoked and the following flush_work() will correctly wait for all of
    those callbacks to finish executing.
    
    Signed-off-by: Zqiang <qiang.zhang@linux.dev>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 4a00e90e17fc07..8b4e7783bdc963 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -701,7 +701,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	for_each_possible_cpu(cpu) {
 		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
 
-		timer_delete_sync(&sdp->delay_work);
+		// Call srcu_barrier() before this cleanup_srcu_struct()
+		// to avoid triggering this WARN_ON().
+		if (WARN_ON(timer_delete_sync(&sdp->delay_work)) &&
+					rcu_cpu_beenfullyonline(sdp->cpu))
+			queue_work_on(sdp->cpu, rcu_gp_wq, &sdp->work);
 		flush_work(&sdp->work);
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
 			return; /* Forgot srcu_barrier(), so just leak it! */
