Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A6CC433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Jun 2022 05:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiFOFIB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jun 2022 01:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiFOFIA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jun 2022 01:08:00 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7300614085
        for <rcu@vger.kernel.org>; Tue, 14 Jun 2022 22:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9A5CCE1BA5
        for <rcu@vger.kernel.org>; Wed, 15 Jun 2022 05:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7640C34115;
        Wed, 15 Jun 2022 05:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655269675;
        bh=TbAAoIwb6O2WrX7NEDkgeMrUwCqJNWUa8quoSOmaZTc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bR9L9HlK1NtRZWbb92j3dNRmFw9d43w2t07jQTk4VJOSAHM6Z2FYnfbJoGwkk1hV9
         Of3MONO1rMnmaAJF3XqPz8cywjmTffvDlCzlIZeasZoGOPmIV0SYG6BuwBun9WS3pL
         7hWjzE2DlsGYC4b86kjPCJiYXJr5+psUIHnfc4Hfwsnsh3fafO0j+xzA14S+IjrZgl
         gnqcEIPHW2jPC7ADZ8Gu282v6qkrYDUBXoOqA1dm6+XQsYqUpOKBoH7CGoK9UrEP5C
         qm1fsZnM+sdmF+OhDWN2C7/gqfeE+o4CilBe9z7XCXI0kWux8IaTj9v+lzvGAi2OEF
         RDxKcZNHzvzuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 961125C0BCC; Tue, 14 Jun 2022 22:07:55 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:07:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     yueluck <yueluck@163.com>
Cc:     josh@joshtriplett.org, rcu@vger.kernel.org, qiang1.zhang@intel.com
Subject: Re: question about rcu and many hung processes lead to reboot
Message-ID: <20220615050755.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <9441c66.1e15.1816591cf9d.Coremail.yueluck@163.com>
 <f1de832.1e37.1816593718c.Coremail.yueluck@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1de832.1e37.1816593718c.Coremail.yueluck@163.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 15, 2022 at 12:16:10PM +0800, yueluck wrote:
> add a detailed attachment
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2022-06-15 12:14:23, "yueluck" <yueluck@163.com> wrote:
> 
> Hi, both of you：
>    Sorry to trouble you, because rcu is too complicated.  
>    I encounter many hung processes which are normal container-runc, the number of which  increases continuely and system load becomes higher and os reboots.
>    There is a related link  https://access.redhat.com/solutions/5224631 ，

I do not have access to this document, so I cannot say anything about
their offered solution.  They do claim to have a solution, though, so I
strongly suggest you follow their suggestions.  Me, I work with mainline,
and the 4.18 kernel that you are running was almost four years ago.

> the call stack and scene are similar.  patch https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d1f898df6586c5ea9aeaf349f13089c6fa37903

What happens when you apply this patch?

>    process is never waken up after synchronize_rcu. 


> Could you pleae have a look at the call stack(attachment) and give me some idea?     
> source code :  https://github.com/bigclouds/linux-4.18.0-147.3.1.el8

Do you see RCU CPU stall warnings?  Please see the Linux-kernel file
named Documentation/RCU/stallwarn.* for more information.  (The "*" might
be "txt" or "rst" depending on how old your kernel source tree is.)
In particular, this file describes various things that can prevent
synchronize_rcu() from returning, ranging from CPUs spinning with
interrupts disabled to malfunctioning timer hardware.

If you do not see stall warnings, have they been disabled?  The values
of the RCU_CPU_STALL_TIMEOUT Kconfig option and the kernel boot
parameter rcupdate.rcu_cpu_stall_suppress control this, as does the
rcupdate.rcu_cpu_stall_suppress_at_boot kernel parameter.

So if the RCU CPU stall warnings have been disabled, please re-enable
them.  They give much more information on these sorts of problems.

Plus there is the usual debugging advice, for example, if this is a new
problem, look at what has changed at about the time that the problem
appeared.  For example, things like this can happen when backporting
fixes or when bringing up new hardware.

Also, please apply whatever debugging tools you have to check the health
of the CPUs, for example, to see if any are spinning with preeemption or
interrupts disabled.  Or even if any are in a tight loop in the kernel.
(No, this will not be visible from the stack trace of the task blocked
in synchronize_rcu().)

And again, please read Documentation/RCU/stallwarn.* carefully, preferably
getting the version from a recent kernel such as v5.18.  This document
contains lots of information on causes of this sort of problem.

							Thanx, Paul

> Thanks,
> 
> 
> 
> 
> 
> 
> ------env-----------------------
> centos 4.18.0-147.3.1.el8_1.3
> -------ps------------------------
> $ ps -aux| grep 156623
> root      156623  0.0  0.0  24012  9044 ?        D    May31   0:00 runc init
> ------stack----------------------
> sudo cat /proc/156623/stack
> Password: 
> [<0>] __wait_rcu_gp+0x117/0x140
> [<0>] synchronize_rcu+0x6f/0x80
> [<0>] namespace_unlock+0x67/0x80
> [<0>] ksys_umount+0x231/0x450
> [<0>] __x64_sys_umount+0x12/0x20
> [<0>] do_syscall_64+0x5b/0x1c0
> [<0>] entry_SYSCALL_64_after_hwframe+0x65/0xca
> [<0>] 0xffffffffffffffff
> test:/var/log$ sudo cat /proc/156623/stat
> ----------------------------------


