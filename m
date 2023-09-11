Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06469EE57DF
	for <rcu@archiver.kernel.org>; Mon, 11 Sep 2023 08:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjIKIQs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Sep 2023 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjIKIQ2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Sep 2023 04:16:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43755FC
        for <rcu@vger.kernel.org>; Mon, 11 Sep 2023 01:16:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5917C433C9;
        Mon, 11 Sep 2023 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694420181;
        bh=JOvntofYBT8O4LvR3Gv4bbSTvE/DMVei5LuO1MZgMz4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vm0uoDFTwfXNSj44sHwwMWiqsJR7cXkQhA4vgxCTPLBR/72OT40iXMP7cszet15n2
         gSlWXjqCsd9cP4TS85GRdOscdm110262omQJHRHRA+2OU34FudpfF82dzw/+dsdnOR
         aBlFl7lNiNZR2erqUXPGwLXSPN+5moSQv5pM0jPBZYk+pFuc6cs741Vx9ZV9bSBE+b
         AFnrRNvuM6UDMY2Ru5Mwa0vZ/cs+ar9uTiinGpjq3mTyURalVH/nEVr/SWQ/KlCABn
         004xFQrTrg+HI2ccNqrEUtRjnpFP715FEA/kZh388IkT5bRKWVF08yw5y9F+6LKKZL
         Nkuzcr95fthmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 70292CE0899; Mon, 11 Sep 2023 01:16:21 -0700 (PDT)
Date:   Mon, 11 Sep 2023 01:16:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230910201445.GA1605059@google.com>
 <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911022725.GA2542634@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 11, 2023 at 02:27:25AM +0000, Joel Fernandes wrote:
> On Sun, Sep 10, 2023 at 07:37:13PM -0400, Joel Fernandes wrote:
> > On Sun, Sep 10, 2023 at 5:16 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, Sep 10, 2023 at 08:14:45PM +0000, Joel Fernandes wrote:
> > [...]
> > > > >  I have been running into another intermittent one as well which
> > > > > is the boost failure and that happens once in 10-15 runs or so.
> > > > >
> > > > > I was thinking of running the following configuration on an automated
> > > > > regular basis to at least provide a better clue on the lucky run that
> > > > > catches an issue. But then the issue is it would change timing enough
> > > > > to maybe hide bugs. I could also make it submit logs automatically to
> > > > > the list on such occurrences, but one step at a time and all that.  I
> > > > > do need to add (hopefully less noisy) tick/timer related trace events.
> > > > >
> > > > > # Define the bootargs array
> > > > > bootargs=(
> > > > >     "ftrace_dump_on_oops"
> > > > >     "panic_on_warn=1"
> > > > >     "sysctl.kernel.panic_on_rcu_stall=1"
> > > > >     "sysctl.kernel.max_rcu_stall_to_panic=1"
> > > > >     "trace_buf_size=10K"
> > > > >     "traceoff_on_warning=1"
> > > > >     "panic_print=0x1f"      # To dump held locks, mem and other info.
> > > > > )
> > > > > # Define the trace events array passed to bootargs.
> > > > > trace_events=(
> > > > >     "sched:sched_switch"
> > > > >     "sched:sched_waking"
> > > > >     "rcu:rcu_callback"
> > > > >     "rcu:rcu_fqs"
> > > > >     "rcu:rcu_quiescent_state_report"
> > > > >     "rcu:rcu_grace_period"
> > > > > )
> > > >
> > > > So some insight on this boost failure. Just before the boost failures are
> > > > reported, I see the migration thread interferring with the rcu_preempt thread
> > > > (aka GP kthread). See trace below. Of note is that the rcu_preempt thread is
> > > > runnable while context switching, which means its execution is interferred.
> > > > The rcu_preempt thread is at RT prio 2 as can be seen.
> > > >
> > > > So some open-ended questions: what exactly does the migration thread want,
> > > > this is something related to CPU hotplug? And if the migration thread had to
> > > > run, why did the rcu_preempt thread not get pushed to another CPU by the
> > > > scheduler? We have 16 vCPUs for this test.
> > >
> > > Maybe we need a cpus_read_lock() before doing a given boost-test interval
> > > and a cpus_read_unlock() after finishing one?  But much depends on
> > > exactly what is starting those migration threads.
> > 
> > But in the field, a real RT task can preempt a reader without doing
> > cpus_read_lock() and may run into a similar boost issue?

The sysctl_sched_rt_runtime should prevent a livelock in most
configurations.  Here, rcutorture explicitly disables this.

> > > Then again, TREE03 is pretty aggressive about doing CPU hotplug.
> > 
> > Ok. I put a trace_printk() in the stopper thread to see what the
> > ->fn() is. I'm doing another run to see what falls out.
> 
> I think I am getting somewhere, It looks like the migration thread tries to
> push the task out due to __balance_push_cpu_stop. Clearly it fails because
> the rcu_preempt task is still on CPU 3. And the whole thing is live locked
> retrying the same.
> 
> I am not sure if the migration thread is trying to migrate rcu_preempt
> because the CPU is going down or because a higher priority RT task is
> running.
> 
> rcu_pree-13        3d..4. 2936723336us : sched_waking: comm=migration/3 pid=34 prio=0 target_cpu=003
> rcu_pree-13        3d..2. 2936723338us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/3 next_pid=34 next_prio=0
> migratio-34        3..... 2936723341us : cpu_stopper_thread: cpu_stop: caller=balance_push+0xc9/0x150 fn=__balance_push_cpu_stop+0x0/0x1c0 on cpu 3
> migratio-34        3d..2. 2936723345us : sched_switch: prev_comm=migration/3 prev_pid=34 prev_prio=0 prev_state=S ==> next_comm=swapper/3 next_pid=0 next_prio=120
> <idle>-0         3d..2. 2936723676us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
> rcu_pree-13        3d..4. 2936723678us : sched_waking: comm=migration/3 pid=34 prio=0 target_cpu=003
> rcu_pree-13        3d..2. 2936723680us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/3 next_pid=34 next_prio=0
> migratio-34        3..... 2936723683us : cpu_stopper_thread: cpu_stop: caller=balance_push+0xc9/0x150 fn=__balance_push_cpu_stop+0x0/0x1c0 on cpu 3
> 
> I am digging deeper to see why the rcu_preempt thread cannot be pushed out
> and then I'll also look at why is it being pushed out in the first place.
> 
> At least I have a strong repro now running 5 instances of TREE03 in parallel
> for several hours.

Very good!  Then why not boot with rcutorture.onoff_interval=0 and see if
the problem still occurs?  If yes, then there is definitely some reason
other than CPU hotplug that makes this happen.

							Thanx, Paul
