Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0DE2C18C;
	Mon, 19 Aug 2024 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101909; cv=none; b=RCPyGHILfGUjfPg6x/0aZLwE97Qj8BFiTH4FLewGn/emBs4iQ+n28Ncu9qDJ6SMGP9CbsAj0P0VJrJXZcFENIC2/PCyA6uC7/0a47RKoylBuY2ypTG/Uss5qj5KEgGaCVH7gKhecG8+NLkUT3cWANvpEC1c2hq4xYG5ovMZpwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101909; c=relaxed/simple;
	bh=Wv5VC2kG4k/btj4LyUA2+F3jFnvO+PpUFpVsL2T+KX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNRI6KIQSv7WBNFuDdlrwhAKfbMW37nLygubKFP17TcyJ4ZWmkA0u0FImw7rdPElG4PSi+Ze1qRBFGap1ttQ0BCn3SNASzxHG3vkupF+nswpMqyMG722EEbRKBpWJdcAabTjsVTTph2AucqPAV2MZicIXs5Dckfhh5U7LW5S0Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBd30Yl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBd30Yl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F26C32782;
	Mon, 19 Aug 2024 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724101909;
	bh=Wv5VC2kG4k/btj4LyUA2+F3jFnvO+PpUFpVsL2T+KX8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=NBd30Yl03Kl46WaR7J9ufYWYyfzV8mxyspakIM96y8qgqZXT3qNLKAH7PV661Htnw
	 L0kLhWjY7RB0k0+SvCTWq6c66VljxApcUWo82toaNwO2Qelw4WYxMa6pSmBjnIW5Ic
	 J/Vfh+Gj5wwmQLOxeo2zHixCMJxOpF8AqJLtDbXMrj5KiaYqpeL9Ox6AeIIlaHvMH2
	 naNQVSLbcf/6UMSqR3YTTyhcB6Ud+i8jAB8fHQ9fL0lDa/8hRGeZ7TpEh48+Lh/+uW
	 UJJhd0o5MKNMvXELdpIXwyk0bW0+bSbH/NqyHRcXCQIRpdqsDVuoCayRRkqTbE4n0v
	 lUz6McXDtzEOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C01D5CE0A05; Mon, 19 Aug 2024 14:11:48 -0700 (PDT)
Date: Mon, 19 Aug 2024 14:11:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] rcu: delete lockdep_assert_irqs_enabled() assert in
 start_poll_synchronize_rcu_common()
Message-ID: <b9cf4f94-d481-4ec0-a3f9-450ad2ac641b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
 <20240819165939.745801-6-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819165939.745801-6-kent.overstreet@linux.dev>

On Mon, Aug 19, 2024 at 12:59:31PM -0400, Kent Overstreet wrote:
> this assertion appears to have been entirely unnecessary
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Please also adjust the comments.  Or just take this from the -rcu tree's
"dev" branch, which is shown at the end of this email:

e0a917e08b9b ("rcu: Permit start_poll_synchronize_rcu*() with interrupts disabled")

> ---
>  kernel/rcu/tree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e641cc681901..52f9f0bf1b8e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4119,7 +4119,6 @@ static void start_poll_synchronize_rcu_common(void)
>  	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  
> -	lockdep_assert_irqs_enabled();
>  	local_irq_save(flags);
>  	rdp = this_cpu_ptr(&rcu_data);
>  	rnp = rdp->mynode;
> -- 
> 2.45.2
> 

------------------------------------------------------------------------

commit e0a917e08b9b39eee5870738250d0b8b10272dbe
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Aug 16 14:22:48 2024 -0700

    rcu: Permit start_poll_synchronize_rcu*() with interrupts disabled
    
    The header comment for both start_poll_synchronize_rcu() and
    start_poll_synchronize_rcu_full() state that interrupts must be enabled
    when calling these two functions, and there is a lockdep assertion in
    start_poll_synchronize_rcu_common() enforcing this restriction.  However,
    there is no need for this restrictions, as can be seen in call_rcu(),
    which does wakeups when interrupts are disabled.
    
    This commit therefore removes the lockdep assertion and the comments.
    
    Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 36b207918158c..47c753ae9bbcd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4103,7 +4103,6 @@ static void start_poll_synchronize_rcu_common(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
-	lockdep_assert_irqs_enabled();
 	local_irq_save(flags);
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
@@ -4128,9 +4127,6 @@ static void start_poll_synchronize_rcu_common(void)
  * grace period has elapsed in the meantime.  If the needed grace period
  * is not already slated to start, notifies RCU core of the need for that
  * grace period.
- *
- * Interrupts must be enabled for the case where it is necessary to awaken
- * the grace-period kthread.
  */
 unsigned long start_poll_synchronize_rcu(void)
 {
@@ -4151,9 +4147,6 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  * grace period (whether normal or expedited) has elapsed in the meantime.
  * If the needed grace period is not already slated to start, notifies
  * RCU core of the need for that grace period.
- *
- * Interrupts must be enabled for the case where it is necessary to awaken
- * the grace-period kthread.
  */
 void start_poll_synchronize_rcu_full(struct rcu_gp_oldstate *rgosp)
 {
