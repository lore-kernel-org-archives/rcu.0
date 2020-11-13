Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48FCC55ABD
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 17:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642E121D7F
	for <rcu@archiver.kernel.org>; Fri, 13 Nov 2020 17:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="geU1bNOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgKMRUj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Nov 2020 12:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgKMRUh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Nov 2020 12:20:37 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 750F621D1A;
        Fri, 13 Nov 2020 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605288050;
        bh=zdOUgjYW8liOu3AAZs+tqukYuDwikvfV437KZjKOKuI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=geU1bNOpM4sMyfBIUL36rJseca7qwuoAje0HAxkIMPPO0sxzBOM8dFNoe8yhYtgAE
         0DVFPAxcwhHb+3z5d9Cgi3dOUCDIWBKzD99JiQYMs0Dj5OjmONOZBYCLsevR4ZpGzj
         eWNUFrK67B59Vo3d8sPHyzFuYYuWYtU7thrqMZBI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2DF9435212DC; Fri, 13 Nov 2020 09:20:50 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:20:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, joel@joelfernandes.org
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201113172050.GJ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201111183430.GN517454@elver.google.com>
 <20201111192123.GB3249@paulmck-ThinkPad-P72>
 <20201111202153.GT517454@elver.google.com>
 <20201112001129.GD3249@paulmck-ThinkPad-P72>
 <CANpmjNNyZs6NrHPmomC4=9MPEvCy1bFA5R2pRsMhG7=c3LhL_Q@mail.gmail.com>
 <20201112161439.GA2989297@elver.google.com>
 <20201112175406.GF3249@paulmck-ThinkPad-P72>
 <20201112181254.GA3113918@elver.google.com>
 <20201112200025.GG3249@paulmck-ThinkPad-P72>
 <20201113110604.GA1907210@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113110604.GA1907210@elver.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 13, 2020 at 12:06:04PM +0100, Marco Elver wrote:
> On Thu, Nov 12, 2020 at 12:00PM -0800, Paul E. McKenney wrote:
> > On Thu, Nov 12, 2020 at 07:12:54PM +0100, Marco Elver wrote:
> > > On Thu, Nov 12, 2020 at 09:54AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Nov 12, 2020 at 05:14:39PM +0100, Marco Elver wrote:
> > > > > On Thu, Nov 12, 2020 at 01:49PM +0100, Marco Elver wrote:
> > > > > > On Thu, 12 Nov 2020 at 01:11, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > [...]
> > > > > > > > This assert didn't fire yet, I just get more of the below. I'll keep
> > > > > > > > rerunning, but am not too hopeful...
> > > > > > >
> > > > > > > Is bisection a possibility?
> > > > > > 
> > > > > > I've been running a bisection for past ~12h, and am making slow
> > > > > > progress. It might be another 12h, but I think it'll get there.
> > > > > 
> > > > > Bisection gave me this:
> > > > > 
> > > > > | git bisect start
> > > > > | # bad: [c07b306d7fa5680777e2132662d2e6c19fb53579] kfence: Avoid stalling work queue task without allocations
> > > > > | git bisect bad c07b306d7fa5680777e2132662d2e6c19fb53579
> > > > > | # good: [3cea11cd5e3b00d91caf0b4730194039b45c5891] Linux 5.10-rc2
> > > > > | git bisect good 27598e7e73260ed0b2917eb02d4a515ebb578313
> > > > > | # good: [3e5acbea719e66ef3be64fe74c99cc905ca697dc] Merge remote-tracking branch 'wireless-drivers-next/master' into master
> > > > > | git bisect good 3e5acbea719e66ef3be64fe74c99cc905ca697dc
> > > > > | # good: [491a5a9a2fea28353d99621b8abb83b6928b4e36] Merge remote-tracking branch 'sound-asoc/for-next' into master
> > > > > | git bisect good 491a5a9a2fea28353d99621b8abb83b6928b4e36
> > > > > | # bad: [502f8643d6e21c7e370a0b75131130cc51609055] Merge remote-tracking branch 'phy-next/next' into master
> > > > > | git bisect bad 502f8643d6e21c7e370a0b75131130cc51609055
> > > > > | # good: [6693cb1fa5ea7b91ec00f9404776a095713face5] Merge remote-tracking branch 'tip/auto-latest' into master
> > > > > | git bisect good 6693cb1fa5ea7b91ec00f9404776a095713face5
> > > > > | # bad: [b790e3afead9357195b6d1e1b6cd9b3521503ad2] Merge branch 'tglx-pc.2020.10.30a' into HEAD
> > > > > | git bisect bad b790e3afead9357195b6d1e1b6cd9b3521503ad2
> > > > > | # bad: [765b512bb3d639bfad7dd43c288ee085236c7267] Merge branches 'cpuinfo.2020.11.06a', 'doc.2020.11.06a', 'fixes.2020.11.02a', 'lockdep.2020.11.02a', 'tasks.2020.11.06a' and 'torture.2020.11.06a' into HEAD
> > > > > | git bisect bad 765b512bb3d639bfad7dd43c288ee085236c7267
> > > > > | # good: [01f9e708d9eae6335ae9ff25ab09893c20727a55] tools/rcutorture: Fix BUG parsing of console.log
> > > > 
> > > > So torture.2020.11.06a is OK.
> > > > 
> > > > > | git bisect good 01f9e708d9eae6335ae9ff25ab09893c20727a55
> > > > > | # good: [1be6ab91e2db157faedb7f16ab0636a80745a073] srcu: Take early exit on memory-allocation failure
> > > > 
> > > > As is fixes.2020.11.02a.
> > > > 
> > > > > | git bisect good 1be6ab91e2db157faedb7f16ab0636a80745a073
> > > > > | # good: [65e9eb1ccfe56b41a0d8bfec651ea014968413cb] rcu: Prevent RCU_LOCKDEP_WARN() from swallowing the condition
> > > > 
> > > > And lockdep.2020.11.02a.
> > > > 
> > > > > | git bisect good 65e9eb1ccfe56b41a0d8bfec651ea014968413cb
> > > > > | # good: [c386e29d43728778ddd642fa73cc582bee684171] docs/rcu: Update the call_rcu() API
> > > > 
> > > > And doc.2020.11.06a.
> > > > 
> > > > > | git bisect good c386e29d43728778ddd642fa73cc582bee684171
> > > > > | # good: [27c0f1448389baf7f309b69e62d4b531c9395e88] rcutorture: Make grace-period kthread report match RCU flavor being tested
> > > > 
> > > > And the first three commits of tasks.2020.11.06a.
> > > > 
> > > > > | git bisect good 27c0f1448389baf7f309b69e62d4b531c9395e88
> > > > > | # good: [3fcd6a230fa7d03bffcb831a81b40435c146c12b] x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs
> > > > 
> > > > And cpuinfo.2020.11.06a.
> > > > 
> > > > > | git bisect good 3fcd6a230fa7d03bffcb831a81b40435c146c12b
> > > > > | # good: [75dc2da5ecd65bdcbfc4d59b9d9b7342c61fe374] rcu-tasks: Make the units of ->init_fract be jiffies
> > > > 
> > > > And the remaining commit of tasks.2020.11.06a.
> > > > 
> > > > > | git bisect good 75dc2da5ecd65bdcbfc4d59b9d9b7342c61fe374
> > > > > | # first bad commit: [765b512bb3d639bfad7dd43c288ee085236c7267] Merge branches 'cpuinfo.2020.11.06a', 'doc.2020.11.06a', 'fixes.2020.11.02a', 'lockdep.2020.11.02a', 'tasks.2020.11.06a' and 'torture.2020.11.06a' into HEAD
> > > > > 
> > > > > This doesn't look very satisfying, given it's the merge commit. :-/
> > > > 
> > > > So each individual branch is just fine, but the merge of them is not.  Fun.
> > > > 
> > > > These have been passing quite a bit of rcutorture over here, including
> > > > preemptible kernels running !SMP, but admittedly on x86 rather than ARMv8.
> > > 
> > > Note that this is ARMv8 on QEMU on an x86 host i.e. emulated. And it's
> > > really slow as a result. Together with a bunch of debug tools including
> > > lockdep.
> > 
> > Then I don't envy you the bisection process!  ;-)
> > 
> > > > One approach would be to binary-search the combinations of merges.
> > > > Except that there are six of them, so there are 64 combinations, of
> > > > which you have tested only 8 thus far (none, one each, and all).
> > > > 
> > > > But are you sure that the bisection points labeled "good" really are good?
> > > > For example, what is the distribution of first failure times in the
> > > > points labeled "bad" vs. the runtime used to make a "good" determination?
> > > > Alternatively, just try a longer run on each of the commits feeding into
> > > > the merge point.
> > > 
> > > Yeah, I'm having doubts, and this might be even more non-deterministic
> > > that I thought and some 'good' could maybe be 'bad' if I had re-run
> > > them? I don't know. One thing I can try is to make sure I run it more
> > > than once, but I'm definitely not doing that manually, so let me try and
> > > script something so I don't have to hand-hold the bisection overnight.
> > > :-)
> > 
> > I know that feeling.  A similar experience motivated me to upgrade my
> > tooling, with more upgrades in the queue.
> 
> [.....]
> 
> > > > > | [  841.143527]  arch_local_irq_restore+0x4/0x8
> > > > 
> > > > So we are just now restoring interrupts, hence our getting the
> > > > interrupt at this point..
> > > > 
> > > > > | [  841.147612]  trace_preempt_on+0xf4/0x190
> > > > 
> > > > From within the trace code, which is apparently recording the fact
> > > > that preemption is being enabled.
> > > > 
> > > > > | [  841.151656]  preempt_schedule_common+0x12c/0x1b0
> > > > > | [  841.155869]  preempt_schedule.part.88+0x20/0x28
> > > > > | [  841.160036]  preempt_schedule+0x20/0x28
> > > > 
> > > > I was not aware that releasing a raw spinlock could result in a direct
> > > > call to preempt_schedule().
> > > > 
> > > > > | [  841.164051]  _raw_spin_unlock_irq+0x80/0x90
> > > > > | [  841.168139]  rcu_gp_kthread+0xe5c/0x19a8
> > > > 
> > > > So the RCU grace-period kthread has spent many seconds attempting to
> > > > release a lock?  Am I reading this correctly?  Mark Rutland, am I missing
> > > > something here?
> > 
> > And yes, this is the RCU grace-period kthread releasing a lock.
> > 
> > I have no idea why that would take so long.  It is acting like a
> > self-deadlock or similar hang, except that in that case, lockdep should
> > have complained before the RCU CPU stall warning rather than after.
> > 
> > The only thing I can suggest is sprinkling lockdep_assert_irqs_disabled()
> > calls hither and yon.  All of the code that lockdep is complaining about
> > runs in the context of the scheduling-clock interrupt, so interrupts
> > had jolly well be disabled!  ;-)
> > 
> > Rerunning some of the allegedly good bisects might be more productive.
> 
> Oof, so I reran bisection, and this time confirming 3x each good run.
> This is what I get:
> 
> | git bisect start
> | # bad: [c07b306d7fa5680777e2132662d2e6c19fb53579] kfence: Avoid stalling work queue task without allocations
> | git bisect bad c07b306d7fa5680777e2132662d2e6c19fb53579
> | # good: [3cea11cd5e3b00d91caf0b4730194039b45c5891] Linux 5.10-rc2
> | git bisect good 27598e7e73260ed0b2917eb02d4a515ebb578313
> | # good: [3e5acbea719e66ef3be64fe74c99cc905ca697dc] Merge remote-tracking branch 'wireless-drivers-next/master' into master
> | git bisect good 3e5acbea719e66ef3be64fe74c99cc905ca697dc
> | # good: [491a5a9a2fea28353d99621b8abb83b6928b4e36] Merge remote-tracking branch 'sound-asoc/for-next' into master
> | git bisect good 491a5a9a2fea28353d99621b8abb83b6928b4e36
> | # bad: [502f8643d6e21c7e370a0b75131130cc51609055] Merge remote-tracking branch 'phy-next/next' into master
> | git bisect bad 502f8643d6e21c7e370a0b75131130cc51609055
> | # good: [6693cb1fa5ea7b91ec00f9404776a095713face5] Merge remote-tracking branch 'tip/auto-latest' into master
> | git bisect good 6693cb1fa5ea7b91ec00f9404776a095713face5
> | # good: [b790e3afead9357195b6d1e1b6cd9b3521503ad2] Merge branch 'tglx-pc.2020.10.30a' into HEAD
> | git bisect good b790e3afead9357195b6d1e1b6cd9b3521503ad2
> | # bad: [7bd5bb161657717d576798f62b0e8d5b44653139] Merge remote-tracking branch 'drivers-x86/for-next' into master
> | git bisect bad 7bd5bb161657717d576798f62b0e8d5b44653139
> | # bad: [e71eb4c4d42bcf36a3a7ede30fd320d47b3c8cb8] Merge remote-tracking branch 'xen-tip/linux-next' into master
> | git bisect bad e71eb4c4d42bcf36a3a7ede30fd320d47b3c8cb8
> | # bad: [c0a41bf9dbc751692c8cb1a44bfd48e70e8bef7f] docs: Remove redundant "``" from Requirements.rst
> | git bisect bad c0a41bf9dbc751692c8cb1a44bfd48e70e8bef7f
> | # bad: [c293fb8f7de6c2fce11cb01a0218d668df326bcd] torture: Make --kcsan specify lockdep
> | git bisect bad c293fb8f7de6c2fce11cb01a0218d668df326bcd
> | # good: [5068ab7dcb6a526a401054ebe0d416f979efb3e1] rcutorture: Add testing for RCU's global memory ordering
> | git bisect good 5068ab7dcb6a526a401054ebe0d416f979efb3e1
> | # good: [bea68a13bbbdc575a2c868dabd7b454c2eddc618] rcu/segcblist: Add additional comments to explain smp_mb()
> | git bisect good bea68a13bbbdc575a2c868dabd7b454c2eddc618
> | # first bad commit: [c293fb8f7de6c2fce11cb01a0218d668df326bcd] torture: Make --kcsan specify lockdep
> 
> Which clearly is ridiculous! So my guess is this probably had existed
> before, but something in -next is making it more visible.
> 
> Short of giving up, I can try your suggestion of sprinkling
> lockdep_assert_irqs_disabled() everywhere, or if you have a patch to
> apply that would give some other debug output you wanted I can run that
> too.

I don't have a patch, but if you are still seeing lots of workqueue
lockups before the RCU CPU stall warning, I again suggest adding the
backtrace as called out in my earlier email.  The idea here is to see
what is causing these lockups.

I can send a formal patch for this if you wish, but today is crazy,
so I cannot promise it before this evening, Pacific Time.

							Thanx, Paul
