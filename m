Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00E9C433F5
	for <rcu@archiver.kernel.org>; Sat,  5 Feb 2022 00:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbiBEAVT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 4 Feb 2022 19:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbiBEAVT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 4 Feb 2022 19:21:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6085DF8E3CA;
        Fri,  4 Feb 2022 16:21:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D68B83860;
        Sat,  5 Feb 2022 00:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B634C004E1;
        Sat,  5 Feb 2022 00:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644020474;
        bh=iAGTjf0kijpYGD/tXeU0h8B4bIEAsKJc+hhSN0LFTdA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=iOPmdTo2cepGZnmVkpZSQFImkOQRaux2/B6knHg6pYqQ1Pf+X8XSdWzmuszXgu5u1
         jRqp+5UJiRi40d8mA0OLSxXCtTsCmTUe83IQ7TJVUr/V2HgXLi7eQeKaL+CDWOMu0A
         ekD61HRqlwuN6bfoYzcBbIp+luLmhGAc87RhGdntUsz3tMy2P+KQSpba6E6Nb29pNm
         blb88XhiR4ARvVeckTKeOm9g0azjTvS9wmCN3vOHji2CgSoVH+DzSusmMp7ZF+XA58
         cj5Xip91kXrf0eBznUGAakf6NjJMJLuhQy0oXkEQzak0fvGUyaQ07qRfXxLRG8U6Oz
         EOMUD4iKOJCCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D417B5C0418; Fri,  4 Feb 2022 16:21:13 -0800 (PST)
Date:   Fri, 4 Feb 2022 16:21:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/2] RCU tasks updates, possibly for v5.18
Message-ID: <20220205002113.GA4693@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides a couple of updates to the RCU Tasks flavors.

1.	rcu-tasks: Use order_base_2() instead of ilog2().
	This spreads CPUs over queues more evenly.

2.	rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention.
	The current mainline series reduces contention by at most a
	factor of two.	This patch gains at least another factor of
	eight during times of high update-side traffic.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tasks.h |    6 +++---
 kernel/rcu/tasks.h   |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
