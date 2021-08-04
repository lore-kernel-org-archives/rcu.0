Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48522C4338F
	for <rcu@archiver.kernel.org>; Wed,  4 Aug 2021 22:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B616109F
	for <rcu@archiver.kernel.org>; Wed,  4 Aug 2021 22:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhHDWeU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhHDWeR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Aug 2021 18:34:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 934E66104F;
        Wed,  4 Aug 2021 22:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628116438;
        bh=0dsbEmAguaSfHlozxbO03jG4cUL4rS7RbChy6uYIzB4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z+kQZHeg13krHlaBS4u37wzE0TuHStij2oh+bIs7ldGzauoqqf2YKFN5fvitdEX/V
         nqKax6KBKKUiepCqjGpdPgluxwscIC6VyNJ5wskwLDn/S3JcbiwyfWo3MwocEwGR4g
         YXe1SKF/yc/e8zLJUYya70ZrRNhnumxRIwUOTtevSyAZIm6/HgxLvqBW+c0JDsP3b9
         FhZMOJtHL/w2VezQnUZeJwK9B/Cj0qSTlMXgB4Zr/g6cebW9NhpuWJl2PpU7BsaGFw
         gCp2qMhi5fXDxDioV0+1lBRD2b9HDL8z2kHKdAkLT0FbBWnWK0YgVFPL89jqGmS1H8
         tvoQBghUxM58g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5944E5C22D9; Wed,  4 Aug 2021 15:33:58 -0700 (PDT)
Date:   Wed, 4 Aug 2021 15:33:58 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Yanfei Xu <yanfei.xu@windriver.com>
Subject: Re: [PATCH rcu 02/18] rcu: Fix stall-warning deadlock due to
 non-release of rcu_node ->lock
Message-ID: <20210804223358.GZ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-2-paulmck@kernel.org>
 <20210803142458.teveyn6t2gwifdcp@e107158-lin.cambridge.arm.com>
 <20210803155226.GQ4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803161221.igae6y6xa6mlzltn@e107158-lin.cambridge.arm.com>
 <20210803162855.GT4397@paulmck-ThinkPad-P17-Gen-1>
 <20210804135017.g6tfaubvygki2osk@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804135017.g6tfaubvygki2osk@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 04, 2021 at 02:50:17PM +0100, Qais Yousef wrote:
> On 08/03/21 09:28, Paul E. McKenney wrote:
> > On Tue, Aug 03, 2021 at 05:12:21PM +0100, Qais Yousef wrote:
> > > On 08/03/21 08:52, Paul E. McKenney wrote:
> > > > On Tue, Aug 03, 2021 at 03:24:58PM +0100, Qais Yousef wrote:
> > > > > Hi
> > > > > 
> > > > > On 07/21/21 13:21, Paul E. McKenney wrote:
> > > > > > From: Yanfei Xu <yanfei.xu@windriver.com>
> > > > > > 
> > > > > > If rcu_print_task_stall() is invoked on an rcu_node structure that does
> > > > > > not contain any tasks blocking the current grace period, it takes an
> > > > > > early exit that fails to release that rcu_node structure's lock.  This
> > > > > > results in a self-deadlock, which is detected by lockdep.
> > > > > > 
> > > > > > To reproduce this bug:
> > > > > > 
> > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3 --trust-make --configs "TREE03" --kconfig "CONFIG_PROVE_LOCKING=y" --bootargs "rcutorture.stall_cpu=30 rcutorture.stall_cpu_block=1 rcutorture.fwd_progress=0 rcutorture.test_boost=0"
> > > > > > 
> > > > > > This will also result in other complaints, including RCU's scheduler
> > > > > > hook complaining about blocking rather than preemption and an rcutorture
> > > > > > writer stall.
> > > > > > 
> > > > > > Only a partial RCU CPU stall warning message will be printed because of
> > > > > > the self-deadlock.
> > > > > > 
> > > > > > This commit therefore releases the lock on the rcu_print_task_stall()
> > > > > > function's early exit path.
> > > > > > 
> > > > > > Fixes: c583bcb8f5ed ("rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled")
> > > > > > Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > > ---
> > > > > 
> > > > > We are seeing similar stall/deadlock issue on android 5.10 kernel, is the fix
> > > > > relevant here? Trying to apply the patches and test, but the problem is tricky
> > > > > to reproduce so thought worth asking first.
> > > > 
> > > > Looks like the relevant symptoms to me, so I suggest trying this series
> > > > from -rcu:
> > > > 
> > > > 8baded711edc ("rcu: Fix to include first blocked task in stall warning")
> > > > f6b3995a8b56 ("rcu: Fix stall-warning deadlock due to non-release of rcu_node ->lock")
> > > 
> > > Great thanks. These are the ones we picked as the rest was a bit tricky to
> > > apply on 5.10.
> > > 
> > > While at it, we see these errors too though they look harmless. They happen
> > > all the time
> > > 
> > > 	[  595.292685] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #02!!!"}
> > > 	[  595.301467] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > > 	[  595.389353] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > > 	[  595.397454] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > > 	[  595.417112] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > > 	[  595.425215] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > > 	[  595.438807] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"}
> > > 
> > > I used to see them on mainline a while back but seem to have been fixed.
> > > Something didn't get backported to 5.10 perhaps?
> > 
> > I believe that you need at least this one:
> > 
> > 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")
> 
> After looking at the content of the patch, it's not related. We don't run with
> PREEMPT_RT.
> 
> I think we're hitting a genuine issue, most likely due to out-of-tree changes
> done by Android to fix RT latency problems against softirq (surprise surprise).
> 
> Thanks for your help and sorry for the noise.

No problem!

But I used to see this very frequently in non-PREEMPT_RT rcutorture runs,
and there was a patch from Thomas that made them go away.  So it might
be worth looking at has patches in this area since 5.10.  Maybe I just
got confused and picked the wrong one.

							Thanx, Paul
