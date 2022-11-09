Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A644DC4332F
	for <rcu@archiver.kernel.org>; Wed,  9 Nov 2022 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKISzm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 9 Nov 2022 13:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKISzk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 9 Nov 2022 13:55:40 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5131F
        for <rcu@vger.kernel.org>; Wed,  9 Nov 2022 10:55:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l2so10875563qtq.11
        for <rcu@vger.kernel.org>; Wed, 09 Nov 2022 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDp5z2rpkamKyOuMg+SJtFBTaKRH30JNGAZGVxBJTvg=;
        b=FVUYdV4+8e23xRxW81ZygN5E/j21i1GU4+H2MCtc06h7JCIwq2tcxnqMYy1rR2iMzT
         SHK3PFPKPbQvGzj1z7wlrL1E++p331FVpDfnSJ1s9QYvF1BqLBYIhUU+OVoKc/AXs3yM
         l/mzGsU5fMvFNRlKNRtEwbWIiOscJLlGnnwQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDp5z2rpkamKyOuMg+SJtFBTaKRH30JNGAZGVxBJTvg=;
        b=iqkRykfGJTh+EtlgsmlHU7VkVTROTc4693xgU2xpgP2hvfNk4HsFGqqTAojhRBKHwC
         ljsuQ10BkpUHT/o12QvVCVFEXkVEwADqktI+DJjj3ENt8j5AzegGipEe+CjMzlNmR4bp
         0xcjBn2BfH8ImsCH5+HCWgOfuUIlhd9qy6XEZc6ww972oEMAv9G/wprgVTx8Dot0AYIl
         SoBN31ZHOT31BL62cNpyZq038K27INTLc1iO5+UJ3kXezoQ6tpM58jgwVxd6PXjukMQy
         a5lwPerTzZOIEV54aeuuIMzegnnr44avfTIPCb2vkOtS4DpkxhbxCJek13NQOeFM6pk9
         R46g==
X-Gm-Message-State: ACrzQf1mAu3mTeY+3xa8r6K+k+eNiA5jioRyoZolcbl+4X/1+sNo7fZF
        rWNKARnhur1i+jbkKYwOyUrSsw==
X-Google-Smtp-Source: AMsMyM50HqMOY3kY4spIJeso5WJrW/GxkTA67yGt8gheGRHPVc5EYvTueapUsSKIdNELy24F0RpXfQ==
X-Received: by 2002:ac8:7f4d:0:b0:3a5:4942:7e53 with SMTP id g13-20020ac87f4d000000b003a549427e53mr30714895qtk.559.1668020138179;
        Wed, 09 Nov 2022 10:55:38 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bk42-20020a05620a1a2a00b006fa4b111c76sm11642932qkb.36.2022.11.09.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 10:55:37 -0800 (PST)
Date:   Wed, 9 Nov 2022 18:55:36 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <Y2v3qM3hwca7Rc2P@google.com>
References: <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
 <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002162002.GR4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTtgLfc0NeYqyWk4Ew-pA9rMREjRjWSnQhYLv-V5117s9Q@mail.gmail.com>
 <20221027174620.GC5600@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTuoy+9DdQsVZvbLcn70JaHUhR2HZ=D35Akj4=GceGO2Lg@mail.gmail.com>
 <20221103165143.GX5600@paulmck-ThinkPad-P17-Gen-1>
 <20221107160726.GA3892067@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107160726.GA3892067@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 07, 2022 at 08:07:26AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 03, 2022 at 09:51:43AM -0700, Paul E. McKenney wrote:
> > On Mon, Oct 31, 2022 at 11:24:37AM +0800, Pingfan Liu wrote:
> > > On Fri, Oct 28, 2022 at 1:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 10, 2022 at 09:55:26AM +0800, Pingfan Liu wrote:
> > > > > On Mon, Oct 3, 2022 at 12:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > [...]
> > > > >
> > > > > > >
> > > > > > > But unfortunately, I did not keep the data. I will run it again and
> > > > > > > submit the data.
> > > > > >
> > > > >
> > > > > I have finished the test on a machine with two sockets and 256 cpus.
> > > > > The test runs against the kernel with three commits reverted.
> > > > >   96926686deab ("rcu: Make CPU-hotplug removal operations enable tick")
> > > > >   53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full
> > > > > IRQ entry")
> > > > >   a1ff03cd6fb9c5 ("tick: Detect and fix jiffies update stall")
> > > > >
> > > > > Summary from console.log
> > > > > "
> > > > >  --- Sat Oct  8 11:34:02 AM EDT 2022 Test summary:
> > > > > Results directory:
> > > > > /home/linux/tools/testing/selftests/rcutorture/res/2022.10.07-23.10.54
> > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > > > > 125h --bootargs rcutorture.onoff_interval=200
> > > > > rcutorture.onoff_holdoff=30 --configs 32*TREE04
> > > > > TREE04 ------- 1365444 GPs (3.03432/s) n_max_cbs: 850290
> > > > > TREE04 no success message, 2897 successful version messages
> > > > > Completed in 44512 vs. 450000
> > > > > TREE04.10 ------- 1331565 GPs (2.95903/s) n_max_cbs: 909075
> > > > > TREE04.10 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.11 ------- 1331535 GPs (2.95897/s) n_max_cbs: 1213974
> > > > > TREE04.11 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.12 ------- 1322160 GPs (2.93813/s) n_max_cbs: 2615313
> > > > > TREE04.12 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.13 ------- 1320032 GPs (2.9334/s) n_max_cbs: 914751
> > > > > TREE04.13 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.14 ------- 1339969 GPs (2.97771/s) n_max_cbs: 1560203
> > > > > TREE04.14 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.15 ------- 1318805 GPs (2.93068/s) n_max_cbs: 1757478
> > > > > TREE04.15 no success message, 2897 successful version messages
> > > > > Completed in 44510 vs. 450000
> > > > > TREE04.16 ------- 1340633 GPs (2.97918/s) n_max_cbs: 1377647
> > > > > TREE04.16 no success message, 2897 successful version messages
> > > > > Completed in 44510 vs. 450000
> > > > > TREE04.17 ------- 1322798 GPs (2.93955/s) n_max_cbs: 1266344
> > > > > TREE04.17 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.18 ------- 1346302 GPs (2.99178/s) n_max_cbs: 1030713
> > > > > TREE04.18 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.19 ------- 1322499 GPs (2.93889/s) n_max_cbs: 917118
> > > > > TREE04.19 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > ...
> > > > > TREE04.4 ------- 1310283 GPs (2.91174/s) n_max_cbs: 2146905
> > > > > TREE04.4 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.5 ------- 1333238 GPs (2.96275/s) n_max_cbs: 1027172
> > > > > TREE04.5 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.6 ------- 1313915 GPs (2.91981/s) n_max_cbs: 1017511
> > > > > TREE04.6 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.7 ------- 1341871 GPs (2.98194/s) n_max_cbs: 816265
> > > > > TREE04.7 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.8 ------- 1339412 GPs (2.97647/s) n_max_cbs: 1316404
> > > > > TREE04.8 no success message, 2897 successful version messages
> > > > > Completed in 44511 vs. 450000
> > > > > TREE04.9 ------- 1327240 GPs (2.94942/s) n_max_cbs: 1409531
> > > > > TREE04.9 no success message, 2897 successful version messages
> > > > > Completed in 44510 vs. 450000
> > > > > 32 runs with runtime errors.
> > > > >  --- Done at Sat Oct  8 11:34:10 AM EDT 2022 (12:23:16) exitcode 2
> > > > > "
> > > > > I have no idea about the test so just arbitrarily pick up the
> > > > > console.log of TREE04.10 as an example. Please get it from attachment.
> > > >
> > > > Very good, thank you!
> > > >
> > > > Could you please clearly indicate what you tested?  For example, if
> > > > you have an externally visible git tree, please point me at the tree
> > > > and the SHA-1.  Or send a patch series clearly indicating what it is
> > > > based on.
> > > >
> > > 
> > > Yes, it is a good way to eliminate any unexpected mistakes before a rigid test.
> > > 
> > > Please clone it from https://github.com/pfliu/linux.git  branch:
> > > rcu#revert_tick_dep
> > 
> > Thank you very much!
> > 
> > > > Then I can try a long run on a larger collection of systems.
> > > >
> > > 
> > > Thank you very much.
> > > 
> > > > If that works out, we can see about adjustments to mainline.  ;-)
> > > >
> > > 
> > > Eager to see.
> > 
> > I ran 200 hours of TREE04 and got an RCU CPU stall warning.  I ran 2000
> > hours on v6.0, which precedes these commits, and everything passed.
> > 
> > I will run more, primarily on v6.0, but that is what I have thus far.
> > At the moment, I have some concerns about this change.
> 
> OK, so I have run a total of 8000 hours on v6.0 without failure.  I have
> run 4200 hours on rcu#revert_tick_dep with 15 failures.  The ones I
> looked at were RCU CPU stall warnings with timer failures.
> 
> This data suggests that the kernel is not yet ready for that commit
> to be reverted.

Even if the tests pass, can we really survive with this patch
that he reverted?
https://github.com/pfliu/linux/commit/03179ef33e8e2608184ade99a27f760f9d01e6b7

If stop machine on a CPU spends a good amount of time in kernel mode, while a
grace period starts on another CPU, then we're kind of screwed if we don't
have the tick enabled right?

Or, did we make any changes to stop machine such that, that's no longer an
issue?

thanks,

 - Joel

