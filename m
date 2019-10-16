Return-Path: <SRS0=y8K2=YJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548B0C4360C
	for <rcu@archiver.kernel.org>; Wed, 16 Oct 2019 03:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0BC2086A
	for <rcu@archiver.kernel.org>; Wed, 16 Oct 2019 03:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571196925;
	bh=NjsMhpYVP779BKlQlynjlqFZHLWRBBm1A3PdjhOLNb0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=S0xYMMCcgU5Yk/heEhw8m+S6hNy2fIEbAhTdedj9vS8ROMPihOpcrsRx+bUsUnCTv
	 g2aYyqtf1gs1xTyYni9es1H8VeSM9XHvwCcM/YhPf0WNbOjqY1CO6IX9VVhd/VI+nb
	 1KTNxl5FAQwfYImg4oOXhV1NDZBfnHfTqNL/4/Kk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbfJPDfY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbfJPDfY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Oct 2019 23:35:24 -0400
Received: from paulmck-ThinkPad-P72 (unknown [76.14.14.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A73A20663;
        Wed, 16 Oct 2019 03:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571196923;
        bh=NjsMhpYVP779BKlQlynjlqFZHLWRBBm1A3PdjhOLNb0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S+JU7BUh4twUx5S2IAtzJ+I8gHGKCFdLP2ZucnZkHBx91AJOA7vgcDJc4U3IKjDcL
         bYQooA6NcRgH6x8d60NUfVysbsTOyN6KsZp+FJQKBdA8aKxDx+gM3J1D2NJQ4Jwg2z
         ZVoP4yqVcIQBhkjltSfLQ4RStQ9pz+xbMjhKs/mQ=
Date:   Tue, 15 Oct 2019 20:35:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/7] rcu: fix incorrect conditional compilation
Message-ID: <20191016033522.GW2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191015102402.1978-1-laijs@linux.alibaba.com>
 <20191015102402.1978-2-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015102402.1978-2-laijs@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 15, 2019 at 10:23:56AM +0000, Lai Jiangshan wrote:
> DO NOT pick it to stable tree.
> (Since the title has "fix", this statement may help stop
> AI pick it to stable tree)
> 
> The tokens SRCU and TINY_RCU are not defined by any configurations,
> they should be CONFIG_SRCU and CONFIG_TINY_RCU. But there is no
> harm when "TINY_RCU" is wrongly used, which are always non-defined,
> which makes "!defined(TINY_RCU)" always true, which means
> the code block is always inclued, and the included code block
> doesn't cause any compilation error so far when CONFIG_TINY_RCU.
> It is also the reason this change doesn't need for stable.
> 
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Applied for review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index a7ab2a023dd3..05f936ed167a 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -254,7 +254,7 @@ void rcu_test_sync_prims(void);
>   */
>  extern void resched_cpu(int cpu);
>  
> -#if defined(SRCU) || !defined(TINY_RCU)
> +#if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU)
>  
>  #include <linux/rcu_node_tree.h>
>  
> @@ -391,7 +391,7 @@ do {									\
>  #define raw_lockdep_assert_held_rcu_node(p)				\
>  	lockdep_assert_held(&ACCESS_PRIVATE(p, lock))
>  
> -#endif /* #if defined(SRCU) || !defined(TINY_RCU) */
> +#endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
>  
>  #ifdef CONFIG_SRCU
>  void srcu_init(void);
> -- 
> 2.20.1
> 
