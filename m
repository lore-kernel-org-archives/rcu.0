Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A4DC2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F483206E9
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TUzNdm53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgDPSlP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgDPSlO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 14:41:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C2C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 11:41:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m67so22399962qke.12
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1hhXP3OcbwBpqChTg2qy0UYmtrJF5n+UqwwBxvvO0Xg=;
        b=TUzNdm53+tWpiU+ybdGUa4Xsr5DsHcBseB2373zHPgQ1LznWR2nhtXxJlCrIPelRMC
         AVcFSUodz6RZB3yd5DMiPPjNlFwvXsfWcNxycchVQefi0JavuOi+3u+G08tVV8jaiedh
         R2qNC0tYHp5cdM5/vmK4H/ED2nAjGZFA4cJ6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1hhXP3OcbwBpqChTg2qy0UYmtrJF5n+UqwwBxvvO0Xg=;
        b=DSSAbI3qdCLjSuU7dj7DLCJRr0Ibk1h3H7vd9IAY7Du3O9c+80YH6esEJWwLO3OUOX
         pbnlaIkUa72XhbgkhPWwrlRZBDs4E9KSWNrcAEBqsvFOd9JHJ/ZeCCCBXQk+FtFjUGn+
         Wf9oAfTECITEIU3Kk3j41jIYihE5L8XTpXneyNkI3O0pHRpe121P4UYD373JLshFcBZE
         qUQzVRfDtnJB8KHd/bxeQxnsVMzg9uY/H80zi6iyO9dUrchbOsQ5EdQmQwzUrtmV3EO4
         xZMCF+S23soStoi5VcdgiAZhtyQHR/ji/za22Z2Rk4fCDTV41h1g34wTTaSzU/eDz+kl
         eYFw==
X-Gm-Message-State: AGi0PuYmLG8TxTcHBHsuu3/o4U4D9V4Zj+3PXazR+Km5sa618Q2QthnN
        sbDrXg5NG7j7Ju9f1eNIok7IsA==
X-Google-Smtp-Source: APiQypLVhqUxpjIJparKX8fAFNwNwU3EDavmLe0cLnenoZwaUfPSj96ncDKVIpia8paqZ9ULyzizbg==
X-Received: by 2002:a05:620a:16cf:: with SMTP id a15mr17844283qkn.156.1587062473149;
        Thu, 16 Apr 2020 11:41:13 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l13sm12682796qtj.17.2020.04.16.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:41:12 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:41:12 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, urezki@gmail.com
Subject: Re: [PATCH 1/3] rcu: Use static initializer for krc.lock
Message-ID: <20200416184112.GA149999@google.com>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416151824.a372pdiphube3x3l@linutronix.de>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 05:18:24PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-04-16 10:42:54 [-0400], Joel Fernandes wrote:
> > Hi Sebastian,
> Hi Joel,
> 
> > > @@ -3139,10 +3136,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >  	unsigned long flags;
> > >  	struct kfree_rcu_cpu *krcp;
> > >  
> > > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > > -	krcp = this_cpu_ptr(&krc);
> > > -	if (krcp->initialized)
> > > -		spin_lock(&krcp->lock);
> > > +	krcp = raw_cpu_ptr(&krc);
> > > +	spin_lock_irqsave(&krcp->lock, flags);
> > 
> > I agree with the patch, except for this bit. Would it be ok to split the
> > other parts of this patch into separate patch(es)?
> 
> if you want, I could split it. Part of the goal is to get rid of the
> local_irq_save(). I don't mind if it happens a patch later :)

Considering the other parts of your patch are less contentious, it makes
sense to me to split it, while we discuss this particular part ;)

> > For this part of the patch, I am wondering what is the value in it. For one,
> 
> local_irq_save() + spin_lock() is the problem, see
>     https://www.kernel.org/doc/html/latest/locking/locktypes.html#spinlock-t-and-rwlock-t
> 
> (the link-instead-explaining part is nice)

This problem can be fixed simply by using raw_spin_lock above right? That
would solve the rtmutex problem in PREEMPT_RT.

> > Also on a slightly related note, could you share with me why this_cpu_ptr()
> > is unsafe to call in non-preemptible context, but raw_cpu_ptr() is ok? Just
> > curious on that.

Here I meant 'in preemptible context'.

> 
> I wouldn't use safe/unsafe as a term to describe the situation. Both do
> the same however this_cpu_ptr() raises a warning (given it is enabled)
> if the current context can migrate to another CPU
> (check_preemption_disabled()).
> If you know what you do and it does not matter whether migration happens
> or not, you can use raw_cpu_ptr() to avoid the warning. In this case it
> is okay because CPU migration does not matter here since the data
> structure is protected with a lock. Using the data structure from
> another CPU (due to accidental migration) is not ideal but _no_
> assumption happens later on for dealing with the current or further
> data. The timer/worker will be scheduled on the "wrong" CPU but this
> again has no bad consequences. The timer and worker use container_of()
> so they operate on the correct resources. Would they instead use
> per_cpu_ptr(krc, smp_processor_id()) then it would operate on the wrong
> data.
> 
> Regarding the safe/unsafe: Would this_cpu_ptr() trigger a warning and
> you add preempt_disable() around the block, where you use the per-CPU
> data, then you would silence the warning and everything would look fine.
> If this per-CPU data structure would also be accessed from interrupt
> context then you would get inconsistent data and no warning.
> What I'm trying to say is that even this_cpu_ptr() is not "safe" if used
> without a thought.

Thanks a lot for the background information on the 2 APIs!!

It got confusing to me when rcu_raw_ptr() would not warn but this_cpu_ptr)_
would. I guess it is about semantics, and this_cpu_ptr() is more explicit
about accessing the same local CPU's data.

 - Joel

> 
> > thanks,
> > 
> >  - Joel
> 
> Sebastian
