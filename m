Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA424C54EBC
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240293AbjAEAlM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240979AbjAEAkX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:40:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33A1AD8A;
        Wed,  4 Jan 2023 16:40:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C52AB81716;
        Thu,  5 Jan 2023 00:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FC5C433D2;
        Thu,  5 Jan 2023 00:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879218;
        bh=4dHRyMC3bi4JwnYGiWFSI19lQtcZCbWZ3/6W5LWfhO8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=TPNop0ZcfYsaKsSsxpbmHl96feJjXEU3iLMUPKcjVoSNYNahh6rTvbnPHkK0jwYG0
         1qhW0bNAxdO3dp7hFQL9KMoO1Nka0ApC52QwPk4NKPH532Izwq7iB7k8IHtwcYhaVM
         wzcj0/RdspOFVi9P9omdQAY5RfiEOrM58DrQcVm7Fagn714Tul+ZOdmz1n6+63mTO1
         tJaLgTgWEqyUvYByyHFaXE6erjoyoJKARbEsv2auLQ8aYtzCg+S74EpGc6CtYwKPlw
         SN6hxYScFiP+FyBIaOrv2tk7ujpGhegJ5LYdQeU4NTvr2Ki6CHBVWUmZnGytvHuxm8
         25+ihHs2uT4PQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7BD695C05CA; Wed,  4 Jan 2023 16:40:18 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:40:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/6] RCU Tasks updates for v6.3
Message-ID: <20230105004018.GA1770640@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides some RCU Tasks updates:

1.	rcu-tasks: Use accurate runstart time for RCU Tasks boot-time
	testing, courtesy of Zqiang.

2.	rcu-tasks: Improve comments explaining tasks_rcu_exit_srcu
	purpose, courtesy of Frederic Weisbecker.

3.	rcu-tasks: Remove preemption disablement around
	srcu_read_[un]lock() calls, courtesy of Frederic Weisbecker.

4.	rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes(),
	courtesy of Frederic Weisbecker.

5.	rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug,
	courtesy of Zqiang.

6.	rcu-tasks: Handle queue-shrink/callback-enqueue race condition,
	courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    2 +
 b/kernel/pid_namespace.c   |   17 +++++++++
 b/kernel/rcu/tasks.h       |    8 +---
 kernel/rcu/tasks.h         |   77 ++++++++++++++++++++++++++++++---------------
 4 files changed, 75 insertions(+), 29 deletions(-)
