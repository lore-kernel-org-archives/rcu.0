Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F72C433EF
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 14:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiDHOIa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiDHOI2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 10:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD741A6342
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 07:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02D8261BFB
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 14:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D09FC385A3;
        Fri,  8 Apr 2022 14:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649426784;
        bh=bsMFMPa9xdc4qXQKk/ztx+aFhK0+3VF/uBT51POjlb8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JqGIGl7bR8+ZRSEWI8/tT3wyHsQPVov6vyGqBTr5wXGOoOJQFffQqeucQbxfE0v4r
         HekJKAvQAaAs1MuZ644SoIndEaovWJq5N+WAvhZ5jnqg1WtxlKyT+9XmQiBUzdYAmu
         TS2ynNJp+JtlvseYFkTM++H3gyiD9x/8hvxJqUaBnzTdhNxWfvqEpryM4Lls1UlRjk
         dSwcDJeJaerUR2fyUVqeiUOG6hzpjMLkpcubr9NXkUoB8xY0Z7xu+LES+o7Zq0hZyG
         RtglujENLbaDMGrNsxDxohh7+BKRfMgWQWiJqQzqVn+gmmzxOmH8uuXNFGnUGvDQ2h
         k/oNbnR5IoYtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EDD575C015D; Fri,  8 Apr 2022 07:06:23 -0700 (PDT)
Date:   Fri, 8 Apr 2022 07:06:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, rcu <rcu@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
Message-ID: <20220408140623.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <87pmls6nt7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmls6nt7.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Apr 08, 2022 at 05:23:32PM +1000, Michael Ellerman wrote:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Wed, Apr 06, 2022 at 05:31:10PM +0800, Zhouyi Zhou wrote:
> >> Hi
> >> 
> >> I can reproduce it in a ppc virtual cloud server provided by Oregon
> >> State University.  Following is what I do:
> >> 1) curl -l https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.18-rc1.tar.gz
> >> -o linux-5.18-rc1.tar.gz
> >> 2) tar zxf linux-5.18-rc1.tar.gz
> >> 3) cp config linux-5.18-rc1/.config
> >> 4) cd linux-5.18-rc1
> >> 5) make vmlinux -j 8
> >> 6) qemu-system-ppc64 -kernel vmlinux -nographic -vga none -no-reboot
> >> -smp 2 (QEMU 4.2.1)
> >> 7) after 12 rounds, the bug got reproduced:
> >> (http://154.223.142.244/logs/20220406/qemu.log.txt)
> >
> > Just to make sure, are you both seeing the same thing?  Last I knew,
> > Zhouyi was chasing an RCU-tasks issue that appears only in kernels
> > built with CONFIG_PROVE_RCU=y, which Miguel does not have set.  Or did
> > I miss something?
> >
> > Miguel is instead seeing an RCU CPU stall warning where RCU's grace-period
> > kthread slept for three milliseconds, but did not wake up for more than
> > 20 seconds.  This kthread would normally have awakened on CPU 1, but
> > CPU 1 looks to me to be very unhealthy, as can be seen in your console
> > output below (but maybe my idea of what is healthy for powerpc systems
> > is outdated).  Please see also the inline annotations.
> >
> > Thoughts from the PPC guys?
> 
> I haven't seen it in my testing. But using Miguel's config I can
> reproduce it seemingly on every boot.
> 
> For me it bisects to:
> 
>   35de589cb879 ("powerpc/time: improve decrementer clockevent processing")
> 
> Which seems plausible.
> 
> Reverting that on mainline makes the bug go away.

Thank you for looking into this!

> I don't see an obvious bug in the diff, but I could be wrong, or the old
> code was papering over an existing bug?
> 
> I'll try and work out what it is about Miguel's config that exposes
> this vs our defconfig, that might give us a clue.

I have recently had some RCU bugs that were due to Kconfig failing to
rule out broken .config files.  Maybe this is something similar?

							Thanx, Paul
