Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9359C433EF
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 22:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbiFTWtq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiFTWtp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 18:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3248117580;
        Mon, 20 Jun 2022 15:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3C2861355;
        Mon, 20 Jun 2022 22:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CB0C3411B;
        Mon, 20 Jun 2022 22:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765384;
        bh=V7mEZ0lfU/n05qqEPI93xDFptYz7yr8cukWTkMIKyeg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=UpRe6/3jcN76WeOgJqCFcIrHjb7YTvHuAy2/0iN5orVHEXZ3ZMWoQLTaWuXr3C6+1
         DWJLYJ8xK+i4mLND91udy1kQ3NYNDZG/eGgUTE+AEfMlS8CApkbfBmTnFCdMSnjHFb
         Ct0NjLTTbK4cq8OWH/soyY1A95+7FShmbw6DTujJtxoM4CfQOZfFyusbiFyh+PIVUM
         HL3HQHicNU5O8eMGMeHMYSdmT+IypH6Usa2PLsPao+FJi8MhBDFlv02YIY8xnHbREH
         yiov7DJBBBmYqd8DSzWPgGx9BxxCs0Ksmsk1W61VYfB51Uhtv6cIELrFVchbHnjRT4
         IcMuHwVWF4qTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D6A475C05B9; Mon, 20 Jun 2022 15:49:43 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:49:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/12] Polled grace-period updates for v5.20
Message-ID: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series adds support for polled expedited RCU grace periods:

1.	Make normal polling GP be more precise about sequence numbers.

2.	Provide a get_completed_synchronize_rcu() function.

3.	Validate get_completed_synchronize_rcu().

4.	Switch polled grace-period APIs to ->gp_seq_polled.

5.	Make polled grace-period API account for expedited grace periods.

6.	Make Tiny RCU grace periods visible to polled APIs.

7.	Verify that polled GP API sees synchronous grace periods.

8.	Add polled expedited grace-period primitives.

9.	Test polled expedited grace-period primitives.

10.	Put panic_on_rcu_stall() after expedited RCU CPU stall warnings,
	courtesy of Zqiang.

11.	Diagnose extended sync_rcu_do_polled_gp() loops.

12.	Add irqs-disabled indicator to expedited RCU CPU stall warnings,
	courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    1 
 b/include/linux/rcutiny.h  |   10 +++
 b/include/linux/rcutree.h  |    2 
 b/kernel/rcu/rcu.h         |   12 ++++
 b/kernel/rcu/rcutorture.c  |    6 ++
 b/kernel/rcu/tiny.c        |    4 -
 b/kernel/rcu/tree.c        |    4 -
 b/kernel/rcu/tree.h        |    2 
 b/kernel/rcu/tree_exp.h    |   16 +++++-
 b/kernel/rcu/update.c      |   13 ++++
 kernel/rcu/rcu.h           |    3 +
 kernel/rcu/rcutorture.c    |   97 +++++++++++++++++++++++++++++++-----
 kernel/rcu/tiny.c          |    7 +-
 kernel/rcu/tree.c          |  119 ++++++++++++++++++++++++++++++++++++++++-----
 kernel/rcu/tree.h          |    8 +++
 kernel/rcu/tree_exp.h      |   99 +++++++++++++++++++++++++++++++++++--
 16 files changed, 365 insertions(+), 38 deletions(-)
