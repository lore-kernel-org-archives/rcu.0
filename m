Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5F1C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FE020774
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKjE/dEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMTAT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMTAT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 15:00:19 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C0BC061757
        for <rcu@vger.kernel.org>; Thu, 13 Aug 2020 12:00:19 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id v13so5970509oiv.13
        for <rcu@vger.kernel.org>; Thu, 13 Aug 2020 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QGoXVOPfPxZsEqNycZbFl0sWQNy+mhbDAXkejSPHtDU=;
        b=uKjE/dEWnnNSWG6P6/XU9zVLlhND4m+HRs/hS5zrSauBFgh6WxJsosF5ZAfaAZxEsV
         GVt7eCZv2Uj6Tixn+560Y7dZtCH2KVZQ9gzVvi5gseSeT8thfVbQKbdRXg4ij70Vyy/H
         MjX7Igqd+bLEH0CWBg46wfSMiosYOEoSWsp/kwe9bJa3xIROex/VNh4nFUZRbkrd6yVa
         jPkWch/hqu6zv6MQxZ0gRNoSwyZZK6MMakSxw9HoXCH+WCGl7bSh/v0LRpJf+mJsC2hL
         aRHSbrSiV2iB6WXtYtvEKM+8+z7GZxBDYRf7wseDZA8bNAgnoapYDp48nZBDHGBbWYA+
         U3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QGoXVOPfPxZsEqNycZbFl0sWQNy+mhbDAXkejSPHtDU=;
        b=Xm7hHqMpAczRuEgw+mBypekfkibxIPMidQWFP+sAyiMTzU83c5PA7KcjrJqwIQKKo3
         yMv4d92sowZPf1KOb8RODa8ut8TQvZ45yBdWnfOhQOhz/shcoNqWyY28Zu2EMQzSQJqw
         OuaJpEPech5fSo/yGENEOr0L/B1a9nxh1CmFFhiwXbLfh8pXFBbwg5p9ibPzCVtjqv64
         lfVdOXS0+pxCF46R2/oQ9xURukOCGVB0bfdjTB1rKEv0KNEKSlcEgWWfLQuvEvBwdteo
         LnaDPwhjinZoJm+6uTf4qq1+m4C3WbL2q+z2Gvy66ZNo/P7R5WasmBTGRLqEXPuoyYkJ
         ZqeQ==
X-Gm-Message-State: AOAM531F7+E75HZOPtvNmBBfzJiGV6cQJhRGbH/smVxiIPfTgpheZVEL
        rMC8/zIcpw8bpflb9dkopDrkMyXZ+jHNvmA4lKY=
X-Google-Smtp-Source: ABdhPJzIdBC8izXWCHiu9EuZ0XNmid+NL2O7nFvOUCWt1Hz/D+s6aMmuqBcB3EA/mKpaVEYX1W5ANoRGBcGr85PkzeA=
X-Received: by 2002:aca:2101:: with SMTP id 1mr4639132oiz.170.1597345218288;
 Thu, 13 Aug 2020 12:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
 <20200813181941.GD4295@paulmck-ThinkPad-P72> <CAJdzfEcgsCDyvVRm4dW1BAfWKKYwgfwjuEimr2wAm+sRO0JFzg@mail.gmail.com>
In-Reply-To: <CAJdzfEcgsCDyvVRm4dW1BAfWKKYwgfwjuEimr2wAm+sRO0JFzg@mail.gmail.com>
From:   Chao Zhou <chaozhou1018@gmail.com>
Date:   Thu, 13 Aug 2020 12:00:07 -0700
Message-ID: <CAJdzfEdfCFqF4t8kNL4UriBW8xTMtsgx7FNjQZwPHzTFQaATiA@mail.gmail.com>
Subject: Re: Allow multiple GP misses before Panic
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

Because sysctl panic_on_rcu_stall is public interface, it might have
already been used by adopters, will the change break them? Will a new
sysctl max_rcu_stall_to_panic be more un-interruptive? Appreciate your
insights about this .

On Thu, Aug 13, 2020 at 11:50 AM Chao Zhou <chaozhou1018@gmail.com> wrote:
>
> Thanks Paul for the insights!
>
> I studied the 3 options and think that #1+#3 offers both flexibility
> to users and coverage of boundary user cases.
>
> For example, as an user of RCU, we want the warnings to be spilled at
> the default 21 seconds so that we know such events are happening. At
> the same time, we want Panic to happen if the stall is long enough to
> significantly affect available system memory on our system.
>
> Here is the plan based on our discussion, please advise if not inline
> with the idea:
> 1. modify panic_on_rcu_stall to be the maximum number of consecutive
> warnings to trigger Panic.
>     1) change its name to max_rcu_stall_to_panic,
>     2) default value to 1, which is the same behavior as today's.
> 2. use ((struct rcu_state *)->gpnum - (struct rcu_data *)->gpnum) >=
> max_rcu_stall_to_panic as condition to trigger Panic;
> 3. reset (struct rcu_data *)->gpnum to (struct rcu_state *)->gpnum
> every time a new grace period starts;
> 4. add a new member (struct rcu_data *)->gpmiss that is incremented at
> each miss to track how many misses so far for statistics/debug
> purpose.
>
> Your insights and advice are highly appreciated.
>
> Thanks!
>
> Chao
>
> On Thu, Aug 13, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Aug 13, 2020 at 10:22:09AM -0700, Chao Zhou wrote:
> > > Hi,
> > >
> > > Some RCU stalls are transient and a system is fully capable to recover
> > > after that, but we do want Panic after certain amount of GP misses.
> > >
> > > Current module parameter rcu_cpu_stall_panic only turn on/off Panic,
> > > and 1 GP miss will trigger Panic when it is enabled.
> > >
> > > Plan to add a module parameter for users to fine-tune how many GP
> > > misses are allowed before Panic.
> > >
> > > To save our precious time, a diff has been tested on our systems and
> > > it works and solves our problem in transient RCU stall events.
> > >
> > > Your insights and guidance is highly appreciated.
> >
> > Please feel free to post a patch.  I could imagine a number of things
> > you might be doing from your description above:
> >
> > 1.      Having a different time for panic, so that (for example) an
> >         RCU CPU stall warning appears at 21 seconds (in mainline), and
> >         if the grace period still has not ended at some time specified
> >         by some kernel parameter.  For example, one approach would be
> >         to make the existing panic_on_rcu_stall sysctl take an integer
> >         instead of a boolean, and to make that integer specify how old
> >         the stall-warned grace period must be before panic() is invoked.
> >
> > 2.      Instead use the number of RCU CPU stall warning messages to
> >         trigger the panic, so that (for example), the panic would happen
> >         on the tenth message.  Again, the panic_on_rcu_stall sysctl
> >         might be used for this.
> >
> > 3.      Like #2, but reset the count every time a new grace period
> >         starts.  So if the panic_on_rcu_stall sysctl was set to
> >         ten, there would need to be ten RCU CPU stall warnings for
> >         the same grace period before panic() was invoked.
> >
> > Of the above three, #1 and #3 seem the most attractive, with a slight
> > preference for #1.
> >
> > Or did you have something else in mind?
> >
> >                                                         Thanx, Paul
