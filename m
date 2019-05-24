Return-Path: <SRS0=/QKf=TY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4372DC072B5
	for <rcu@archiver.kernel.org>; Fri, 24 May 2019 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1A72070D
	for <rcu@archiver.kernel.org>; Fri, 24 May 2019 16:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BoD43RPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390605AbfEXQuM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 May 2019 12:50:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37104 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390346AbfEXQuM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 May 2019 12:50:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23so5670186pff.4
        for <rcu@vger.kernel.org>; Fri, 24 May 2019 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QllwIGe4CGfQlfHGQxn6FJsttbRuw0tLf5PsM4D9zgs=;
        b=BoD43RPLrADFini2q/nazz1hfHmME9w7rgrTWluoX36uLMdpMOtx5V8IPS8sTf6lMx
         okNHK/lGaZD2eJ/Tm8Rc/1+1fZqY1KBundgzPxHlKr6kHEPtVoITwTGvmMY12F0bXYef
         qXSqJ9W0BnUNJHyCTCpWYb7ohL1FZac0nsQpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QllwIGe4CGfQlfHGQxn6FJsttbRuw0tLf5PsM4D9zgs=;
        b=MV4y+MKhkDBvClptAW6HHTYI0uqAXwyO0WrUshuV8Mt6pupXNI0b7tNLFly/wGdKth
         ADvTreAf8clgeccOEVbs2zYJ6cXQxAWeSaL/9qjJhB3zy9D124WIsTjDm5L9/hWNJI2w
         eHIslQC6hRtNutFJKPTfZz3c5KLej8dziBZ8eGBrpg5Ei51fcW87yj4yQ6YBjQAfhrlY
         FSvG7RYId15Q81WKVswyHoOxRxoyDjwiHNs+lflPry4UWKxjMRlqJb+Z7/6syy+E7bxr
         PEDVCOmIDfJ1tbXX3mtSTig9jMcW1n6qfZb70LW4kWwRl+q+76+Q2jBUcEx+xRxwBTE6
         hwAw==
X-Gm-Message-State: APjAAAVhNsGBhMEfOmNUtSVbikxWc9d9m+9YzFN9V+Sk99PDG/1FR84F
        Rho1IJ6C+mUYfj8qXXGqmMcW0A==
X-Google-Smtp-Source: APXvYqxtspEzWyFRc10KrrOuvuB5oy9MnibV5uCatlbmFmOP0bB3E6v0cm5OyNw2z+/lIYadO0oBbg==
X-Received: by 2002:a17:90a:654b:: with SMTP id f11mr10725913pjs.34.1558716611578;
        Fri, 24 May 2019 09:50:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d20sm3091116pjs.24.2019.05.24.09.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 09:50:10 -0700 (PDT)
Date:   Fri, 24 May 2019 12:50:09 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     rcu@vger.kernel.org
Subject: Re: Should list_entry_rcu use rcu_dereference ?
Message-ID: <20190524165009.GB197789@google.com>
References: <20190504185944.GA79652@google.com>
 <20190506235430.GA3923@linux.ibm.com>
 <20190513033017.GA96252@google.com>
 <20190514222018.GD4184@linux.ibm.com>
 <20190524080737.GA176324@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524080737.GA176324@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 24, 2019 at 04:07:37AM -0400, Joel Fernandes wrote:
[snip]
> > > The purpose of this is to
> > > check if any RCU reader is active at all. I believe after the flavor
> > > consolidation effort, this is a sufficient condition from an RCU perspective.
> > > Having some lockdep checking is better than no lockdep checking so I think it
> > > is good to have. Let me know what you think about the below patch and I can
> > > roll into a proper patch and send it as well (with proper comments).
> > > 
> > > I was able to trigger the lockdep check by removing the preempt_disable()
> > > calls in ftrace_mod_get_kallsym() and insert some modules (PROVE_LOCKING and
> > > FUNCION_TRACE enabled).
> > 
> > The big question is "what would use these?".  Although it would be good
> > to replace uses of rcu_dereference_raw(), many of those are driven by a
> > desire to support both RCU and non-RCU use cases, where in the non-RCU
> > variant the user supplies the lock.
> > 
> > So would these actually see enough use to make their addition worthwhile?
> > If so, which uses are you thinking in terms of?
> 
> Yes true. Actually my initial intent was to add some lockdep checking for
> RCU-list traversal via list_for_each_entry_rcu(). Since the pointers are
> traversed without any lockdep checking due to not going through the
> rcu_dereference API family.
> 
> You are right the patch I shared is complicated, and I could just keep the
> rcu_read_lock_any_held() and use that in list_for_each_entry_rcu for that
> matter (and in any other list RCU APIs doing list traversals). In fact I
> could probably also call this new API as: lockdep_assert_rcu_held().
> 
> Also I noticed there is a rcu_lockdep_assert() mentioned in the
> Requirements.html part of the documentation, but didn't find such a
> definition in the kernel sources. So we should probably also update that ;-)

And I see rcu_lockdep_assert() got converted to RCU_LOCKDEP_WARN in
https://lore.kernel.org/patchwork/patch/580641/

I will toy with the idea of a lockdep_assert_rcu_held() which checks for
consolidated RCU reader sections and use that for list RCU and such, and we
can discuss more on the subsequent RFC.

thanks!


> 
> From Requirements.html:
> 	A given function might wish to check for RCU-related preconditions
> 	upon entry, before using any other RCU API.
> 	The <tt>rcu_lockdep_assert()</tt> does this job,
> 	asserting the expression in kernels having lockdep enabled
> 	and doing nothing otherwise.
> 
> > Sorry to be so skeptical, but it has not been that long since Linus
> > read me the riot act over RCU complexity.  ;-)
> 
> No problem, perfectly legit skepticism ;-)
> 
> thanks,
> 
>  - Joel
> 
> > 
> > 							Thanx, Paul
> > 
> > > ---8<-----------------------
> > > 
> > > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > > index e91ec9ddcd30..334c625ef421 100644
> > > --- a/include/linux/rculist.h
> > > +++ b/include/linux/rculist.h
> > > @@ -273,9 +273,12 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
> > >   *
> > >   * This primitive may safely run concurrently with the _rcu list-mutation
> > >   * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
> > > + *
> > > + * Use rcu_dereference_any() to ensure we are generically within an RCU reader
> > > + * section (whether sched, bh or regular).
> > >   */
> > >  #define list_entry_rcu(ptr, type, member) \
> > > -	container_of(READ_ONCE(ptr), type, member)
> > > +	container_of(rcu_dereference_any(ptr), type, member)
> > >  
> > >  /*
> > >   * Where are list_empty_rcu() and list_first_entry_rcu()?
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 922bb6848813..7481d93ed9bb 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -223,6 +223,7 @@ int debug_lockdep_rcu_enabled(void);
> > >  int rcu_read_lock_held(void);
> > >  int rcu_read_lock_bh_held(void);
> > >  int rcu_read_lock_sched_held(void);
> > > +int rcu_read_lock_any_held(void);
> > >  
> > >  #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > >  
> > > @@ -243,6 +244,12 @@ static inline int rcu_read_lock_sched_held(void)
> > >  {
> > >  	return !preemptible();
> > >  }
> > > +
> > > +static inline int rcu_read_lock_any_held(void)
> > > +{
> > > +	return !preemptible();
> > > +}
> > > +
> > >  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > >  
> > >  #ifdef CONFIG_PROVE_RCU
> > > @@ -472,6 +479,10 @@ static inline void rcu_preempt_sleep_check(void) { }
> > >  	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
> > >  				__rcu)
> > >  
> > > +#define rcu_dereference_any_check(p, c) \
> > > +	__rcu_dereference_check((p), (c) || rcu_read_lock_any_held(), \
> > > +				__rcu)
> > > +
> > >  /*
> > >   * The tracing infrastructure traces RCU (we want that), but unfortunately
> > >   * some of the RCU checks causes tracing to lock up the system.
> > > @@ -525,6 +536,8 @@ static inline void rcu_preempt_sleep_check(void) { }
> > >   */
> > >  #define rcu_dereference_sched(p) rcu_dereference_sched_check(p, 0)
> > >  
> > > +#define rcu_dereference_any(p) rcu_dereference_any_check(p, 0)
> > > +
> > >  /**
> > >   * rcu_pointer_handoff() - Hand off a pointer from RCU to other mechanism
> > >   * @p: The pointer to hand off
> > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > index c3bf44ba42e5..2dab75d34806 100644
> > > --- a/kernel/rcu/update.c
> > > +++ b/kernel/rcu/update.c
> > > @@ -298,6 +298,31 @@ int rcu_read_lock_bh_held(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
> > >  
> > > +int rcu_read_lock_any_held(void)
> > > +{
> > > +	int lockdep_opinion = 0;
> > > +
> > > +	if (!debug_lockdep_rcu_enabled())
> > > +		return 1;
> > > +	if (!rcu_is_watching())
> > > +		return 0;
> > > +	if (!rcu_lockdep_current_cpu_online())
> > > +		return 0;
> > > +
> > > +	if (lock_is_held(&rcu_lock_map))
> > > +		return 1;
> > > +
> > > +	/* BH flavor */
> > > +	if (in_softirq() || irqs_disabled())
> > > +		return 1;
> > > +
> > > +	/* Sched flavor */
> > > +	if (debug_locks)
> > > +		lockdep_opinion = lock_is_held(&rcu_sched_lock_map);
> > > +	return lockdep_opinion || !preemptible();
> > > +}
> > > +EXPORT_SYMBOL_GPL(rcu_read_lock_any_held);
> > > +
> > >  #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
> > >  
> > >  /**
> > > -- 
> > > 2.21.0.1020.gf2820cf01a-goog
> > > 
