Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF5FC2D0E4
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 15:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96B322244
	for <rcu@archiver.kernel.org>; Fri, 27 Nov 2020 15:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5Te/uyt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgK0PuY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Nov 2020 10:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgK0PuX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Nov 2020 10:50:23 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE3D21D7A;
        Fri, 27 Nov 2020 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606492223;
        bh=lFiIw0D3fVkvZN+kwaJU8yol6xsvIi3hwx+kgZeJzR8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=E5Te/uyt5FDsuLpbuGsvviqKnHX2ykovtoNPBfnv9Kna7lQkB8an5QxXsioQUB++D
         Q95I9POCZCK28Ghx0NLIJRMN6uP+D+0gBZpb431MHnOpMlK7LH7R768bYIFemYwb6z
         hw6kTq0hNxt4Um6Gr6xxxZkQlLmVenfIxk1kPNjg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DF6373520430; Fri, 27 Nov 2020 07:50:22 -0800 (PST)
Date:   Fri, 27 Nov 2020 07:50:22 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     rcu@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mark.rutland@arm.com
Subject: Re: powerpc 5.10-rcN boot failures with RCU_SCALE_TEST=m
Message-ID: <20201127155022.GV1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87eekfh80a.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eekfh80a.fsf@dja-thinkpad.axtens.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Nov 27, 2020 at 01:02:29PM +1100, Daniel Axtens wrote:
> Hi all,
> 
> I'm having some difficulty tracking down a bug.
> 
> Some configurations of the powerpc kernel since somewhere in the 5.10
> merge window fail to boot on some ppc64 systems. They hang while trying
> to bring up SMP. It seems to depend on the RCU_SCALE/PERF_TEST option.
> (It was renamed in the 5.10 merge window.)

Adding Mark Rutland on CC in case his similarly mystifying experience
obtaining a fix for ARM has relevance.  From what I could see, that
was a delayed consequence of the x86/entry rewrite.  It was similarly
difficult to bisect.

							Thanx, Paul

> I can reproduce it as follows with qemu tcg:
> 
> make -j64 pseries_le_defconfig
> scripts/config -m RCU_SCALE_TEST
> scripts/config -m RCU_PERF_TEST
> make -j 64 vmlinux CC="ccache gcc"
> 
> qemu-system-ppc64 -cpu power9 -M pseries -m 1G -nographic -vga none -smp 4 -kernel vmlinux
> 
> ...
> [    0.036284][    T0] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes, linear)
> [    0.036481][    T0] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes, linear)
> [    0.148168][    T1] POWER9 performance monitor hardware support registered
> [    0.151118][    T1] rcu: Hierarchical SRCU implementation.
> [    0.186660][    T1] smp: Bringing up secondary CPUs ...
> <hangs>
> 
> I have no idea why RCU_SCALE/PERF_TEST would be causing this, but that
> seems to be what does it: if I don't set that, the kernel boots fine.
> 
> I've tried to git bisect it, but I keep getting different results:
> always a random merge of a seemingly-unrelated subsystem tree - things
> like armsoc or integrity or input.
> 
> It appears to also depend on the way the kernel is booted. Testing with
> a Canonical kernel, so a slightly different config but including
> RCU_SCALE_TEST=m, I see:
> 
> Power8 host + KVM + grub         -> boots
> Power9 host bare metal (kexec)   -> fails
> Power9 host + KVM + grub         -> fails
> Power9 host + KVM + qemu -kernel -> boots
> qemu TCG + power9 cpu            -> fails
> qemu TCG + power8 cpu            -> fails
> 
> Any ideas?
> 
> Kind regards,
> Daniel
> 
> $ qemu-system-ppc64 -version
> QEMU emulator version 4.2.1 (Debian 1:4.2-3ubuntu6.9)
> 
> $ gcc --version
> gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
> 
> It also happens when compiling with GCC 7 and 10.
> 
> 
