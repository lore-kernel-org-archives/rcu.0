Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F1C4338F
	for <rcu@archiver.kernel.org>; Fri, 30 Jul 2021 05:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3632060F0F
	for <rcu@archiver.kernel.org>; Fri, 30 Jul 2021 05:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhG3F5P (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Jul 2021 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbhG3F5P (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Jul 2021 01:57:15 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5E4C061765;
        Thu, 29 Jul 2021 22:57:10 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id a14so8295564ila.1;
        Thu, 29 Jul 2021 22:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5DVSK5IBlRMydOO7jGerNOSiXbfz9hpASpT9yHINJTo=;
        b=IvLhCI3luMg7QhGU18GfhxPji7Mcv+y8HLCWjte6lJBYwbI3tSZF1J2bo3Z+VAHGXA
         nxElwx/HQHXgdn7s0oIChdwwUmfnJbK3AtJ5+4X2dF1+ew1BqnhXvmA0GgUl7pLrZKhl
         4VxJNsik+2Gl3ed/sZl9vpOr5/5IYfGnNe+xmZUdtgs+JLmh1hGcC7NuQy+QfwGkE8bi
         4mWXhQ7XasJplAi7ukmQ49g9d+rOXO2h/fs8XqYzR9CBcopyJvWqVPvJwUlMP7x5Z90z
         6b8B8mhakWoSXikspXYGuTbIk03L2k03uszVGeH8d+pgHWvzpbNdpGkAMTI389IhGsxF
         lBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5DVSK5IBlRMydOO7jGerNOSiXbfz9hpASpT9yHINJTo=;
        b=b77J/nH6nCTlYfuwOKrQ+S3ifD/e/C6D9AxKQ3cMU1Gb+pbkDIs93WJp6awMFK+vnS
         9VkrvDfQW/zP7R1dF9WObK3Y0WQCVgndLATcgve476fZkm3M5wdx+EH0Z2Q/79su2+SO
         T3Z8L8vNGECVLCXNdI31E4c5XdgAyW6r5EZR20id/My/m5PMq1kFrGYWCeYpGpiAaVyA
         TWmvtC78swWVmK9hkNYNP0K+Gm2Xy6NL7VzvBBn88myU4yI7A9g7GZC5NNTwIa6B6fSa
         qc6gne9qifkcH2Jt+r2I+naeEyUUxvB0dBff8gSFlcKS3FrkjZTqF6TMcd6ZEeC2lxf5
         kWcw==
X-Gm-Message-State: AOAM5337+LaM2RvSqv6TOmfkNLVJyC9rmzz785DEkHXEXRQ3+d5cTjov
        UiGwFLx1CPb/wwkEagWXA1A=
X-Google-Smtp-Source: ABdhPJxN1g0acFhZzp3Z/YqqoQ8e20wMv9ydY+JiIOepZSwvTxi8DQuqPg9XIQO+aoeXs6/ev2TASw==
X-Received: by 2002:a92:ddcf:: with SMTP id d15mr109215ilr.184.1627624629554;
        Thu, 29 Jul 2021 22:57:09 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d9sm305807ilu.9.2021.07.29.22.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 22:57:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id A2E6727C0054;
        Fri, 30 Jul 2021 01:57:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 30 Jul 2021 01:57:07 -0400
X-ME-Sender: <xms:spQDYYf3YyLn2W_6rEgLXZ_sHO4HoupmaAMi7O6RuRVDTIR7Ug9q-Q>
    <xme:spQDYaPKXf9reY_XPM49-cx9HmRUMFjuURfmjDLPj7vaxjIj-1-RHek10RmETtyIo
    9lmVBw7upTTmesKNQ>
X-ME-Received: <xmr:spQDYZgRoh75Grlax0Bqyl07BaC-v9ioSfQ8v7quNfwA_4aj0KMINa5RRtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheeggdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeiffdviedtteehffduudfggfegvdejjeeiffehledtgefhheeuheetheelgeeh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:spQDYd950_PJYjQSG2OVU_FN_WFbcFTvoYlDYYiEDkn8i50APtxQoQ>
    <xmx:spQDYUsCYcgMOhDO9Sof6LM1aUppghNDR7mc_5ffGgCFe_e_ueiLbA>
    <xmx:spQDYUH4ZyHQwDa8pSspgEGhdAaQqXJfuFNaN1-ruskXSmhWGO-8uw>
    <xmx:s5QDYfmgXHGkfHJnuvG6i3eBGiB_GtCzlR0VV1OPlwCo_4M0cgOslFpe8w4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jul 2021 01:57:06 -0400 (EDT)
Date:   Fri, 30 Jul 2021 13:56:41 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH rcu 04/18] rcu: Weaken ->dynticks accesses and updates
Message-ID: <YQOUmZmAZQIhjEWC@boqun-archlinux>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org>
 <YQJfjFv8lOnkUkhs@boqun-archlinux>
 <20210729105331.GA301667@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729105331.GA301667@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 29, 2021 at 12:53:31PM +0200, Frederic Weisbecker wrote:
> On Thu, Jul 29, 2021 at 03:58:04PM +0800, Boqun Feng wrote:
> > > The following litmus test, also adapted from the one supplied off-list
> > > by Frederic Weisbecker, models the RCU grace-period kthread detecting
> > > a non-idle CPU that is concurrently transitioning to idle:
> > > 
> > > 	C dynticks-into-idle
> > > 
> > > 	{
> > > 		DYNTICKS=1; (* Initially non-idle. *)
> > > 	}
> > > 
> > > 	P0(int *X, int *DYNTICKS)
> > > 	{
> > > 		int dynticks;
> > > 
> > > 		// Non-idle.
> > > 		WRITE_ONCE(*X, 1);
> > > 		dynticks = READ_ONCE(*DYNTICKS);
> > > 		smp_store_release(DYNTICKS, dynticks + 1);
> > > 		smp_mb();
> > 
> > this smp_mb() is not needed, as we rely on the release-acquire pair to
> > provide the ordering.
> > 
> > This means that if we use different implementations (one w/ smp_mb(),
> > another w/o) rcu_dynticks_inc() for idle-to-nonidle and nonidle-to-idle,
> > we could save a smp_mb(). Thoughts?
> 
> That's exactly what I wanted to propose but everybody was sober. Namely order
> only the RCU read side critical sections before/after idle together:
> 
>      READ side critical section
>      //enter idle
>      //exit idle
>      smp_mb()
>      READ side critical section
> 
> instead of ordering the RCU read side critical section before idle - with the RCU
> idle extended quiescent state - with the RCU read side critical section after idle:
> 
>      READ side critical section
>      //enter idle
>      smp_mb();
>      //exit idle
>      smp_mb()
>      READ side critical section
> 
> So the side effect now is that if the write side waits for the reader to
> report a quiescent state and scans its dynticks state and see it's not yet in
> RCU idle mode, then later on when the read side enters in RCU idle mode we
> expect it to see the write side updates.
> But after the barrier removal the reader will only see the write side update
> once we exit RCU idle mode.
> 
> So the following may happen:
> 
> 	P0(int *X, int *Y, int *DYNTICKS)
> 	{
> 		int y;
> 
> 		WRITE_ONCE(*X, 1);
> 		smp_store_release(DYNTICKS, 1); // rcu_eqs_enter
> 		//smp_mb() not there anymore
> 		y = READ_ONCE(*Y);
> 		smp_store_release(DYNTICKS, 2); // rcu_eqs_exit()
> 		smp_mb();
> 	}
> 
> 	P1(int *X, int *Y, int *DYNTICKS)
> 	{
> 		int x;
> 		int dynticks;
> 		
> 		WRITE_ONCE(*Y, 1);
> 		smp_mb();
> 		dynticks = smp_load_acquire(DYNTICKS);
> 		x = READ_ONCE(*X);
> 	}
> 
> 	exists (1:x=0 /\ 0:y=0)
> 

Thanks for the detailed explanation ;-)

> Theoretically it shouldn't matter because the RCU idle mode isn't
> supposed to perform RCU reads. But theoretically again once a CPU

Right, in LOCKDEP=y kernel, rcu_read_lock_held() requires
rcu_is_watching(), so rcu_dereference() is not allowed in idle mode,
unless using RCU_NONIDLE() or rcu_irq_enter_irqson() to temporarily exit
the idle mode.

> has reported a quiescent state, any further read is expected to see
> the latest updates from the write side.

Yes, but in your above case, doesn't P0 already reach to a quiescent
state even before WRITE_ONCE()? IOW, that case is similar to the
following:

	P0(int *X, int *Y)
	{
		// in QS

		WRITE_ONCE(*X, 1);
		y = READ_ONCE(*Y);
	}

	P1(int *X, int *Y)
	{
		WRITE_ONCE(*Y, 1);
		synchronize_rcu();
		x = READ_ONCE(*X);
	}

	exists (1:x=0 /\ 0:y=0)

And RCU doesn't guarantee the READ_ONCE() on P0 sees the WRITE_ONCE() on
P1.

> 
> So I don't know what to think. In practice I believe it's not a big deal
> because RCU idle mode code is usually a fragile path that just handles
> cpuidle code to put the CPU in/out low power mode. But what about dragons...

My current thought is that if the cpuidle code requires some ordering
with synchronize_rcu(), RCU_NONIDLE() should be used, and ordering can
be guaranteed in this case (RCU_NONIDLE() has a rcu_eqs_exit() in it).
Otherwise, it's a bug.

So looks like we can drop that smp_mb() in rcu_eqs_enter()? At least, we
can say something in the doc to prevent people from relying on the
ordering between normal reads in RCU idle mode and synchronize_rcu().

Thoughts?

Regards,
Boqun
