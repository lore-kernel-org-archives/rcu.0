Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BBCECAAD3
	for <rcu@archiver.kernel.org>; Wed, 31 Aug 2022 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiHaSVU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 31 Aug 2022 14:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiHaSVD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 31 Aug 2022 14:21:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDD8FB0D9;
        Wed, 31 Aug 2022 11:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34528B8220F;
        Wed, 31 Aug 2022 18:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E243BC433D7;
        Wed, 31 Aug 2022 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969753;
        bh=P8hugWEH9dFAuQ4O1YQpRk4CZxmEtuhvEuG7za9zhs8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ZWElMjeD7pXQhb5KrUcDCEA5kEKC/GJfHqlEs+hlTYLNPNcS5XZLhPuS+hvK2MvCT
         7X0XSxx2e8Bie2DEmTgw/08O83S6hlXkc5ewLTh6LO12R7aLsHwrZXFVJzuOP8R4HQ
         7nTnlFyd7TEYrJOO9+Ub7QnuKwx1LU2vn3pku1Zqu5iAHuiJRu0WKQXH1fmKkTB8b1
         scn4/znUUaLNG4v7vm6ozWrV9OkdOickZg5az1boXbllDy65+/EB0ptd/bYYCKcDGr
         m99jUP9QATWIIcUAVcpP7ncw16GayK39tm2leikWy5st6iPI54tdaqjV3FzehgPWvH
         nUQ4b1IvVn+sQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 940755C015D; Wed, 31 Aug 2022 11:15:53 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:15:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] RCU Tasks updates for v6.1
Message-ID: <20220831181553.GA2696186@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides some RCU Tasks updates:

1.	rcu-tasks: Convert RCU_LOCKDEP_WARN() to WARN_ONCE(), courtesy
	of Zqiang.

2.	rcu-tasks: Ensure RCU Tasks Trace loops have quiescent states.

3.	rcu-tasks: Make RCU Tasks Trace check for userspace execution,
	courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tasks.h       |    2 +-
 b/kernel/rcu/tree.c        |    4 ++--
 b/kernel/rcu/tree_plugin.h |    4 ----
 kernel/rcu/tasks.h         |    3 +++
 4 files changed, 6 insertions(+), 7 deletions(-)
