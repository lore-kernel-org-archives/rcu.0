Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9557FC4332F
	for <rcu@archiver.kernel.org>; Thu, 22 Dec 2022 16:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLVQk2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Dec 2022 11:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiLVQk0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Dec 2022 11:40:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D307631DC4
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 08:40:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FCD460C17
        for <rcu@vger.kernel.org>; Thu, 22 Dec 2022 16:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1FEC433D2;
        Thu, 22 Dec 2022 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671727224;
        bh=R38aU6US1nMCa9sg1zfX/ooZZsNltThp2BZKDmQaYf4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h2YtjvQhHi9jAuVr9n9R4tfSjzHxOWTGerrMj8TQC1Ux2YYz0Ho8effKqO80OblR4
         t1GDEhEX/TfJVmF3cn6JHDN1Gg/fjCiUUg6jO+H3kJqbzUqNPG4wsTuNFHHmgllPIR
         9DEyL+3mKeMKz10y/eil1p7j96RcSNT0LfRrZLBBteLP79gFkveJKWHHjyvs572ZPq
         dcKQNKnbQ9Jyn00ItoUqp3WG2aoMuzJRvSlSy/TMg2z9v1wced4zWJjRRZW4pwPJnS
         tV3cHbLMOkDg4KIWMkeSfuTNuy9XsM3gFh6RW/rB513i+8Y5OUIu+Y95FRcyp/N+tV
         WxqZnTJk9tDYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 75DB35C146C; Thu, 22 Dec 2022 08:40:24 -0800 (PST)
Date:   Thu, 22 Dec 2022 08:40:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, rcu@vger.kernel.org
Subject: Re: NULL pointer issue in rcu_do_batch()
Message-ID: <20221222164024.GO4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <0fc6b3b3-465b-0b64-fbdf-c80db18a9f88@quicinc.com>
 <459A73FF-7095-4D5D-9D2A-D90BDAD27AF0@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <459A73FF-7095-4D5D-9D2A-D90BDAD27AF0@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 22, 2022 at 08:11:23AM -0500, Joel Fernandes wrote:
> 
> 
> > On Dec 22, 2022, at 6:34 AM, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
> > 
> > ﻿Hi All,
> > 
> > We are observing NULL pointer dereference issue in rcu_do_batch() in 5.15, although it is very hard to hit.
> > 
> > Wanted to check if it is been reported and fixed in recent kernel ?
> 
> What is the test case? I have not seen such corruption. Is it possible for you to run with CONFIG_PROVE_RCU?

What Joel said!

Another common cause of this is double call_rcu(), free-after-call_rcu(),
or similar.  CONFIG_DEBUG_OBJECTS_RCU_HEAD can help track these down,
and KASAN can also be helpful.

							Thanx, Paul

> This looks like an Android kernel, I can tell by looking at VendorHooks in the log. So with all that GKI stuff, are we sure that is not causing some unforeseen side effect ?
> 
> Thanks,
> 
>  - Joel
> 
> 
> > <1>[16.814014] [pid:    58] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> > <0>[16.814027] [pid:    58] PC Code: bad value
> > <0>[16.814034] [pid:    58] LR Code: f81e03a8 b5000068 d10083a8 f81e83a8 aa1f03f6 91127319 d10083b7 f9434b68 d503201f f9400408 910006d6 f900041f d63f0100 (91004308) b8bfc108 374001c8 97ffff2b 9111e308 38bfc108 72001d1f
> > 
> > <4>[16.814359] [pid:    58] CPU: 7 PID: 58 Comm: rcuop/5 Tainted: G S   W  OE     5.15.41-android13-8-25574579-abS911USQU1AVLL #1
> > <4>[16.814361] [pid:    58] Hardware name: XXXXX
> > <4>[16.814362] [pid:    58] pstate: 42400805 (nZcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=-c)
> > <4>[16.814364] [pid:    58] pc : 0x0
> > <4>[16.814365] [pid:    58] lr : rcu_do_batch+0x328/0xcd8
> > 
> > 
> > rcu_data for CPU5 contains additional 12 RCU callback heads in the segment of RCU_DONE_TAIL whose func is NULL. It doesn’t seem to be a random memory corruption since only rhp->func is set to null across multiple objects.
> > 
> > There is one more occurrence with CONFIG_CFI_CLANG enabled.
> > 
> > [123587.101222][   T44] Kernel panic - not syncing: CFI failure (target: 0x0)
> > [123587.101249][   T44] CPU: 0 PID: 44 Comm: rcuop/3 Tainted: G S WC OE     5.15.41 #1
> > [123587.101263][   T44] Hardware name: XXXXX
> > [123587.101274][   T44] Call trace:
> > [123587.101283][   T44]  dump_backtrace.cfi_jt+0x0/0x8
> > [123587.101298][   T44]  show_stack+0x1c/0x2c
> > [123587.101311][   T44]  dump_stack_lvl+0x94/0x100
> > [123587.101326][   T44]  panic+0x17c/0x450
> > [123587.101338][   T44]  find_check_fn+0x0/0x210
> > [123587.101349][   T44]  rcu_do_batch+0x368/0x6f8
> > [123587.101362][   T44]  nocb_cb_wait+0x80/0x450
> > [123587.101374][   T44]  rcu_nocb_cb_kthread+0x54/0x90
> > [123587.101386][   T44]  kthread+0x174/0x1d8
> > [123587.101398][   T44]  ret_from_fork+0x10/0x20
> > [123587.101410][   T44] SMP: stopping secondary CPUs
> > [123587.101670][    C4] VendorHooks: CPU4: stopping
> > 
> > -Mukesh
