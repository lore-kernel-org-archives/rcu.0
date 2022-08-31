Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8766ECAAD3
	for <rcu@archiver.kernel.org>; Wed, 31 Aug 2022 18:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiHaSLF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiHaSKt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 Aug 2022 14:10:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620BF5853C;
        Wed, 31 Aug 2022 11:10:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC14BB82012;
        Wed, 31 Aug 2022 18:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A649C433D6;
        Wed, 31 Aug 2022 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969357;
        bh=EZCaHFNfWzzK81BUJHas2+EH26hcxKcbRtxd2gbUdDc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=TiKAENTnjrECd4Xna+cz74y6FT50vB1jrnin5uWfY3H6yBAPla+EoG+VfhwEnWl7W
         i/keiA4tAA+Z6luGjr4Tk1MA9GFTj67WyWbJzkdulbseyT5UhFG7hliYO//j6epMq0
         8a0WF/3580uBOjx3H2sxYxqp+PY14z/gyKt4R0Yk8beNVbswINe3QqBLIiKXPnlG5F
         PxiD7mOpj0QsCAVm6dti5PjU0yEGa7S+NaqXui81Tadnu8vnaNz4xO90OHgQ1evCPh
         Ditl9sokGanELEXbpCnyMqfsgX5J4rHOgYSU7matcT0NmW/QXeZBQm+ssAFs0AtR8X
         IvDByMozyJW4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F0DA15C015D; Wed, 31 Aug 2022 11:09:16 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:09:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] kvfree_rcu updates for v6.1
Message-ID: <20220831180916.GA2693797@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains a few kvfree_rcu() updates:

1.	Back off upon fill_page_cache_func() allocation failure, courtesy
	of Michal Hocko.

2.	Fix kfree_rcu_shrink_count() return value, courtesy of "Joel
	Fernandes (Google)".

3.	Update KFREE_DRAIN_JIFFIES interval, courtesy of "Uladzislau Rezki
	(Sony)".

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tree.c |   17 +++++++++--------
 kernel/rcu/tree.c   |   25 ++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 13 deletions(-)
