Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA0FA373D
	for <rcu@archiver.kernel.org>; Mon, 31 Oct 2022 03:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiJaDYz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 30 Oct 2022 23:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaDYy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 30 Oct 2022 23:24:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664FD958C
        for <rcu@vger.kernel.org>; Sun, 30 Oct 2022 20:24:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l8so4343933ljh.13
        for <rcu@vger.kernel.org>; Sun, 30 Oct 2022 20:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0ajwVhGdjr5HHuaYgS4zOIYeUAwm4vNCG744rRNFF0w=;
        b=n4TSTJN+aCqXA8vJFiDOFg2LipJtck9L/wp64fj1CqeVA00P6cCIqfBnpq0umpj12X
         YLkagmiObl+H1vgm3ldaAsebomUlTu3r5ZsCcah/I9k5gzMjvP6UPmiETsA/WHVBdAsJ
         eJ70FMIHLzve0daJYCCP5M6nfSD31R1L5tRm35DuyAxNsqH0KVVvKQ+n4tr/X4mTK9bA
         2szVgeis6enetG5yee46ipQw5cLQbATHIK+xk5bM4ac2fq5Ylq/C6bhIhTn+f4zDckl2
         zp+b1mt7uyqO2UowRPb9A+13JOV6l4D7oHfpb7jyisBqBlnpfJBL4MGXsBNi/Tc0VHi/
         EoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ajwVhGdjr5HHuaYgS4zOIYeUAwm4vNCG744rRNFF0w=;
        b=UvK5wcnMVG+abKv/hHU/mldgllxCk2v4KNco//t49pV02DCcJvEfdXavktCN3g5OWe
         3TBwdD8sCV2rFtN8rk33nMbnGdiEcfwl3Zq9nmiC3jaDSKFD/HSO555v0/cH/p7S6OZU
         70ETNcp61795MLlrGR+l95/fUqvGxOi8XkHWFpd8cQM4P0DArlP4WJ4/ojfzGTcTAbw6
         sr85glpFBWbK8b9j30aJrRqjeTC/fcJulig5N4qB5AymEPb3mqgEmrHjGPda7hhXiF7P
         s4fq6FCPvTy+aoqkmIIAs+/cgTE7QBAhywOxfU2T9TdBUNzBsmItMIi22s9hwZxsHGCK
         KNWg==
X-Gm-Message-State: ACrzQf2QCpzJxNSiUA5g42kCfgsTovQ11j+EtB9ESkFSjGlbIxcdgpGq
        7j/htFLPODsyIimog5zsV30JWjUJqv8dBiFxkQ==
X-Google-Smtp-Source: AMsMyM7GOb8lncU4vgEI6Uhs0aOPpzLgmeWMFIFEref24r65hprfNlOIUA+M3igZLFpeBgaOsK7FuMm4DDEMWxkI5Yg=
X-Received: by 2002:a05:651c:1207:b0:277:276a:9d7b with SMTP id
 i7-20020a05651c120700b00277276a9d7bmr4248088lja.129.1667186689644; Sun, 30
 Oct 2022 20:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com> <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com> <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com> <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002162002.GR4196@paulmck-ThinkPad-P17-Gen-1> <CAFgQCTtgLfc0NeYqyWk4Ew-pA9rMREjRjWSnQhYLv-V5117s9Q@mail.gmail.com>
 <20221027174620.GC5600@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221027174620.GC5600@paulmck-ThinkPad-P17-Gen-1>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 31 Oct 2022 11:24:37 +0800
Message-ID: <CAFgQCTuoy+9DdQsVZvbLcn70JaHUhR2HZ=D35Akj4=GceGO2Lg@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent offlining
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
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

On Fri, Oct 28, 2022 at 1:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Oct 10, 2022 at 09:55:26AM +0800, Pingfan Liu wrote:
> > On Mon, Oct 3, 2022 at 12:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > [...]
> >
> > > >
> > > > But unfortunately, I did not keep the data. I will run it again and
> > > > submit the data.
> > >
> >
> > I have finished the test on a machine with two sockets and 256 cpus.
> > The test runs against the kernel with three commits reverted.
> >   96926686deab ("rcu: Make CPU-hotplug removal operations enable tick")
> >   53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full
> > IRQ entry")
> >   a1ff03cd6fb9c5 ("tick: Detect and fix jiffies update stall")
> >
> > Summary from console.log
> > "
> >  --- Sat Oct  8 11:34:02 AM EDT 2022 Test summary:
> > Results directory:
> > /home/linux/tools/testing/selftests/rcutorture/res/2022.10.07-23.10.54
> > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > 125h --bootargs rcutorture.onoff_interval=200
> > rcutorture.onoff_holdoff=30 --configs 32*TREE04
> > TREE04 ------- 1365444 GPs (3.03432/s) n_max_cbs: 850290
> > TREE04 no success message, 2897 successful version messages
> > Completed in 44512 vs. 450000
> > TREE04.10 ------- 1331565 GPs (2.95903/s) n_max_cbs: 909075
> > TREE04.10 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.11 ------- 1331535 GPs (2.95897/s) n_max_cbs: 1213974
> > TREE04.11 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.12 ------- 1322160 GPs (2.93813/s) n_max_cbs: 2615313
> > TREE04.12 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.13 ------- 1320032 GPs (2.9334/s) n_max_cbs: 914751
> > TREE04.13 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.14 ------- 1339969 GPs (2.97771/s) n_max_cbs: 1560203
> > TREE04.14 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.15 ------- 1318805 GPs (2.93068/s) n_max_cbs: 1757478
> > TREE04.15 no success message, 2897 successful version messages
> > Completed in 44510 vs. 450000
> > TREE04.16 ------- 1340633 GPs (2.97918/s) n_max_cbs: 1377647
> > TREE04.16 no success message, 2897 successful version messages
> > Completed in 44510 vs. 450000
> > TREE04.17 ------- 1322798 GPs (2.93955/s) n_max_cbs: 1266344
> > TREE04.17 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.18 ------- 1346302 GPs (2.99178/s) n_max_cbs: 1030713
> > TREE04.18 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.19 ------- 1322499 GPs (2.93889/s) n_max_cbs: 917118
> > TREE04.19 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > ...
> > TREE04.4 ------- 1310283 GPs (2.91174/s) n_max_cbs: 2146905
> > TREE04.4 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.5 ------- 1333238 GPs (2.96275/s) n_max_cbs: 1027172
> > TREE04.5 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.6 ------- 1313915 GPs (2.91981/s) n_max_cbs: 1017511
> > TREE04.6 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.7 ------- 1341871 GPs (2.98194/s) n_max_cbs: 816265
> > TREE04.7 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.8 ------- 1339412 GPs (2.97647/s) n_max_cbs: 1316404
> > TREE04.8 no success message, 2897 successful version messages
> > Completed in 44511 vs. 450000
> > TREE04.9 ------- 1327240 GPs (2.94942/s) n_max_cbs: 1409531
> > TREE04.9 no success message, 2897 successful version messages
> > Completed in 44510 vs. 450000
> > 32 runs with runtime errors.
> >  --- Done at Sat Oct  8 11:34:10 AM EDT 2022 (12:23:16) exitcode 2
> > "
> > I have no idea about the test so just arbitrarily pick up the
> > console.log of TREE04.10 as an example. Please get it from attachment.
>
> Very good, thank you!
>
> Could you please clearly indicate what you tested?  For example, if
> you have an externally visible git tree, please point me at the tree
> and the SHA-1.  Or send a patch series clearly indicating what it is
> based on.
>

Yes, it is a good way to eliminate any unexpected mistakes before a rigid test.

Please clone it from https://github.com/pfliu/linux.git  branch:
rcu#revert_tick_dep


> Then I can try a long run on a larger collection of systems.
>

Thank you very much.

> If that works out, we can see about adjustments to mainline.  ;-)
>

Eager to see.

Thanks,

    Pingfan
