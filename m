Return-Path: <SRS0=0ICO=3L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C56C2D0CE
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 01:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C432465A
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579656391;
	bh=fBxdLTfAc/qffrrqnCaKyRKLBXHq68D7Pa+/N8aYUHk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=aAfpcCXGfsb4l3tPYoQNbo5xqtLoWBgmae7169KBdW3MJim5e9kdGE3VJdF6FGd6k
	 RriKXWIDs2uKSOCaGQNlK6TIAEevUk0NL8XeGGg2OvWepziHbEEw2xWuZI5i/KmX1k
	 qC6PodJuhFGXs77OG44bc/KWT3D8VrrBFvZ6kXYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAVB0b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:26:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgAVB0a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Jan 2020 20:26:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6250F2253D;
        Wed, 22 Jan 2020 01:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579656390;
        bh=fBxdLTfAc/qffrrqnCaKyRKLBXHq68D7Pa+/N8aYUHk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K3LQcewxot5uQ4gn4r1KHLNZqf/Whp1MK5cP1KRAqwZMTTXVl7D4AuZmlL3JFQHCI
         SoQoYgAqeuT6LI78V3YSmd5h6quOzGKQNSQ/vhcoQxcFn9VoVYI7IDf/zSghKKo9Ai
         COpFRD8eE87AmWRUkiJ0YEQI/SEgdpQ8RkU57UGU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3AC6A3520DC0; Tue, 21 Jan 2020 17:26:30 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:26:30 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 0/5] Lock warning clean up
Message-ID: <20200122012630.GE2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200120223515.51287-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120223515.51287-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jan 20, 2020 at 10:35:15PM +0000, Jules Irenge wrote:
> This patch series adds missing annotations to functions that register warnings of context imbalance when built with Sparse tool.
> The adds fix these warnings and give insight on what the functions are actually doing.
> In the core kernel,
> 
> 1. IRQ and RCU subsystems: exactly patch 1 and 3,  __releases() annotations were added as these functions exit the critical section
> 2. RCU subsystem again, patch 2 and 4, __acquire() annotations were added as the functions allow entry to the critical section.
> 3. TIME subsystem, patch 5 where lock is held at entry and exit of the function, an __must_hold() annotation was added.

Queued for review and testing, thank you!

I edited the commit logs, so please check to make sure that I did not
mess something up.

							Thanx, Paul

> Jules Irenge (5):
>   irq: Add  missing annotation for __irq_put_desc_unlock()
>   rcu: Add missing annotation for exit_tasks_rcu_start()
>   rcu: Add missing annotation for exit_tasks_rcu_finish()
>   rcu: Add missing annotation for rcu_nocb_bypass_lock()
>   time: Add missing annotation for __run_timer()
> 
>  kernel/irq/irqdesc.c     | 1 +
>  kernel/rcu/tree_plugin.h | 1 +
>  kernel/rcu/update.c      | 4 ++--
>  kernel/time/hrtimer.c    | 2 +-
>  4 files changed, 5 insertions(+), 3 deletions(-)
> 
> -- 
> 2.24.1
> 
