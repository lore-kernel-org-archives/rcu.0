Return-Path: <SRS0=HCMS=WM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4E8C3A589
	for <rcu@archiver.kernel.org>; Fri, 16 Aug 2019 00:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330C12086C
	for <rcu@archiver.kernel.org>; Fri, 16 Aug 2019 00:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="awKTJsFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfHPACU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:02:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34913 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfHPACU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Aug 2019 20:02:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id d85so2162231pfd.2
        for <rcu@vger.kernel.org>; Thu, 15 Aug 2019 17:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bBMO+81b+9FqbnypyztdBrioxofnj72xFOfPW1A0L4M=;
        b=awKTJsFIk4r/ROTIGzOjLkvhueBvIJr27EXtiZYutXqjH0+7j/l+3hT1i/TWM5ptu7
         fOkqmOjHvk2wCwGUBCl4ZX+sbBgqQIK2Ozye6iO7RnWJarcZ8JpuLUsEjmpHt5lbck/j
         kFFZXt/Ky6OO1an6EjvINW4JjK2OiPzqQUEqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bBMO+81b+9FqbnypyztdBrioxofnj72xFOfPW1A0L4M=;
        b=e37z2iCTLQ+nfFdZaKiVHwOM/dyvZ21GJdUtAMyEn6ClxlBOFvT1M2OEdGSfSf2eF+
         UFiuNSX+t4k4ZjFdayZZPbtAQ9wrRby4kfKhBk9g+gecPoJZaBs+e2wSTSg4OG5NVWFh
         JaFdqqHM2FW0n/Qmdu1IbNuFAva6IysXNFk8TteymlmWAbDZfGqgzmv0KP5eOGPRwFcz
         PhiyP62+p/zLLUoCaEnk3JpmCCc+lTPz2MfvfCUH0+WY4EOvFZ8gom0gg2USiZE/Pvq9
         CasYT6aRHg+f7HaO4PY2+tR3mOm1PCHamgY+0g67VSPb/1kaReKR90oW1JauZnll69Wb
         NV4w==
X-Gm-Message-State: APjAAAUZxc08huzsU7LjCx1zaUvWs9gIrr4NMBUlFv8OUaDWo18kI10q
        y+ncb/iotrv9zPyhuNfxFfUBxg==
X-Google-Smtp-Source: APXvYqyEO0qasvzudUDiB8xMlvl9LOmKD81rA/XDNjXZWwGNbgksxvJ2qS04IsA48oRkKelK/v5NOQ==
X-Received: by 2002:a65:4205:: with SMTP id c5mr5335831pgq.265.1565913739568;
        Thu, 15 Aug 2019 17:02:19 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id x2sm2987789pja.22.2019.08.15.17.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 17:02:18 -0700 (PDT)
Date:   Thu, 15 Aug 2019 20:02:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190816000201.GC225926@google.com>
References: <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190815171714.GA1023@linux.ibm.com>
 <20190815200432.GB23194@google.com>
 <20190815203107.GL28441@linux.ibm.com>
 <20190815212216.GA224191@google.com>
 <20190815214542.GM28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815214542.GM28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 15, 2019 at 02:45:42PM -0700, Paul E. McKenney wrote:
> On Thu, Aug 15, 2019 at 05:22:16PM -0400, Joel Fernandes wrote:
> > On Thu, Aug 15, 2019 at 01:31:07PM -0700, Paul E. McKenney wrote:
> > > On Thu, Aug 15, 2019 at 04:04:32PM -0400, Joel Fernandes wrote:
> > > > On Thu, Aug 15, 2019 at 10:17:14AM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> > > > > > On Mon, Aug 12, 2019 at 04:01:38PM -0700, Paul E. McKenney wrote:
> > > > > 
> > > > > [ . . . ]
> > > > > 
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index 8c494a692728..ad906d6a74fb 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> > > > > > >  	 */
> > > > > > >  	if (rdp->dynticks_nmi_nesting != 1) {
> > > > > > >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > > > > > > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > > > > > > +		    rdp->dynticks_nmi_nesting == 2 &&
> > > > > > > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > > > > > > +			rdp->rcu_forced_tick = true;
> > > > > > > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > > > > > > +		}
> > > > > > 
> > > > > > 
> > > > > > Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> > > > > > we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> > > > > > rcu_nmi_enter_common() ? We could add this code there, under the "if
> > > > > > (rcu_dynticks_curr_cpu_in_eqs())".
> > > > > 
> > > > > This would need to go in an "else" clause, correct?  But there would still
> > > > > want to be a check for interrupt from base level (which would admittedly
> > > > > be an equality comparison with zero) and we would also still need to check
> > > > > for rdp->rcu_urgent_qs && !rdp->rcu_forced_tick.
> > > > 
> > > > True, agreed. I replied to this before saying it should be
> > > > !rcu_dynticks_curr_cpu_in_eqs() in the "if" ;) But it seems I could also be
> > > > missing the check for TICK_DEP_MASK_RCU in my tree so I think we need this as
> > > > well which is below as diff. Testing it more now!
> > > > 
> > > > And, with this I do get many more ticks during the test. But there are
> > > > intervals where the tick is not seen. Still it is much better than before:
> > > > 
> > > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > > index be9707f68024..e697c7a2ce67 100644
> > > > --- a/kernel/time/tick-sched.c
> > > > +++ b/kernel/time/tick-sched.c
> > > > @@ -198,6 +198,10 @@ static bool check_tick_dependency(atomic_t *dep)
> > > >  		return true;
> > > >  	}
> > > >  
> > > > +	if (val & TICK_DEP_MASK_CLOCK_RCU) {
> > > > +		return true;
> > > > +	}
> > > > +
> > > >  	return false;
> > > >  }
> > > 
> > > That one is not in my tree, either.  Frederic, should I add this to
> > > your patch?  For that matter, may I add your Signed-off-by as well?
> > > Your original is in my -rcu tree at:
> > > 
> > > 0cb41806c799 ("EXP nohz: Add TICK_DEP_BIT_RCU")
> > > 
> > > I am testing Joel's suggested addition now.
> > 
> > Actually there's more addition needed! I found another thing missing:
> > 
> > There's a per-cpu &tick_dep_mask and a per-cpu ts->tick_dep_mask. It seems
> > RCU is setting the latter.
> 
> As I understand it, tick_dep_mask forces the tick on globally,
> ts->tick_dep_mask forces it on for a specific CPU (which RCU uses when it
> needs a quiescent state from that CPU), current->tick_dep_mask forces
> it on for a specific task (which RCU uses for callback invocation
> and certain rcutorture kthreads), and I don't pretend to understand
> current->signal->tick_dep_mask (the comment says something about POSIX
> CPU timers).

Right. I am pretty new to all of these so I could have something incorrect in
a hurry. But thanks for the explanation of your understanding of these.

Yes this commit talks about timers as well for the signal->tick_dep_mask:
d027d45d8a17 ("nohz: New tick dependency mask")

> But it looks to me that can_stop_full_tick() and check_tick_dependency()
> already cover all of these.  What am I missing?

As you mentioned, all of these are covered.

> > So I added a check for both, below is the diff:
> > 
> > However, I see in some cases that the tick_dep_mask is just 0 but I have to
> > debug that tomorrow if that's an issue on the RCU side of things. For now,
> > below should be the completed Frederick patch which you could squash into his
> > if he's Ok with it:
> > 
> > ---8<-----------------------
> > 
> > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > index f92a10b5e112..3f476e2a4bf7 100644
> > --- a/include/linux/tick.h
> > +++ b/include/linux/tick.h
> > @@ -108,7 +108,8 @@ enum tick_dep_bits {
> >  	TICK_DEP_BIT_POSIX_TIMER	= 0,
> >  	TICK_DEP_BIT_PERF_EVENTS	= 1,
> >  	TICK_DEP_BIT_SCHED		= 2,
> > -	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
> > +	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> > +	TICK_DEP_BIT_RCU		= 4
> >  };
> >  
> >  #define TICK_DEP_MASK_NONE		0
> > @@ -116,6 +117,7 @@ enum tick_dep_bits {
> >  #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
> >  #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
> >  #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
> > +#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
> >  
> >  #ifdef CONFIG_NO_HZ_COMMON
> >  extern bool tick_nohz_enabled;
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index be9707f68024..a613916cc3f0 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -198,6 +198,11 @@ static bool check_tick_dependency(atomic_t *dep)
> >  		return true;
> >  	}
> >  
> > +	if (val & TICK_DEP_MASK_RCU) {
> > +		trace_tick_stop(0, TICK_DEP_MASK_RCU);
> > +		return true;
> > +	}
> > +
> >  	return false;
> >  }
> >  
> > @@ -208,8 +213,13 @@ static bool can_stop_full_tick(int cpu, struct tick_sched *ts)
> >  	if (unlikely(!cpu_online(cpu)))
> >  		return false;
> >  
> > -	if (check_tick_dependency(&tick_dep_mask))
> > +	if (check_tick_dependency(&ts->tick_dep_mask)) {
> >  		return false;
> > +	}
> > +
> > +	if (check_tick_dependency(&tick_dep_mask)) {
> > +		return false;
> > +	}
> >  
> >  	if (check_tick_dependency(&ts->tick_dep_mask))
> >  		return false;
> 
> You lost me on this one.  How does it help to check ts->tick_dep_mask
> twice?  And why is it important to check it before checking tick_dep_mask,
> especially given that the common case of all-zero masks will cause
> all to be checked anyway?

You are right. In a later reply I had mentioned to you to drop this hunk. It
is not needed.

I will pull your -rcu dev branch now to get the latest and will test the RCU
dyntick code to see if I can make that work with the tick-sched code.

Keep you posted!

thanks,

 - Joel

