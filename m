Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D67C77B7D
	for <rcu@archiver.kernel.org>; Wed, 10 May 2023 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjEJRGX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 May 2023 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjEJRGT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 May 2023 13:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3676A19B3;
        Wed, 10 May 2023 10:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 951BE60ABF;
        Wed, 10 May 2023 17:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011A0C433EF;
        Wed, 10 May 2023 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738361;
        bh=O7xPHBuKYymEq9QfOs6J9G+s+CD0IysaluF7gPmpAC4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=V3nPTiCB4dDVf7BsmRK9iPZ7hzc1NgVp38NjNBnWOPpPWSq6c8oa4Ax81kxbPxuS9
         W98Bfmfp/l3aX1LQjcfxky1I4PYL86a7XStT7EypbWA795sCIfCrcWWg7HO+bXwr7W
         cS7PP2F2feKsa5q7aL7hXINkIF2Cd83YqjaonI3k5aO6jksfy0In/PdAvn/GrvIPIt
         Fo80GtIq5W2NYATKLJriKIBqfZzdk4JHVfMZ2+WS7DRRRDNOslszuTCdkC8GKctPY8
         j9iK+fe3Bjc6Z32/lEEeEhnhDIb1I6IFYSkZJ2C9X3Tsp745SGlvfgTa0OC6z11iwr
         suoYr3c5Wjksg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8656ACE126E; Wed, 10 May 2023 10:06:00 -0700 (PDT)
Date:   Wed, 10 May 2023 10:06:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/4] Callback-offloading updates for v6.5
Message-ID: <9c5fae22-e25e-4548-b6e9-117495b29e62@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides some nocb callback-offloading updates:

1.	rcu/nocb: Protect lazy shrinker against concurrent
	(de-)offloading, courtesy of Frederic Weisbecker.

2.	rcu/nocb: Fix shrinker race against callback enqueuer, courtesy
	of Frederic Weisbecker.

3.	rcu/nocb: Recheck lazy callbacks under the ->nocb_lock from
	shrinker, courtesy of Frederic Weisbecker.

4.	rcu/nocb: Make shrinker to iterate only NOCB CPUs, courtesy of
	Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree_nocb.h |   25 ++++++++++++++++++++++++-
 kernel/rcu/tree_nocb.h   |   33 ++++++++++++++++++++++++++-------
 2 files changed, 50 insertions(+), 8 deletions(-)
