Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88D5C61DA4
	for <rcu@archiver.kernel.org>; Thu, 23 Feb 2023 16:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjBWQKP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Feb 2023 11:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjBWQKO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Feb 2023 11:10:14 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C800251F83
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 08:10:12 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id y3so11424124qvn.4
        for <rcu@vger.kernel.org>; Thu, 23 Feb 2023 08:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVJs00yGU4ljOjIPJVv3EsPslnnyUQHNKLpkZ62KQ+0=;
        b=YBxz5jipV4vFE+rG/tPjOqjyOafrIjFHYOg5ChHQNeEXKJufWqmvdBpYUtqa71G6dy
         MTQX14mhAIlQYLnNeXs2maaqDShUc67SYokd0r/niPbfkGOHYiFqQW9SjLRjriR6EnZ9
         9T/aSgKGyVOA6abpD4q7gzcsLQibFYJKNpA+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVJs00yGU4ljOjIPJVv3EsPslnnyUQHNKLpkZ62KQ+0=;
        b=y402BngQ1IeE9PFXYN0OewZamwfGjH/R/w6pumUxvnRfNAIwUznnUxhj9Zco17dfFh
         Hg4ExAspeTqKdgQfKtVnrzDVzEL+66PltfQgLBpztJanGg+tAEAywasANORDa+u+2L/S
         KuBcqNcZPsN1GRh9jT2cn5eln4NEZpPQkXudJQRW1LaU1f/cuwnN1FsUoUeJJEvHMwFG
         wXlotOJTpetwXn1HP6pvV86s1tLgJbvsgx62wqJ8UvZ1v5AOybBlN9new1Zd6xBCdA12
         P8yIuy5GmRvNLUhTkHVap9N5/+mlxVKPzUPOSDvbRBoI60tIHP8g1zx3qG2mchvPoCEK
         uxTQ==
X-Gm-Message-State: AO0yUKWfpiI7chk0F65j9JJLCV+qTES2ZTF/Nnt3367Lshwr9vzvyed+
        r0pO31MK+yhz67de1ZvNaVf3cA==
X-Google-Smtp-Source: AK7set/65ey9xnhompEPPWX9/BtMgz3T4V/JD+ZA5vb1PnJ690MKr0+dSU2iOm6M/OeqUGYnwB40ww==
X-Received: by 2002:a05:6214:f2d:b0:56b:4e51:acd5 with SMTP id iw13-20020a0562140f2d00b0056b4e51acd5mr27696659qvb.12.1677168611830;
        Thu, 23 Feb 2023 08:10:11 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id 11-20020a37060b000000b00741921f3f60sm5470491qkg.42.2023.02.23.08.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 08:10:10 -0800 (PST)
Date:   Thu, 23 Feb 2023 16:10:10 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Message-ID: <Y/eP4h/chB8J0rAj@google.com>
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
 <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Feb 23, 2023 at 08:43:05AM +0000, Zhang, Qiang1 wrote:
> > From: Zqiang <qiang1.zhang@intel.com>
> > Sent: Thursday, February 23, 2023 2:30 PM
> > To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> > joel@joelfernandes.org
> > Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> > call_rcu_tasks_generic()
> > 
> > According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> > call_rcu_tasks_generic()")', the grace-period kthread is delayed to wakeup
> > using irq_work_queue() is because if the caller of
> > call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built with
> > CONFIG_PROVE_RAW_LOCK_NESTING=y, due to a spinlock will be hold in
> > wake_up(), so the lockdep splats will happen. but now using
> > rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), in
> > rcuwait_wake_up() no spinlock will be acquired, so this commit remove using
> >
> >There are still spinlock-acquisition and spinlock-release invocations within the call path from rcuwait_wake_up().
> >
> >rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
> >
> >    raw_spin_lock_irqsave()
> >    ...
> >    raw_spin_unlock_irqrestore
> 
> Yes, but this is raw_spinlock acquisition and release(note: spinlock will convert to
> sleepable lock in Preempt-RT kernel, but raw spinlock is not change).
> 
> acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.

Is this really safe in the long run though? I seem to remember there are
weird locking dependencies if RCU is used from within the scheduler [1].

I prefer to keep it as irq_work_queue() unless you are seeing some benefit.
Generally, there has to be a 'win' or other justification for adding more
risk.

thanks,

 - Joel
[1] http://www.joelfernandes.org/rcu/scheduler/locking/2019/09/02/rcu-schedlocks.html

> > irq_work_queue(), invoke rcuwait_wake_up() directly in
> > call_rcu_tasks_generic().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tasks.h | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> > baf7ec178155..757b8c6da1ad 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -39,7 +39,6 @@ struct rcu_tasks_percpu {
> >  	unsigned long rtp_jiffies;
> >  	unsigned long rtp_n_lock_retries;
> >  	struct work_struct rtp_work;
> > -	struct irq_work rtp_irq_work;
> >  	struct rcu_head barrier_q_head;
> >  	struct list_head rtp_blkd_tasks;
> >  	int cpu;
> > @@ -112,12 +111,9 @@ struct rcu_tasks {
> >  	char *kname;
> >  };
> > 
> > -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> > -
> >  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)
> > 			\
> >  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {
> > 			\
> >  	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ##
> > __percpu.cbs_pcpu_lock),		\
> > -	.rtp_irq_work = IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),
> > 			\
> >  };
> > 		\
> >  static struct rcu_tasks rt_name =
> > 		\
> >  {
> > 		\
> > @@ -273,16 +269,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
> >  	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__,
> > data_race(rtp->percpu_enqueue_shift), data_race(rtp-
> > >percpu_enqueue_lim));
> >  }
> > 
> > -// IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
> > -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp) -{
> > -	struct rcu_tasks *rtp;
> > -	struct rcu_tasks_percpu *rtpcp = container_of(iwp, struct
> > rcu_tasks_percpu, rtp_irq_work);
> > -
> > -	rtp = rtpcp->rtpp;
> > -	rcuwait_wake_up(&rtp->cbs_wait);
> > -}
> > -
> >  // Enqueue a callback for the specified flavor of Tasks RCU.
> >  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> >  				   struct rcu_tasks *rtp)
> > @@ -334,7 +320,7 @@ static void call_rcu_tasks_generic(struct rcu_head
> > *rhp, rcu_callback_t func,
> >  	rcu_read_unlock();
> >  	/* We can't create the thread unless interrupts are enabled. */
> >  	if (needwake && READ_ONCE(rtp->kthread_ptr))
> > -		irq_work_queue(&rtpcp->rtp_irq_work);
> > +		rcuwait_wake_up(&rtp->cbs_wait);
> >  }
> > 
> >  // RCU callback function for rcu_barrier_tasks_generic().
> > --
> > 2.25.1
> 
