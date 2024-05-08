Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E1B127B5D
	for <rcu@vger.kernel.org>; Wed,  8 May 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189564; cv=none; b=uxuy7wUe/eBco9n7OI5jkfNNY/SxNKckuwUHgBWl3Q7gfGcjMYRX+DJbZYEJv4GvqVx2K5R3WIbvgwbJo2L7753dNNnHzzC/rajJWVlinb4VK3mx6jkiqYkiZRQHQZcB4NDvZLQT59u/SRhClzsfmPA4Oed25jxJ2U03SoKsIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189564; c=relaxed/simple;
	bh=BC8sijRbFaCIzeW+8vEAZF9PyEVUHkeF2+Fkt7j6WdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDKUdQioDmpq5h6rvj417GDxHbm6JfebKxyARdMRX3AYl2LDqAPqZjYZJEJ/22vNWfxDuqDlFJMX15XpKp1xe+U9B+EIxaXIScagvrB2GTEKHAPAjvBirwpbyz4wA0L/MylBUlo7LtScXWTfC/LkXKPO2sZFo2wqxW7SAsHv5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHxZf86T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHxZf86T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DA4C113CC;
	Wed,  8 May 2024 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715189564;
	bh=BC8sijRbFaCIzeW+8vEAZF9PyEVUHkeF2+Fkt7j6WdQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FHxZf86TWLmymIB6bq2uuwnBqw2zelLeKmm77w9fo6ZIX6Ff6lGHaLCRtpRIgc0st
	 C/jJ4WD5mCPZxxNRKsqjwfPoScEMjaDjlhD2+eWA3CTzL2VDHJEzsld5np4LDQqxZl
	 SBW3DNdE5c6fWyax7GMb5LQGm0Rxeb5S9ABKCVFhmj4TnWXcXjsn9INvtb9NdSb1/p
	 HCWlVp87CdgDqogOdx1VSnTZZT2Po5sZ9GE6HZtCDoPACaADhwKj3zYG8xaeqhxDn6
	 K6z5sidRtlZbulqcQydYCY63BEM0pj8kbDUQrls08k0pCGy2+Asu8q6lgBID63lDLx
	 Lt+mq/tadj79Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8841BCE0448; Wed,  8 May 2024 10:32:43 -0700 (PDT)
Date: Wed, 8 May 2024 10:32:43 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: dwmw@amazon.co.uk, rcu@vger.kernel.org
Subject: Re: [bug report] rcu: Kill rnp->ofl_seq and use only
 rcu_state.ofl_lock for exclusion
Message-ID: <e775bd83-dfa3-4f09-9539-e0e655feda08@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain>
 <cef46486-ac26-495d-bd2d-1e998a73a421@paulmck-laptop>
 <edfea2ff-d73e-48aa-83db-96daba77c500@moroto.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edfea2ff-d73e-48aa-83db-96daba77c500@moroto.mountain>

On Wed, May 08, 2024 at 05:55:38PM +0300, Dan Carpenter wrote:
> On Wed, May 08, 2024 at 07:33:38AM -0700, Paul E. McKenney wrote:
> > On Wed, May 08, 2024 at 03:29:12PM +0300, Dan Carpenter wrote:
> > > Hello David Woodhouse,
> > > 
> > > Commit 82980b1622d9 ("rcu: Kill rnp->ofl_seq and use only
> > > rcu_state.ofl_lock for exclusion") from Feb 16, 2021 (linux-next),
> > > leads to the following Smatch static checker warning:
> > > 
> > > 	kernel/rcu/tree.c:1844 rcu_gp_init()
> > > 	warn: mixing irq and irqsave
> > 
> > There are actually cases where this does make sense, one example being
> > where some called function (for example, rcu_report_qs_rnp() below)
> > needs a flags argument.
> > 
> 
> I only found one false positive which was kind of related to that in
> __run_hrtimer().
> 
>   1643  
>   1644  static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
>   1645                            struct hrtimer_clock_base *base,
>   1646                            struct hrtimer *timer, ktime_t *now,
>   1647                            unsigned long flags) __must_hold(&cpu_base->lock)
>                                                 ^^^^^
> 
>   1648  {
> ....
> 
>   1678          /*
>   1679           * The timer is marked as running in the CPU base, so it is
>   1680           * protected against migration to a different CPU even if the lock
>   1681           * is dropped.
>   1682           */
>   1683          raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
>                                                             ^^^^^
> We potentially enable IRQs.
> 
>   1684          trace_hrtimer_expire_entry(timer, now);
>   1685          expires_in_hardirq = lockdep_hrtimer_enter(timer);
>   1686  
>   1687          restart = fn(timer);
>   1688  
>   1689          lockdep_hrtimer_exit(expires_in_hardirq);
>   1690          trace_hrtimer_expire_exit(timer);
>   1691          raw_spin_lock_irq(&cpu_base->lock);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Then disable them again.
> 
>   1692  
> 
> Of course the other warnings are mostly not "bugs" because the callers
> haven't disabled IRQs.  They're just in need of clean up.

Agreed, and please see below for the proposed cleanup in this case.

							Thanx, Paul

------------------------------------------------------------------------

commit 43e96791e7d1605803093b34fb70217fe29ddaeb
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed May 8 10:28:43 2024 -0700

    rcu: Disable interrupts directly in rcu_gp_init()
    
    Interrupts are enabled in rcu_gp_init(), so this commit switches from
    local_irq_save() and local_irq_restore() to local_irq_disable() and
    local_irq_enable().
    
    Link: https://lore.kernel.org/all/febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain/
    
    Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d5507ac1bbf19..7560e204198bb 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1841,7 +1841,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
 	/* Exclude CPU hotplug operations. */
 	rcu_for_each_leaf_node(rnp) {
-		local_irq_save(flags);
+		local_irq_disable();
 		arch_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -1849,7 +1849,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 			/* Nothing to do on this leaf rcu_node structure. */
 			raw_spin_unlock_rcu_node(rnp);
 			arch_spin_unlock(&rcu_state.ofl_lock);
-			local_irq_restore(flags);
+			local_irq_enable();
 			continue;
 		}
 
@@ -1886,7 +1886,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 
 		raw_spin_unlock_rcu_node(rnp);
 		arch_spin_unlock(&rcu_state.ofl_lock);
-		local_irq_restore(flags);
+		local_irq_enable();
 	}
 	rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
 
