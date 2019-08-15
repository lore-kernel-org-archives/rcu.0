Return-Path: <SRS0=ayKe=WL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68BDC3A589
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 21:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A646A205F4
	for <rcu@archiver.kernel.org>; Thu, 15 Aug 2019 21:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="O+djbzjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfHOVWf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:22:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43835 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbfHOVWf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Aug 2019 17:22:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so1837064pgb.10
        for <rcu@vger.kernel.org>; Thu, 15 Aug 2019 14:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U3MoRbpvlUTJ/O6odziLgQVnTbR6tTW7hiBsEo4Y7Us=;
        b=O+djbzjjweKaIhcsuHSzsQWgd2hyKJyIQslJ4u67NEXYYZFxVsISC1jh9wvC++2MZ1
         ozmbHF5wB0EuC1vvuljwccfpNIA9d6JifpRknQHnGPG7RQwdPCsk4mCaa8+JXrQlBi+b
         kO+G+E3/lUsv+B2F+OHEn3nopHIUXceSZWSQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U3MoRbpvlUTJ/O6odziLgQVnTbR6tTW7hiBsEo4Y7Us=;
        b=AFRzrSgIAi6/IcdQckYn5jLdgViy0KaY8cLXZ4ySqoV0/+4y3shxtUqGwJC5ySBQz2
         9Th0pMWhcUk9UxeGhUXAWGZUhJhauZ1VpGshKssk4jblE4rGatgutQsCHbcdYpylizgf
         SdCTtOl5/QZnLaNS9vj1lotAV/eTgW3uLAkx9TxFer+1J6ejhfbCTQs16Wf4nWbeN/YA
         DVMS/Uzeev5tSehG9KO0tdXpMa1wLl2QszXUzjYgF+oUagk4LgCAn/GCjed6P2ir0cD0
         f16Oo1kcwu1PCzN7RERp3C5KLj+mkhV4ZJX3KnAMzzepF/MZ0j28aomF8TOb9Lhd0ikf
         6Iug==
X-Gm-Message-State: APjAAAWj5lBWtV8+TdOUsAN1+ujkPu/sy0HGv0RdApuFxgIZ+bAB+UhY
        A8x+R95TbMUz75wG0+gvwVcjyvgpZmY=
X-Google-Smtp-Source: APXvYqwYPNSSLEQxSCGa1pAam2+jBCGTX9jRmn7q/wbT6dWwHmzWor5TKxZ8RD4ILtgGqVjFcwfKNw==
X-Received: by 2002:aa7:9d07:: with SMTP id k7mr7298836pfp.94.1565904153855;
        Thu, 15 Aug 2019 14:22:33 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id v18sm3301856pgl.87.2019.08.15.14.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:22:33 -0700 (PDT)
Date:   Thu, 15 Aug 2019 17:22:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190815212216.GA224191@google.com>
References: <20190811180852.GA128944@google.com>
 <20190811211318.GX28441@linux.ibm.com>
 <20190812032142.GA171001@google.com>
 <20190812035306.GE28441@linux.ibm.com>
 <20190812212013.GB48751@google.com>
 <20190812230138.GS28441@linux.ibm.com>
 <20190813010249.GA129011@google.com>
 <20190815171714.GA1023@linux.ibm.com>
 <20190815200432.GB23194@google.com>
 <20190815203107.GL28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815203107.GL28441@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 15, 2019 at 01:31:07PM -0700, Paul E. McKenney wrote:
> On Thu, Aug 15, 2019 at 04:04:32PM -0400, Joel Fernandes wrote:
> > On Thu, Aug 15, 2019 at 10:17:14AM -0700, Paul E. McKenney wrote:
> > > On Mon, Aug 12, 2019 at 09:02:49PM -0400, Joel Fernandes wrote:
> > > > On Mon, Aug 12, 2019 at 04:01:38PM -0700, Paul E. McKenney wrote:
> > > 
> > > [ . . . ]
> > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index 8c494a692728..ad906d6a74fb 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -651,6 +651,12 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> > > > >  	 */
> > > > >  	if (rdp->dynticks_nmi_nesting != 1) {
> > > > >  		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2, rdp->dynticks);
> > > > > +		if (tick_nohz_full_cpu(rdp->cpu) &&
> > > > > +		    rdp->dynticks_nmi_nesting == 2 &&
> > > > > +		    rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
> > > > > +			rdp->rcu_forced_tick = true;
> > > > > +			tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU);
> > > > > +		}
> > > > 
> > > > 
> > > > Instead of checking dynticks_nmi_nesting == 2 in rcu_nmi_exit_common(), can
> > > > we do the tick_dep_set_cpu(rdp->cpu, TICK_DEP_MASK_RCU)  from
> > > > rcu_nmi_enter_common() ? We could add this code there, under the "if
> > > > (rcu_dynticks_curr_cpu_in_eqs())".
> > > 
> > > This would need to go in an "else" clause, correct?  But there would still
> > > want to be a check for interrupt from base level (which would admittedly
> > > be an equality comparison with zero) and we would also still need to check
> > > for rdp->rcu_urgent_qs && !rdp->rcu_forced_tick.
> > 
> > True, agreed. I replied to this before saying it should be
> > !rcu_dynticks_curr_cpu_in_eqs() in the "if" ;) But it seems I could also be
> > missing the check for TICK_DEP_MASK_RCU in my tree so I think we need this as
> > well which is below as diff. Testing it more now!
> > 
> > And, with this I do get many more ticks during the test. But there are
> > intervals where the tick is not seen. Still it is much better than before:
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index be9707f68024..e697c7a2ce67 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -198,6 +198,10 @@ static bool check_tick_dependency(atomic_t *dep)
> >  		return true;
> >  	}
> >  
> > +	if (val & TICK_DEP_MASK_CLOCK_RCU) {
> > +		return true;
> > +	}
> > +
> >  	return false;
> >  }
> 
> That one is not in my tree, either.  Frederic, should I add this to
> your patch?  For that matter, may I add your Signed-off-by as well?
> Your original is in my -rcu tree at:
> 
> 0cb41806c799 ("EXP nohz: Add TICK_DEP_BIT_RCU")
> 
> I am testing Joel's suggested addition now.

Actually there's more addition needed! I found another thing missing:

There's a per-cpu &tick_dep_mask and a per-cpu ts->tick_dep_mask. It seems
RCU is setting the latter.

So I added a check for both, below is the diff:

However, I see in some cases that the tick_dep_mask is just 0 but I have to
debug that tomorrow if that's an issue on the RCU side of things. For now,
below should be the completed Frederick patch which you could squash into his
if he's Ok with it:

---8<-----------------------

diff --git a/include/linux/tick.h b/include/linux/tick.h
index f92a10b5e112..3f476e2a4bf7 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -108,7 +108,8 @@ enum tick_dep_bits {
 	TICK_DEP_BIT_POSIX_TIMER	= 0,
 	TICK_DEP_BIT_PERF_EVENTS	= 1,
 	TICK_DEP_BIT_SCHED		= 2,
-	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
+	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
+	TICK_DEP_BIT_RCU		= 4
 };
 
 #define TICK_DEP_MASK_NONE		0
@@ -116,6 +117,7 @@ enum tick_dep_bits {
 #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
 #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
 #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
+#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
 
 #ifdef CONFIG_NO_HZ_COMMON
 extern bool tick_nohz_enabled;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index be9707f68024..a613916cc3f0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -198,6 +198,11 @@ static bool check_tick_dependency(atomic_t *dep)
 		return true;
 	}
 
+	if (val & TICK_DEP_MASK_RCU) {
+		trace_tick_stop(0, TICK_DEP_MASK_RCU);
+		return true;
+	}
+
 	return false;
 }
 
@@ -208,8 +213,13 @@ static bool can_stop_full_tick(int cpu, struct tick_sched *ts)
 	if (unlikely(!cpu_online(cpu)))
 		return false;
 
-	if (check_tick_dependency(&tick_dep_mask))
+	if (check_tick_dependency(&ts->tick_dep_mask)) {
 		return false;
+	}
+
+	if (check_tick_dependency(&tick_dep_mask)) {
+		return false;
+	}
 
 	if (check_tick_dependency(&ts->tick_dep_mask))
 		return false;
-- 
2.23.0.rc1.153.gdeed80330f-goog

