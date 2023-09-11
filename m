Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2013C71153
	for <rcu@archiver.kernel.org>; Mon, 11 Sep 2023 02:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjIKC1p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 22:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIKC1n (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 22:27:43 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDC11B8
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 19:27:27 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7b8d2631fdso3672476276.3
        for <rcu@vger.kernel.org>; Sun, 10 Sep 2023 19:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694399247; x=1695004047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OS4aBFYQ7MEw0pbsliSk0BILACg5LyQ1YIp0lwZOJOY=;
        b=wiOKuqBdk6Kgi2AZ4u6oxBYahpOk+evSu+8BXFEqjfHcZc+/qMPmOC9x/tJHqzgjLz
         SKYxLP/ZR0xP6fH4A0maiYTEb6zRN+ruWvQg9c8hP1G+CmaKnniwN+YoCcDizQT+YKh9
         hkppui0eh4LEHugjoRNco6UE4Ds/Fqr6Vb9L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694399247; x=1695004047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OS4aBFYQ7MEw0pbsliSk0BILACg5LyQ1YIp0lwZOJOY=;
        b=kDxBczjc+Y0yK7LMAQkOHxSPj6kLQC1DwAAJfqFVpzWFfriTHunkCOoUARg2Spbe75
         FpFJE+57SoIe4cGjB776FYpmou4vs2KCOV246ROZGIwPddDbXgb/Eno4J/rPjbHc59B2
         ooC1jcL2q04i9PAYPQhljctYpFu1GbaWHCc3ckyRFxdtKJScWzprw8CYUnDTh8FaYDOd
         TJhGwvRMtMlxfFoOm2c5sHhBboXreLBPvm81hOHq9nyAPuV8A8YMJIZxr97wpxNO7eub
         hcLk3rAktlmcG04azNXjNMI/W7ayiP1mDr5tarNIlWFoeg2fUaMEGKW28+31BzfqWOU3
         IZuQ==
X-Gm-Message-State: AOJu0Yw8c/5CmxTqzR5wDfflgMRaAcU1ebQ6S4efPmsOXCBvsi/wJLax
        JJLKcPYazEitmliBUSy1qo4dGPAULMAioduh9KE=
X-Google-Smtp-Source: AGHT+IGk6PBf/2oUoZqnEK5Btejaos7zKdStuRNgIjRXn/+XaTD2CternbJqxjnniBEWts0h9tDHIQ==
X-Received: by 2002:a25:928e:0:b0:d80:83b1:2298 with SMTP id y14-20020a25928e000000b00d8083b12298mr2909240ybl.48.1694399246801;
        Sun, 10 Sep 2023 19:27:26 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id y22-20020a02ce96000000b0042b61a5087csm1842170jaq.132.2023.09.10.19.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 19:27:26 -0700 (PDT)
Date:   Mon, 11 Sep 2023 02:27:25 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <20230911022725.GA2542634@google.com>
References: <20230910201445.GA1605059@google.com>
 <a2518e2d-14ba-4965-8775-f6f3054b7522@paulmck-laptop>
 <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YRMQx8AGoshpW6xLGsmN4fZ34T3Xy5H1-iN8p2Ho5-jEg@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Sep 10, 2023 at 07:37:13PM -0400, Joel Fernandes wrote:
> On Sun, Sep 10, 2023 at 5:16 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Sep 10, 2023 at 08:14:45PM +0000, Joel Fernandes wrote:
> [...]
> > > >  I have been running into another intermittent one as well which
> > > > is the boost failure and that happens once in 10-15 runs or so.
> > > >
> > > > I was thinking of running the following configuration on an automated
> > > > regular basis to at least provide a better clue on the lucky run that
> > > > catches an issue. But then the issue is it would change timing enough
> > > > to maybe hide bugs. I could also make it submit logs automatically to
> > > > the list on such occurrences, but one step at a time and all that.  I
> > > > do need to add (hopefully less noisy) tick/timer related trace events.
> > > >
> > > > # Define the bootargs array
> > > > bootargs=(
> > > >     "ftrace_dump_on_oops"
> > > >     "panic_on_warn=1"
> > > >     "sysctl.kernel.panic_on_rcu_stall=1"
> > > >     "sysctl.kernel.max_rcu_stall_to_panic=1"
> > > >     "trace_buf_size=10K"
> > > >     "traceoff_on_warning=1"
> > > >     "panic_print=0x1f"      # To dump held locks, mem and other info.
> > > > )
> > > > # Define the trace events array passed to bootargs.
> > > > trace_events=(
> > > >     "sched:sched_switch"
> > > >     "sched:sched_waking"
> > > >     "rcu:rcu_callback"
> > > >     "rcu:rcu_fqs"
> > > >     "rcu:rcu_quiescent_state_report"
> > > >     "rcu:rcu_grace_period"
> > > > )
> > >
> > > So some insight on this boost failure. Just before the boost failures are
> > > reported, I see the migration thread interferring with the rcu_preempt thread
> > > (aka GP kthread). See trace below. Of note is that the rcu_preempt thread is
> > > runnable while context switching, which means its execution is interferred.
> > > The rcu_preempt thread is at RT prio 2 as can be seen.
> > >
> > > So some open-ended questions: what exactly does the migration thread want,
> > > this is something related to CPU hotplug? And if the migration thread had to
> > > run, why did the rcu_preempt thread not get pushed to another CPU by the
> > > scheduler? We have 16 vCPUs for this test.
> >
> > Maybe we need a cpus_read_lock() before doing a given boost-test interval
> > and a cpus_read_unlock() after finishing one?  But much depends on
> > exactly what is starting those migration threads.
> 
> But in the field, a real RT task can preempt a reader without doing
> cpus_read_lock() and may run into a similar boost issue?
> 
> > Then again, TREE03 is pretty aggressive about doing CPU hotplug.
> 
> Ok. I put a trace_printk() in the stopper thread to see what the
> ->fn() is. I'm doing another run to see what falls out.

I think I am getting somewhere, It looks like the migration thread tries to
push the task out due to __balance_push_cpu_stop. Clearly it fails because
the rcu_preempt task is still on CPU 3. And the whole thing is live locked
retrying the same.

I am not sure if the migration thread is trying to migrate rcu_preempt
because the CPU is going down or because a higher priority RT task is
running.

rcu_pree-13        3d..4. 2936723336us : sched_waking: comm=migration/3 pid=34 prio=0 target_cpu=003
rcu_pree-13        3d..2. 2936723338us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/3 next_pid=34 next_prio=0
migratio-34        3..... 2936723341us : cpu_stopper_thread: cpu_stop: caller=balance_push+0xc9/0x150 fn=__balance_push_cpu_stop+0x0/0x1c0 on cpu 3
migratio-34        3d..2. 2936723345us : sched_switch: prev_comm=migration/3 prev_pid=34 prev_prio=0 prev_state=S ==> next_comm=swapper/3 next_pid=0 next_prio=120
<idle>-0         3d..2. 2936723676us : sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcu_preempt next_pid=13 next_prio=97
rcu_pree-13        3d..4. 2936723678us : sched_waking: comm=migration/3 pid=34 prio=0 target_cpu=003
rcu_pree-13        3d..2. 2936723680us : sched_switch: prev_comm=rcu_preempt prev_pid=13 prev_prio=97 prev_state=R ==> next_comm=migration/3 next_pid=34 next_prio=0
migratio-34        3..... 2936723683us : cpu_stopper_thread: cpu_stop: caller=balance_push+0xc9/0x150 fn=__balance_push_cpu_stop+0x0/0x1c0 on cpu 3

I am digging deeper to see why the rcu_preempt thread cannot be pushed out
and then I'll also look at why is it being pushed out in the first place.

At least I have a strong repro now running 5 instances of TREE03 in parallel
for several hours.

thanks,

 - Joel

