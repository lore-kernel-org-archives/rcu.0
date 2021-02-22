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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43390C433DB
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 19:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA8064E27
	for <rcu@archiver.kernel.org>; Mon, 22 Feb 2021 19:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhBVTJC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhBVTHs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Feb 2021 14:07:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB16C061574;
        Mon, 22 Feb 2021 11:07:07 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j19so7377363lfr.12;
        Mon, 22 Feb 2021 11:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O6GIyyoTrO4dQ+CLo8l+0ODsKrayFvT21sFlP6VM+Ow=;
        b=GKIiSC9+xR2v8RwrUGMH1HxMmpqevlrFj6JU1WtB0+3fV4i9qY9QuCT88QlJU3pHYp
         ngr5fJMAFpj7EEazdS6IoExvI6nmjdp4DnqdpVlzeOm4xtEQpAtLx2zzHi5lNk75O1pa
         L3lFMg75sBPnhI0LAm2i2K4j+mGKHS/BwTLwgTn8/rMe8Bry5P2K/d5YfDuzFBLwmQZO
         JX8+W7i8E3aM4rzjoKtpPsbVhyQ6McXOp8oD2zlZYjfoS11xriSuE6vS95VHnx26SvFn
         LWc0eX2gxIrs1WW6HLeqEy0zXh0+a7+pN0K4NDOGWA3BQbqpTS5qymIpIWdwiZEDsuEq
         ytAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O6GIyyoTrO4dQ+CLo8l+0ODsKrayFvT21sFlP6VM+Ow=;
        b=sTZbiyNeFy2R/e+utuejiWbiVHkxHCq5Sf+p0ItAhGg9XJI8FhJ82+HOChObvlv4QK
         Bx8jfA5iEpLtPB4RX3QqgnN0PvBdxGNMZ352CTdUPmRMXRW9tzugiBRRhRKdY6DjTS7h
         YTokYZrqM07sZJqRZtWkx8DyAVUcxZFgPN/qa4QvPjqeskM8up/Tk1MB6XAYjiBIfBQQ
         HW+1IREpha6JcCKjvA6eqxmmmlU89x1N/eAWj2GTcGgb6yrBQmzToidp8kRRPSIDnos3
         YdS7cVkpXYWgXD5DxwhKsytL8yXZbgUlm9wvxEsEsOMR9AKrFm/B0aAo7MuslH5Wez5V
         0l+w==
X-Gm-Message-State: AOAM533Uf1motMQ5fcZdrKMCyhRjvKtV2f7B3tHh7i8WslNINKkYPqUP
        ZljdXJAhw5o3XJp3KmEf5Lk=
X-Google-Smtp-Source: ABdhPJwprln/0QJQjiEmse61T0OMSwWIRgMXxIAwrDlDqwPXUhVen++cqWMM8FQmYSIUVFiDsPDvig==
X-Received: by 2002:a19:7d1:: with SMTP id 200mr14404599lfh.110.1614020826373;
        Mon, 22 Feb 2021 11:07:06 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c6sm2062614lfb.204.2021.02.22.11.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 11:07:05 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 22 Feb 2021 20:07:03 +0100
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
Message-ID: <20210222190703.GA19167@pc638.lan>
References: <20210219111738.go6i2fdzvavpotxd@linutronix.de>
 <20210219112357.GA34462@pc638.lan>
 <20210219112751.GA34528@pc638.lan>
 <20210219181811.GY2743@paulmck-ThinkPad-P72>
 <20210219183336.GA23049@paulmck-ThinkPad-P72>
 <20210222102104.v3pr7t57hmpwijpi@linutronix.de>
 <20210222125431.GA41939@pc638.lan>
 <20210222150903.GH2743@paulmck-ThinkPad-P72>
 <20210222171605.GA42169@pc638.lan>
 <20210222181608.GK2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222181608.GK2743@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Feb 22, 2021 at 10:16:08AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 22, 2021 at 06:16:05PM +0100, Uladzislau Rezki wrote:
> > On Mon, Feb 22, 2021 at 07:09:03AM -0800, Paul E. McKenney wrote:
> > > On Mon, Feb 22, 2021 at 01:54:31PM +0100, Uladzislau Rezki wrote:
> > > > On Mon, Feb 22, 2021 at 11:21:04AM +0100, Sebastian Andrzej Siewior wrote:
> > > > > On 2021-02-19 10:33:36 [-0800], Paul E. McKenney wrote:
> > > > > > For definiteness, here is the first part of the change, posted earlier.
> > > > > > The commit log needs to be updated.  I will post the change that keeps
> > > > > > the tick going as a reply to this email.
> > > > > …
> > > > > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > > > > index 9d71046..ba78e63 100644
> > > > > > --- a/kernel/softirq.c
> > > > > > +++ b/kernel/softirq.c
> > > > > > @@ -209,7 +209,7 @@ static inline void invoke_softirq(void)
> > > > > >  	if (ksoftirqd_running(local_softirq_pending()))
> > > > > >  		return;
> > > > > >  
> > > > > > -	if (!force_irqthreads) {
> > > > > > +	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
> > > > > >  #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
> > > > > >  		/*
> > > > > >  		 * We can safely execute softirq on the current stack if
> > > > > > @@ -358,8 +358,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> > > > > >  
> > > > > >  	pending = local_softirq_pending();
> > > > > >  	if (pending) {
> > > > > > -		if (time_before(jiffies, end) && !need_resched() &&
> > > > > > -		    --max_restart)
> > > > > > +		if (!__this_cpu_read(ksoftirqd) ||
> > > > > > +		    (time_before(jiffies, end) && !need_resched() && --max_restart))
> > > > > >  			goto restart;
> > > > > 
> > > > > This is hunk shouldn't be needed. The reason for it is probably that the
> > > > > following wakeup_softirqd() would avoid further invoke_softirq()
> > > > > performing the actual softirq work. It would leave early due to
> > > > > ksoftirqd_running(). Unless I'm wrong, any raise_softirq() invocation
> > > > > outside of an interrupt would do the same. 
> > > 
> > > And it does pass the rcutorture test without that hunk:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --bootargs "threadirqs=1" --trust-make
> > > 
> > Yep. I have tested that patch also. It works for me as well. So
> > technically i do not see any issues from the first glance but of
> > course it should be reviewed by the softirq people to hear their
> > opinion.
> > 
> > IRQs are enabled, so it can be handled from an IRQ tail until
> > ksoftirqd threads are spawned.
> 
> And if I add "CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" it still works,
> even if I revert my changes to rcu_needs_cpu().  Should I rely on this
> working globally?  ;-)
> 
There might be corner cases which we are not aware of so far. From the
other hand what the patch does is simulating the !threadirqs behaviour
during early boot. In that case we know that handling of SW irqs from
real-irq tail works :)

--
Vlad Rezki
