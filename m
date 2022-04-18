Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C305CC433EF
	for <rcu@archiver.kernel.org>; Mon, 18 Apr 2022 22:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiDRW7R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDRW7R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 18:59:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0E5BCAD;
        Mon, 18 Apr 2022 15:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FCFBB81134;
        Mon, 18 Apr 2022 22:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BDFC385A1;
        Mon, 18 Apr 2022 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322594;
        bh=418bIgHfKo8GbdgcSjiFRcccYmsSnPg9VC1dkgqQfXY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=gqpz0YwWfiIE0eN4weqxocih03fufpSQix5SJKKZWIndMCtCFXkso7JzYOWDuZa8D
         YmUfuycEP7y2YAmXtlSKa7pF4DOJS3cCvgybOO+2RJ+YMGj1R0U4V9O3XYJ0PKgNig
         cyO53ab1DMWdAlp7zR7cjV/8Mp7h0+uAYd4z1w+qFL7xJ9g5MlFKvhUtFYFszFR8uF
         KA/BhbUEkI1oBKupbl9wi0tO0PbrhyZTEn6Udj/voCmZoPunf+KIeb1ckJtK0va787
         oaU0DbRSf+KdHOAzzYot8yvB82jWUEGe3+K+H+Mw1xP1+9Bg3GOjtYvNkV5pt41ojN
         zSipq9LbBPpmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B9E025C04BD; Mon, 18 Apr 2022 15:56:33 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:56:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/5] Callback-offloading (NOCB) updates for v5.19
Message-ID: <20220418225633.GA3945428@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series applies some simplifications to RCU's callback-offloading
code:

1.	Remove rcu_is_nocb_cpu(), courtesy of Frederic Weisbecker.

2.	Move rcu_nocb_is_setup to rcu_state, courtesy of Frederic
	Weisbecker.

3.	Assume rcu_init() is called before smp, courtesy of Frederic
	Weisbecker.

4.	Initialize boost kthread only for boot node prior SMP
	initialization, courtesy of Frederic Weisbecker.

5.	Initialize nocb kthreads only for boot CPU prior SMP
	initialization, courtesy of Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcu.h         |    2 --
 b/kernel/rcu/tree.c        |   11 +++++------
 b/kernel/rcu/tree.h        |    1 +
 b/kernel/rcu/tree_nocb.h   |    8 --------
 b/kernel/rcu/tree_plugin.h |   16 ----------------
 kernel/rcu/tree.c          |   11 +++++++++--
 kernel/rcu/tree.h          |    2 --
 kernel/rcu/tree_nocb.h     |   33 +++++----------------------------
 8 files changed, 20 insertions(+), 64 deletions(-)
