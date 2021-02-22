Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B949C433DB
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 17:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6BF664DE9
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 17:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhBVRQw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBVRQu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 12:16:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18128C06174A;
        Mon, 22 Feb 2021 09:16:10 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p21so6832402lfu.11;
        Mon, 22 Feb 2021 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AqJmvskH+CThkf4DuZDtgowUXGgt9vrGudKQ1R2/zLA=;
        b=Pur0JfFbtvOVXt3dye576Re6cYZHWWFVigbUbgquTdA6MzGEcL6s+JotR37+/OS1jM
         HSBLbqoC9Bh9VxExrk0qgpHcpPrcQjxGsiK0K7lZSE/vtyuYkXWkUtkDI6QdrmZrYkm8
         eKSTFZJrbMZeaQiYJ3v6bDXGrnulBrmLE0MtTKcGMCeSxMrSKOV2NM1og7xhCQjRnNH8
         UAeBMDvuF8ODICVBs/PDDDhXlhhT7T+4TpWkV/e6QnBezMDurd6fdkPEMZNDDmbj8Zfo
         zxN9jLNfN2o2qk4eQF58G1oxJZBFQZ5JJ765d2JOF+/NUUp4/bKu0Ohoya1y/ImD7Sy1
         84/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AqJmvskH+CThkf4DuZDtgowUXGgt9vrGudKQ1R2/zLA=;
        b=SMSaU3DSdmYXcPUAW+DXGxBO8b+FU4OFKtDb5vUxWhAhaCWcoKxOCp3+X3ZANnVsKW
         QzfWggn1bjgPKBSBvvxCswixp76gQgTCFjGCokBPHuCpqzjMhJ3t//hk2XU6MANzpFkL
         zEMtPkO1/Wd6t7CZ/sFrJ/ac7V9bilxU2CsGzrQcOfq5hhK031uNW1cXPAJGqVQL9KBC
         R6IEO6BHxrFq4TUXxpmkfgjuD3qCQbz3q7rM5xZF4SebvQsCu7Z08Sn6S2ELRrmfWe6l
         e5i7Q1jHBODezhtiOaO5JqC9SISoF/rpzGcLJBO1mGgo+XHp+I7CWnlCWRThqF/BWD+d
         K0XQ==
X-Gm-Message-State: AOAM533Ob29FIHSqS5J5OUqsTD2bL6ER0bZN5/Fmw7qKyJLy49BF4/rX
        83lhKDDe93LLMckW5ZDyQMM=
X-Google-Smtp-Source: ABdhPJwwE6eDlU72KO6Rh+bACmoULHhxGAEPaY5IvCcwyXSooyeajFUe98fOpOTHMfcT/ECzOA6mDw==
X-Received: by 2002:ac2:4ad0:: with SMTP id m16mr12024255lfp.195.1614014168509;
        Mon, 22 Feb 2021 09:16:08 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c17sm2021711lfr.133.2021.02.22.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 09:16:08 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 22 Feb 2021 18:16:05 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210222171605.GA42169@pc638.lan>
References: <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219183336.GA23049@paulmck-ThinkPad-P72>
 <20210222102104.v3pr7t57hmpwijpi@linutronix.de>
 <20210222125431.GA41939@pc638.lan>
 <20210222150903.GH2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222150903.GH2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 22, 2021 at 07:09:03AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 22, 2021 at 01:54:31PM +0100, Uladzislau Rezki wrote:
> > On Mon, Feb 22, 2021 at 11:21:04AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2021-02-19 10:33:36 [-0800], Paul E. McKenney wrote:
> > > > For definiteness, here is the first part of the change, posted earlier.
> > > > The commit log needs to be updated.  I will post the change that keeps
> > > > the tick going as a reply to this email.
> > > …
> > > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > > index 9d71046..ba78e63 100644
> > > > --- a/kernel/softirq.c
> > > > +++ b/kernel/softirq.c
> > > > @@ -209,7 +209,7 @@ static inline void invoke_softirq(void)
> > > >  	if (ksoftirqd_running(local_softirq_pending()))
> > > >  		return;
> > > >  
> > > > -	if (!force_irqthreads) {
> > > > +	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
> > > >  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
> > > >  		/*
> > > >  		 * We can safely execute softirq on the current stack if
> > > > @@ -358,8 +358,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> > > >  
> > > >  	pending = local_softirq_pending();
> > > >  	if (pending) {
> > > > -		if (time_before(jiffies, end) && !need_resched() &&
> > > > -		    --max_restart)
> > > > +		if (!__this_cpu_read(ksoftirqd) ||
> > > > +		    (time_before(jiffies, end) && !need_resched() && --max_restart))
> > > >  			goto restart;
> > > 
> > > This is hunk shouldn't be needed. The reason for it is probably that the
> > > following wakeup_softirqd() would avoid further invoke_softirq()
> > > performing the actual softirq work. It would leave early due to
> > > ksoftirqd_running(). Unless I'm wrong, any raise_softirq() invocation
> > > outside of an interrupt would do the same. 
> 
> And it does pass the rcutorture test without that hunk:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make
> 
Yep. I have tested that patch also. It works for me as well. So
technically i do not see any issues from the first glance but of
course it should be reviewed by the softirq people to hear their
opinion.

IRQs are enabled, so it can be handled from an IRQ tail until
ksoftirqd threads are spawned.

> > > I would like PeterZ / tglx to comment on this one. Basically I'm not
> > > sure if it is okay to expect softirqs beeing served and waited on that
> > > early in the boot.
> 
> It would be good to get other eyes on this.
> 
> I do agree that "don't wait on softirq handlers until after completion
> of all early_initcall() handlers" is a nice simple rule, but debugging
> violations of it is not so simple.  Adding warnings to ease debugging
> of violations of this rule is quite a bit more complex than is either of
> the methods of making the rule unnecessary, at least from what I can see
> at this point.  The complexity of the warnings is exactly what Sebastian
> pointed out earlier, that it is currently legal to raise_softirq() but
> not to wait on the resulting handlers.  But even waiting is OK if that
> waiting does not delay the boot sequence.  But if the boot kthread waits
> on the kthread that does the waiting, it is once again not OK.
> 
> So am I missing something subtle here?
>
I agree here. Seems like we are on the same page in understanding :)

> > The ksoftirqd threads get spawned during early_initcall() phase. Why not
> > just spawn them one step earlier what is totally safe? I mean before
> > do_pre_smp_initcalls() that calls early callbacks.
> > 
> > +       spawn_ksoftirqd();
> >         rcu_init_tasks_generic();
> >         do_pre_smp_initcalls();
> > 
> > With such change the spawning will not be depended on linker/compiler
> > i.e. when and in which order an early_initcall(spawn_ksoftirqd) callback
> > is executed.
> 
> We both posted patches similar to this, so I am not opposed.  One caveat,
> though, namely that this narrows the window quite a bit but does not
> entirely close it.  But it does allow the early_initcall()s to wait on
> softirq handlers.
> 
Yep, that was an intention. At least to provide such functionality for early
callbacks. What happens before it(init/main.c) is pretty controllable.

--
Vlad Rezki
