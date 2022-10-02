Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86568C433F5
	for <rcu@archiver.kernel.org>; Sun,  2 Oct 2022 16:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJBQUY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 2 Oct 2022 12:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJBQUX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 2 Oct 2022 12:20:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C28201A6
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 09:20:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BE03B80D6E
        for <rcu@vger.kernel.org>; Sun,  2 Oct 2022 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65976C433C1;
        Sun,  2 Oct 2022 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664727619;
        bh=SgZf1nZsgXTIW4y2nVWoGIAdPIaXBLDUD5/9n84bh7U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jntigxyQNG6MgQZ6cyvAz/TLPtAxjEvpbymnjJewJTAXQR63SzjO0YWByIf/OI6as
         Kg/2a9UDdhBUsbe8EqV87xbOOdvsUa70W9q9CDm4a0qpqQH2b2JKLahfsvWTtHCs3V
         rMexaxA++I4c907iEH9QrmVsdExCAmIzzgkxVs07uCc9P/726v/BO4vAP6JK7reBQs
         Fz7wJu3gfh/6Fr7gRwnMfK8nUgPzcKxuUiO3snUYo2u5babyYlpQrCCW40AWnEjI0K
         bYNpPq45zGY0bE/YYR8/frfJcW1gj3ku3GYXy+VBHbPjBFh4ICqZ+uwRh1v8Yn8DvX
         gNOGzo1ZQAeNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0E6DF5C086D; Sun,  2 Oct 2022 09:20:19 -0700 (PDT)
Date:   Sun, 2 Oct 2022 09:20:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, rcu@vger.kernel.org,
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
Message-ID: <20221002162019.GS4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220920191339.GS4196@paulmck-ThinkPad-P17-Gen-1>
 <Yywq/AtA5DN6J5+6@piliu.users.ipa.redhat.com>
 <20220922135442.GH4196@paulmck-ThinkPad-P17-Gen-1>
 <YzFH6WSMX/Yht+i1@piliu.users.ipa.redhat.com>
 <20220926222352.GV4196@paulmck-ThinkPad-P17-Gen-1>
 <YzLJZU2mAPjfD/RK@piliu.users.ipa.redhat.com>
 <CAFgQCTtLm-JXRyQfKo6-+P00SShVGujZGau+khmtCe1AiRodQA@mail.gmail.com>
 <20220930154459.GF4196@paulmck-ThinkPad-P17-Gen-1>
 <CAFgQCTu75NPFM8L6a8-bgAzwzNtEdAV+DkXc7ssu6arf3o-o-A@mail.gmail.com>
 <20221002150858.GA292620@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002150858.GA292620@lothringen>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Oct 02, 2022 at 05:08:58PM +0200, Frederic Weisbecker wrote:
> On Sun, Oct 02, 2022 at 09:29:59PM +0800, Pingfan Liu wrote:
> > On Fri, Sep 30, 2022 at 11:45 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > [...]
> > > > > I have managed to grasp three two-socket machine, each has 256 cpus.
> > > > > The test has run about 7 hours till now without any problem by the following command:
> > > > > tools/testing/selftests/rcutorture/bin/kvm-remote.sh "sys1 sys2 sys3" \
> > > > > --duration 45h --cpus 256 --bootargs "rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30" --configs "96*TREE04"
> > > > >
> > > > > It seems promising.
> > > > >
> > > >
> > > > The test is against v6.0-rc7 kernel, and only with 96926686deab ("rcu:
> > > > Make CPU-hotplug removal operations enable tick") reverted. It is
> > > > close to the end, but unfortunately it fails.
> > > > Quote from remote-log
> > > > "
> > > > TREE04.57 ------- 4410955 GPs (27.2281/s) [rcu: g36045577 f0x0
> > > > total-gps=9011687] n_max_cbs: 4111392
> > > > TREE04.58 ------- 4368391 GPs (26.9654/s) [rcu: g35630093 f0x0
> > > > total-gps=8907816] n_max_cbs: 2411104
> > > > TREE04.59 ------- 800516 GPs (4.94146/s) n_max_cbs: 3634471
> > > > QEMU killed
> > > > TREE04.59 no success message, 10547 successful version messages
> > > > ^[[033mWARNING: ^[[mTREE04.59 GP HANG at 800516 torture stat 1925
> > > > ^[[033mWARNING: ^[[mAssertion failure in
> > > > /home/linux/tools/testing/selftests/rcutorture/res/2022.09.26-23.33.34-remote/TREE04.59/console.log
> > > > TREE04.59
> > > > ^[[033mWARNING: ^[[mSummary: Call Traces: 1 Stalls: 8615
> > > > TREE04.6 ------- 4348443 GPs (26.8422/s) [rcu: g35341129 f0x0
> > > > total-gps=8835575] n_max_cbs: 2329432
> > >
> > > First, thank you for running this!
> > >
> > > This is not the typical failure that we were seeing, which would show
> > > up as a 2.199.0-second RCU CPU stall during which time there would be
> > > no console messages.
> > >
> > > But please do let me know how continuing tests go!
> > >
> > 
> > This time, the same test environment except against v6.0-rc7 mainline,
> > also encountered the not typical failure.
> 
> Interesting, I'm trying to reproduce...

Very good, thank you!

							Thanx, Paul
