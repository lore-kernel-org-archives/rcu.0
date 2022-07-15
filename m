Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38BC433EF
	for <rcu@archiver.kernel.org>; Fri, 15 Jul 2022 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiGOP3n (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jul 2022 11:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGOP3l (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jul 2022 11:29:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7952BF43
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 08:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B1EAB82B2F
        for <rcu@vger.kernel.org>; Fri, 15 Jul 2022 15:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E354C34115;
        Fri, 15 Jul 2022 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657898978;
        bh=LkSG3gIYI2emS0F64ef1/aHI1tlYNvbZcLtJvbvbd1U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aZN5WccuPSd95QOtWR3hMt2+rwlr+vQpNghuMFydjoUy7clTbTpT3lOae+CPd9fgf
         sTq5nx1kgDPT+p3avVJ08xHYdy6k77N3R8fJ/bd7nwsiv46bQAMqo1ueTPFrE/tMuD
         pxpNjmQHbwxtL4UAe0lcAS+bYQLa2c7Skw+dwkw0NnjwM1h8mXUIO40UoZJYhH6WZQ
         1dGXRiL4mRtqW4KDUU+HhgZ3oj2E8Et4uxfLzz2wpuzP+KB+S7HntcbLz53B8JxAPy
         5WxmKKrA3i6lmg6vSC11/kyE3DiYrnmr3z+90RQxW1pvc7HiM54sDossxh8pkyxUfP
         o1Wk+NY0IG+tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BA1A35C015D; Fri, 15 Jul 2022 08:29:37 -0700 (PDT)
Date:   Fri, 15 Jul 2022 08:29:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/5] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <20220715152937.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220713213237.1596225-1-joel@joelfernandes.org>
 <20220714205154.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220714222131.GA3321557@paulmck-ThinkPad-P17-Gen-1>
 <YtGFLFbzuZncfDeN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtGFLFbzuZncfDeN@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 15, 2022 at 03:18:04PM +0000, Joel Fernandes wrote:
> On Thu, Jul 14, 2022 at 03:21:31PM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 14, 2022 at 01:51:54PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 13, 2022 at 09:32:32PM +0000, Joel Fernandes (Google) wrote:
> > > > Hello!
> > > > 
> > > > Please find the next improved version of call_rcu_lazy() attached.  The main
> > > > difference between the previous versions is that:
> > > > - In v2 rcu_barrier is fixed to not hang (I found this to be due to a missing
> > > >   GP thread wakeup), now I am limiting this wake up only to rcu_barrier() as
> > > >   requested by Paul.
> > > > - Fixed checkpatch and build robot issues.
> > > > - Some more changes to 'lazy' parameter passing and consolidation of segcblist
> > > >   functions.
> > > > - more testing via rcutorture and rcuscale.
> > > 
> > > Thank you!  What I am going to do is to pull these into an experimental
> > > not-for-mainline branch and run the usual set of rcutorture tests.
> > > I will then take a look at the patches.
> > 
> > And there were a few conflicts with the nocb patch series in -rcu.
> > The allegedly conflict-resolved series is here: joel.2022.07.14a
> > Please let me know if I messed something up.
> 
> Thanks, it looks Ok. There is one robot fix for hexagon's arch where I think
> TREE_RCU is disabled, could you apply the diff below to patch 1/5 ?
> 
> Or, I can also just keep it in my version of 1/5 to go out with the next rev.

Given that I am not testing on hexagon, I will let you fix this one on
the next rev.  If someone out there is testing this branch on hexagon,
they should feel free to apply your patch locally.  ;-)

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index c358387fd223..aa3243e49506 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -464,6 +464,14 @@ enum rcutorture_type {
>  	INVALID_RCU_FLAVOR
>  };
>  
> +#if defined(CONFIG_RCU_LAZY)
> +unsigned long rcu_lazy_get_jiffies_till_flush(void);
> +void rcu_lazy_set_jiffies_till_flush(unsigned long j);
> +#else
> +static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
> +static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
> +#endif
> +
>  #if defined(CONFIG_TREE_RCU)
>  void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
>  			    unsigned long *gp_seq);
> @@ -475,14 +483,6 @@ void do_trace_rcu_torture_read(const char *rcutorturename,
>  void rcu_gp_set_torture_wait(int duration);
>  void rcu_force_call_rcu_to_lazy(bool force);
>  
> -#if defined(CONFIG_RCU_LAZY)
> -unsigned long rcu_lazy_get_jiffies_till_flush(void);
> -void rcu_lazy_set_jiffies_till_flush(unsigned long j);
> -#else
> -static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
> -static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
> -#endif
> -
>  #else
>  static inline void rcutorture_get_gp_data(enum rcutorture_type test_type,
>  					  int *flags, unsigned long *gp_seq)
