Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45729C433E0
	for <rcu@archiver.kernel.org>; Fri, 15 Jan 2021 18:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196BC222B3
	for <rcu@archiver.kernel.org>; Fri, 15 Jan 2021 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbhAOSWC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jan 2021 13:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732975AbhAOSWC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jan 2021 13:22:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C30D423A5E;
        Fri, 15 Jan 2021 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610734881;
        bh=LLZFQLbL6eRrWEswEA5+HX+Gb4bnXN1M5RP5dstQyts=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mn/GIygGq/0GcAiJmv4wP1hWPXDezGrQs/laCr61gXQYrkZY/macw8INg78+GN1qm
         jbPzfJoPp7BQMIEUHFk9pXlOJNmhn+xgxQY06y2gYyGoJGBFslbVvQZTLPURKMIHqZ
         eZEVMN0WEFWhGtqpttk/By2b0gfMxNoCrFoW95FpocL3HZoj/suEMCIj+7MRCxaH0A
         6Lk31OSMkuQxnfIthxpJhWrwhtKnIrNfA1X74lQqsXzwp5mal/cakFebkNxs5R3akU
         1OY9Ckep1OUCIfrxHFQedtRqN3s2J0Kye/YmWhQPYcvot5iv/B8sbejVEpgOmIMWsg
         UkA1Fk2nAMDEg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 917AF352162B; Fri, 15 Jan 2021 10:21:21 -0800 (PST)
Date:   Fri, 15 Jan 2021 10:21:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -rcu] rculist: Replace reference to atomic_ops.rst
Message-ID: <20210115182121.GK2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <94e4df15-770b-4944-f3c6-f2856fc49786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e4df15-770b-4944-f3c6-f2856fc49786@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jan 16, 2021 at 12:11:45AM +0900, Akira Yokosawa wrote:
> >From f92cae321e9a42a1d4bc8a2d5d1a2cd62ab35410 Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Fri, 15 Jan 2021 23:39:03 +0900
> Subject: [PATCH -rcu] rculist: Replace reference to atomic_ops.rst
> 
> atomic_ops.rst was removed in commit f0400a77ebdc ("atomic: Delete
> obsolete documentation").
> Instead, reference a section in memory-barriers.txt discussing
> the use of barrier() in loops.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Queued, thank you!

							Thanx, Paul

> ---
>  include/linux/rculist_nulls.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
> index ff3e94779e73..d8afdb8784c1 100644
> --- a/include/linux/rculist_nulls.h
> +++ b/include/linux/rculist_nulls.h
> @@ -161,7 +161,7 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
>   *
>   * The barrier() is needed to make sure compiler doesn't cache first element [1],
>   * as this loop can be restarted [2]
> - * [1] Documentation/core-api/atomic_ops.rst around line 114
> + * [1] Documentation/memory-barriers.txt around line 1533
>   * [2] Documentation/RCU/rculist_nulls.rst around line 146
>   */
>  #define hlist_nulls_for_each_entry_rcu(tpos, pos, head, member)			\
> -- 
> 2.17.1
> 
