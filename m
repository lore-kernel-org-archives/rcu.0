Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC3EC433F5
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 14:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiENOi6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 10:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiENOi4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 10:38:56 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8B225C5A
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:38:55 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id p3so8986259qvi.7
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u3n2lD04vXu2mCaCahPu8doQd6nEgPZ4kcyR+z7mgUg=;
        b=nGPAvffy+ObVKbkXqX1sFjbjXmADbNGNkVLTKxSJtEXJCOHBODbqRXPf5B7++MEsYQ
         rj3/lW8LKEqUE3HEyPHn3z6IRKCLnyK7DXBJHbJ0sAgzh+YcjERXLt8VzfQQ9bA0+n7F
         iEOIF6uURKyS6s0PKZ+d2W6QQC3hbVyIOrYB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u3n2lD04vXu2mCaCahPu8doQd6nEgPZ4kcyR+z7mgUg=;
        b=2c98zm0tLdGFiSYgclhMtICjydYQy9ekESHND2RB2Qh4iCl4ql63l5usIihAYf60WU
         YR38WVaipO6WY9TissVv+AQXEJDgiBxqVyznF93ZU2aJMPsGpmf/odRhP9ENOwgr57nu
         4MtjtaljbPWGN3AmFGCAIA8hYkawe9ldAIQwRibE320WRk7KZRsNUJXjuwcLxQUNkQw6
         W/8GftPS6n9YtkwMSa/nZaAAGA54vNV6UlivTyvVHjmIorgro3/Px+1eEB6NoAwW5nBv
         vz9IQ6Ns1qeBOXmvJnO7mFuqmP5QPanE/tI6K8OT97SumjfArw6tVmYOKbSG+079UpdT
         DwRg==
X-Gm-Message-State: AOAM533CG3vyZeGYMOIDrsc9OTXJVQf+Aa9L5PSc1JV2LealaKX2333h
        KAAMwtECOORtkNq2PwgyUPhBlA==
X-Google-Smtp-Source: ABdhPJwm4P+DAQWBNN6iL44RvhHp9kx93fKXiW1jsyMQ/4goW5s3/hALzXmOZCeGFOZYPHLBpb2mdA==
X-Received: by 2002:ad4:5bc1:0:b0:42d:758c:f694 with SMTP id t1-20020ad45bc1000000b0042d758cf694mr8334267qvt.99.1652539134568;
        Sat, 14 May 2022 07:38:54 -0700 (PDT)
Received: from localhost (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id l5-20020ac848c5000000b002f3fbf28826sm3271915qtr.23.2022.05.14.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 07:38:54 -0700 (PDT)
Date:   Sat, 14 May 2022 14:38:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 14/14] DEBUG: Toggle rcu_lazy and tune at runtime
Message-ID: <Yn++/Rx89qZGeuI6@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-15-joel@joelfernandes.org>
 <20220513001622.GA1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513001622.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 05:16:22PM -0700, Paul E. McKenney wrote:
> On Thu, May 12, 2022 at 03:04:42AM +0000, Joel Fernandes (Google) wrote:
> > Add sysctl knobs just for easier debugging/testing, to tune the maximum
> > batch size, maximum time to wait before flush, and turning off the
> > feature entirely.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> This is good, and might also be needed longer term.
> 
> One thought below.
> 
> 							Thanx, Paul
> 
> > ---
> >  include/linux/sched/sysctl.h |  4 ++++
> >  kernel/rcu/lazy.c            | 12 ++++++++++--
> >  kernel/sysctl.c              | 23 +++++++++++++++++++++++
> >  3 files changed, 37 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> > index c19dd5a2c05c..55ffc61beed1 100644
> > --- a/include/linux/sched/sysctl.h
> > +++ b/include/linux/sched/sysctl.h
> > @@ -16,6 +16,10 @@ enum { sysctl_hung_task_timeout_secs = 0 };
> >  
> >  extern unsigned int sysctl_sched_child_runs_first;
> >  
> > +extern unsigned int sysctl_rcu_lazy;
> > +extern unsigned int sysctl_rcu_lazy_batch;
> > +extern unsigned int sysctl_rcu_lazy_jiffies;
> > +
> >  enum sched_tunable_scaling {
> >  	SCHED_TUNABLESCALING_NONE,
> >  	SCHED_TUNABLESCALING_LOG,
> > diff --git a/kernel/rcu/lazy.c b/kernel/rcu/lazy.c
> > index 55e406cfc528..0af9fb67c92b 100644
> > --- a/kernel/rcu/lazy.c
> > +++ b/kernel/rcu/lazy.c
> > @@ -12,6 +12,10 @@
> >  // How much to wait before flushing?
> >  #define MAX_LAZY_JIFFIES	10000
> >  
> > +unsigned int sysctl_rcu_lazy_batch = MAX_LAZY_BATCH;
> > +unsigned int sysctl_rcu_lazy_jiffies = MAX_LAZY_JIFFIES;
> > +unsigned int sysctl_rcu_lazy = 1;
> > +
> >  // We cast lazy_rcu_head to rcu_head and back. This keeps the API simple while
> >  // allowing us to use lockless list node in the head. Also, we use BUILD_BUG_ON
> >  // later to ensure that rcu_head and lazy_rcu_head are of the same size.
> > @@ -49,6 +53,10 @@ void call_rcu_lazy(struct rcu_head *head_rcu, rcu_callback_t func)
> >  	struct lazy_rcu_head *head = (struct lazy_rcu_head *)head_rcu;
> >  	struct rcu_lazy_pcp *rlp;
> >  
> > +	if (!sysctl_rcu_lazy) {
> 
> This is the place to check for early boot use.  Or, alternatively,
> initialize sysctl_rcu_lazy to zero and set it to one once boot is far
> enough along to allow all the pieces to work reasonably.

Sure, I was also thinking perhaps to set this to a static branch. That way we
don't have to pay the cost of the branch after it is setup on boot.

But I think as you mentioned on IRC, if we were to promote this to a
non-DEBUG patch, we would need to handle conditions similar to Frederick's
work on toggling offloading.

thanks,

 - Joel

