Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE79C433F5
	for <rcu@archiver.kernel.org>; Fri,  8 Apr 2022 14:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbiDHOoy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiDHOox (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Apr 2022 10:44:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9814BF94EF
        for <rcu@vger.kernel.org>; Fri,  8 Apr 2022 07:42:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KZgvm2CQ9z4xR1;
        Sat,  9 Apr 2022 00:42:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1649428964;
        bh=EZHCP6PqnVf23desNVAgG8DT5zERwIhvdfa/BbmKnpQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l7MWlC+BihqhZwSLnIwDvuqwoMsplYU/BcQR/V08MYFAm0U7iqxy9lC+r0NOzgeAV
         hNPmsS67SC1ll/pWfMCuIgiYiqWAlmPjuAGBgBOCpVD0odQa/9d8jZ7bxJhNl/ASzQ
         oDfpeJ0DTe7y/beXmI/n9S2v+mLjXhXYILhL52u56MuvIYQSxRIq3SIwCqVOOCfsYz
         /jl1RO+0I1xkf7aZUzqzLfxOHTH69BiDBWYK3ADucPofheJPCEpzvN+v70fLGYsKRM
         cOO9hZMay/pnLTnwBcPFZgZ1o6dfUSUIsZkLbeBB1y8BjoyPWFCAhNwCBFjw2dxQPs
         e0btYqr4hIacQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     paulmck@kernel.org, Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
In-Reply-To: <87pmls6nt7.fsf@mpe.ellerman.id.au>
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <87pmls6nt7.fsf@mpe.ellerman.id.au>
Date:   Sat, 09 Apr 2022 00:42:39 +1000
Message-ID: <87k0bz7i1s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> "Paul E. McKenney" <paulmck@kernel.org> writes:
>> On Wed, Apr 06, 2022 at 05:31:10PM +0800, Zhouyi Zhou wrote:
>>> Hi
>>> 
>>> I can reproduce it in a ppc virtual cloud server provided by Oregon
>>> State University.  Following is what I do:
>>> 1) curl -l https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/snapshot/linux-5.18-rc1.tar.gz
>>> -o linux-5.18-rc1.tar.gz
>>> 2) tar zxf linux-5.18-rc1.tar.gz
>>> 3) cp config linux-5.18-rc1/.config
>>> 4) cd linux-5.18-rc1
>>> 5) make vmlinux -j 8
>>> 6) qemu-system-ppc64 -kernel vmlinux -nographic -vga none -no-reboot
>>> -smp 2 (QEMU 4.2.1)
>>> 7) after 12 rounds, the bug got reproduced:
>>> (http://154.223.142.244/logs/20220406/qemu.log.txt)
>>
>> Just to make sure, are you both seeing the same thing?  Last I knew,
>> Zhouyi was chasing an RCU-tasks issue that appears only in kernels
>> built with CONFIG_PROVE_RCU=y, which Miguel does not have set.  Or did
>> I miss something?
>>
>> Miguel is instead seeing an RCU CPU stall warning where RCU's grace-period
>> kthread slept for three milliseconds, but did not wake up for more than
>> 20 seconds.  This kthread would normally have awakened on CPU 1, but
>> CPU 1 looks to me to be very unhealthy, as can be seen in your console
>> output below (but maybe my idea of what is healthy for powerpc systems
>> is outdated).  Please see also the inline annotations.
>>
>> Thoughts from the PPC guys?
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
>
> I don't see an obvious bug in the diff, but I could be wrong, or the old
> code was papering over an existing bug?
>
> I'll try and work out what it is about Miguel's config that exposes
> this vs our defconfig, that might give us a clue.

It's CONFIG_HIGH_RES_TIMERS=n which triggers the stall.

I can reproduce just with:

  $ make ppc64le_guest_defconfig
  $ ./scripts/config -d HIGH_RES_TIMERS

We have no defconfigs that disable HIGH_RES_TIMERS, I didn't even
realise you could disable it TBH :)

The Rust CI has it disabled because I copied that from the x86 defconfig
they were using back when I added the Rust support. I think that was
meant to be a stripped down fast config for CI, but the result is it's
just using a badly tested combination which is not helpful.

So I'll send a patch to turn HIGH_RES_TIMERS on for the Rust CI, and we
can debug this further without blocking them.

cheers
