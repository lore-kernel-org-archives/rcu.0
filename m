Return-Path: <SRS0=bMVE=BY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82048C433E1
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 16:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF3D20791
	for <rcu@archiver.kernel.org>; Fri, 14 Aug 2020 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597421468;
	bh=1eHtnTQKd6vwBqrROLmEzpSpv+XROEYdwyl4yv71Ks8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HK0Rd4AoxfXRDe+dyONOtGwNyiEweZ0aeLdIVPHlnvs6lW0KY/M2T37QFukhTD81+
	 lU085wNpmNfkxoWdH75+kWkj6f4/p3CLKtP/w0TKnYkWPx+zAjdUm0xVRV+l/pTZFg
	 qoS3wqe6cyONTn48kUNXCIThJ97a1ghNjVtN6Qss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHNQLI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgHNQLH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Aug 2020 12:11:07 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CCB72078D;
        Fri, 14 Aug 2020 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597421467;
        bh=1eHtnTQKd6vwBqrROLmEzpSpv+XROEYdwyl4yv71Ks8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y6z5CY1nwi7oy57gblgg9EAFAoluxSg6wt4kSl2xd4o66tgT04GaKNVnM+9ED/gV0
         wUTN14LksC3gedJTY60VNrKRLnpO3SY7UcY/xYH40sU+YxoYi4rFKMtvPM9ki/pFgk
         29u7pPcFm2QM3eIcNWhmVBOnRVYgtat6UnBX+hh4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C4F1E3522A0E; Fri, 14 Aug 2020 09:11:06 -0700 (PDT)
Date:   Fri, 14 Aug 2020 09:11:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200814161106.GA13853@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813095840.GA25268@pc636>
 <874kp6llzb.fsf@nanos.tec.linutronix.de>
 <20200813133308.GK9477@dhcp22.suse.cz>
 <87sgcqty0e.fsf@nanos.tec.linutronix.de>
 <20200813182618.GX2674@hirez.programming.kicks-ass.net>
 <20200813185257.GF4295@paulmck-ThinkPad-P72>
 <20200813220619.GA2674@hirez.programming.kicks-ass.net>
 <875z9m3xo7.fsf@nanos.tec.linutronix.de>
 <20200814083037.GD3982@worktop.programming.kicks-ass.net>
 <20200814141425.GM4295@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814141425.GM4295@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 14, 2020 at 07:14:25AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 14, 2020 at 10:30:37AM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 14, 2020 at 01:59:04AM +0200, Thomas Gleixner wrote:

[ . . . ]

> > > > 3.	Reusing existing GFP_ flags/values/whatever to communicate
> > > >	the raw-context information that was to be communicated by
> > > >	the new GFP_ flag.
> > > >
> > > > 4.	Making lockdep forgive acquiring spinlocks while holding
> > > >	raw spinlocks, but only in CONFIG_PREEMPT_NONE=y kernels.
> > 
> > Uhh, !CONFIG_PREEMPT_RT, the rest is 'fine'.
> 
> I would be OK with either.  In CONFIG_PREEMPT_NONE=n kernels, the
> kfree_rcu() code could use preemptible() to determine whether it was safe
> to invoke the allocator.  The code in kfree_rcu() might look like this:
> 
> 	mem = NULL;
> 	if (IS_ENABLED(CONFIG_PREEMPT_NONE) || preemptible())
> 		mem = __get_free_page(...);
> 
> Is your point is that the usual mistakes would then be caught by the
> usual testing on CONFIG_PREEMPT_NONE=n kernels?

Just to make sure we are talking about the same thing, please see below
for an untested patch that illustrates how I was interpreting your words.
Was this what you had in mind?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 62a382d..42d0ff1 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -579,7 +579,7 @@ do {									\
 # define lockdep_assert_preemption_disabled() do { } while (0)
 #endif
 
-#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
+#ifdef CONFIG_PROVE_RAW_LOCK_NESTING_EFFECTIVE
 
 # define lockdep_assert_RT_in_threaded_ctx() do {			\
 		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index bb35b44..70867d58 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -20,7 +20,7 @@ enum lockdep_wait_type {
 	LD_WAIT_FREE,		/* wait free, rcu etc.. */
 	LD_WAIT_SPIN,		/* spin loops, raw_spinlock_t etc.. */
 
-#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
+#ifdef PROVE_RAW_LOCK_NESTING_EFFECTIVE
 	LD_WAIT_CONFIG,		/* CONFIG_PREEMPT_LOCK, spinlock_t etc.. */
 #else
 	LD_WAIT_CONFIG = LD_WAIT_SPIN,
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c..e02de40 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1215,6 +1215,9 @@ config PROVE_RAW_LOCK_NESTING
 
 	 If unsure, select N.
 
+config PROVE_RAW_LOCK_NESTING_EFFECTIVE
+	def_bool PROVE_RAW_LOCK_NESTING && !PREEMPTION
+
 config LOCK_STAT
 	bool "Lock usage statistics"
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
