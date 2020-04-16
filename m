Return-Path: <SRS0=pJ0D=6A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9BCC2BB55
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0C220786
	for <rcu@archiver.kernel.org>; Thu, 16 Apr 2020 18:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hHbwxSL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDPS7i (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgDPS7h (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Apr 2020 14:59:37 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73504C061A0C
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 11:59:36 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i19so14458968qtp.13
        for <rcu@vger.kernel.org>; Thu, 16 Apr 2020 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oNK9ad1ClIOMU3TN0PLbWRRU2R8+/LPu5ERmozE78U0=;
        b=hHbwxSL4wBHQdSL+Xcl3ZpowAwECc2usv901dUR5jIdkvfmxo62t9d3Z+VHqFDZ/nM
         DngTQjUmVQ5J/IrlReQCeYOoMSoMeuTcTFkiM68Hq2yBMBalbNzxzlWDyKIKwhp9nyz5
         baYMbYFAZndj/RpKCBYmebzEaeD3NnGBSl/X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oNK9ad1ClIOMU3TN0PLbWRRU2R8+/LPu5ERmozE78U0=;
        b=oSRjuORL+9HGgcWikMoYb8pVHHXJUJvQ2h80nXFPyGW44LvHkDaM/6kelZHfExpFJ4
         y6Wz3BZovyAwN7ApNmT+UelmEFOMvHBMOF8ZVTXEekYAdMeXjQbTtl+0GWNehLZ6uMb8
         X8AoBK2g+7ouXFYyQ1m0j0uV3PIKtrDpcEqNlajVDk/c1ElIeRFMlei/CN3D0PYdK61q
         RKb+tv+AaUm16QJ28m1DadC1T6sIwLo15bBWL5oDfNZVzZi/FLxpvmFdyrTDRyy7H4yr
         vdusTNfJxD1vuo9bDBh4gr1Z+iBgdS9fBFznBVweg9PtPdY8oJ+doHA7RyiFVrz1pFLG
         5AKw==
X-Gm-Message-State: AGi0PuZjwZDQdhaN3VCBhOW3caYdS2VjFacaE8YQ6g/WiibOCdKE9QTw
        eGJLHZWPlVjIT2U4Owtmn03n6g==
X-Google-Smtp-Source: APiQypLePBOeCBKOm6QP8cMuQKQZFlMr40wqUB67F8CNhsnnzN4u1rcmPUb+wtstPFLMbgNcru8DDg==
X-Received: by 2002:ac8:66c6:: with SMTP id m6mr27921194qtp.25.1587063575627;
        Thu, 16 Apr 2020 11:59:35 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 18sm9002499qks.98.2020.04.16.11.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 11:59:34 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:59:34 -0400
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
Message-ID: <20200416185934.GD149999@google.com>
References: <20200415160034.662274-2-bigeasy@linutronix.de>
 <20200416144254.GC90777@google.com>
 <20200416151824.a372pdiphube3x3l@linutronix.de>
 <20200416184112.GA149999@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416184112.GA149999@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 02:41:12PM -0400, Joel Fernandes wrote:
> On Thu, Apr 16, 2020 at 05:18:24PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-04-16 10:42:54 [-0400], Joel Fernandes wrote:
> > > Hi Sebastian,
> > Hi Joel,
> > 
> > > > @@ -3139,10 +3136,8 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >  	unsigned long flags;
> > > >  	struct kfree_rcu_cpu *krcp;
> > > >  
> > > > -	local_irq_save(flags);	// For safely calling this_cpu_ptr().
> > > > -	krcp = this_cpu_ptr(&krc);
> > > > -	if (krcp->initialized)
> > > > -		spin_lock(&krcp->lock);
> > > > +	krcp = raw_cpu_ptr(&krc);
> > > > +	spin_lock_irqsave(&krcp->lock, flags);
> > > 
> > > I agree with the patch, except for this bit. Would it be ok to split the
> > > other parts of this patch into separate patch(es)?
> > 
> > if you want, I could split it. Part of the goal is to get rid of the
> > local_irq_save(). I don't mind if it happens a patch later :)
> 
> Considering the other parts of your patch are less contentious, it makes
> sense to me to split it, while we discuss this particular part ;)
> 
> > > For this part of the patch, I am wondering what is the value in it. For one,
> > 
> > local_irq_save() + spin_lock() is the problem, see
> >     https://www.kernel.org/doc/html/latest/locking/locktypes.html#spinlock-t-and-rwlock-t
> > 
> > (the link-instead-explaining part is nice)
> 
> This problem can be fixed simply by using raw_spin_lock above right? That
> would solve the rtmutex problem in PREEMPT_RT.

I guess a higher level question is, on PREEMPT_RT, do we want to make the
kfree_rcu() code fully preemptible?

I am not saying we should not, but that is another thing to consider.

Obviously, the migrate_disable(); idea would be better then if are Ok with
making it preemptible.

But, then will it be safe for kfree_rcu() callers from hard IRQ context to
call this in PREEMPT_RT? That could would just break then as you cannot sleep
in hard IRQ context even on PREEMPT_RT.

thanks,

 - Joel

