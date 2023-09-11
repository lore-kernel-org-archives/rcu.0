Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FBFCA0ECF
	for <rcu@archiver.kernel.org>; Mon, 11 Sep 2023 22:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbjIKV6f (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237879AbjIKNRi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 11 Sep 2023 09:17:38 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94215EE
        for <rcu@vger.kernel.org>; Mon, 11 Sep 2023 06:17:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79536bc669dso150807639f.3
        for <rcu@vger.kernel.org>; Mon, 11 Sep 2023 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694438252; x=1695043052; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QceivWPKDOg4Q23tRx4xuq3pgfCv2Z0byeQUFYfKDZA=;
        b=Za0OjOeyLqOSKWgXXkZVo8kC2KdFDaDkVgXp5l9qLgyKnnolx3BuXFy4tucVJZO0SC
         YfreKRvCcSsQYILZ1tNHGGcgokdnOuRM0O7jbAM8rXpCxwS0ZMeInA4BssaZMckuiOa7
         7FVyq2Ouq7xaBzPIfZHqpSnvvrnR/dtnMG18o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438252; x=1695043052;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QceivWPKDOg4Q23tRx4xuq3pgfCv2Z0byeQUFYfKDZA=;
        b=jVqDm6VkZK70bh49n/KOVK3Ik4PaWTU7nD7bDOOgADK+cYs+91U9wOIWVk9C33oQ4z
         JbUt+qDWZAhnPQ2Rpu0hI86++TqIad5wWX6uV+nkta919ny1GAgfVeAITzv50pGsOr2i
         1m15Vg1PhOOq2K/iFc6bwiVt6mANrrXekvOQiNuvSlx8NVXdl4potYJCQj04vwJMs5NG
         aYK5b6tdWY/PCpoW0y18xR2Z7e+JXw3P0kbIeIdpo7g2Pr4PY3QswvRPgQr3S/TLtQej
         hwv4yOhts8t1Q2uIrMs/qHCl4tsyKkhoqRav/J6RVUO+HgqPoAgHz95AU846AqlnZ+RI
         Ngxw==
X-Gm-Message-State: AOJu0Yytw6YVTyTVieaN6J6A6Mo6NZ5BQQezJYdkkLaDnMniIU6w4+Zs
        hdlfSSEayoYEORl6wPC6um/sPg==
X-Google-Smtp-Source: AGHT+IF+jm/POJptVkYP0ZDcWw+R5v9ssuIkeW7T62AWGvyS8yBGUNGZOrjDJLoYkCI1Qylh5bVP5g==
X-Received: by 2002:a5d:884b:0:b0:795:fa0:c13 with SMTP id t11-20020a5d884b000000b007950fa00c13mr12089946ios.12.1694438251834;
        Mon, 11 Sep 2023 06:17:31 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id b15-20020a02c98f000000b00418a5e0e93esm2237094jap.162.2023.09.11.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:17:31 -0700 (PDT)
Date:   Mon, 11 Sep 2023 13:17:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <20230911131730.GA2291108@google.com>
References: <20230910201445.GA1605059@google.com>
 <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
 <20230911022725.GA2542634@google.com>
 <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 11, 2023 at 01:16:21AM -0700, Paul E. McKenney wrote:
> On Mon, Sep 11, 2023 at 02:27:25AM +0000, Joel Fernandes wrote:
> > On Sun, Sep 10, 2023 at 07:37:13PM -0400, Joel Fernandes wrote:
> > > On Sun, Sep 10, 2023 at 5:16 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Sun, Sep 10, 2023 at 08:14:45PM +0000, Joel Fernandes wrote:
> > > [...]
> > > > > >  I have been running into another intermittent one as well which
> > > > > > is the boost failure and that happens once in 10-15 runs or so.
> > > > > >
> > > > > > I was thinking of running the following configuration on an automated
> > > > > > regular basis to at least provide a better clue on the lucky run that
> > > > > > catches an issue. But then the issue is it would change timing enough
> > > > > > to maybe hide bugs. I could also make it submit logs automatically to
> > > > > > the list on such occurrences, but one step at a time and all that.  I
> > > > > > do need to add (hopefully less noisy) tick/timer related trace events.
> > > > > >
> > > > > > # Define the bootargs array
> > > > > > bootargs=(
> > > > > >     "ftrace_dump_on_oops"
> > > > > >     "panic_on_warn=1"
> > > > > >     "sysctl.kernel.panic_on_rcu_stall=1"
> > > > > >     "sysctl.kernel.max_rcu_stall_to_panic=1"
> > > > > >     "trace_buf_size=10K"
> > > > > >     "traceoff_on_warning=1"
> > > > > >     "panic_print=0x1f"      # To dump held locks, mem and other info.
> > > > > > )
> > > > > > # Define the trace events array passed to bootargs.
> > > > > > trace_events=(
> > > > > >     "sched:sched_switch"
> > > > > >     "sched:sched_waking"
> > > > > >     "rcu:rcu_callback"
> > > > > >     "rcu:rcu_fqs"
> > > > > >     "rcu:rcu_quiescent_state_report"
> > > > > >     "rcu:rcu_grace_period"
> > > > > > )
> > > > >
> > > > > So some insight on this boost failure. Just before the boost failures are
> > > > > reported, I see the migration thread interferring with the rcu_preempt thread
> > > > > (aka GP kthread). See trace below. Of note is that the rcu_preempt thread is
> > > > > runnable while context switching, which means its execution is interferred.
> > > > > The rcu_preempt thread is at RT prio 2 as can be seen.
> > > > >
> > > > > So some open-ended questions: what exactly does the migration thread want,
> > > > > this is something related to CPU hotplug? And if the migration thread had to
> > > > > run, why did the rcu_preempt thread not get pushed to another CPU by the
> > > > > scheduler? We have 16 vCPUs for this test.
> > > >
> > > > Maybe we need a cpus_read_lock() before doing a given boost-test interval
> > > > and a cpus_read_unlock() after finishing one?  But much depends on
> > > > exactly what is starting those migration threads.
> > > 
> > > But in the field, a real RT task can preempt a reader without doing
> > > cpus_read_lock() and may run into a similar boost issue?
> 
> The sysctl_sched_rt_runtime should prevent a livelock in most
> configurations.  Here, rcutorture explicitly disables this.

I see. Though RT throttling will actually stall the rcu_preempt thread as
well in the real world. RT throttling is a bit broken and we're trying to fix
it in scheduler land. Even if there are idle CPUs, RT throttling will starve
not just the offending RT task, but all of them essentially causing a
priority inversion between running RT and CFS tasks.

> > > > Then again, TREE03 is pretty aggressive about doing CPU hotplug.
> > > 
> > > Ok. I put a trace_printk() in the stopper thread to see what the
> > > ->fn() is. I'm doing another run to see what falls out.
> > 
> > I think I am getting somewhere, It looks like the migration thread tries to
> > push the task out due to __balance_push_cpu_stop. Clearly it fails because
> > the rcu_preempt task is still on CPU 3. And the whole thing is live locked
> > retrying the same.
> > 
> > I am not sure if the migration thread is trying to migrate rcu_preempt
> > because the CPU is going down or because a higher priority RT task is
> > running.
> > 
> > rcu_pree-13        3d..4. 2936723336us : sched_waking: comm=migration/3 pid=34 prio=0 target_cpu=003
> > rcu_pree-13        3d..2. 2936723338us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/3 next_pid=34 next_prio=0
> > migratio-34        3..... 2936723341us : cpu_stopper_thread: cpu_stop: caller=balance_push+0xc9/0x150 fn=__balance_push_cpu_stop+0x0/0x1c0 on cpu 3
> > migratio-34        3d..2. 2936723345us : sched_switch: prev_comm=migration/3 prev_pid=34 prev_prio=0 prev_state=S ==> next_comm=swapper/3 next_pid=0 next_prio=120
> > <idle>-0         3d..2. 2936723676us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
> > rcu_pree-13        3d..4. 2936723678us : sched_waking: comm=migration/3 pid=34 prio=0 target_cpu=003
> > rcu_pree-13        3d..2. 2936723680us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/3 next_pid=34 next_prio=0
> > migratio-34        3..... 2936723683us : cpu_stopper_thread: cpu_stop: caller=balance_push+0xc9/0x150 fn=__balance_push_cpu_stop+0x0/0x1c0 on cpu 3
> > 
> > I am digging deeper to see why the rcu_preempt thread cannot be pushed out
> > and then I'll also look at why is it being pushed out in the first place.
> > 
> > At least I have a strong repro now running 5 instances of TREE03 in parallel
> > for several hours.
> 
> Very good!  Then why not boot with rcutorture.onoff_interval=0 and see if
> the problem still occurs?  If yes, then there is definitely some reason
> other than CPU hotplug that makes this happen.

Sure, I'll do this now. If that disappears, I'll do the cpu_read_lock()
suggestion you mentioned. IMHO this is increasingly looking like a scheduling
issue with RT and too many RT tasks running at the same time where the
rcu_preempt thread migrates around looking for a CPU than it does any work.

Today morning's traces show that __balance_push_cpu_stop() actually
successfully moves the rcu_preempt task out of the CPU. But a few ms later,
it is back on the same CPU again only to have the migration thread try to
move it out again. Maybe the cpuhp threads are fighting with it. There's also
all the rcutorture boost kthreads that are all running at the same time
during the failure but those are lower priority than the rcu_preempt thread
in this test.

Also I am switching to some day job things while the onoff_interval=0 test
runs, thanks a lot Paul for your help!  I'll continue to look at this as I
can.

thanks,

 - Joel

