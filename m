Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A304C433FE
	for <rcu@archiver.kernel.org>; Fri, 30 Sep 2022 15:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiI3PpS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 30 Sep 2022 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiI3PpI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 30 Sep 2022 11:45:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B819673317
        for <rcu@vger.kernel.org>; Fri, 30 Sep 2022 08:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC7B623BD
        for <rcu@vger.kernel.org>; Fri, 30 Sep 2022 15:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4214C433D6;
        Fri, 30 Sep 2022 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664552699;
        bh=BlGmRLGSOWZrE2EsaQntYja0SiHVjvGrPCsMmrGRZek=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nUp/YhaWVoaCYTo2DLjBvtr4WtLUFKCLXiunHJ/HcXiLFPymiZ6Eukq26XZuSbUqg
         fyTLCX3llScBNpZUgDkn6l6pae0UYNJ1zUJ8RLqwZ8fBJvIC6APnmK6HomBowUYIvb
         FQqrTGH5VxzVxVkwcyPE1iLXeOcH9i6xC5elhyC7Ohb5FH2B02CSZO0Eyu/wfL/kO8
         KZoSlOPyzi5Ufy/RkrkPjPPZDHnkt6fHslww1NDrIJvsJC3etJLbKRte37wcvWYR3j
         Ufp24114cekL+lufWrImLpueOEnZihza75Z4xHcILJFfENII35LPGyloe24nvBpfeO
         FYHjSw5RdC0dg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 471AC5C0BE3; Fri, 30 Sep 2022 08:44:59 -0700 (PDT)
Date:   Fri, 30 Sep 2022 08:44:59 -0700
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
Message-ID: <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220916134258.GB25891@lothringen>
 <YylrJCjYPrcT6xKJ@piliu.users.ipa.redhat.com>
 <20220920094645.GG69891@lothringen>
 <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
 <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com>
 <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
 <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 29, 2022 at 04:19:28PM +0800, Pingfan Liu wrote:
> On Tue, Sep 27, 2022 at 5:59 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Mon, Sep 26, 2022 at 03:23:52PM -0700, Paul E. McKenney wrote:
> > > On Mon, Sep 26, 2022 at 02:34:17PM +0800, Pingfan Liu wrote:
> > > > Sorry to reply late. I just realize this e-mail misses in my gmail.
> > > >
> > > > On Thu, Sep 22, 2022 at 06:54:42AM -0700, Paul E. McKenney wrote:
> > > > [...]
> > > > >
> > > > > If you have tools/.../rcutorture/bin on your path, yes.  This would default
> > > > > to a 30-minute run.  If you have at least 16 CPUs, you should add
> > > >                                             ^^^ TREE04 has CONFIG_NR_CPUS=8, so I think here the num is 8
> > >
> > > Yes, you will get some benefit from --allcpus on systems with from 9-15
> > > CPUs as well as for 16 and more.  At 8 CPUs, it wouldn't matter.
> > >
> > > > > "--allcpus" to do concurrrent runs.  For example, given 64 CPUs you could
> > > > > do this:
> > > > >
> > > > > tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "4*TREE04"
> > > > >
> > > >
> > > > I have tried to find a two socket system with 128 cpus and run
> > > >   sh kvm.sh --allcpus --duration 250h --bootargs rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30 --configs 16*TREE04
> > > >
> > > > Where 250*16=4000
> > >
> > > That would work.
> > >
> >
> > This job has successfully run 24+ hours. (But maybe I can only keep it
> > about 180 hours)
> >
> > > > > This would run four concurrent instances of the TREE04 scenario, each for
> > > > > 10 hours, for a total of 40 hours of test time.
> > > > >
> > > > > > > It does take some time to run.  I did 4,000 hours worth of TREE04
> > > > > >                                         ^^^ '--duration=4000h' can serve this purpose?
> > > > >
> > > > > You could, at least if you replace the "=" with a space character, but
> > > > > that really would run a six-month test, which is probably not what you
> > > > > want to do.  There being 8,760 hours in a year and all that.
> > > > >
> > > > > > Is it related with the cpu's freq?
> > > > >
> > > > > Not at all.  '--duration 10h' would run ten hours of wall-clock time
> > > > > regardless of the CPU frequencies.
> > > > >
> > > > > > > to confirm lack of bug.  But an 80-CPU dual-socket system can run
> > > > > > > 10 concurrent instances of TREE04, which gets things down to a more
> > > > > >
> > > > > > The total demanded hours H = 4000/(system_cpu_num/8)?
> > > > >
> > > > > Yes.  You can also use multiple systems, which is what kvm-remote.sh is
> > > > > intended for, again assuming 80 CPUs per system to keep the arithmetic
> > > > > simple:
> > > > >
> > > > > tools/testing/selftests/rcutorture/bin/kvm-remote.sh "sys1 sys2 ... sys20" --duration 20h --cpus 80 --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "200*TREE04"
> > > > >
> > > >
> > > > That is appealing.
> > > >
> > > > I will see if any opportunity to grasp a batch of machines to run the
> > > > test.
> > >
> > > Initial tests with smaller numbers of CPUs are also useful, for example,
> > > in case reversion causes some bug due to bad interaction with a later
> > > commit.
> > >
> > > Please let me know how it goes!
> > >
> >
> > I have managed to grasp three two-socket machine, each has 256 cpus.
> > The test has run about 7 hours till now without any problem by the following command:
> > tools/testing/selftests/rcutorture/bin/kvm-remote.sh "sys1 sys2 sys3" \
> > --duration 45h --cpus 256 --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "96*TREE04"
> >
> > It seems promising.
> >
> 
> The test is against v6.0-rc7 kernel, and only with 96926686deab ("rcu:
> Make CPU-hotplug removal operations enable tick") reverted. It is
> close to the end, but unfortunately it fails.
> Quote from remote-log
> "
> TREE04.57 ------- 4410955 GPs (27.2281/s) [rcu: g36045577 f0x0
> total-gps=9011687] n_max_cbs: 4111392
> TREE04.58 ------- 4368391 GPs (26.9654/s) [rcu: g35630093 f0x0
> total-gps=8907816] n_max_cbs: 2411104
> TREE04.59 ------- 800516 GPs (4.94146/s) n_max_cbs: 3634471
> QEMU killed
> TREE04.59 no success message, 10547 successful version messages
> ^[[033mWARNING: ^[[mTREE04.59 GP HANG at 800516 torture stat 1925
> ^[[033mWARNING: ^[[mAssertion failure in
> /home/linux/tools/testing/selftests/rcutorture/res/2022.09.26-23.33.34-remote/TREE04.59/console.log
> TREE04.59
> ^[[033mWARNING: ^[[mSummary: Call Traces: 1 Stalls: 8615
> TREE04.6 ------- 4348443 GPs (26.8422/s) [rcu: g35341129 f0x0
> total-gps=8835575] n_max_cbs: 2329432

First, thank you for running this!

This is not the typical failure that we were seeing, which would show
up as a 2.199.0-second RCU CPU stall during which time there would be
no console messages.

But please do let me know how continuing tests go!

							Thanx, Paul

> ...
> ...
> TREE04.91 ------- 4895716 GPs (30.2205/s) [rcu: g39322065 f0x0
> total-gps=9830808] n_max_cbs: 2208839
> TREE04.92 ------- 4902696 GPs (30.2636/s) [rcu: g39113441 f0x0
> total-gps=9778652] n_max_cbs: 1412377
> TREE04.93 ------- 4891393 GPs (30.1938/s) [rcu: g39244749 f0x0
> total-gps=9811481] n_max_cbs: 1772653
> TREE04.94 ------- 4921510 GPs (30.3797/s) [rcu: g39187349 f0x0
> total-gps=9797129] n_max_cbs: 1120534
> TREE04.95 ------- 4885795 GPs (30.1592/s) [rcu: g39020985 f0x0
> total-gps=9755538] n_max_cbs: 1178416
> TREE04.96 ------- 4889097 GPs (30.1796/s) [rcu: g39097057 f0x0
> total-gps=9774556] n_max_cbs: 1861434
> 1 runs with runtime errors.
>  --- Done at Wed Sep 28 08:40:31 PM EDT 2022 (1d 21:06:57) exitcode 2
> "
> 
> Quote from  console.log of TREE04.59
> "
> .....
> [162001.696486] rcu-torture: rcu_torture_barrier_cbs is stopping
> [162001.697004] rcu-torture: Stopping rcu_torture_fwd_prog task
> [162001.697662] rcu_torture_fwd_prog n_max_cbs: 0
> [162001.698195] rcu_torture_fwd_prog: Starting forward-progress test 0
> [162001.698782] rcu_torture_fwd_prog_cr: Starting forward-progress test 0
> [162001.707571] rcu_torture_fwd_prog_cr: Waiting for CBs:
> rcu_barrier+0x0/0x3b0() 0
> [162002.738504] rcu_torture_fwd_prog_nr: Starting forward-progress test 0
> [162002.746491] rcu_torture_fwd_prog_nr: Waiting for CBs:
> rcu_barrier+0x0/0x3b0() 0
> [162002.850483] rcu_torture_fwd_prog: tested 2105 tested_tries 2107
> [162002.851008] rcu-torture: rcu_torture_fwd_prog is stopping
> [162002.851542] rcu-torture: Stopping rcu_torture_writer task
> [162004.530463] rcu-torture: rtc: 00000000ac003c99 ver: 800516 tfle: 0
> rta: 800517 rtaf: 0 rtf: 800507 rtmbe: 0 rtmbkf: 0/142699 rtbe: 0
> rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 205710931 onoff:
> 185194/185194:185196/185196 1,1860:1,3263 25610601:47601063 (HZ=1000)
> barrier: 773783/773783:0 read-exits: 184960 nocb-toggles: 0:0
> [162004.532583] rcu-torture: Reader Pipe:  343007605654 1359216 0 0 0
> 0 0 0 0 0 0
> [162004.533113] rcu-torture: Reader Batch:  342996212546 12752324 0 0
> 0 0 0 0 0 0 0
> [162004.533648] rcu-torture: Free-Block Circulation:  800516 800515
> 800514 800513 800512 800511 800510 800509 800508 800507 0
> [162004.534442] ??? Writer stall state RTWS_EXP_SYNC(4) g30755544 f0x0
> ->state 0x2 cpu 0
> [162004.535057] rcu: rcu_sched: wait state: RCU_GP_WAIT_GPS(1)
> ->state: 0x402 ->rt_priority 0 delta ->gp_start 1674 ->gp_activity
> 1670 ->gp_req_activity 1674 ->gp_wake_time 1674 ->gp_wake_seq 30755540
> ->gp_seq 30755544 ->gp_seq_needed 30755544 ->gp_max 989 ->gp_flags 0x0
> [162004.536805] rcu:    CB 1^0->2 KbclSW F2838 L2838 C0 ..... q0 S CPU 0
> [162004.537277] rcu:    CB 2^0->3 KbclSW F2911 L2911 C7 ..... q0 S CPU 0
> [162004.537742] rcu:    CB 3^0->-1 KbclSW F1686 L1686 C2 ..... q0 S CPU 0
> [162004.538217] rcu: nocb GP 4 KldtS W[..] ..:0 rnp 4:7 2176869 S CPU 0
> [162004.538729] rcu:    CB 4^4->5 KbclSW F2912 L2912 C7 ..... q0 S CPU 0
> [162004.539202] rcu:    CB 5^4->6 KbclSW F2871 L2872 C1 ..... q0 S CPU 0
> [162004.539667] rcu:    CB 6^4->7 KbclSW F4060 L4060 C0 ..... q0 S CPU 0
> [162004.540136] rcu:    CB 7^4->-1 KbclSW F5763 L5763 C1 ..... q0 S CPU 0
> [162004.540653] rcu: RCU callbacks invoked since boot: 1431149091
> [162004.541076] rcu-torture: rcu_torture_stats is stopping
> "
> 
> I have no idea whether this is related to the reverted commit.
> 
> 
> Thanks,
> 
> Pingfan


