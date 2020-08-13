Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609E3C433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 21:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3348B204EC
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 21:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elbXdGx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMV5e (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMV5d (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 17:57:33 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F5EC061757
        for <rcu@vger.kernel.org>; Thu, 13 Aug 2020 14:57:33 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h3so6413776oie.11
        for <rcu@vger.kernel.org>; Thu, 13 Aug 2020 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/q4PtMlu9wxRZ07Q6EmydB4ZcP8+vsrq9plCQqFt42U=;
        b=elbXdGx/L0uaKctsMjM8kKV/idt8iCJuTorGigDo1H42ktQoPGIIHRve723B0dllHg
         zkV2g06uX1ly2rIzDr1cUCK58cs0KCTIUHjNhZNeUmcDG7UhfWl/jqGd29NU26aKMike
         r31Mrt6r1PJwuGa7IAdF6MgPGQndRJNtMpG0rL83jFSfR3/W9WxWQF9kazDHDpqFoZkY
         m22kyCB2tR/k0hPAuWolBSnilq/fuqLVb9APiY2o96sylHrnxPpxAoPXn/8N7XQdYbYl
         0sd1SnL3Y1QGOODJlhs1HtfKIIO/SOyZAX1ppq9LM+jOeaiKfOS35t3iLRYwMQPeZ3GD
         kzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/q4PtMlu9wxRZ07Q6EmydB4ZcP8+vsrq9plCQqFt42U=;
        b=N10DSEKAHqa/VhjrFZpPo6PZ8fAS6ro/qSxW6YJTFNMSoNtHmnt51vz6eXUsN+h7Oj
         lI1lluvdNrAhZ5dsz4KBx2t7NrhbeDSDiwlojLSvPC4npF/lubDAlqxRAVyUEYy05q6A
         503ytVZpR69RFL6TOAw4dd1yaKd3S9AV9EE9KJ3m2q/oycSQmcXkOYJhs0Izhp9HWOaR
         iTsgaKShN0gHYZnYU/ljf5Y9DjG1t94snLgyFVzoug0o/IrZe/lS+hcUiNbgGmQ47EW8
         1l5kvoP//omO0OYlCWAZlXaGbTyU0XvDfb4oxLa0g6BJfzdn3/bIRjS9TXE2j09ZjvJK
         7sQg==
X-Gm-Message-State: AOAM532EfBgDNiOWFBklEkYcSs3a5sZ3aBjOqdi5+ZRZXm9yasHOg8LN
        05sUde+o8e8Evck41SUvAR5uycfG0ZxBoyI5m9Uin5Ug
X-Google-Smtp-Source: ABdhPJymK2uE01ZRLNwexGWrwd+8SkGKo/YLTHMtNabJgG5aXuMWMBULHZIJi1cjNbnIYkQUtJel/CbHb6u3kKFpYh4=
X-Received: by 2002:aca:2101:: with SMTP id 1mr5065268oiz.170.1597355851206;
 Thu, 13 Aug 2020 14:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
 <20200813181941.GD4295@paulmck-ThinkPad-P72> <CAJdzfEcgsCDyvVRm4dW1BAfWKKYwgfwjuEimr2wAm+sRO0JFzg@mail.gmail.com>
 <20200813212126.GG4295@paulmck-ThinkPad-P72>
In-Reply-To: <20200813212126.GG4295@paulmck-ThinkPad-P72>
From:   Chao Zhou <chaozhou1018@gmail.com>
Date:   Thu, 13 Aug 2020 14:57:20 -0700
Message-ID: <CAJdzfEcOXGEyuJQi=Hw9mdy_dhcyF9=Aiv8+VOfQvgpAULqHFg@mail.gmail.com>
Subject: Re: Allow multiple GP misses before Panic
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thanks Paul, please see inline @chao.

On Thu, Aug 13, 2020 at 2:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Aug 13, 2020 at 11:50:47AM -0700, Chao Zhou wrote:
> > Thanks Paul for the insights!
> >
> > I studied the 3 options and think that #1+#3 offers both flexibility
> > to users and coverage of boundary user cases.
> >
> > For example, as an user of RCU, we want the warnings to be spilled at
> > the default 21 seconds so that we know such events are happening. At
> > the same time, we want Panic to happen if the stall is long enough to
> > significantly affect available system memory on our system.
>
> OK, good, you want to panic only on long stalls, not on multiple short
> stalls.  Makes sense!
>
> By the way, the short stalls sometimes indicate bugs that should
> be fixed.  For example, there might be a long loop in the kernel
> that needs an added cond_resched().  Fixing those would make your
> systems less noisy.
>
> I am not asking you to do anything I don't do myself:
>
> 0a3b3c253a1e ("mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls")
> 9f47eb5461aa ("fs/btrfs: Add cond_resched() for try_release_extent_mapping() stalls")

@chao: Yes exactly, any stall will warn, that is why I want to add
miss statistics.
but mostly it is long stalls that hold on to Read Copy and detriment
system's capability to a point that we have to Panic :) .

cond_resched is exactly the API I am asking my team to do as one of
the ways to fix some of the stallers. Feel honored that we are on same
page.

>
> > Here is the plan based on our discussion, please advise if not inline
> > with the idea:
> > 1. modify panic_on_rcu_stall to be the maximum number of consecutive
> > warnings to trigger Panic.
> >     1) change its name to max_rcu_stall_to_panic,
>
> This change would make sense were it not for the possibility that there
> are lots of existing "panic_on_rcu_stall" instances in scripts, boot
> parameters, and so on.  We need the old name for compatibility, and with
> "0" and "1" having the same meanings as before.  We -can- use other
> numbers because those other numbers were not legal before.
>
> So we don't get to change the name.

@chao: Thanks that is why I post a follow up email about this to get
your advice. It is public API, better find another way.

>
> >     2) default value to 1, which is the same behavior as today's.
>
> The default value must be zero, which needs to mean "don't ever panic".
> Setting the value to "1" must mean "panic after the very first RCU CPU
> stall warning.  Other values can have other meanings.
>
> But you could use the existing panic_on_rcu_stall to be (say) the number
> of stall-warning messages that will be tolerated in a given grace period
> before panicking.
>
> Then you could create a new panic_on_rcu_stall_age or similar that
> does the time-based panicking.

@chao: good suggestions, will use in the patch.

>
> Either way, people currently using panic_on_rcu_stall need to be able
> to continue using panic_on_rcu_stall exactly as they are without seeing
> any change in behavior.  We don't break users if we have a choice,
> and here we really do have a choice.  So we don't break users.
>

@chao: sure will do. Also learning the best practices.

> > 2. use ((struct rcu_state *)->gpnum - (struct rcu_data *)->gpnum) >=
> > max_rcu_stall_to_panic as condition to trigger Panic;
>
> This probably won't do what you want.  This would trigger only if
> the rcu_data structure's ->gpnum were to lag behind the rcu_state
> structure's ->gpnum, which happens now whenever a CPU is idle for
> an extended time period.
>
> For the time-based approach (#1 below), the idea would be to compare
> against the rcu_state structure's ->gp_start field, and even then only
> when a grace period is actually in progress.  One way to do this is
> to check against the "gps" local variable in check_cpu_stall() in
> kernel/rcu/tree_stall.h.

@chao: good advice, will do in patch.

>
> > 3. reset (struct rcu_data *)->gpnum to (struct rcu_state *)->gpnum
> > every time a new grace period starts;
>
> Touching every rcu_data structure at the beginning of each grace
> period will slow things down.  This slowdown is avoided in the
> current code by having each CPU update its rcu_data structure's
> ->gpnum when it notices a new grace period.
>
> And ->gpnum and ->completed have been combined into a single ->gp_seq
> in recent kernels.
>
> So it is better to compare against ->gp_start (AKA "gps") as discussed
> above.

@chao: good advice, will do in patch.

>
> > 4. add a new member (struct rcu_data *)->gpmiss that is incremented at
> > each miss to track how many misses so far for statistics/debug
> > purpose.
>
> This is for #3 below, correct?
>
> If so, please instead create an ->nstalls_cur_gp or similar in the
> rcu_state structure.  Zero this at the beginning of every grace
> period (in record_gp_stall_check_time() in kernel/rcu/tree_stall.h)
> and increment and check it in both legs of the "if" statement at the
> end of check_cpu_stall() in this same file.

@chao: sure will do.

>
> > Your insights and advice are highly appreciated.
>
> Please let me know how it goes!

@chao: Thanks Paul, I think we are at a stage where I need to post a
patch for more suggestions.

>
>                                                         Thanx, Paul
>
> > Thanks!
> >
> > Chao
> >
> > On Thu, Aug 13, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Aug 13, 2020 at 10:22:09AM -0700, Chao Zhou wrote:
> > > > Hi,
> > > >
> > > > Some RCU stalls are transient and a system is fully capable to recover
> > > > after that, but we do want Panic after certain amount of GP misses.
> > > >
> > > > Current module parameter rcu_cpu_stall_panic only turn on/off Panic,
> > > > and 1 GP miss will trigger Panic when it is enabled.
> > > >
> > > > Plan to add a module parameter for users to fine-tune how many GP
> > > > misses are allowed before Panic.
> > > >
> > > > To save our precious time, a diff has been tested on our systems and
> > > > it works and solves our problem in transient RCU stall events.
> > > >
> > > > Your insights and guidance is highly appreciated.
> > >
> > > Please feel free to post a patch.  I could imagine a number of things
> > > you might be doing from your description above:
> > >
> > > 1.      Having a different time for panic, so that (for example) an
> > >         RCU CPU stall warning appears at 21 seconds (in mainline), and
> > >         if the grace period still has not ended at some time specified
> > >         by some kernel parameter.  For example, one approach would be
> > >         to make the existing panic_on_rcu_stall sysctl take an integer
> > >         instead of a boolean, and to make that integer specify how old
> > >         the stall-warned grace period must be before panic() is invoked.
> > >
> > > 2.      Instead use the number of RCU CPU stall warning messages to
> > >         trigger the panic, so that (for example), the panic would happen
> > >         on the tenth message.  Again, the panic_on_rcu_stall sysctl
> > >         might be used for this.
> > >
> > > 3.      Like #2, but reset the count every time a new grace period
> > >         starts.  So if the panic_on_rcu_stall sysctl was set to
> > >         ten, there would need to be ten RCU CPU stall warnings for
> > >         the same grace period before panic() was invoked.
> > >
> > > Of the above three, #1 and #3 seem the most attractive, with a slight
> > > preference for #1.
> > >
> > > Or did you have something else in mind?
> > >
> > >                                                         Thanx, Paul
