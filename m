Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D371C77B7C
	for <rcu@archiver.kernel.org>; Wed, 10 May 2023 17:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjEJRKG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 May 2023 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEJRKF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 May 2023 13:10:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5068C2;
        Wed, 10 May 2023 10:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F998632B0;
        Wed, 10 May 2023 17:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A029C433EF;
        Wed, 10 May 2023 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738603;
        bh=TvewwtgwqQo7uolmGLzXAL9JLsLG6h/mAf5zcFj0wSA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Nhgx/AEuCveBz0CqVGsL1XXKGgu8/owHWbFuP2Zq7ymh4aeejIpLxplf6lijVHgP/
         yYk1c31uVBmJ6CT30u/dcFIqrr4onBkgdJgyRxVENcznZ/COga5DsFUj0x5rmLT6A7
         hnbK7lUWO2oGshgnmX6OdcTfgsPdXO3JkmzL2e3Y1tTpTIZaDlTBBlwv4i2YPKOvwR
         b4zUaNbtLfR/1+ep0w6XPnx7yl38xz7sNZR0SVL4Yem8t8btX23ZNS8qoHAEeJ8pyo
         mqQeQEqlv81q1blcfvnLLETraan3X0iPw8Q3Xa4jduczIpCuFB9u6Z6Ig+WYz4bJ7T
         0eXo6ZRtdXsGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1C410CE126E; Wed, 10 May 2023 10:10:03 -0700 (PDT)
Date:   Wed, 10 May 2023 10:10:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/2] Tasks RCU updates for v6.5
Message-ID: <edff5c4b-e894-4146-8a1d-ae291d01c4fb@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains Tasks RCU updates.

1.	rcu-tasks: Avoid pr_info() with spin lock in
	cblist_init_generic(), courtesy of Shigeru Yoshida.

2.	rcu-tasks: Clarify the cblist_init_generic() function's pr_info()
	output, courtesy of Zqiang.

An additional Tasks RCU update may instead be found here due to
conflict-inducing dependencies:

https://lore.kernel.org/all/20230510165832.2187453-8-paulmck@kernel.org/

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/tasks.h |    5 ++++-
 kernel/rcu/tasks.h   |    6 ++----
 2 files changed, 6 insertions(+), 5 deletions(-)
