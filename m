Return-Path: <SRS0=vfTc=4D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEB8C35242
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EF2207FF
	for <rcu@archiver.kernel.org>; Sat, 15 Feb 2020 00:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581726997;
	bh=XDmB0fzZx2g4HWiPoJ/T+BNmxX+vs22yK6L6RWm/DVw=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=FNc7bR8ntPdHUjdvmXjL3FPOI4RTDiD4Ba1T1vqdfh1dsFCFyvo2OGDhWmiFBDASL
	 R1YzQYE8DYkucn5YxlKe5ww20Grjttp2BlOy12qzyyL1OSgNTMstSz3hO6fW/Tx0oA
	 0xy1xgsoKwtiW+ptzZ3E4JCWF30HrSuHQ73F8v1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBOAgh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgBOAgh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Feb 2020 19:36:37 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64216206CC;
        Sat, 15 Feb 2020 00:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581726996;
        bh=XDmB0fzZx2g4HWiPoJ/T+BNmxX+vs22yK6L6RWm/DVw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Zd7EL7Iwo9YQ/ZGJ8nNqidTkHZVexjneMd1CpgZdZ4aAxpuTtP++nScZoXI5o2pSm
         peqV0TySNbZoa/x4S3UqTYb0M84OAtWZK8CmBodyPOr6V8GcgiczhyjrRh/e0KWapL
         4aooINxN20BGPr1BOXo+7MLthAVFT1aDPWi9F/0Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A43083520D46; Fri, 14 Feb 2020 16:36:34 -0800 (PST)
Date:   Fri, 14 Feb 2020 16:36:34 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/18] Torture-test updates for v5.7
Message-ID: <20200215003634.GA16227@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains torture-test updates.

1.	Suppress forward-progress complaints during early boot.

2.	Make results-directory date format completion-friendly.

3.	Refrain from callback flooding during boot.

4.	Forgive -EBUSY from boottime CPU-hotplug operations.

5.	Allow boottime stall warnings to be suppressed.

6.	Suppress boottime bad-sequence warnings.

7.	Allow disabling of boottime CPU-hotplug torture operations.

8.	Add 100-CPU configuration.

9.	Summarize summary of build and run results.

10.	Make kvm-find-errors.sh abort on bad directory.

11.	Fix rcu_torture_one_read()/rcu_torture_writer() data race.

12.	Fix stray access to rcu_fwd_cb_nodelay.

13.	Add READ_ONCE() to rcu_torture_count and rcu_torture_batch.

14.	Annotation lockless accesses to rcu_torture_current.

15.	Measure memory footprint during kfree_rcu() test.

16.	Make rcu_torture_barrier_cbs() post from corresponding CPU.

17.	Manually clean up after rcu_barrier() failure.

18.	Set KCSAN Kconfig options to detect more data races.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt           |   10 +
 include/linux/rcutiny.h                                   |    1 
 include/linux/rcutree.h                                   |    1 
 kernel/rcu/rcu.h                                          |   17 +++
 kernel/rcu/rcuperf.c                                      |   14 ++
 kernel/rcu/rcutorture.c                                   |   73 ++++++++++----
 kernel/rcu/tree_exp.h                                     |    9 +
 kernel/rcu/tree_stall.h                                   |    6 -
 kernel/rcu/update.c                                       |   20 +++
 kernel/torture.c                                          |   29 ++++-
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh |    2 
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh     |   17 +++
 tools/testing/selftests/rcutorture/bin/kvm.sh             |    2 
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon   |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE10     |   18 +++
 15 files changed, 187 insertions(+), 34 deletions(-)
