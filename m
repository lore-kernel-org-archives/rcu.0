Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E6C433EF
	for <rcu@archiver.kernel.org>; Mon,  9 May 2022 01:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiEIB3q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 8 May 2022 21:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiEIAVx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 8 May 2022 20:21:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71983262F
        for <rcu@vger.kernel.org>; Sun,  8 May 2022 17:17:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h85so13703266iof.12
        for <rcu@vger.kernel.org>; Sun, 08 May 2022 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mC+FUCGE8dHmSEOL195HWoNstxugJQ9rWUm+vklH5X0=;
        b=noAn0a5ITN/TBqX3KWmwimksk33tXbGAHvROKpZbtc4s9dbOloh/qVrzfgPCx7FtXp
         OmuqbkoJHqvdVhX8GL8FE99dVBC1Pac3SRSkAcaLCxY+gE7pw9Cmp3O9DQGHs+AXln9y
         49yJy/1OleGV7hVgGOytcCPZ/PWv1koc+Nfzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mC+FUCGE8dHmSEOL195HWoNstxugJQ9rWUm+vklH5X0=;
        b=UutsXJe6tuESkrL+lby86Y7ohYZAPIvldIOFQdjfylpAsi3q1J8Hxv1p4Q5vNJ6wrA
         5sTkbAmY0Y7wf28p3nH7lcKzxpqmGmXKBkw1Jq2x94XNBFoKfLVcJIzSHMD4ny9HhI4E
         byC1/xisVaprEFIpOegFbbrmyxVK+HDh8bnIyzGTSrlhmD4PdUmM2futUPG3E+z9bEsj
         9f1F7QHf8QLevyMx0vy5Plg4KENO64mWW/bcFhHQCICCg6zEcGBu5Qxj+KwGxYihZOuK
         EkzPb6HnCmoZRbJGQKHix1N4uGFLWVS3X0v3qtD1EIFqMqn9Q17oRN9CB/B3oPecb2Fn
         caQA==
X-Gm-Message-State: AOAM531OMWmsoCu/xStVKwfsB3EK4LKK714htqWPJMSBeoN8LBQ/AQHD
        rOawZD8W2Il3BERCyG3EreQCbtbUaFrO2k1CZX4Cgw==
X-Google-Smtp-Source: ABdhPJyDbl1vzdLQ8pd+bZpJz7/4cqBibtN/Qh6TfzsW+le7S1k0VG3W+LXvE7btHsUO5cSyYcPzFeDqiaUWNvACh2c=
X-Received: by 2002:a02:9702:0:b0:32b:fc3c:cabb with SMTP id
 x2-20020a029702000000b0032bfc3ccabbmr1327493jai.2.1652055478783; Sun, 08 May
 2022 17:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220505101641.28472-1-urezki@gmail.com> <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnVLQozNFvgk3olP@pc638.lan> <20220506182425.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <YnY33nq5jl6FLFOu@pc638.lan> <20220507223247.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSyYRSRQwfMTJU1dowMaxrj6Daa17-BMx4syoPV05bZFg@mail.gmail.com> <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220508213222.GL1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 8 May 2022 20:17:49 -0400
Message-ID: <CAEXW_YQ9t8gxp9cKCpba+e4NZ6ohPr8jHxJYuqRBFRtvSDa0Lw@mail.gmail.com>
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT context
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Alison Chaiken <achaiken@aurora.tech>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, May 8, 2022 at 5:32 PM Paul E. McKenney <paulmck@kernel.org> wrote:
[...]
> > > > > > > One easy way to make this work would be to invert the sense of this
> > > > > > > Kconfig option ("RCU_NOCB_CB_NO_BOOST"?), continue having it default to
> > > > > > > "n", but then select it somewhere in drivers/android/Kconfig.  But I
> > > > > > > would not be surprised if there is a better way.
> > > >
> > > > In that situation probably we should just enable it by default.
> > >
> > > You are within your rights to cause it to be enabled by default -within-
> > > -Android-.  You are -not- within your rights to break other workloads.
> > >
> > > If ChromeOS needs it too, they too can enable it -within- -ChromeOS-.
> > >
> > > It is not -that- hard, guys!  ;-)
> >
> > I think on the topic of RT, +Steven Rostedt should chime in as well
> > considering he wrote a good chunk of the RT scheduler ;-). Personally,
> > I feel the issue of "rcu callback offload" threads running as RT or
> > not should not be a matter of CONFIG option or the system in concern.
> > Instead it should be a function of how many callbacks there are to
> > run.  The reason I say this is, RT threads should not be doing a lot
> > of work anyway, lest they cause RT throttling and starvation of other
> > threads.
>
> This gets complicated surprisingly quickly.  For but one example, you
> would find yourself wanting time-based boosting, most likely before you
> wanted boosting based on numbers of callbacks.  And it is all too easy
> to drive considerably complexity into the mix before proving that it is
> really needed.  Especially given how rare the need for RCU priority
> boosting is to begin with.

I think this patch does not deal with or change the behavior of
dynamic priority boosting preempted RCU readers, but rather it makes
it such that the no-cb offload threads that execute the callbacks. So
I am not sure why you are talking about the boosting behavior of
preempted RCU readers? I was referring only to the nocb offload
kthreads which as I understand, Vlad *does not* want to run at RT
priority.

> > Also, I think it is wrong to assume that a certain kind of system will
> > always have a certain number of callbacks to process at a time. That
> > seems prone to poor design due to assumptions which may not always be
> > true.
>
> Who was assuming that?  Uladzislau was measuring rather than assuming,
> if that was what you were getting at.  Or if you are thinking about
> things like qhimark, your point is exactly why there is both a default
> (which has worked quite well for a very long time) and the ability to
> adjust based on the needs of your specific system.

I was merely saying that based on measurements make assumptions, but
in the real world the assumption may not be true, then everything
falls apart. Instead I feel, callback threads should be RT only if 1.
As you mentioned, the time based thing. 2. If the CB list is long and
there's lot of processing. But instead, if it is made a CONFIG option,
then that forces a fixed behavior which may fall apart in the real
world. I think adding more CONFIGs and special cases is more complex
but that's my opinion.

> > Can we not have 2 sets of RCU offload threads, one which operate at RT
> > and only process few callbacks at a time, while another which is the
> > lower priority CFS offload thread - executes whenever there is a lot
> > of CBs pending? Just a thought.
>
> How about if we start by solving the problems we know that we have?

I don't know why you would say that, because we are talking about
solving the specific problem Vlad's patch addresses, not random
problems. Which is that, Android wants to run expedited GPs, but when
the callback list is large, the RT nocb thread can starve other
things. Did I misunderstand the patch? If so, sorry about that but
that's what my email was discussing. i.e. running of CBs in RT
threads. I suck at writing well as I clearly miscommunicated.

> > Otherwise, I feel like we might be again proliferating CONFIG options
> > and increasing burden on the user to get it the CONFIG right.
>
> I bet that we will solve this without adding any new Kconfig options.
> And I bet that the burden is at worst on the device designer, not on
> the user.  Plus it is entirely possible that there might be a way to
> automatically configure things to handle what we know about today,
> again without adding Kconfig options.

Yes, agreed.

Thanks,
Joel
