Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9F5C433F5
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 14:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245219AbiEMOvc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 May 2022 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiEMOvc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 May 2022 10:51:32 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E39DF8D
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:51:30 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id b11so1928501ilr.4
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7PQOhj+IGsF4taEiagAVPy4E0pHWfXhq/9+zQ9mqXM=;
        b=U2DEgQCk+6dm4fmA/hs95m2fOPeRxPq3rsh0D+jV0bG245g3cHeOU+XO2Fl72/Yk7B
         inOz7HV5eO99KdfcWwJJM0Cd4Vp4OHMASOCuTNd35vDWM0z1zgZfAidBYu2ULSIX5tGz
         RGhXC5n0/XpYBDeW/nS0jJJ83Fwy29VCuaUZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7PQOhj+IGsF4taEiagAVPy4E0pHWfXhq/9+zQ9mqXM=;
        b=7oJ16us5uGaRoDDiLmCcDubsXx86837ApgBQ7hzXx6ggXnmMKhnbyr9Yn1YbUQftVG
         i0u8gz70prLvgsIaSoRTl2gn2dgKBSGlu5fJIjgjzvuYQThQwDtK9CVOAczMLxKJDLCL
         FfBIQtnE0UUprUlEb3VrrlKEE99PKT95lWos2RjZzMkVBCs+x1QuFIZCWOMG1Ito76WC
         ei3IeJdnuial8SA/+B9BjUFF1D5Cuv/IY9V7OQA5KbH25vHkvhNld7TvTGjykDxnUlpb
         q26KjjGnonb0Efh426kQKVbbv/NMGl+U9ww/ZMPnrmEzZviiEsxmkit8SkXXHwzy95Qs
         BguA==
X-Gm-Message-State: AOAM531ykbNcLZUGIz7AxC+ozEy58F5USqrUuPFGgHlRpqnDQoQo5sdc
        mA+JUYYK9UqqMu3ZcIczJkQFJgg+RlNNClmxZK4Kl24fct4=
X-Google-Smtp-Source: ABdhPJzzuQtM2GSVtkyCRjxKiOZZ/7vaoaX5x6V7iv8Rub+Alh8wgPeIWzj1m16ritWzGpsunSqHNX/t+zmEk5zDDI0=
X-Received: by 2002:a05:6e02:19c8:b0:2cf:910:7834 with SMTP id
 r8-20020a056e0219c800b002cf09107834mr2746370ill.307.1652453490260; Fri, 13
 May 2022 07:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
 <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
 <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
 <Yn0TuehXj6VoWG0A@google.com> <Yn0bwhkdfPvbjIwK@pc638.lan>
 <CAEXW_YQNPDJ8aaxKzG2NN9gVR_QPbarJthiXYRd9Erw7p5V=FA@mail.gmail.com>
 <Yn02uhvov7CDoKX7@pc638.lan> <Yn5e7w8NWzThUARb@pc638.lan>
In-Reply-To: <Yn5e7w8NWzThUARb@pc638.lan>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 13 May 2022 10:51:18 -0400
Message-ID: <CAEXW_YQSLSAOAYDhztreYu=t2v8HPCdjRwJ=5Bx6N3LT8frtkQ@mail.gmail.com>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 13, 2022 at 9:36 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > > On Thu, May 12, 2022 at 10:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > >
> > > > > On Thu, May 12, 2022 at 03:56:37PM +0200, Uladzislau Rezki wrote:
> > > > > > Never mind. I port it into 5.10
> > > > >
> > > > > Oh, this is on mainline. Sorry about that. If you want I have a tree here for
> > > > > 5.10 , although that does not have the kfree changes, everything else is
> > > > > ditto.
> > > > > https://github.com/joelagnel/linux-kernel/tree/rcu-nocb-4
> > > > >
> > > > No problem. kfree_rcu two patches are not so important in this series.
> > > > So i have backported them into my 5.10 kernel because the latest kernel
> > > > is not so easy to up and run on my device :)
> > >
> > > Actually I was going to write here, apparently some tests are showing
> > > kfree_rcu()->call_rcu_lazy() causing possible regression. So it is
> > > good to drop those for your initial testing!
> > >
> > Yep, i dropped both. The one that make use of call_rcu_lazy() seems not
> > so important for kfree_rcu() because we do batch requests there anyway.
> > One thing that i would like to improve in kfree_rcu() is a better utilization
> > of page slots.
> >
> > I will share my results either tomorrow or on Monday. I hope that is fine.
> >
>
> Here we go with some data on our Android handset that runs 5.10 kernel. The test
> case i have checked was a "static image" use case. Condition is: screen ON with
> disabled all connectivity.
>
> 1.
> First data i took is how many wakeups cause an RCU subsystem during this test case
> when everything is pretty idling. Duration is 360 seconds:
>
> <snip>
> serezkiul@seldlx26095:~/data/call_rcu_lazy$ ./psp ./perf_360_sec_rcu_lazy_off.script | sort -nk 6 | grep rcu

Nice! Do you mind sharing this script? I was just talking to Rushikesh
that we want something like this during testing. Appreciate it. Also,
if we dump timer wakeup reasons/callbacks that would also be awesome.

FWIW, I wrote a BPF tool that periodically dumps callbacks and can
share that with you on request as well. That is probably not in a
shape for mainline though (Makefile missing and such).

> name:                         rcub/0 pid:         16 woken-up     2     interval: min 86772734  max 86772734    avg 43386367
> name:                        rcuop/7 pid:         69 woken-up     4     interval: min  4189     max  8050       avg  5049
> name:                        rcuop/6 pid:         62 woken-up    55     interval: min  6910     max 42592159    avg 3818752
[..]

> There is a big improvement in lazy case. Number of wake-ups got reduced quite a lot
> and it is really good!

Cool!

> 2.
> Please find in attachment two power plots. The same test case. One is related to a
> regular use of call_rcu() and second one is "lazy" usage. There is light a difference
> in power, it is ~2mA. Event though it is rather small but it is detectable and solid
> what is also important, thus it proofs the concept. Please note it might be more power
> efficient for other arches and platforms. Because of different HW design that is related
> to C-states of CPU and energy that is needed to in/out of those deep power states.

Nice! I wonder if you still have other frequent callbacks on your
system that are getting queued during the tests. Could you dump the
rcu_callbacks trace event and see if you have any CBs frequently
called that the series did not address?

Also, one more thing I was curious about is - do you see savings when
you pin the rcu threads to the LITTLE CPUs of the system? The theory
being, not disturbing the BIG CPUs which are more power hungry may let
them go into a deeper idle state and save power (due to leakage
current and so forth).

> So a front-lazy-batching is something worth to have, IMHO :)

Exciting! Being lazy pays off some times ;-) ;-). If you are Ok with
it, we can add your data to the LPC slides as well about your
investigation (with attribution to you).

thanks,

 - Joel
