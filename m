Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC9C4332F
	for <rcu@archiver.kernel.org>; Mon, 21 Nov 2022 03:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKUDsq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUDsp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 20 Nov 2022 22:48:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6571EEF0
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 19:48:43 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d6so16978450lfs.10
        for <rcu@vger.kernel.org>; Sun, 20 Nov 2022 19:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AddR68RPFOwPYHfFfk/PiLeS2ZTI3OvOea4KUDJMDgg=;
        b=BIb0pD8E2ztutQj5AX3Ush+wa4CI5D9RavHV9VW6pPQOi/P3iCD63VF0wQ0oI166OE
         PDoYRgdCR6msjyb2CFjqdlPPuvFN/UtG1kdfBrRU0/mNXhn4bOCYoHgEaWzWEMyv60dN
         igtRXTwaaYqnbxU01dCf2521Pn/gZMOtWcWC4XUK4AqVntW67bbkxt4Jpi1VzllBdBil
         KXUNwKzeGIKxsLyTKXFokhM7w7IjF4RQcvVNZOi2JMuvO6NAuSoVBZYQmvA9dJHmFn57
         kKmX2qwTdMjksyitJNrXsLV2vlWQgHj60816Nt02cOOgBs4fb21+IiwgtkoO7v22XFWX
         7n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AddR68RPFOwPYHfFfk/PiLeS2ZTI3OvOea4KUDJMDgg=;
        b=NH+WXH+k6/jnW3LVsJSMVReSeJuro5QaodUcFHal0C1m9sMnTF8NOk/kAwZwswKGyH
         d+zDNXGEKnre3CQTdgifZD4ibJ45Trf90valBk0u2vBDnvxvqjCL6RnaLXgcXqyu8vuo
         +cizhTktWMWa+sybYMCvNxg1mBiosXb54MdFObm5ppMS8a39eDTohzrlhUupknTwWtKV
         N/UV9x/myqCw7sbKjfWah8uIRaj/Dm1BDErh6dO8SNVC8vjyXjrv95IkAWd1sAiSKJ/p
         zSF1TiVBMz74mljxNOl85k8R8lTDFbvhAj4HqGu7RMw2kK6WhNcS9exVrSywKcezhj6v
         8H6Q==
X-Gm-Message-State: ANoB5pno1l3mZsc+80MyiCUIEGmpV+nYFufM8fXHX1Z3eCMkYiSW8cvb
        P1vkflzeB+yb/j3eaVUyrmOCkXnVdVikpz23eQ==
X-Google-Smtp-Source: AA0mqf5enzFTL1j7SiY36Y3Hjcfb9HBQnN+hCUFx26qUr2jcBE70sWUwusTFup3co2SmOXy5Vxsx3NeHaEU1WkWn5FM=
X-Received: by 2002:a05:6512:258a:b0:4a2:27f0:46a5 with SMTP id
 bf10-20020a056512258a00b004a227f046a5mr250282lfb.611.1669002521588; Sun, 20
 Nov 2022 19:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002162002.GR4196@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTtgLfc0NeYqyWk4Ew-pA9rMREjRjWSnQhYLv-V5117s9Q@mail.gmail.com>
 <20221027174620.GC5600@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTuoy+9DdQsVZvbLcn70JaHUhR2HZ=D35Akj4=GceGO2Lg@mail.gmail.com>
 <20221103165143.GX5600@paulmck-ThinkPad-P17-Gen-1> <20221107160726.GA3892067@paulmck-ThinkPad-P17-Gen-1>
 <Y2v3qM3hwca7Rc2P@google.com> <CAFgQCTv+cYijiZ_exiyqPgtUNg7j4mV8aKD=Ko0ccu5ude3CkQ@mail.gmail.com>
 <20221118233003.GS4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221118233003.GS4001@paulmck-ThinkPad-P17-Gen-1>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 21 Nov 2022 11:48:29 +0800
Message-ID: <CAFgQCTvw+JOfvW-BoR2tzyc-ymkwwkDeWFMPa6TAwtVkMB43UA@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Nov 19, 2022 at 7:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Nov 18, 2022 at 08:08:35PM +0800, Pingfan Liu wrote:
> > On Thu, Nov 10, 2022 at 2:55 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Mon, Nov 07, 2022 at 08:07:26AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Nov 03, 2022 at 09:51:43AM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Oct 31, 2022 at 11:24:37AM +0800, Pingfan Liu wrote:
> > > > > > On Fri, Oct 28, 2022 at 1:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > >
> > > > > > > On Mon, Oct 10, 2022 at 09:55:26AM +0800, Pingfan Liu wrote:
> > > > > > > > On Mon, Oct 3, 2022 at 12:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > But unfortunately, I did not keep the data. I will run it again and
> > > > > > > > > > submit the data.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I have finished the test on a machine with two sockets and 256 cpus.
> > > > > > > > The test runs against the kernel with three commits reverted.
> > > > > > > >   96926686deab ("rcu: Make CPU-hotplug removal operations enable tick")
> > > > > > > >   53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full
> > > > > > > > IRQ entry")
> > > > > > > >   a1ff03cd6fb9c5 ("tick: Detect and fix jiffies update stall")
> > > > > > > >
> > > > > > > > Summary from console.log
> > > > > > > > "
> > > > > > > >  --- Sat Oct  8 11:34:02 AM EDT 2022 Test summary:
> > > > > > > > Results directory:
> > > > > > > > /home/linux/tools/testing/selftests/rcutorture/res/2022.10.07-23.10.54
> > > > > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > > > > > > > 125h --bootargs rcutorture.onoff_interval=200
> > > > > > > > rcutorture.onoff_holdoff=30 --configs 32*TREE04
> > > > > > > > TREE04 ------- 1365444 GPs (3.03432/s) n_max_cbs: 850290
> > > > > > > > TREE04 no success message, 2897 successful version messages
> > > > > > > > Completed in 44512 vs. 450000
> > > > > > > > TREE04.10 ------- 1331565 GPs (2.95903/s) n_max_cbs: 909075
> > > > > > > > TREE04.10 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.11 ------- 1331535 GPs (2.95897/s) n_max_cbs: 1213974
> > > > > > > > TREE04.11 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.12 ------- 1322160 GPs (2.93813/s) n_max_cbs: 2615313
> > > > > > > > TREE04.12 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.13 ------- 1320032 GPs (2.9334/s) n_max_cbs: 914751
> > > > > > > > TREE04.13 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.14 ------- 1339969 GPs (2.97771/s) n_max_cbs: 1560203
> > > > > > > > TREE04.14 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.15 ------- 1318805 GPs (2.93068/s) n_max_cbs: 1757478
> > > > > > > > TREE04.15 no success message, 2897 successful version messages
> > > > > > > > Completed in 44510 vs. 450000
> > > > > > > > TREE04.16 ------- 1340633 GPs (2.97918/s) n_max_cbs: 1377647
> > > > > > > > TREE04.16 no success message, 2897 successful version messages
> > > > > > > > Completed in 44510 vs. 450000
> > > > > > > > TREE04.17 ------- 1322798 GPs (2.93955/s) n_max_cbs: 1266344
> > > > > > > > TREE04.17 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.18 ------- 1346302 GPs (2.99178/s) n_max_cbs: 1030713
> > > > > > > > TREE04.18 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.19 ------- 1322499 GPs (2.93889/s) n_max_cbs: 917118
> > > > > > > > TREE04.19 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > ...
> > > > > > > > TREE04.4 ------- 1310283 GPs (2.91174/s) n_max_cbs: 2146905
> > > > > > > > TREE04.4 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.5 ------- 1333238 GPs (2.96275/s) n_max_cbs: 1027172
> > > > > > > > TREE04.5 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.6 ------- 1313915 GPs (2.91981/s) n_max_cbs: 1017511
> > > > > > > > TREE04.6 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.7 ------- 1341871 GPs (2.98194/s) n_max_cbs: 816265
> > > > > > > > TREE04.7 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.8 ------- 1339412 GPs (2.97647/s) n_max_cbs: 1316404
> > > > > > > > TREE04.8 no success message, 2897 successful version messages
> > > > > > > > Completed in 44511 vs. 450000
> > > > > > > > TREE04.9 ------- 1327240 GPs (2.94942/s) n_max_cbs: 1409531
> > > > > > > > TREE04.9 no success message, 2897 successful version messages
> > > > > > > > Completed in 44510 vs. 450000
> > > > > > > > 32 runs with runtime errors.
> > > > > > > >  --- Done at Sat Oct  8 11:34:10 AM EDT 2022 (12:23:16) exitcode 2
> > > > > > > > "
> > > > > > > > I have no idea about the test so just arbitrarily pick up the
> > > > > > > > console.log of TREE04.10 as an example. Please get it from attachment.
> > > > > > >
> > > > > > > Very good, thank you!
> > > > > > >
> > > > > > > Could you please clearly indicate what you tested?  For example, if
> > > > > > > you have an externally visible git tree, please point me at the tree
> > > > > > > and the SHA-1.  Or send a patch series clearly indicating what it is
> > > > > > > based on.
> > > > > > >
> > > > > >
> > > > > > Yes, it is a good way to eliminate any unexpected mistakes before a rigid test.
> > > > > >
> > > > > > Please clone it from https://github.com/pfliu/linux.git  branch:
> > > > > > rcu#revert_tick_dep
> > > > >
> > > > > Thank you very much!
> > > > >
> > > > > > > Then I can try a long run on a larger collection of systems.
> > > > > > >
> > > > > >
> > > > > > Thank you very much.
> > > > > >
> > > > > > > If that works out, we can see about adjustments to mainline.  ;-)
> > > > > > >
> > > > > >
> > > > > > Eager to see.
> > > > >
> > > > > I ran 200 hours of TREE04 and got an RCU CPU stall warning.  I ran 2000
> > > > > hours on v6.0, which precedes these commits, and everything passed.
> > > > >
> > > > > I will run more, primarily on v6.0, but that is what I have thus far.
> > > > > At the moment, I have some concerns about this change.
> > > >
> > > > OK, so I have run a total of 8000 hours on v6.0 without failure.  I have
> > > > run 4200 hours on rcu#revert_tick_dep with 15 failures.  The ones I
> > > > looked at were RCU CPU stall warnings with timer failures.
> > > >
> > > > This data suggests that the kernel is not yet ready for that commit
> > > > to be reverted.
> > >
> > > Even if the tests pass, can we really survive with this patch
> > > that he reverted?
> > > https://github.com/pfliu/linux/commit/03179ef33e8e2608184ade99a27f760f9d01e6b7
> > >
> > > If stop machine on a CPU spends a good amount of time in kernel mode, while a
> > > grace period starts on another CPU, then we're kind of screwed if we don't
> > > have the tick enabled right?
> >
> > In this case, I think multi_cpu_stop()->rcu_momentary_dyntick_idle()
> > can serve this purpose.
>
> There are a lot of things that can go wrong in this scenario.  Does that
> added rcu_momentary_dyntick_idle() cover everything that still needs to
> be covered?
>

Absorbed by the context "while a grace period starts on another CPU",
I assumed it is from the RCU perspective. Then I think every non-idle
cpu can report its quiescent state in that case.

But from a system perspective, I think that it is promising but not
sure. And that is what the TREE04 torture test tries to verify.

Thanks,

    Pingfan
