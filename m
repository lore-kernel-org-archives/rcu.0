Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB3BC3DA78
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 04:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjAQEak (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjAQEaQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 23:30:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54677252B7
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 20:30:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D819EB80E74
        for <rcu@vger.kernel.org>; Tue, 17 Jan 2023 04:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762ECC433EF;
        Tue, 17 Jan 2023 04:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673929811;
        bh=Vb1Z891Iid263VMKIXJGRTCq5kf4ScNrOYnm4UH6WIM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ntBymqeIvu+01wwe1GZzXHG9ohWlJMPnQrVXbJHXIgr5SGUHrNeJHEHfhCqlNkFoj
         V/VlXEREvXL5dlZgxoTzpsFsCI8XITozos6tMy9O42xiT5/M4nTUJ1fIN6fTpip9fD
         +iaYjwswYV3FTwvgOCvxeHhMyYVhsQuVqKPNRaUbMVEdEAPQ+xx5YX1k4Tnp0IbRxM
         iaoKrl47y8oPgq6i85RQzCLOTv50dPqn5j1Zvt1/HWZhNPejVWQAHNzQl9D2Mt7ywX
         A9RepjzgDb6PKg9oLq21S/FaTSrB0VxHdTfZ/lnSCj4cBcRzWDTQ4x6n4TbW15c7eC
         AchqzByqap/oQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 181B75C06D0; Mon, 16 Jan 2023 20:30:11 -0800 (PST)
Date:   Mon, 16 Jan 2023 20:30:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
Message-ID: <20230117043011.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
 <CAABZP2xnCCfCf5DLQuiTXBVbpEgsoedqxA8JsWBLs4SyLOLuFw@mail.gmail.com>
 <CAEXW_YQsUN_80FiXcts+5KgWo999KXWZDbkuPjmFCb8LiiLBzw@mail.gmail.com>
 <Y8Xoi3UvMs+Oy78O@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Xoi3UvMs+Oy78O@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 17, 2023 at 12:15:07AM +0000, Joel Fernandes wrote:
> On Mon, Jan 16, 2023 at 05:38:00PM -0500, Joel Fernandes wrote:
> > Hi Zhouyi,
> > 
> > On Mon, Jan 16, 2023 at 1:33 PM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > >
> > [..]
> > > On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > Hello,
> > > > I am seeing -EBUSY returned a lot during torture_onoff() when running
> > > > rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> > > > also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
> > > >
> > > > This causes warnings in torture tests:
> > > > [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > > [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> > > >
> > > > Full kernel log here:
> > > > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
> > > >
> > > > Any ideas on why this is happening and only for CPU 0 (presumably the
> > > > boot CPU)? I'd personally need these warnings to go away for my tests
> > > > as this causes rcutorture's tests to not cleanly pass for me. It
> > > > appears remove_cpu() -> device_offline() is what returns the error.
> > > >
> > > I guess this probably because CPU 0 is the tick_do_timer_cpu in
> > > nohz_full mode, which prevent that cpu from
> > > going offline [1]. We have discussed this topic, but there is no
> > > agreement on how to solve it yet.
> > 
> > But I am seeing the issue in TRACE02 config which is:
> > CONFIG_NO_HZ_IDLE=y
> > # CONFIG_NO_HZ_FULL is not set
> > 
> > So that is not NO_HZ_FULL:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TRACE02/console.log.diags/
> > However, I can't seem to find the full kernel logs for that.
> > 
> > Also, other than the TRACE02 fail, I only see the issue with configs
> > with CONFIG_NO_HZ_FULL=y
> > 
> > Can you try TRACE02 specifically, and see if you can reproduce the
> > same issue on your setup? Meanwhile, I'll try to trace what is
> > returning the -EBUSY.
> 
> How about something simple like the following? (untested)
> 
> ---8<-----------------------
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index bc8fb361efc0..cd64110694c0 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -220,6 +220,9 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
>  			// PCI probe frequently disables hotplug during boot.
>  			(*n_offl_attempts)--;
>  			s = " (-EBUSY forgiven during boot)";
> +		} else if (tick_nohz_full_running && ret == -EBUSY) {
> +			(*n_offl_attempts)--;
> +			s = " (-EBUSY forgiven if nohz_full is running)";

But this should be forgiven for the timekeeping CPU, not everyone,
correct?

Yes, I know that CPU-hotplug operations can fail, but in my testing
they almost never do.  This means that a new failure might well be a
real bug somewhere that needs attention.

							Thanx, Paul

>  		}
>  		if (verbose)
>  			pr_alert("%s" TORTURE_FLAG
