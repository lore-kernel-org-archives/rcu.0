Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F0C433E6
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFB464E77
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 12:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhBVM4Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 07:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhBVMzR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 07:55:17 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AFAC061574;
        Mon, 22 Feb 2021 04:54:35 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e8so18753077ljj.5;
        Mon, 22 Feb 2021 04:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RrBwkSa3eYYNnET70Vfs0NV0b1hJqOhmYz0UOGm6Kqs=;
        b=l8NnzxZGR39uGUNfhDbESNjcNQaO2QLkaE0TsJUBMFEwoPx3ytiFMySsTzOsR2i529
         U0kiwCnJthLjGP3vfKO6A/UvDYZQDzg3X0fY6CPThaQZ9pAJHVed/IGuzrHAFeOS/Ca7
         TTmtQ2pGp/0ej7IwuL99AJYo8b6SI7CD1HLQDOWjScWF2nNxeIpdc1s+i0J8VfU0MVb8
         PjXF6qBWfJk6l55QDYUUUidDEAiEUiZ36UYfkDcGmcEyMEAZkBe7ccbaHuIKxNEfJm62
         WU1QfDPCcbONCNyA3GMiU/ZxZNda7UzCUKB5maXi0mktrPssU7YwbUtcMB05PgrfFXX8
         rvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RrBwkSa3eYYNnET70Vfs0NV0b1hJqOhmYz0UOGm6Kqs=;
        b=kq6eXZkTrjWg04UK+3CpkV9X0vXXK4+uopPYlPbVIgULlY5yugcxAUE3s2f6DtlAqh
         uPe+KZAXPC/b+1xvvtmD3oyWqB4KifBDxk9Bnw7WbbKh8+1vh/HmDgCmlGTR4S21L50r
         CTmvUa7ZR3o1iwkSIK1G+8cujqm6xKSKkpbl0YghN9Nzu+sHCyr/GmfrI2TRKNqsYImb
         eyTfiXe1Wv90YPlPuHDsOnYDqbHAqDID9C2UKl6QqXcToMb93ZbFoSiB/YHlApk+XFcc
         WIfxbcxpZ0ERMncujxYM/5QVUYjCA5mOfhGAHQ/6rTaCZ0wgPu/hkKZMAkQwz+d8s365
         2Odw==
X-Gm-Message-State: AOAM530GQm2ohGGHcpczDL7Aw94TlmkK/Vfgtn1PvJcSkHfOnVsp6Aoq
        NOcT8a02HH+TywQx+VMGnQY=
X-Google-Smtp-Source: ABdhPJw8BgzQokAl13DgnFQMaFyhb1S5Z5Ir+bsZflClI7O4LfBTVuoAvwFvj2qPF3NEjQXET9NTug==
X-Received: by 2002:ac2:4acd:: with SMTP id m13mr7601383lfp.201.1613998474080;
        Mon, 22 Feb 2021 04:54:34 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id x24sm1928214lfu.206.2021.02.22.04.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 04:54:33 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 22 Feb 2021 13:54:31 +0100
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20210222125431.GA41939@pc638.lan>
References: <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
 <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219183336.GA23049@paulmck-ThinkPad-P72>
 <20210222102104.v3pr7t57hmpwijpi@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222102104.v3pr7t57hmpwijpi@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 22, 2021 at 11:21:04AM +0100, Sebastian Andrzej Siewior wrote:
> On 2021-02-19 10:33:36 [-0800], Paul E. McKenney wrote:
> > For definiteness, here is the first part of the change, posted earlier.
> > The commit log needs to be updated.  I will post the change that keeps
> > the tick going as a reply to this email.
> …
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 9d71046..ba78e63 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -209,7 +209,7 @@ static inline void invoke_softirq(void)
> >  	if (ksoftirqd_running(local_softirq_pending()))
> >  		return;
> >  
> > -	if (!force_irqthreads) {
> > +	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
> >  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
> >  		/*
> >  		 * We can safely execute softirq on the current stack if
> > @@ -358,8 +358,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> >  
> >  	pending = local_softirq_pending();
> >  	if (pending) {
> > -		if (time_before(jiffies, end) && !need_resched() &&
> > -		    --max_restart)
> > +		if (!__this_cpu_read(ksoftirqd) ||
> > +		    (time_before(jiffies, end) && !need_resched() && --max_restart))
> >  			goto restart;
> 
> This is hunk shouldn't be needed. The reason for it is probably that the
> following wakeup_softirqd() would avoid further invoke_softirq()
> performing the actual softirq work. It would leave early due to
> ksoftirqd_running(). Unless I'm wrong, any raise_softirq() invocation
> outside of an interrupt would do the same. 
> 
> I would like PeterZ / tglx to comment on this one. Basically I'm not
> sure if it is okay to expect softirqs beeing served and waited on that
> early in the boot.
> 
The ksoftirqd threads get spawned during early_initcall() phase. Why not
just spawn them one step earlier what is totally safe? I mean before
do_pre_smp_initcalls() that calls early callbacks.

+       spawn_ksoftirqd();
        rcu_init_tasks_generic();
        do_pre_smp_initcalls();

With such change the spawning will not be depended on linker/compiler
i.e. when and in which order an early_initcall(spawn_ksoftirqd) callback
is executed.

--
Vlad Rezki
