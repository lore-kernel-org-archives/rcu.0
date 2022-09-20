Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA7EECAAD8
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 07:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiITH0j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiITH0i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 03:26:38 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB959263
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 00:26:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p18so1513662plr.8
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 00:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=p2rNR4Kj1hpBCMiW7AS+lBqxR2mV7zkNpZ/5tL3N5Co=;
        b=RsG/mzPlfK5FNvLNNdCCD8sXT2oak3XOFl2eJshIfDZqPwVTz0uxZ4ip0/9irEM2xD
         iPIeOKSYk6j1IdLtUKrSjGtbda+UyqzWBYkoL6vNls/biq0fmk4tKsLMnpwG/HWyi1T7
         i/3yOp0jlS0bUolRmrDt13YLUIf/fDcMkqqinf6TYNuAuCSeGOP0nmvg4mpcv5FEI95e
         FVvlwREKaBZq7SiUKh0ZLqa0zsyxu7C+x7dpViLWceGXPJj8JwXTPydBYLyx0wCboQVw
         aT3wRCgJ9CeN8duD97ESrrRBOdBYOoyfSGeW4nKRNY8w/M638HyPxb43F742xNSenh8u
         HQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=p2rNR4Kj1hpBCMiW7AS+lBqxR2mV7zkNpZ/5tL3N5Co=;
        b=TwG3ODjTUFR0eLmuyKAe+cz2bJeBhHo8CUPetTYtp7aItb6RNHj0Afl36LkeW1gG9r
         Gl9f1NXK2GANKTOZ32eeLPJs6Q+d1dgXXGQoEwnw6jVnNQU8Shd6exzj8+8EKEhUkicj
         Egs+LSgHY9jwxKebR7UjAAbthZ2iwrrXx42w7pXi6+gTdU7MrkBZTE5ToT5BLIuYmw7J
         475EopG12eU2uTuomXVcId8cCWIQJWjEmi0xcT06SM/WCSn5xqg40M2rhafsZRKlmMwA
         opkSul07DbkXxpsU+KeUqgxgi6+QLMv2KSU52nZHzygejIO7Vqp3Kzcd8QsstoMYqrCH
         fX8g==
X-Gm-Message-State: ACrzQf3f7AOVPC0DLys4N79wC3jTwrFupz2q2mFwSXb5kBMFsgLZdJTH
        GNRtnRBvwgD7zfzuTn8EIg==
X-Google-Smtp-Source: AMsMyM7F+O5eMo3gYf6+ARiHYk06Y1GOh0mbjbqsgn06V8736roGAtCB44gVf+dgtht3ATEVRoLyEA==
X-Received: by 2002:a17:90b:3a85:b0:203:214d:4288 with SMTP id om5-20020a17090b3a8500b00203214d4288mr2344071pjb.183.1663658796178;
        Tue, 20 Sep 2022 00:26:36 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z4-20020aa79904000000b0053e9d14e51asm793731pff.98.2022.09.20.00.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 00:26:35 -0700 (PDT)
Date:   Tue, 20 Sep 2022 15:26:28 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
References: <20220915055825.21525-1-kernelfans@gmail.com>
 <20220915055825.21525-4-kernelfans@gmail.com>
 <20220916134258.GB25891@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916134258.GB25891@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 16, 2022 at 03:42:58PM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 15, 2022 at 01:58:25PM +0800, Pingfan Liu wrote:
> > As Paul pointed out  "The tick_dep_clear() is SMP-safe because it uses
> > atomic operations, but the problem is that if there are multiple
> > nohz_full CPUs going offline concurrently, the first CPU to invoke
> > rcutree_dead_cpu() will turn the tick off.  This might require an
> > atomically manipulated counter to mediate the calls to
> > rcutree_dead_cpu(). "
> > 
> > This patch introduces a new member ->dying to rcu_node, which reflects
> > the number of concurrent offlining cpu. TICK_DEP_BIT_RCU is set by
> > the first entrance and cleared by the last.
> > 
> > Note: now, tick_dep_set() is put under the rnp->lock, but since it takes
> > no lock, no extra locking order is introduced.
> > 
> > Suggested-by: "Paul E. McKenney" <paulmck@kernel.org>
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: David Woodhouse <dwmw@amazon.co.uk>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > To: rcu@vger.kernel.org
> > ---
> >  kernel/rcu/tree.c | 19 ++++++++++++++-----
> >  kernel/rcu/tree.h |  1 +
> >  2 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8a829b64f5b2..f8bd0fc5fd2f 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2164,13 +2164,19 @@ int rcutree_dead_cpu(unsigned int cpu)
> >  {
> >  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >  	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > +	unsigned long flags;
> > +	u8 dying;
> >  
> >  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> >  		return 0;
> >  
> >  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> > -	// Stop-machine done, so allow nohz_full to disable tick.
> > -	tick_dep_clear(TICK_DEP_BIT_RCU);
> > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > +	dying = --rnp->dying;
> > +	if (!dying)
> > +		// Stop-machine done, so allow nohz_full to disable tick.
> > +		tick_dep_clear(TICK_DEP_BIT_RCU);
> > +	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> 
> Note this is only locking the rdp's node, not the root node.
> Therefore if CPU 0 and CPU 256 are going off at the same time and they
> don't belong to the same node, the above won't protect against concurrent
> TICK_DEP_BIT_RCU set/clear.
> 

Nice, thanks for the careful thoughts. How about moving the counting
place to the root node?

> My suspicion is that we don't need this TICK_DEP_BIT_RCU tick dependency
> anymore. I believe it was there because of issues that were fixed with:
> 
> 	53e87e3cdc15 (timers/nohz: Last resort update jiffies on nohz_full IRQ entry)
> and:
> 
> 	a1ff03cd6fb9 (tick: Detect and fix jiffies update stall)
> 
> It's unfortunately just suspicion because the reason for that tick dependency
> is unclear but I believe it should be safe to remove now.
> 

I have gone through this tick dependency again, but got less.

I think at least from the RCU's viewpoint, it is useless since
multi_cpu_stop()->rcu_momentary_dyntick_idle() has eliminate the
requirement for tick interrupt.


Is there a way to have a convincing test so that these code can be removed?
Or this code will be got along with?


Thanks,

	Pingfan
