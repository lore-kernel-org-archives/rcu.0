Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B67DC4332F
	for <rcu@archiver.kernel.org>; Fri, 18 Nov 2022 01:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKRBqK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Nov 2022 20:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbiKRBqG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Nov 2022 20:46:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8614B742E1
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 17:46:05 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l12so5847512lfp.6
        for <rcu@vger.kernel.org>; Thu, 17 Nov 2022 17:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsm5q2Fbqh+S9+BA461w10oQVPp4wjse4b1o1TaHjxg=;
        b=N4pipC4csb2coM7Y606RWgHws9WRzgLgMDP4sDdxeZxBHoV4Fw73UbqcjdsICOlEls
         EakQcsg67HHBUTgCoh9g2FMmXzLWDs2rfd1IkDHgsECU7DNJdGFtXYL/Mx6o4pYWptuD
         QjYdfiwSt7U3aUYQPNxelXXseVGeZeit2Ofsz2nbjPhSMoSgf//1e0fmPgw8k7oSYNPj
         dnXHYev3hKHFo/PuXbm8o5q0Und26KWYMzEWx1GokjyYEdGaoNjho61Ph4cNNbSuaVIU
         xSn2hMfkGZJLByBfks/piQDifilwP4Ss/zkJ51vIkPAjTSQZ3LhVGTVaWQO3wAzUF6s2
         uF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fsm5q2Fbqh+S9+BA461w10oQVPp4wjse4b1o1TaHjxg=;
        b=fwz2P76gMABtPzYUGNr0eJ4HpprkmmtySh3Z+zWXwXIBYu5zz/b4LIFL3yGCc8S7LQ
         lgo8oQ/XPzpH6dml+cmbf6iXsv9QMX0cVx5gfANo0Rg2LWjftHcbTU3UoYbmmj9+Ghbo
         P8yIf7tnvrNq/YY9ZTupPrYVdFyo+F1eTu0yrZp6A87z5LvZiGkJvWobqAtQZEp2hfui
         WhK9l6dWcwZiCZlk9k9LlwfIPxT2UtFO7cDf/uQeMeQTdsyfnkOXeGYY6YELv8MNCZzA
         N0u+HQenITFAhL3zKHIDHdr2VkE24f+/Gew/EjzZ9uk64FnY8xWVgclssIGtFIfQVElF
         /yBw==
X-Gm-Message-State: ANoB5plXyE0Y/195RPeUiupza6NOqzhFonNUMyP86c5M/iOYpJmIOwDJ
        lvpMNzMgXYuF2Efcgp8A7PqJKL7nmN05TOKYBPa84DdJH4EF
X-Google-Smtp-Source: AA0mqf5satcBD7PFN0RuTTvKQb0lYQduobanzWOkqXKoi7r0MPMQG8t5xuqA+p1i7qaUki0sWzhbQN5d0y5yeWEfb1k=
X-Received: by 2002:a05:6512:36c3:b0:4b4:c0c:8995 with SMTP id
 e3-20020a05651236c300b004b40c0c8995mr1952427lfs.326.1668735963769; Thu, 17
 Nov 2022 17:46:03 -0800 (PST)
MIME-Version: 1.0
References: <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com> <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002162002.GR4196@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTtgLfc0NeYqyWk4Ew-pA9rMREjRjWSnQhYLv-V5117s9Q@mail.gmail.com>
 <20221027174620.GC5600@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTuoy+9DdQsVZvbLcn70JaHUhR2HZ=D35Akj4=GceGO2Lg@mail.gmail.com>
 <20221103165143.GX5600@paulmck-ThinkPad-P17-Gen-1> <20221107160726.GA3892067@paulmck-ThinkPad-P17-Gen-1>
 <20221117143946.GG839309@lothringen>
In-Reply-To: <20221117143946.GG839309@lothringen>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 18 Nov 2022 09:45:52 +0800
Message-ID: <CAFgQCTsyzHiv0bkF25riwV_Ruqezz4ec=f8z72-b_MvP4VwXqQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 17, 2022 at 10:39 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> On Mon, Nov 07, 2022 at 08:07:26AM -0800, Paul E. McKenney wrote:
> > > I ran 200 hours of TREE04 and got an RCU CPU stall warning.  I ran 2000
> > > hours on v6.0, which precedes these commits, and everything passed.
> > >
> > > I will run more, primarily on v6.0, but that is what I have thus far.
> > > At the moment, I have some concerns about this change.
> >
> > OK, so I have run a total of 8000 hours on v6.0 without failure.  I have
> > run 4200 hours on rcu#revert_tick_dep with 15 failures.  The ones I
> > looked at were RCU CPU stall warnings with timer failures.
> >
> > This data suggests that the kernel is not yet ready for that commit
> > to be reverted.
>
> But that branch has the three commits reverted:
>
> 1) tick: Detect and fix jiffies update stall
> 2) timers/nohz: Last resort update jiffies on nohz_full IRQ entry*
> 3) rcu: Make CPU-hotplug removal operations enable tick
>
> Reverting all of them is expected to fail anyway.
>
> What we would like to know is if reverting just 3) is fine. Because
> 1) and 2) are supposed to fix the underlying issue.
>
> I personally didn't manage to trigger failures with just reverting 3)
> after thousands hours. But it failed with reverting all of them.
>
> Has someone managed to trigger a failure with only 3) reverted?
>

Oh, a long long thread hides the history!   Once it was done [1].  But
I have not kept the data (IIRC, it occupied ~1GB).

If the information and attachment in [1] are not enough for you, I am
happy to redo the test.

Thanks,

    Pingfan

[1]: https://lore.kernel.org/all/CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com/

> Thanks.
