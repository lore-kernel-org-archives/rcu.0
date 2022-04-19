Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DD2C433EF
	for <rcu@archiver.kernel.org>; Tue, 19 Apr 2022 00:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbiDSACx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbiDSACw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CEBC96;
        Mon, 18 Apr 2022 17:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 467DCCE0B26;
        Tue, 19 Apr 2022 00:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC5DC385A1;
        Tue, 19 Apr 2022 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326407;
        bh=ZR6gQYEJdXJ2+sTzbqqBqwaigPZJYaasmoHWa/u3sw4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=ZjOI+cuo2TRk/T5z2jMpXQjMQ2Y4c7LvM5B3KazFoiEX/gNvEmC+w19G/BUeBzeud
         hHl96SXqRRdJnATogl69N/ihQL4fEYog2EcgB8A7Uvt801eklNm3pTebEKXcXYR3b1
         W7cA9VH6f8otZmgjnes/oZRtjaDAt/8PUibPO9ttxCVbz9F2rDYWm1eQKtPBmNCf8T
         OQZW2Bl3ioeIgDesZbce4LUrHFSTijXlJXnig8PdSIrYlw3NAVW/K752+tWUG+KlSa
         AaMzk7pNWyY1YWAhpOskOHj/4UgOD4ncLixlzyjreONsk9TmsMQuPYBIkOrAOR1kJ7
         DlwcXSTMFQt3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1657B5C04BD; Mon, 18 Apr 2022 17:00:07 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:00:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/9] Tasks-RCU updates for v5.19
Message-ID: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains RCU-Tasks updates, including some -rt fixups,
handling of systems with sparse CPU numbering, and a fix for a boot-time
race-condition failure.

1.	rcu-tasks: Fix race in schedule and flush work, courtesy of
	Padmanabha Srinivasaiah.

2.	rcu-tasks: Print pre-stall-warning informational messages.

3.	rcu-tasks: Use rcuwait for the rcu_tasks_kthread(), courtesy of
	Sebastian Andrzej Siewior.

4.	rcu-tasks: Make Tasks RCU account for userspace execution.

5.	rcu-tasks: Use schedule_hrtimeout_range() to wait for grace
	periods, courtesy of Sebastian Andrzej Siewior.

6.	rcu-tasks: Restore use of timers for non-RT kernels.

7.	rcu-tasks: Make show_rcu_tasks_generic_gp_kthread() check
	all CPUs.

8.	rcu-tasks: Handle sparse cpu_possible_mask, courtesy of Eric
	Dumazet.

9.	rcu-tasks: Handle sparse cpu_possible_mask in
	rcu_tasks_invoke_cbs().

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |   30 ++++++-
 b/include/linux/rcupdate.h                        |    1 
 b/kernel/rcu/tasks.h                              |    3 
 b/kernel/rcu/tree.c                               |    2 
 kernel/rcu/tasks.h                                |   92 +++++++++++++++++-----
 5 files changed, 105 insertions(+), 23 deletions(-)
