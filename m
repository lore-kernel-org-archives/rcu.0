Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB5C71153
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 21:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjIJVQZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 17:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIJVQZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 17:16:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF636129
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 14:16:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBFDC433C8;
        Sun, 10 Sep 2023 21:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694380579;
        bh=HzJzKjR19uV9BfCzqhrmSsDba+n3a6w1bKopYcRGIW0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K1w42WsKyAqs/oZ2MbPCm8vzBtAMgWr8rO9C8sWaHzUi+staDjEb9LnV9ba8CPRpU
         fDi1jKPL5NLxx4VF42qJ9pwxq9T/84b71HzHgowHm390Zzl/92bW4E8Nl4Grh+p+bg
         EbMyPd3HuPf9qf4i8K5Nwz/kHVXDA0W9LG2fw0yZT/J/M/hJQSE3sF30qRqeLZta1f
         G/sDdNPwMjMg7CrOnOLMtMkNopmMHgPIFNzkJbfiIAynz2pP44RsfVCaMshjgmF0EZ
         S9ygbYMHl9l4/uJh7mFvCUCHQ9YOL4nItuEOJdRrsINRSeXBPGVwr8Ji4i6E7HuRZc
         NmtoTlxdH+fbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DD268CE080C; Sun, 10 Sep 2023 14:16:18 -0700 (PDT)
Date:   Sun, 10 Sep 2023 14:16:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230910201445.GA1605059@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230910201445.GA1605059@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 10, 2023 at 08:14:45PM +0000, Joel Fernandes wrote:
> On Fri, Sep 08, 2023 at 09:32:35AM -0400, Joel Fernandes wrote:
> > On Fri, Sep 8, 2023 at 7:41 AM Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > On Fri, Sep 08, 2023 at 01:27:06AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Sep 07, 2023 at 08:51:43PM -0400, Joel Fernandes wrote:
> > > > > On Thu, Sep 7, 2023 at 4:03 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > > On Sep 7, 2023, at 12:23 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > >
> > > > > > > ﻿On Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote:
> > > > > > >> Hi,
> > > > > > >> Just started seeing this on 6.5 stable. It is new and first occurrence:
> > > > > > >>
> > > > > > >> TREE04 no success message, 234 successful version messages
> > > > > > >> [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> > > > > > >> [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
> > > > > > >> f0x0 ->state 0x2 cpu 6
> > > > > > >> [   38.388342] Call Trace:
> > > > > > >> [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
> > > > > > >> f0x2 ->state 0x2 cpu 6
> > > > > > >> [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
> > > > > > >> f0x0 ->state 0x2 cpu 6
> > > > > > >> [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
> > > > > > >> f0x0 ->state 0x2 cpu 6
> > > > > > >> [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
> > > > > > >> f0x0 ->state 0x2 cpu 6
> > > > > > >> [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
> > > > > > >> f0x0 ->state 0x2 cpu 6
> > > > > > >> [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
> > > > > > >> f0x0 ->state 0x2 cpu 6
> > > > > > >> [..]
> > > > > > >>
> > > > > > >> All logs:
> > > > > > >> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TREE04/
> > > > > > >
> > > > > > > Huh.  Does this happen for you in v6.5 mainline?
> > > > > > >
> > > > > > > Both the code under test (full-state polled grace periods) and the
> > > > > > > rcutorture test code are fairly new, so there is some reason for general
> > > > > > > suspicion.  ;-)
> > > > > >
> > > > > > Ah. I never saw it on either 6.5 mainline or stable till today. Even on stable
> > > > > > I only ever saw it this once. On mainline I have not seen it yet but I do test
> > > > > > stable much more since I have been on stable maintenance duty ;-).
> > > > >
> > > > > I did a couple of long runs and I am not able to reproduce it anymore. :-/
> > > >
> > > > I know that feeling!
> > >
> > > Same here, this is after all the reason why we keep the tick dependency within
> > > the hotplug process without really knowing why :o)
> > 
> > Heh. I have been running into another intermittent one as well which
> > is the boost failure and that happens once in 10-15 runs or so.
> > 
> > I was thinking of running the following configuration on an automated
> > regular basis to at least provide a better clue on the lucky run that
> > catches an issue. But then the issue is it would change timing enough
> > to maybe hide bugs. I could also make it submit logs automatically to
> > the list on such occurrences, but one step at a time and all that.  I
> > do need to add (hopefully less noisy) tick/timer related trace events.
> > 
> > # Define the bootargs array
> > bootargs=(
> >     "ftrace_dump_on_oops"
> >     "panic_on_warn=1"
> >     "sysctl.kernel.panic_on_rcu_stall=1"
> >     "sysctl.kernel.max_rcu_stall_to_panic=1"
> >     "trace_buf_size=10K"
> >     "traceoff_on_warning=1"
> >     "panic_print=0x1f"      # To dump held locks, mem and other info.
> > )
> > # Define the trace events array passed to bootargs.
> > trace_events=(
> >     "sched:sched_switch"
> >     "sched:sched_waking"
> >     "rcu:rcu_callback"
> >     "rcu:rcu_fqs"
> >     "rcu:rcu_quiescent_state_report"
> >     "rcu:rcu_grace_period"
> > )
> 
> So some insight on this boost failure. Just before the boost failures are
> reported, I see the migration thread interferring with the rcu_preempt thread
> (aka GP kthread). See trace below. Of note is that the rcu_preempt thread is
> runnable while context switching, which means its execution is interferred.
> The rcu_preempt thread is at RT prio 2 as can be seen.
> 
> So some open-ended questions: what exactly does the migration thread want,
> this is something related to CPU hotplug? And if the migration thread had to
> run, why did the rcu_preempt thread not get pushed to another CPU by the
> scheduler? We have 16 vCPUs for this test.

Maybe we need a cpus_read_lock() before doing a given boost-test interval
and a cpus_read_unlock() after finishing one?  But much depends on
exactly what is starting those migration threads.

Then again, TREE03 is pretty aggressive about doing CPU hotplug.

> IMHO, this might be unrelated to boost but just that the boost test detects
> a stall in RCU 'sooner'. I am planning to add more tracing to the migration
> thread to trace down, but I'm afraid I am hitting some limits of what the
> console is capable of in terms of accepting trace dumping. I am seeing a lot
> of printk messages dropped.

Quite possibly.

> Maybe if I reduce RCU stall detector threshold to 4 seconds or so, I might
> 
> see this even without boost testing, I feel.

Definitely something to try.

> migratio-66        8d..2. 1544321393us : sched_switch: prev_comm=migration/8 prev_pid=66 prev_prio=0 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120
> <idle>-0           8d..2. 1544321890us : sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
> rcu_pree-13        8d..4. 1544321892us : sched_waking: comm=migration/8 pid=66 prio=0 target_cpu=008
> rcu_pree-13        8d..2. 1544321895us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/8 next_pid=66 next_prio=0
> migratio-66        8d..2. 1544321903us : sched_switch: prev_comm=migration/8 prev_pid=66 prev_prio=0 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120
> <idle>-0           8d..2. 1544322121us : sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
> rcu_pree-13        8d..4. 1544322123us : sched_waking: comm=migration/8 pid=66 prio=0 target_cpu=008
> rcu_pree-13        8d..2. 1544322126us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/8 next_pid=66 next_prio=0
> migratio-66        8d..2. 1544322134us : sched_switch: prev_comm=migration/8 prev_pid=66 prev_prio=0 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120
> <idle>-0           8d..2. 1544322495us : sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
> rcu_pree-13        8d..4. 1544322497us : sched_waking: comm=migration/8 pid=66 prio=0 target_cpu=008
> rcu_pree-13        8d..2. 1544322500us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/8 next_pid=66 next_prio=0
> migratio-66        8d..2. 1544322508us : sched_switch: prev_comm=migration/8 prev_pid=66 prev_prio=0 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120
> <idle>-0           8d..2. 1544322978us : sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
> rcu_pree-13        8d..4. 1544322980us : sched_waking: comm=migration/8 pid=66 prio=0 target_cpu=008
> rcu_pree-13        8d..2. 1544322984us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/8 next_pid=66 next_prio=0
> migratio-66        8d..2. 1544322992us : sched_switch: prev_comm=migration/8 prev_pid=66 prev_prio=0 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120
> <idle>-0           8d..2. 1544323301us : sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
> rcu_pree-13        8d..4. 1544323303us : sched_waking: comm=migration/8 pid=66 prio=0 target_cpu=008
> rcu_pree-13        8d..2. 1544323306us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/8 next_pid=66 next_prio=0
> migratio-66        8d..2. 1544323314us : sched_switch: prev_comm=migration/8 prev_pid=66 prev_prio=0 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120
> <idle>-0           8d..2. 1544323673us : sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
> rcu_pree-13        8d..4. 1544323675us : sched_waking: comm=migration/8 pid=66 prio=0 target_cpu=008
> rcu_pree-13        8d..2. 1544323678us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/8 next_pid=66 next_prio=0
> migratio-66        8d..2. 1544323686us : sched_switch: prev_comm=migration/8 prev_pid=66 prev_prio=0 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120
> rcu_tort-1726     12..... 1544323807us : rcu_torture_boost_failed: Boost inversion thread ->rt_priority 1 gp_state 1242792 jiffies 2503
> rcu_tort-1723      1..... 1544323840us : rcu_torture_boost_failed: Boost failed
> rcu_tort-1743      4..... 1544323844us : rcu_torture_boost_failed: Boost failed
> rcu_tort-1715      3..... 1544323848us : rcu_torture_boost_failed: Boost failed
> rcu_tort-1713      7..... 1544323852us : rcu_torture_boost_failed: Boost failed
> 
> (At this point a message says tracing was disabled due to a boost failure
> warning due to my use of traceoff_on_warning=1)
> 
> Side note: I was talking to Steve the other day that it'd be nice to extract
> the trace buffer in a better way than console. Perhaps we can do a core dump
> from rcutorture? I think 'crash' can already extract ftrace [1] from core
> dumps and Qemu can generate core dumps via QMP.
> 
> [1] https://access.redhat.com/solutions/239433

That would be a good option to have.  I have never tried it, so I can't say
what the plusses and minuses might be.

							Thanx, Paul
