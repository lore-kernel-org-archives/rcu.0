Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2D1A23A4
	for <rcu@vger.kernel.org>; Wed, 13 Aug 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119595; cv=none; b=D0421BOM7e3awl0hv9xxJg96XtUBg71kP0G8+7+UtQos0u7uoUIKHXohuYgjaklQFnGvesWrGC+//l3QZ2jksP2sY1iEsaI8v37dcId+QQtFlADUAvhOAIXlBY+l9owgWfz7/0vbMZDRQDJ/cH3A8HYXwBp3BuHEsK0xOfikv84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119595; c=relaxed/simple;
	bh=GO6LKrQYCW30vO/h21j8W1T8z4/zg09hAP2rnMeMMXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bswMWfMRlnHtihFlGOoorYvc3+cfsWSasjNDdtmBBIUOYWFM8Fq4wNSSFORtzTGKpBYMhZJUtCD2fYsxx1cuaolhLAws496ZFnQa2SC+AJpTGHCF66XkVA98NNt0HDTSao6Qywh4m2k2x0WJ7Yks7iCP9kWVTeFOfcH3v9Se6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox3rdf33; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox3rdf33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8744BC4CEEB;
	Wed, 13 Aug 2025 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755119593;
	bh=GO6LKrQYCW30vO/h21j8W1T8z4/zg09hAP2rnMeMMXU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ox3rdf33Uj/3M4QO9WsJH6vyatD7+PqMNXsZNijKR7fLjM0W2jDKZUpCbdp+/+of4
	 WN/5GGEfvnvCkL8+HsRSa5dwph3LoYfYiaSENCdZLLkKWdzu2cZIXQ+KPGvIV9EZNG
	 Z9hPzo35p6wNFuqsUajfTf2WfCDxqb0RoYswLBuh/jUsATj6jRsNuJ2n+9gkhu/iDN
	 lzhTnx80ICKqShG8gTJB0W+LtFJgXBdLAMohp/sxJ/yPdLJOliygbww2ckOxHLBCse
	 NrbYmD0ncweAHFiMH0Dc4RvwfE3WcO7t9V2n6p5vLAo+ed8tnvWYoshwOBj++yKbWr
	 2iNy0CJqbRZzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 38875CE0A48; Wed, 13 Aug 2025 14:13:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:13:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
	boqun.feng@gmail.com, urezki@gmail.com, rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Remove local_irq_save/restore() in
 rcu_preempt_deferred_qs_handler()
Message-ID: <ca6d0ea1-9f67-4c8a-bfcc-357ffb9496d7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250813133002.331879-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813133002.331879-1-qiang.zhang@linux.dev>

On Wed, Aug 13, 2025 at 09:30:02PM +0800, Zqiang wrote:
> Currently, the per-cpu rcu_data structure's->defer_qs_iw is initialized by
> IRQ_WORK_INIT_HARD(), this means the rcu_preempt_deferred_qs_handler()
> always be executed in the hardirq context of irq-disabled.
> This commit therefore remove local_irq_save/restore() operations in
> rcu_preempt_deferred_qs_handler() and add lockdep_assert_irqs_disabled()
> check, if someone mistakenly invokes this function in hardirq enabled
> context will splat.
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>

Queued for further review and testing.  With luck, this will make the
v6.18 merge window.  I could not resist editing the commit log, so could
you please check whether I messed something up?

							Thanx, Paul

------------------------------------------------------------------------

commit 523e71ba3007f8f7c260b9c2baf69c9461a84f55
Author: Zqiang <qiang.zhang@linux.dev>
Date:   Wed Aug 13 21:30:02 2025 +0800

    rcu: Remove local_irq_save/restore() in rcu_preempt_deferred_qs_handler()
    
    The per-CPU rcu_data structure's ->defer_qs_iw field is initialized
    by IRQ_WORK_INIT_HARD(), which means that the subsequent invocation of
    rcu_preempt_deferred_qs_handler() will always be executed with interrupts
    disabled.  This commit therefore removes the local_irq_save/restore()
    operations from rcu_preempt_deferred_qs_handler() and adds a call to
    lockdep_assert_irqs_disabled() in order to enable lockdep to diagnose
    mistaken invocations of this function from interrupts-enabled code.
    
    Signed-off-by: Zqiang <qiang.zhang@linux.dev>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fc14adf15cbb34..57e2ae51c0b2cb 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -626,11 +626,10 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
  */
 static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 {
-	unsigned long flags;
 	struct rcu_data *rdp;
 
+	lockdep_assert_irqs_disabled();
 	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
-	local_irq_save(flags);
 
 	/*
 	 * If the IRQ work handler happens to run in the middle of RCU read-side
@@ -647,8 +646,6 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
 	 */
 	if (rcu_preempt_depth() > 0)
 		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
-
-	local_irq_restore(flags);
 }
 
 /*
