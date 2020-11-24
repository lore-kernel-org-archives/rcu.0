Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D3C2D0E4
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 03:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E624D206FA
	for <rcu@archiver.kernel.org>; Tue, 24 Nov 2020 03:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEqloDj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgKXDA2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Nov 2020 22:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgKXDA1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Nov 2020 22:00:27 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB0BC0613CF;
        Mon, 23 Nov 2020 19:00:27 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id n9so3677365qvp.5;
        Mon, 23 Nov 2020 19:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9dXI24aC8NvP/kqZdopSzP2LewH/N8Z0aB66LTLcHvE=;
        b=WEqloDj3pQkHX/rykrKshZfsbcCFrb7Nnf00c3YqN5OaW4DiwvjYgmOEv/T/Jeir9Y
         52cpDiHcVrElzwhPz4rHypEcCfMDSIQ3obrclpYdIx57IeRgdY3gWjbY+NgxnT6WxdvT
         ypjzMSO1oFqLdVQ6YBjlT87lUiNGuM2pCijcLekmYKBSlzFR9ivbGjMfJ8NdvoZZzzTW
         L2vhfbZVf7ouhvYHOUTHRx6Pvt7XrrjHU/8Y9bKrK5EHQ+UHrlU5of2XVVRpExMeCaON
         NI16vHytRRMrKcTlEimaI6cyyYJvmL1wm2qU1YH68vUAI082poVvdaqOANqoINvZcZbw
         aDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9dXI24aC8NvP/kqZdopSzP2LewH/N8Z0aB66LTLcHvE=;
        b=hLAekkD6CxBnuj2Ido+H/fOIP5o/GBiGEd/BYVWxMskWSbaiiTX6vpd0ibcBVpwXPO
         Up+HJ+BXWE3kyWrfahLDJzoeJ4d+r6LFmK9A/0eal+ULgWXDQUqJpKktEuJk7C9m8LTm
         y838m4k+Y5BFyoj7x6vzrmJYvE2bW9zr6jK/gI++NG6hzF7CnplexKjqXpWom85vZuwU
         bjdk//XRItjOd0ZOWm/JUSjZGJu9WE6DBThdYDd3bOGsO3RVkwj7tqWlHnNJ/mIjMCwN
         x8XykMJCOFprFi4oSf31rry6SP69y1V37Z1dQJqSqmQdE7zM8oqCTpcBbIh5W+OG3/GH
         rxSg==
X-Gm-Message-State: AOAM532iY8MLNb1WTHo8iv1uvYE/1eR978Qgfewrwz9ojIIs4DXQx8iU
        IaPWbnZWUd/+Nauw+UJokiA=
X-Google-Smtp-Source: ABdhPJxH7jj3FF+5RuwZ9GNlWj2c8UxLx+AfCz81AZzM1Ew0KXCJd7hKJ4QfbZ8o59GXirU6bTTphg==
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr2543732qvt.46.1606186826260;
        Mon, 23 Nov 2020 19:00:26 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h8sm7294688qka.117.2020.11.23.19.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 19:00:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 657D527C0054;
        Mon, 23 Nov 2020 22:00:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 23 Nov 2020 22:00:22 -0500
X-ME-Sender: <xms:RHe8X8nhjwC9ixhL5bNug7kbvlycNZqxon1X4wu5mNxJu7Pz5XHf0g>
    <xme:RHe8X73UXz0fmmgs8tu8zgbAr1Nw9mYh8NkzcJoj8rXKvEDuTFXL9vwkZTK-ASN3d
    QZDjJiw2DCbpfpDkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:RHe8X6q6izYmjBpKOcIsrU1pCgaFljAMLFUewdqAuRkH2_JLAJyAOg>
    <xmx:RHe8X4mizohZZSst8rd3803nXlAmHpd2ubbbKKyTvK355jE_sqivHg>
    <xmx:RHe8X60OksZQ7bAe_ACtVM2KqOSGytjaaVAx5Qkma08-c0seT1M-gQ>
    <xmx:Rne8X12Cw0YTpE8tjQMdP_-IxdAg7c8bUkFwq2Nq7z4bvZi5_SpwtS8GpAc>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 816D83064AB3;
        Mon, 23 Nov 2020 22:00:20 -0500 (EST)
Date:   Tue, 24 Nov 2020 10:59:45 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without
 allocations
Message-ID: <20201124025945.GG286534@boqun-archlinux>
References: <20201113175754.GA6273@paulmck-ThinkPad-P72>
 <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201120142734.75af5cd6@gandalf.local.home>
 <20201123152720.GA2177956@elver.google.com>
 <20201123112812.19e918b3@gandalf.local.home>
 <20201123134227.6df443db@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123134227.6df443db@gandalf.local.home>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Steven,

On Mon, Nov 23, 2020 at 01:42:27PM -0500, Steven Rostedt wrote:
> On Mon, 23 Nov 2020 11:28:12 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I noticed:
> > 
> > 
> > [  237.650900] enabling event benchmark_event
> > 
> > In both traces. Could you disable CONFIG_TRACEPOINT_BENCHMARK and see if
> > the issue goes away. That event kicks off a thread that spins in a tight
> > loop for some time and could possibly cause some issues.
> > 
> > It still shouldn't break things, we can narrow it down if it is the culprit.
> 
> [ Added Thomas  ]
> 
> And that's just one issue. I don't think that has anything to do with the
> other one:
> 
> [ 1614.162007] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [ 1614.168625]  (detected by 0, t=3752 jiffies, g=3529, q=1)
> [ 1614.170825] rcu: All QSes seen, last rcu_preempt kthread activity 242 (4295293115-4295292873), jiffies_till_next_fqs=1, root ->qsmask 0x0
> [ 1614.194272] 
> [ 1614.196673] ================================
> [ 1614.199738] WARNING: inconsistent lock state
> [ 1614.203056] 5.10.0-rc4-next-20201119-00004-g77838ee21ff6-dirty #21 Not tainted
> [ 1614.207012] --------------------------------
> [ 1614.210125] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [ 1614.213832] swapper/0/1 [HC0[0]:SC0[0]:HE0:SE1] takes:
> [ 1614.217288] ffffd942547f47d8 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x7c0/0x17a0
> [ 1614.225496] {IN-HARDIRQ-W} state was registered at:
> [ 1614.229031]   __lock_acquire+0xae8/0x1ac8
> [ 1614.232203]   lock_acquire+0x268/0x508
> [ 1614.235254]   _raw_spin_lock_irqsave+0x78/0x14c
> [ 1614.238547]   rcu_sched_clock_irq+0x7c0/0x17a0
> [ 1614.241757]   update_process_times+0x6c/0xb8
> [ 1614.244950]   tick_sched_handle.isra.0+0x58/0x88
> [ 1614.248225]   tick_sched_timer+0x68/0xe0
> [ 1614.251304]   __hrtimer_run_queues+0x288/0x730
> [ 1614.254516]   hrtimer_interrupt+0x114/0x288
> [ 1614.257650]   arch_timer_handler_virt+0x50/0x70
> [ 1614.260922]   handle_percpu_devid_irq+0x104/0x4c0
> [ 1614.264236]   generic_handle_irq+0x54/0x78
> [ 1614.267385]   __handle_domain_irq+0xac/0x130
> [ 1614.270585]   gic_handle_irq+0x70/0x108
> [ 1614.273633]   el1_irq+0xc0/0x180
> [ 1614.276526]   rcu_irq_exit_irqson+0x40/0x78
> [ 1614.279704]   trace_preempt_on+0x144/0x1a0
> [ 1614.282834]   preempt_schedule_common+0xf8/0x1a8
> [ 1614.286126]   preempt_schedule+0x38/0x40
> [ 1614.289240]   __mutex_lock+0x608/0x8e8
> [ 1614.292302]   mutex_lock_nested+0x3c/0x58
> [ 1614.295450]   static_key_enable_cpuslocked+0x7c/0xf8
> [ 1614.298828]   static_key_enable+0x2c/0x40
> [ 1614.301961]   tracepoint_probe_register_prio+0x284/0x3a0
> [ 1614.305464]   tracepoint_probe_register+0x40/0x58
> [ 1614.308776]   trace_event_reg+0xe8/0x150
> [ 1614.311852]   __ftrace_event_enable_disable+0x2e8/0x608
> [ 1614.315351]   __ftrace_set_clr_event_nolock+0x160/0x1d8
> [ 1614.318809]   __ftrace_set_clr_event+0x60/0x90
> [ 1614.322061]   event_trace_self_tests+0x64/0x12c
> [ 1614.325335]   event_trace_self_tests_init+0x88/0xa8
> [ 1614.328758]   do_one_initcall+0xa4/0x500
> [ 1614.331860]   kernel_init_freeable+0x344/0x3c4
> [ 1614.335110]   kernel_init+0x20/0x16c
> [ 1614.338102]   ret_from_fork+0x10/0x34
> [ 1614.341057] irq event stamp: 3206302
> [ 1614.344123] hardirqs last  enabled at (3206301): [<ffffd9425238da04>] rcu_irq_exit_irqson+0x64/0x78
> [ 1614.348697] hardirqs last disabled at (3206302): [<ffffd942522123c0>] el1_irq+0x80/0x180
> [ 1614.353013] softirqs last  enabled at (3204216): [<ffffd94252210b80>] __do_softirq+0x630/0x6b4
> [ 1614.357509] softirqs last disabled at (3204191): [<ffffd942522c623c>] irq_exit+0x1cc/0x1e0
> [ 1614.361737] 
> [ 1614.361737] other info that might help us debug this:
> [ 1614.365566]  Possible unsafe locking scenario:
> [ 1614.365566] 
> [ 1614.369128]        CPU0
> [ 1614.371747]        ----
> [ 1614.374282]   lock(rcu_node_0);
> [ 1614.378818]   <Interrupt>
> [ 1614.381394]     lock(rcu_node_0);
> [ 1614.385997] 
> [ 1614.385997]  *** DEADLOCK ***
> [ 1614.385997] 
> [ 1614.389613] 5 locks held by swapper/0/1:
> [ 1614.392655]  #0: ffffd9425480e940 (event_mutex){+.+.}-{3:3}, at: __ftrace_set_clr_event+0x48/0x90
> [ 1614.401701]  #1: ffffd9425480a530 (tracepoints_mutex){+.+.}-{3:3}, at: tracepoint_probe_register_prio+0x48/0x3a0
> [ 1614.410973]  #2: ffffd9425476abf0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x24/0x40
> [ 1614.419858]  #3: ffffd94254816348 (jump_label_mutex){+.+.}-{3:3}, at: static_key_enable_cpuslocked+0x7c/0xf8
> [ 1614.429049]  #4: ffffd942547f47d8 (rcu_node_0){?.-.}-{2:2}, at: rcu_sched_clock_irq+0x7c0/0x17a0
> [ 1614.438029] 
> [ 1614.438029] stack backtrace:
> [ 1614.441436] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc4-next-20201119-00004-g77838ee21ff6-dirty #21
> [ 1614.446149] Hardware name: linux,dummy-virt (DT)
> [ 1614.449621] Call trace:
> [ 1614.452337]  dump_backtrace+0x0/0x240
> [ 1614.455372]  show_stack+0x34/0x88
> [ 1614.458306]  dump_stack+0x140/0x1bc
> [ 1614.461258]  print_usage_bug+0x2a0/0x2f0
> [ 1614.464399]  mark_lock.part.0+0x438/0x4e8
> [ 1614.467528]  mark_held_locks+0x54/0x90
> [ 1614.470576]  lockdep_hardirqs_on_prepare+0xe0/0x290
> [ 1614.473935]  trace_hardirqs_on+0x90/0x370
> [ 1614.477045]  el1_irq+0xdc/0x180
> [ 1614.479934]  rcu_irq_exit_irqson+0x40/0x78
> [ 1614.483093]  trace_preempt_on+0x144/0x1a0
> [ 1614.486211]  preempt_schedule_common+0xf8/0x1a8
> [ 1614.489479]  preempt_schedule+0x38/0x40
> [ 1614.492544]  __mutex_lock+0x608/0x8e8
> 
> 
> The above has:
> 
>  preempt_schedule_common() {
>    trace_preempt_on() {
>      <interrupt>
> 	el1_irq:
> 	   handle_arch_irq {
> 	      irq_enter();
> 	      [..]
> 	      irq_exit();
> 	   }
> 	   bl trace_hardirqs_on
> 
> 
> I wonder if the lockdep logic got confused on ARM64 by the rework done to
> lockdep and tracing with respect to irq entry / exit.
> 

I'm also staring at this problem and another thing caused my attention
is that there is a line like the following after the lockdep splat:

[...] BUG: scheduling while atomic ...

, which means preemption count has some inconsistency too.

Given this, a possible case cause this is that we got preempted inside a
rcu_node lock critical section (I know, this is quite impossible, but
preemption count and lockdep data are maintained quite separately, so
it's unlikely they are broken at the same time...)

Will continue to look into this.

Regards,
Boqun

> Or maybe there's an rcu_node leak lock that happened somewhere?
> 
> -- Steve
