Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F39C433E1
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 18:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABBD20774
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 18:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2TiJZvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMSu7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSu7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 14:50:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06881C061757
        for <rcu@vger.kernel.org>; Thu, 13 Aug 2020 11:50:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id r21so5635248ota.10
        for <rcu@vger.kernel.org>; Thu, 13 Aug 2020 11:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWLJUcH08S/HKgK2ZBtdUCqQa5XrLi+yfPnrXu3jjJ0=;
        b=C2TiJZvJc6XTMxJIVXA3aUvdSyMWg+5Qyw5GjCyfFvtguilebABTXmJiNIw1WLYB7X
         QhKaObXzHWp0OwWiM05qiy+UhIZpcTQURmtOTqmBMbMrW4/brKAsglnqfwZ9mWE2Xe59
         g5KZwzWOPmgQ5Dqi1KR6ptec6iut8Ewtqrf6Tp8HqHwGOsEp928HePoX+RwBOTEDVNPd
         jtRMiPytj3UCqtbopsKfp+7uIWGGDV2FhbbjBJasqU7hSpVqpZdbN44Al0ip2Xm1sSO1
         70TTfXWsDVizJ5b5MkzNzrArtuzc3+oMbq5Hchi1gZmBROwm3vnpq4l1bNIijDWw7YuK
         1MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWLJUcH08S/HKgK2ZBtdUCqQa5XrLi+yfPnrXu3jjJ0=;
        b=al3YvJQzN4N7p49T4MmrTatXCnXmw7R99smFUGsTpQgB0fDJiqfjDrHqaMCt/f9Imo
         H6dW+ZfRPCAO6ImyjkTP3LmF+UB+ipxGQtYkMdFeExH9OmkYBr9sl1Lr3fGAVIVYKTcV
         dbN5U45muIGBs+Jx8caO7/PUmqaCfAUqjwWYUnpPuJjPLWVDElR6A/I000J9/naPuuIj
         al7QPwOT1S8aVn3w3GpuwxPWMQ/cAta5MdsHkfWuzxkTcfgPS5KkNzIxKRmz1kgPy/Pc
         PC0JR/5XrrkRdw/tSGxJIJxNA/lRMduPC4hh7FyJWK6w4vM0hIHnmYOFbDsPJbWWsDo+
         AeBQ==
X-Gm-Message-State: AOAM531TUSZJFGswJPzOdOHxhlMMVvPhR+kKHJ2KNDYghVhcClrIgM4g
        7nVZ0wi4buOuW7QTbf6s1hxbLY9dIYxaIWKcK5sFRIx1U6k=
X-Google-Smtp-Source: ABdhPJz6VWDGjJ2av3igLuuI3rX2qN48TfhSDoUqNX6ZRj/DGaCKwjogp8rdb7tqVkTIV4iRJLpNferfjOB0NGKqDFI=
X-Received: by 2002:a9d:396:: with SMTP id f22mr5248302otf.6.1597344658296;
 Thu, 13 Aug 2020 11:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
 <20200813181941.GD4295@paulmck-ThinkPad-P72>
In-Reply-To: <20200813181941.GD4295@paulmck-ThinkPad-P72>
From:   Chao Zhou <chaozhou1018@gmail.com>
Date:   Thu, 13 Aug 2020 11:50:47 -0700
Message-ID: <CAJdzfEcgsCDyvVRm4dW1BAfWKKYwgfwjuEimr2wAm+sRO0JFzg@mail.gmail.com>
Subject: Re: Allow multiple GP misses before Panic
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thanks Paul for the insights!

I studied the 3 options and think that #1+#3 offers both flexibility
to users and coverage of boundary user cases.

For example, as an user of RCU, we want the warnings to be spilled at
the default 21 seconds so that we know such events are happening. At
the same time, we want Panic to happen if the stall is long enough to
significantly affect available system memory on our system.

Here is the plan based on our discussion, please advise if not inline
with the idea:
1. modify panic_on_rcu_stall to be the maximum number of consecutive
warnings to trigger Panic.
    1) change its name to max_rcu_stall_to_panic,
    2) default value to 1, which is the same behavior as today's.
2. use ((struct rcu_state *)->gpnum - (struct rcu_data *)->gpnum) >=
max_rcu_stall_to_panic as condition to trigger Panic;
3. reset (struct rcu_data *)->gpnum to (struct rcu_state *)->gpnum
every time a new grace period starts;
4. add a new member (struct rcu_data *)->gpmiss that is incremented at
each miss to track how many misses so far for statistics/debug
purpose.

Your insights and advice are highly appreciated.

Thanks!

Chao

On Thu, Aug 13, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Aug 13, 2020 at 10:22:09AM -0700, Chao Zhou wrote:
> > Hi,
> >
> > Some RCU stalls are transient and a system is fully capable to recover
> > after that, but we do want Panic after certain amount of GP misses.
> >
> > Current module parameter rcu_cpu_stall_panic only turn on/off Panic,
> > and 1 GP miss will trigger Panic when it is enabled.
> >
> > Plan to add a module parameter for users to fine-tune how many GP
> > misses are allowed before Panic.
> >
> > To save our precious time, a diff has been tested on our systems and
> > it works and solves our problem in transient RCU stall events.
> >
> > Your insights and guidance is highly appreciated.
>
> Please feel free to post a patch.  I could imagine a number of things
> you might be doing from your description above:
>
> 1.      Having a different time for panic, so that (for example) an
>         RCU CPU stall warning appears at 21 seconds (in mainline), and
>         if the grace period still has not ended at some time specified
>         by some kernel parameter.  For example, one approach would be
>         to make the existing panic_on_rcu_stall sysctl take an integer
>         instead of a boolean, and to make that integer specify how old
>         the stall-warned grace period must be before panic() is invoked.
>
> 2.      Instead use the number of RCU CPU stall warning messages to
>         trigger the panic, so that (for example), the panic would happen
>         on the tenth message.  Again, the panic_on_rcu_stall sysctl
>         might be used for this.
>
> 3.      Like #2, but reset the count every time a new grace period
>         starts.  So if the panic_on_rcu_stall sysctl was set to
>         ten, there would need to be ten RCU CPU stall warnings for
>         the same grace period before panic() was invoked.
>
> Of the above three, #1 and #3 seem the most attractive, with a slight
> preference for #1.
>
> Or did you have something else in mind?
>
>                                                         Thanx, Paul
