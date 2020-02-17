Return-Path: <SRS0=T7aT=4F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BD0C34022
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 23:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C29207FD
	for <rcu@archiver.kernel.org>; Mon, 17 Feb 2020 23:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581981789;
	bh=3xCrSVe1aguvEuypNldklZAVyLc2gTe3TRj2nmNmVW4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Du43tihLlDNpOHiSsRCcnr4XrQqVv1NU/N4FylOaey5h1G5t3VL+x78gatxm8I89Y
	 +Vw9GcxSQnWprtkHlyFWSAeQJK3UPnPFPxEDY2UPitR6cpwtwB+d4MUXPhikGFgWQW
	 RocgDisMKBAUd36/HkHkUF8YYlH9nt+OeL+ujafc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgBQXXJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 17 Feb 2020 18:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:54078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgBQXXJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 17 Feb 2020 18:23:09 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7FE4206E2;
        Mon, 17 Feb 2020 23:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581981787;
        bh=3xCrSVe1aguvEuypNldklZAVyLc2gTe3TRj2nmNmVW4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zy4osd5VfvSaqmPoFCWME6hKJkO13ovKAbHRqHqIFUKWMGQIQ4avCdi+pQUBhYbLI
         +15442YUELPF8WY+N99olaXBWS/QWJTd0hf1QRzRw5l7mGDNKpPhO1FC2kJT0wQx4g
         Dg/7pcHSVF6feBa0O2mce9YVGLsHz0sP7NJSNGSA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C17EF35227A8; Mon, 17 Feb 2020 15:23:07 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:23:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH V2 2/7] rcu: cleanup rcu_preempt_deferred_qs()
Message-ID: <20200217232307.GA17570@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191102124559.1135-1-laijs@linux.alibaba.com>
 <20191102124559.1135-3-laijs@linux.alibaba.com>
 <20191103020150.GA23770@tardis>
 <7489f817-adaf-275b-b19d-18ad248b071f@linux.alibaba.com>
 <20191104145539.GY20975@paulmck-ThinkPad-P72>
 <e820852f-87ca-f974-2245-99833205e270@linux.alibaba.com>
 <20191105071911.GL20975@paulmck-ThinkPad-P72>
 <20191111143238.GA13306@paulmck-ThinkPad-P72>
 <cbded276-6770-25a0-2975-2c087872a38e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbded276-6770-25a0-2975-2c087872a38e@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 12, 2019 at 09:28:37AM +0800, Lai Jiangshan wrote:
> 
> 
> On 2019/11/11 10:32 下午, Paul E. McKenney wrote:
> > On Mon, Nov 04, 2019 at 11:19:11PM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 05, 2019 at 10:09:15AM +0800, Lai Jiangshan wrote:
> > > > On 2019/11/4 10:55 下午, Paul E. McKenney wrote:
> > > > > On Sun, Nov 03, 2019 at 01:01:21PM +0800, Lai Jiangshan wrote:
> > > > > > 
> > > > > > 
> > > > > > On 2019/11/3 10:01 上午, Boqun Feng wrote:
> > > > > > > Hi Jiangshan,
> > > > > > > 
> > > > > > > 
> > > > > > > I haven't checked the correctness of this patch carefully, but..
> > > > > > > 
> > > > > > > 
> > > > > > > On Sat, Nov 02, 2019 at 12:45:54PM +0000, Lai Jiangshan wrote:
> > > > > > > > Don't need to set ->rcu_read_lock_nesting negative, irq-protected
> > > > > > > > rcu_preempt_deferred_qs_irqrestore() doesn't expect
> > > > > > > > ->rcu_read_lock_nesting to be negative to work, it even
> > > > > > > > doesn't access to ->rcu_read_lock_nesting any more.
> > > > > > > 
> > > > > > > rcu_preempt_deferred_qs_irqrestore() will report RCU qs, and may
> > > > > > > eventually call swake_up() or its friends to wake up, say, the gp
> > > > > > > kthread, and the wake up functions could go into the scheduler code
> > > > > > > path which might have RCU read-side critical section in it, IOW,
> > > > > > > accessing ->rcu_read_lock_nesting.
> > > > > > 
> > > > > > Sure, thank you for pointing it out.
> > > > > > 
> > > > > > I should rewrite the changelog in next round. Like this:
> > > > > > 
> > > > > > rcu: cleanup rcu_preempt_deferred_qs()
> > > > > > 
> > > > > > IRQ-protected rcu_preempt_deferred_qs_irqrestore() itself doesn't
> > > > > > expect ->rcu_read_lock_nesting to be negative to work.
> > > > > > 
> > > > > > There might be RCU read-side critical section in it (from wakeup()
> > > > > > or so), 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
> > > > > > will ensure that ->rcu_read_unlock_special is zero and these RCU
> > > > > > read-side critical sections will not call rcu_read_unlock_special().
> > > > > > 
> > > > > > Thanks
> > > > > > Lai
> > > > > > 
> > > > > > ===
> > > > > > PS: Were 1711d15bf5ef(rcu: Clear ->rcu_read_unlock_special only once)
> > > > > > not applied earlier, it will be protected by previous patch (patch1)
> > > > > > in this series
> > > > > > "rcu: use preempt_count to test whether scheduler locks is held"
> > > > > > when rcu_read_unlock_special() is called.
> > > > > 
> > > > > This one in -rcu, you mean?
> > > > > 
> > > > > 5c5d9065e4eb ("rcu: Clear ->rcu_read_unlock_special only once")
> > > > 
> > > > Yes, but the commit ID is floating in the tree.
> > > 
> > > Indeed, that part of -rcu is subject to rebase, and will continue
> > > to be until about v5.5-rc5 or thereabouts.
> > > 
> > > https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html
> > > 
> > > My testing of your full stack should be complete by this coming Sunday
> > > morning, Pacific Time.
> > 
> > And you will be happy to hear that it ran the full time without errors.
> > 
> > Good show!!!
> > 
> > My next step is to look much more carefully at the remaining patches,
> > checking my first impressions.  This will take a few days.
> > 
> 
> Hi, All
> 
> I'm still asking for more comments.
> 
> By now, I have received some precious comments, mainly due to my
> stupid naming mistakes and a misleading changelog. I should have
> updated all these with a new series patches. But I hope I
> can polish more in the new patchset with more suggestions from
> valuable comments, especially in x86,scheduler,percpu and rcu
> areas.
> 
> I'm very obliged to hear anything.

Hearing no objections, and having more confidence in other commits that
(allegedly) guarantee forward progress for nohz_full CPUs, i have pulled
this into -rcu for testing and further review.  Please see below for the
updated patch.

							Thanx, Paul

------------------------------------------------------------------------

commit 23a58acde0eea57ac77377e5d50d9562b2dbdfaa
Author: Lai Jiangshan <laijs@linux.alibaba.com>
Date:   Sat Feb 15 14:37:26 2020 -0800

    rcu: Don't set nesting depth negative in rcu_preempt_deferred_qs()
    
    Now that RCU flavors have been consolidated, an RCU-preempt
    rcu_rea_unlock() in an interrupt or softirq handler cannot possibly
    end the RCU read-side critical section.  Consider the old vulnerability
    involving rcu_preempt_deferred_qs() being invoked within such a handler
    that interrupted an extended RCU read-side critical section, in which
    a wakeup might be invoked with a scheduler lock held.  Because
    rcu_read_unlock_special() no longer does wakeups in such situations,
    it is no longer necessary for rcu_preempt_deferred_qs() to set the
    nesting level negative.
    
    This commit therfore removes this recursion-protection code from
    rcu_preempt_deferred_qs().
    
    Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4bd062a..118407f8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -569,16 +569,11 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 static void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	unsigned long flags;
-	bool couldrecurse = rcu_preempt_depth() >= 0;
 
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
-	if (couldrecurse)
-		rcu_preempt_depth_set(rcu_preempt_depth() - RCU_NEST_BIAS);
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
-	if (couldrecurse)
-		rcu_preempt_depth_set(rcu_preempt_depth() + RCU_NEST_BIAS);
 }
 
 /*
