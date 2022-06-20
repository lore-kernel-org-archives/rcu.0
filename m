Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB7C43334
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 23:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiFTXAA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345942AbiFTW7p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A854186D1;
        Mon, 20 Jun 2022 15:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B489B8125A;
        Mon, 20 Jun 2022 22:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E30C3411B;
        Mon, 20 Jun 2022 22:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765895;
        bh=hbfsCMIA8UZFLtewmwQIjAp1YYBY7vRz1838WgDBFtA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=gX8LTWfJR1jJqKN96C0uXr5GT74mtZFzwYP7DLJqjq49ouD7Dk77mBtC8J+McQkdt
         35iPaJUAJl1MbRETjhtCujAjOHt2lbAQ/IrfMHOH5aZ2xtNHL9nJE/lUqdFw29bAgk
         lq+HTVHmbcOTIZWpspHohwA9ONCvQlQnq46hdv81Q4TX1JayPtiakiUA/wfU5d2GWE
         Aoe94cHdRZTifklPvxNgwLcWtn1SCJtO09sLKbMmegp4h+AFDf2I2Q2KlecjJ9TE3c
         ugenmVuBGzkLbidLWJ9fsO8c07mLyYC9kGuTYRVh03vcFWTxRt8E4hPyFzpmv7m2zC
         jXX9dUmrcUsAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9BB2F5C05B9; Mon, 20 Jun 2022 15:58:14 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:58:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/12] Torture-test updates for v5.20
Message-ID: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides torture-test updates, both C-language and scripting:

1.	Make kvm-remote.sh announce which system is being waited on.

2.	Change order of warning and trace dump, courtesy of Anna-Maria
	Behnsen.

3.	Simplify rcu_torture_read_exit_child() loop.

4.	Fix memory leak in rcu_test_debug_objects(), courtesy of Zqiang.

5.	Adjust to again produce debugging information.

6.	Make failure indication note reader-batch overflow.

7.	Fix smp_processor_id()-in-preemptible warnings, courtesy of
	Zqiang.

8.	Create kvm-check-branches.sh output in proper location.

9.	Fix ksoftirqd boosting timing and iteration, courtesy of Frederic
	Weisbecker.

10.	Handle failure of memory allocation functions, courtesy of
	Li Qiong.

11.	Flush printk() buffers before powering off.

12.	Convert test_lock spinlock to raw_spinlock, courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcuscale.c                                        |    1 
 b/kernel/rcu/rcutorture.c                                      |    3 
 b/kernel/rcu/refscale.c                                        |   18 +-
 b/kernel/torture.c                                             |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh |   11 -
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh         |    1 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                |    6 
 kernel/rcu/rcutorture.c                                        |   88 +++++-----
 8 files changed, 65 insertions(+), 64 deletions(-)
