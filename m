Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5107C77B7D
	for <rcu@archiver.kernel.org>; Mon, 15 May 2023 11:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbjEOL1G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 15 May 2023 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjEOL1E (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 15 May 2023 07:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DAF1
        for <rcu@vger.kernel.org>; Mon, 15 May 2023 04:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A309F622CB
        for <rcu@vger.kernel.org>; Mon, 15 May 2023 11:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148BFC433EF;
        Mon, 15 May 2023 11:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684150016;
        bh=CVgBgO7F7FMwRI+zstZCoQLOAarjMPXjNT++tSyqp1U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KLpO7djH2G62RKG8hJtZfmRgv5sbbKV/aH407NtUTAq+zWsw3Yrxg7sVNlLQQeTRM
         gAK6V41HEev9hOkORsJ8dyDuKtRuZUvblDUciVXTGSI8Go+/elH8TjTifut7+ellFE
         vociVDtPwvBLUYjVtYsVuRIJjDpLnJR2QV8r0XXw4/nfNnYArzeOpk7+LGLAYRxEKR
         orTGgf5wXDF9Pw/iOVe/I9B6QybW0dyeQLrS2p+5oQzUX/UAOAdCLBxU77y82XOO8o
         zL1KTWsc58+WuZzc7LVEajOS5kE0Ie94cD5RXkEiDc7q3QRgNm/Vcl2ZhKyfFUsTl+
         U9KLG8NBw6mLw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8BCADCE0CC0; Mon, 15 May 2023 04:26:55 -0700 (PDT)
Date:   Mon, 15 May 2023 04:26:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     rcu <rcu@vger.kernel.org>
Subject: Re: A small question about rcu_nocb_wait_contended
Message-ID: <7a026049-fbfa-41b0-bbba-f0690802c8ec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAABZP2yo4J8tp0_oyzPnk+8KhUEC2mqSNRvpNdPsLawvaJxrRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABZP2yo4J8tp0_oyzPnk+8KhUEC2mqSNRvpNdPsLawvaJxrRA@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 15, 2023 at 09:55:02AM +0800, Zhouyi Zhou wrote:
> Dear RCUers:
> 
> When I study the function rcu_nocb_try_bypass, the only place it can
> be called is from
> function __call_rcu_common, and __call_rcu_common disable irq before
> call rcu_nocb_try_bypass, so, I assume when we enter
> rcu_nocb_try_bypass, there will be no
> context switch.
> 
> In rcu_nocb_try_bypass, rcu_nocb_wait_contended got called, the
> purpose of rcu_nocb_wait_contended is "relying on the fact that at
> most two kthreads and one CPU contend for this lock".
> 
> My question is: assume there will be no context switch, why will there
> be two kthreads competing for this CPU lock?
> 
> I have stumbled on this question for more than a year.
> 
> Thank you all in advance ;-)

In kernels built with CONFIG_RCU_NOCB_CPU=y and on CPUs selected by either
the nohz_full or rcu_nocbs kernel boot parameters, callbacks are invoked
by "rcuo" kthreads created for this purpose.  These kthreads might run
on any CPU, and so you can have the CPU queuing the callback contending
with the CPU running the corresponding "rcuo" kthread.

							Thanx, Paul
