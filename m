Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9778C46467
	for <rcu@archiver.kernel.org>; Thu,  5 Jan 2023 00:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjAEAyZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjAEAxk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Jan 2023 19:53:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1100A50F66;
        Wed,  4 Jan 2023 16:50:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83BB1B81986;
        Thu,  5 Jan 2023 00:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CC0C433F0;
        Thu,  5 Jan 2023 00:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879495;
        bh=JpJUIfKj2grmhASneCvm4eoguqoWrw7JCeey0tMxfOI=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=iX6ueXCrM2bNMyjTcgpS52x4ATQqWLIkzqo5g/DVioAbfTB6T3kKArlOsxGew1Q3F
         BhCjgunWbupeqEk4v943C1gYoYcTmKSuB+xNaczshH+Bqp3g7vuWdMCVvoJY6ytelV
         UGmMJhFTQO98UaflEJ/PTXjrKeZh1arQTdjPpGIcczqb6m42gFp87v0Ib2/hMfPMlx
         HCKNtq4DXolyBFr/1qnqyYl4UQLgYL6G4Jc4m5jgLdbkcbKpt5yHHyA4mUOomID4Oa
         PK4U7neecoPc7irjhOTyvkVmpWJ0vjUWms9GtubIxe4bfIJuKBAz5eCuWegjUkmhrl
         fRZruENvWszxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D3F875C05CA; Wed,  4 Jan 2023 16:44:54 -0800 (PST)
Date:   Wed, 4 Jan 2023 16:44:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Torture-test updates for v6.3
Message-ID: <20230105004454.GA1771168@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series provides torture-testing updates:

1.	rcu-tasks: Use accurate runstart time for RCU Tasks boot-time
	testing, courtesy of Zqiang.

2.	Seed torture_random_state on CPU.

3.	rcu-tasks: Improve comments explaining tasks_rcu_exit_srcu
	purpose, courtesy of Frederic Weisbecker.

4.	Provide for initialization failure.

5.	rcu-tasks: Remove preemption disablement around
	srcu_read_[un]lock() calls, courtesy of Frederic Weisbecker.

6.	Add tests using SLAB_TYPESAFE_BY_RCU.

7.	Allow non-rtmutex lock types to be boosted, courtesy of "Joel
	Fernandes (Google)".

8.	rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes(),
	courtesy of Frederic Weisbecker.

9.	Make the rt_boost factor a tunable, courtesy of "Joel Fernandes
	(Google)".

10.	rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug,
	courtesy of Zqiang.

11.	rcu-tasks: Handle queue-shrink/callback-enqueue race condition,
	courtesy of Zqiang.

12.	Drop sparse lock-acquisition annotations.

13.	Fix hang during kthread shutdown phase, courtesy of "Joel
	Fernandes (Google)".

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h     |    2 
 b/kernel/locking/locktorture.c |   99 +++++++++--------
 b/kernel/pid_namespace.c       |   17 ++
 b/kernel/rcu/rcutorture.c      |   12 +-
 b/kernel/rcu/refscale.c        |   16 +-
 b/kernel/rcu/tasks.h           |    8 -
 b/kernel/torture.c             |    2 
 kernel/locking/locktorture.c   |   12 +-
 kernel/rcu/refscale.c          |  236 +++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tasks.h             |   77 +++++++++----
 kernel/torture.c               |    2 
 11 files changed, 393 insertions(+), 90 deletions(-)
