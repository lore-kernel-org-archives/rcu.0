Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993DCC433EF
	for <rcu@archiver.kernel.org>; Tue, 31 May 2022 18:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiEaSvw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 May 2022 14:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiEaSvv (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 May 2022 14:51:51 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4CA5F7C
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 11:51:50 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id ea7so4817674qvb.12
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UkJnJUznWc4LNcj6tcgMY9XCh2Q62Kzx7qiikBqJWQo=;
        b=dTe4RTghH/5Z0uRLef+Uktb5Vr14VrukNIQLW63LkhorMi2yCNnvd4rqJWz6b6POhF
         fmc1feLkCVK78059UYW5cn0nBL0CE+Yrt26Kg3gOIDD6fi+S1ryd0tWp654mCEVfcPvo
         E2cKSUxYwpUpZPFezDnwFj1+2MLe+AqofO3uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UkJnJUznWc4LNcj6tcgMY9XCh2Q62Kzx7qiikBqJWQo=;
        b=C7e5zjosmYeb7jyQJtZUSQcbheo22vVzuF9f05o7ZAVF+eK4JqCH0Bnz9RLuqO2E/C
         jf35WP8P9ksq/e27aJLMsqksRrgbVbM6DbGVGm7jElgQ1VzBF7JWyxmG/BlHITugmWqh
         x7L++ozXGE3zDgNvWhFhniYqDW72DzNmNpjk69KbdJ5lhrPpL4fisPGWIbbOlw4WgJAY
         Lv0D3XvBDkoYWnFmqBkwteqs0ekvVjILRwzxwybpPbWx902STU6+LtEntufbuv5JFPlO
         YhaUjYCT++GgBQXMf63//TwhwRaR4LponqymJq3oj/qSFZDMnu6HyRf/kVnjTAhsVKjd
         X7qA==
X-Gm-Message-State: AOAM530o67rTUgf0rEPwWwjW/uNPWNc7sUCZaW9sgVajOK1opc+3rVbE
        QwMiwGi5ac0D2LWmVTULNZZRQA==
X-Google-Smtp-Source: ABdhPJzIAgDE22IbHkcXWO2wtIG08Xo6hlVK4F5H854AbsQD7SKfUFvtZakBai4n/1KPYhRDQvuO7g==
X-Received: by 2002:a05:6214:1c8f:b0:443:8505:14b3 with SMTP id ib15-20020a0562141c8f00b00443850514b3mr52823499qvb.7.1654023109120;
        Tue, 31 May 2022 11:51:49 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d8-20020a05620a204800b006a34df5a9a9sm9337516qka.126.2022.05.31.11.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 11:51:48 -0700 (PDT)
Date:   Tue, 31 May 2022 18:51:48 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <YpZjxKX5sNwl9wMK@google.com>
References: <Yn/F8V5kYR8fybPV@google.com>
 <20220514163421.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpFawyhgLCj1+X1A@google.com>
 <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org>
 <20220530164203.GB1790663@paulmck-ThinkPad-P17-Gen-1>
 <0da0d321-7007-2c19-7f85-11d6ef8fed1f@joelfernandes.org>
 <20220531042624.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <6def6fce-13e2-7b80-467f-56a33124d67f@joelfernandes.org>
 <20220531164534.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531164534.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 31, 2022 at 09:45:34AM -0700, Paul E. McKenney wrote:
[..] 
> > Example:
> > 1. Say 5 lazy CBs queued onto bypass list (while the regular cblist is
> > empty).
> > 2. Now say 10000 non-lazy CBs are queued. As per the comments, these
> > have to go to the bypass list to keep rcu_barrier() from breaking.
> > 3. Because this causes the bypass list to overflow, all the lazy +
> > non-lazy CBs have to flushed to the main -cblist.
> > 
> > If only the non-lazy CBs are flushed, rcu_barrier() might break. If all
> > are flushed, then the lazy ones lose their laziness property as RCU will
> > be immediately kicked off to process GPs on their behalf.
> 
> Exactly why is this loss of laziness a problem?  You are doing that
> grace period for the 10,000 non-lazy callbacks anyway, so what difference
> could the five non-lazy callbacks possibly make?

It does not make any difference, I kind of answered my own question. I was
thinking out loud in this thread (Sorry).

> > This can fixed by making rcu_barrier() queue both a lazy and non-lazy
> > CB, and only flushing the non-lazy CBs on a bypass list overflow, to the
> > ->cblist, I think.
> 
> I don't see anything that needs fixing.  If you are doing a grace period
> anyway, just process the lazy callbacks along with the non-lazy callbacks.
> After all, you are paying for that grace period anyway.  And handling
> the lazy callbacks with that grace period means that you don't need a
> later grace period for those five lazy callbacks.  So running the lazy
> callbacks into the grace period required by the non-lazy callbacks is
> a pure win, right?
> 
> If it is not a pure win, please explain exactly what is being lost.

Agreed. As discussed on IRC, we can only care about increment of the lazy
length, and the flush will drop it to 1 or 0. No need to design for partial
flushing for now as no usecase.

> > Or, we flush both -lazy and non-lazy CBs to the ->cblist just to keep it
> > simple. I think that should be OK since if there are a lot of CBs queued
> > in a short time, I don't think there is much opportunity for power
> > savings anyway IMHO.
> 
> I believe that it will be simpler, faster, and more energy efficient to
> do it this way, flushing everything from the bypass list to ->cblist.
> Again, leaving the lazy callbacks lying around means that there must be a
> later battery-draining grace period that might not be required otherwise.

Perfect.

> > >> Currently the struct looks like this:
> > >>
> > >> struct rcu_segcblist {
> > >>         struct rcu_head *head;
> > >>         struct rcu_head **tails[RCU_CBLIST_NSEGS];
> > >>         unsigned long gp_seq[RCU_CBLIST_NSEGS];
> > >> #ifdef CONFIG_RCU_NOCB_CPU
> > >>         atomic_long_t len;
> > >> #else
> > >>         long len;
> > >> #endif
> > >>         long seglen[RCU_CBLIST_NSEGS];
> > >>         u8 flags;
> > >> };
> > >>
> > >> So now, it would need to be like this?
> > >>
> > >> struct rcu_segcblist {
> > >>         struct rcu_head *head;
> > >>         struct rcu_head **tails[RCU_CBLIST_NSEGS];
> > >>         unsigned long gp_seq[RCU_CBLIST_NSEGS];
> > >> #ifdef CONFIG_RCU_NOCB_CPU
> > >>         struct rcu_head *lazy_head;
> > >>         struct rcu_head **lazy_tails[RCU_CBLIST_NSEGS];
> > >>         unsigned long lazy_gp_seq[RCU_CBLIST_NSEGS];
> > >>         atomic_long_t lazy_len;
> > >> #else
> > >>         long len;
> > >> #endif
> > >>         long seglen[RCU_CBLIST_NSEGS];
> > >>         u8 flags;
> > >> };
> > > 
> > > I freely confess that I am not loving this arrangement.  Large increase
> > > in state space, but little benefit that I can see.  Again, what am I
> > > missing here?
> > 
> > I somehow thought tracking GPs separately for the lazy CBs requires
> > duplication of the rcu_head pointers/double-points in this struct. As
> > you pointed, just tracking the lazy len may be sufficient.
> 
> Here is hoping!
> 
> After all, if you thought that taking care of applications that need
> expediting of grace periods is scary, well, now...

Haha... my fear is I don't know all the applications requiring expedited GP
and I keep getting surprised by new RCU usages that pop up in the system, or
new systems.

For one, a number of tools and processes, use ftrace directly in the system,
and it may not be practical to chase down every tool. Some of them start
tracing randomly in the system. Handling it in-kernel itself would be best if
possible.

Productive email discussion indeed! On to writing the code :P
 
Thanks,

 - Joel
