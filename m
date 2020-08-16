Return-Path: <SRS0=FxgN=B2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFCEC433E1
	for <rcu@archiver.kernel.org>; Sun, 16 Aug 2020 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307C620739
	for <rcu@archiver.kernel.org>; Sun, 16 Aug 2020 23:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX7luAj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHPX40 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Aug 2020 19:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgHPX40 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Aug 2020 19:56:26 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A3C061786
        for <rcu@vger.kernel.org>; Sun, 16 Aug 2020 16:56:25 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a24so13350875oia.6
        for <rcu@vger.kernel.org>; Sun, 16 Aug 2020 16:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emmxucoxN2cgrXIoxcyepyuvxX5SsCAWb3NY1NXab5k=;
        b=gX7luAj2A245cTmdm6RCYXGY+6SZ5sXB610rwUKi+Kf9FMibS/yxG2+/RrtgX8RzNB
         dut7FIZY2yEbqEnHIzZRpgsTgP/IOovu0YAVDYERQqFVGHCagl5HVpuECTARMSmF+uKA
         ZPpfh3GKyKeHt9yPyq5mqu859x7GL+uWIu+Itxo9RvNwlryY4Qr7PJXN6m0z/o2hYaeN
         VeMW+T8gCzN8QJOQNKV62Eway8A6wjye9EFaDbSpLiUd3hB/5HK8YDYfF2cgTCWSzJYh
         LnPnfEoUK2ZeBx8ij1DwmIYq+iOCXwiqEap7vO7RXfxx+bSxZ/q7tPdfR3pJ64HAueoP
         p2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emmxucoxN2cgrXIoxcyepyuvxX5SsCAWb3NY1NXab5k=;
        b=KV9HKHIfoYzyDhsMf94B4QfMwvMoofFgeZNRRxiy9KwTRWuG5HKCzmL33RWGhrRdmK
         JidLNXwUottMRRVal3FYvDjOFH6sSzO7jd0rmub0lslSad9CqgRXLweivigzPLQXefAx
         IlYFl8pBty7cGyMfExUkJ5vbL0dCHoBBoybLgwkJW8vpf8IC21q3tB3h68+w+dgVnOv4
         MpKNwaCr8N/yiJy376GGvWcFp8x8QK2EcxeTZC4jKIuHGfA//+49r1XIg4ZMxPNmsOfO
         BvSFbn+4ZXyo0s7hws/1R5n2fcsBFO9o41XAUEsAaY45yQ50KGP/mFpv6c4+HQ1DT/Pz
         GdJQ==
X-Gm-Message-State: AOAM530DFGg5jALxxMhyjpRrpOj4Ict0ahm/kyboyq+JNslPCpg1F+MW
        4r5y2SlWWUFmBU+5bF8mQvDqkiEgtMh4vLWZrTA=
X-Google-Smtp-Source: ABdhPJyk7HDT5yj1ujNVUOmprEhZj/8aUlOvAxLxq/zexa1t6Nylg4GPqGdEHT0moUTohHzAl72E3c7vVA8AOdH8WKk=
X-Received: by 2002:aca:220b:: with SMTP id b11mr7753831oic.126.1597622182155;
 Sun, 16 Aug 2020 16:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJdzfEd6nf9xBw7w26EdsM5ukpDEhKNc0L6PW7SKKJDCgtt+Sg@mail.gmail.com>
 <20200813181941.GD4295@paulmck-ThinkPad-P72> <CAJdzfEcgsCDyvVRm4dW1BAfWKKYwgfwjuEimr2wAm+sRO0JFzg@mail.gmail.com>
 <CAJdzfEdfCFqF4t8kNL4UriBW8xTMtsgx7FNjQZwPHzTFQaATiA@mail.gmail.com> <20200816180137.GA23602@paulmck-ThinkPad-P72>
In-Reply-To: <20200816180137.GA23602@paulmck-ThinkPad-P72>
From:   Chao Zhou <chaozhou1018@gmail.com>
Date:   Sun, 16 Aug 2020 16:56:11 -0700
Message-ID: <CAJdzfEdsvS6rG+w9a4BJN-m=ySqtGBW7=2DgDsx=FRRrE__PPA@mail.gmail.com>
Subject: Re: Allow multiple GP misses before Panic
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Great, thanks!

On Sun, Aug 16, 2020 at 11:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Aug 13, 2020 at 12:00:07PM -0700, Chao Zhou wrote:
> > Hi Paul,
> >
> > Because sysctl panic_on_rcu_stall is public interface, it might have
> > already been used by adopters, will the change break them? Will a new
> > sysctl max_rcu_stall_to_panic be more un-interruptive? Appreciate your
> > insights about this .
>
> It is a public interface, but using the previously forbidden values
> other than zero and one is fine.
>
>                                                         Thanx, Paul
>
> > On Thu, Aug 13, 2020 at 11:50 AM Chao Zhou <chaozhou1018@gmail.com> wrote:
> > >
> > > Thanks Paul for the insights!
> > >
> > > I studied the 3 options and think that #1+#3 offers both flexibility
> > > to users and coverage of boundary user cases.
> > >
> > > For example, as an user of RCU, we want the warnings to be spilled at
> > > the default 21 seconds so that we know such events are happening. At
> > > the same time, we want Panic to happen if the stall is long enough to
> > > significantly affect available system memory on our system.
> > >
> > > Here is the plan based on our discussion, please advise if not inline
> > > with the idea:
> > > 1. modify panic_on_rcu_stall to be the maximum number of consecutive
> > > warnings to trigger Panic.
> > >     1) change its name to max_rcu_stall_to_panic,
> > >     2) default value to 1, which is the same behavior as today's.
> > > 2. use ((struct rcu_state *)->gpnum - (struct rcu_data *)->gpnum) >=
> > > max_rcu_stall_to_panic as condition to trigger Panic;
> > > 3. reset (struct rcu_data *)->gpnum to (struct rcu_state *)->gpnum
> > > every time a new grace period starts;
> > > 4. add a new member (struct rcu_data *)->gpmiss that is incremented at
> > > each miss to track how many misses so far for statistics/debug
> > > purpose.
> > >
> > > Your insights and advice are highly appreciated.
> > >
> > > Thanks!
> > >
> > > Chao
> > >
> > > On Thu, Aug 13, 2020 at 11:19 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 13, 2020 at 10:22:09AM -0700, Chao Zhou wrote:
> > > > > Hi,
> > > > >
> > > > > Some RCU stalls are transient and a system is fully capable to recover
> > > > > after that, but we do want Panic after certain amount of GP misses.
> > > > >
> > > > > Current module parameter rcu_cpu_stall_panic only turn on/off Panic,
> > > > > and 1 GP miss will trigger Panic when it is enabled.
> > > > >
> > > > > Plan to add a module parameter for users to fine-tune how many GP
> > > > > misses are allowed before Panic.
> > > > >
> > > > > To save our precious time, a diff has been tested on our systems and
> > > > > it works and solves our problem in transient RCU stall events.
> > > > >
> > > > > Your insights and guidance is highly appreciated.
> > > >
> > > > Please feel free to post a patch.  I could imagine a number of things
> > > > you might be doing from your description above:
> > > >
> > > > 1.      Having a different time for panic, so that (for example) an
> > > >         RCU CPU stall warning appears at 21 seconds (in mainline), and
> > > >         if the grace period still has not ended at some time specified
> > > >         by some kernel parameter.  For example, one approach would be
> > > >         to make the existing panic_on_rcu_stall sysctl take an integer
> > > >         instead of a boolean, and to make that integer specify how old
> > > >         the stall-warned grace period must be before panic() is invoked.
> > > >
> > > > 2.      Instead use the number of RCU CPU stall warning messages to
> > > >         trigger the panic, so that (for example), the panic would happen
> > > >         on the tenth message.  Again, the panic_on_rcu_stall sysctl
> > > >         might be used for this.
> > > >
> > > > 3.      Like #2, but reset the count every time a new grace period
> > > >         starts.  So if the panic_on_rcu_stall sysctl was set to
> > > >         ten, there would need to be ten RCU CPU stall warnings for
> > > >         the same grace period before panic() was invoked.
> > > >
> > > > Of the above three, #1 and #3 seem the most attractive, with a slight
> > > > preference for #1.
> > > >
> > > > Or did you have something else in mind?
> > > >
> > > >                                                         Thanx, Paul
