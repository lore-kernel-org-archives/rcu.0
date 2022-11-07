Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0985C4332F
	for <rcu@archiver.kernel.org>; Mon,  7 Nov 2022 16:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiKGQIc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 7 Nov 2022 11:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiKGQH5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 7 Nov 2022 11:07:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE1E20BF9
        for <rcu@vger.kernel.org>; Mon,  7 Nov 2022 08:07:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EBDCB815A3
        for <rcu@vger.kernel.org>; Mon,  7 Nov 2022 16:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB87BC433D7;
        Mon,  7 Nov 2022 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667837248;
        bh=Vl7erzoUosc23RETV4W5GWKjjfQdkbeR6TiFOIH95cE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AcAQhU2gxhrwb8VGyqZqBH1xMFKbSvhCVDuh4Aq1fJLpzpl3RbaE2YySDcKTTS26H
         OYaJSPjpkmIk2enhn65ZV7Mwt2OI26xgJ0+jFJ+TVyYOLkjfejmFQSkejzNP0V/+A2
         hHueg+YUhOco3Sosh9KmgcwpTscsl7FL3XmKy1yDYxi2Ihy0L4KcReGY0VJOQfi3Zr
         FSlYkD9+E2F4uMKGm8Daor3mgylg4Bnv/h2AR1btZKsC+VcUyiSriYwjLC/0WgezOL
         rzpqj8kmXmVIW95kfTiuOz9CTUBwUX2SsEz00/raRU+15P7ythcd7GZ04xANHBRkJ5
         X37uOMvTZH/uA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BBC8A5C08E5; Mon,  7 Nov 2022 08:07:26 -0800 (PST)
Date:   Mon, 7 Nov 2022 08:07:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCHv2 3/3] rcu: coordinate tick dependency during concurrent
 offlining
Message-ID: <20221107160726.GA3892067@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
 <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002162002.GR4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTtgLfc0NeYqyWk4Ew-pA9rMREjRjWSnQhYLv-V5117s9Q@mail.gmail.com>
 <20221027174620.GC5600@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTuoy+9DdQsVZvbLcn70JaHUhR2HZ=D35Akj4=GceGO2Lg@mail.gmail.com>
 <20221103165143.GX5600@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103165143.GX5600@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 03, 2022 at 09:51:43AM -0700, Paul E. McKenney wrote:
> On Mon, Oct 31, 2022 at 11:24:37AM +0800, Pingfan Liu wrote:
> > On Fri, Oct 28, 2022 at 1:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Mon, Oct 10, 2022 at 09:55:26AM +0800, Pingfan Liu wrote:
> > > > On Mon, Oct 3, 2022 at 12:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > [...]
> > > >
> > > > > >
> > > > > > But unfortunately, I did not keep the data. I will run it again and
> > > > > > submit the data.
> > > > >
> > > >
> > > > I have finished the test on a machine with two sockets and 256 cpus.
> > > > The test runs against the kernel with three commits reverted.
> > > >   96926686deab ("rcu: Make CPU-hotplug removal operations enable tick")
> > > >   53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full
> > > > IRQ entry")
> > > >   a1ff03cd6fb9c5 ("tick: Detect and fix jiffies update stall")
> > > >
> > > > Summary from console.log
> > > > "
> > > >  --- Sat Oct  8 11:34:02 AM EDT 2022 Test summary:
> > > > Results directory:
> > > > /home/linux/tools/testing/selftests/rcutorture/res/2022.10.07-23.10.54
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration
> > > > 125h --bootargs rcutorture.onoff_interval=200
> > > > rcutorture.onoff_holdoff=30 --configs 32*TREE04
> > > > TREE04 ------- 1365444 GPs (3.03432/s) n_max_cbs: 850290
> > > > TREE04 no success message, 2897 successful version messages
> > > > Completed in 44512 vs. 450000
> > > > TREE04.10 ------- 1331565 GPs (2.95903/s) n_max_cbs: 909075
> > > > TREE04.10 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.11 ------- 1331535 GPs (2.95897/s) n_max_cbs: 1213974
> > > > TREE04.11 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.12 ------- 1322160 GPs (2.93813/s) n_max_cbs: 2615313
> > > > TREE04.12 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.13 ------- 1320032 GPs (2.9334/s) n_max_cbs: 914751
> > > > TREE04.13 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.14 ------- 1339969 GPs (2.97771/s) n_max_cbs: 1560203
> > > > TREE04.14 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.15 ------- 1318805 GPs (2.93068/s) n_max_cbs: 1757478
> > > > TREE04.15 no success message, 2897 successful version messages
> > > > Completed in 44510 vs. 450000
> > > > TREE04.16 ------- 1340633 GPs (2.97918/s) n_max_cbs: 1377647
> > > > TREE04.16 no success message, 2897 successful version messages
> > > > Completed in 44510 vs. 450000
> > > > TREE04.17 ------- 1322798 GPs (2.93955/s) n_max_cbs: 1266344
> > > > TREE04.17 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.18 ------- 1346302 GPs (2.99178/s) n_max_cbs: 1030713
> > > > TREE04.18 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.19 ------- 1322499 GPs (2.93889/s) n_max_cbs: 917118
> > > > TREE04.19 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > ...
> > > > TREE04.4 ------- 1310283 GPs (2.91174/s) n_max_cbs: 2146905
> > > > TREE04.4 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.5 ------- 1333238 GPs (2.96275/s) n_max_cbs: 1027172
> > > > TREE04.5 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.6 ------- 1313915 GPs (2.91981/s) n_max_cbs: 1017511
> > > > TREE04.6 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.7 ------- 1341871 GPs (2.98194/s) n_max_cbs: 816265
> > > > TREE04.7 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.8 ------- 1339412 GPs (2.97647/s) n_max_cbs: 1316404
> > > > TREE04.8 no success message, 2897 successful version messages
> > > > Completed in 44511 vs. 450000
> > > > TREE04.9 ------- 1327240 GPs (2.94942/s) n_max_cbs: 1409531
> > > > TREE04.9 no success message, 2897 successful version messages
> > > > Completed in 44510 vs. 450000
> > > > 32 runs with runtime errors.
> > > >  --- Done at Sat Oct  8 11:34:10 AM EDT 2022 (12:23:16) exitcode 2
> > > > "
> > > > I have no idea about the test so just arbitrarily pick up the
> > > > console.log of TREE04.10 as an example. Please get it from attachment.
> > >
> > > Very good, thank you!
> > >
> > > Could you please clearly indicate what you tested?  For example, if
> > > you have an externally visible git tree, please point me at the tree
> > > and the SHA-1.  Or send a patch series clearly indicating what it is
> > > based on.
> > >
> > 
> > Yes, it is a good way to eliminate any unexpected mistakes before a rigid test.
> > 
> > Please clone it from https://github.com/pfliu/linux.git  branch:
> > rcu#revert_tick_dep
> 
> Thank you very much!
> 
> > > Then I can try a long run on a larger collection of systems.
> > >
> > 
> > Thank you very much.
> > 
> > > If that works out, we can see about adjustments to mainline.  ;-)
> > >
> > 
> > Eager to see.
> 
> I ran 200 hours of TREE04 and got an RCU CPU stall warning.  I ran 2000
> hours on v6.0, which precedes these commits, and everything passed.
> 
> I will run more, primarily on v6.0, but that is what I have thus far.
> At the moment, I have some concerns about this change.

OK, so I have run a total of 8000 hours on v6.0 without failure.  I have
run 4200 hours on rcu#revert_tick_dep with 15 failures.  The ones I
looked at were RCU CPU stall warnings with timer failures.

This data suggests that the kernel is not yet ready for that commit
to be reverted.

							Thanx, Paul
