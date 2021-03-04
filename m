Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0270C433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807FD64F0D
	for <rcu@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbhCDBB1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451919AbhCDAia (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Mar 2021 19:38:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E40A64E2E;
        Thu,  4 Mar 2021 00:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818270;
        bh=5mJSdAL1m93TawtdxGgGfy0hd3XakM/v/swDq+tcC2A=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Ix/9s9IZksuoAZNpNZ3v6ulKtmlBLOytgzY/4YxEYlzpeiJyR9FukSYbv17e7rugh
         6h40rWMNZs60xNiYX7rUkJDjkaiBBuX2wxVguNmvWJP7t+0eYKQaPqTCy53Nv9PFqN
         LFYKIXusoo/lxDtliYSK6ioAWDxEfUGVBONr7jlB3Vi68bT+H4bUk4XX+aR5LmTB+J
         8XQ2GXF+i+Chfx+eSRdwo1xi/Z4e7C/OJM5mzXECgJtNa7i7D6jqcL6cxcpVn8ozkO
         CfcHqcOWvwkxHCyfxvx2runSZrDKyFaJKiUeX7QTK1ogyRfS/1e/++MmKv7Ke3Rcrd
         u+XBbKBSYbL/g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 683C23522591; Wed,  3 Mar 2021 16:37:50 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:37:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/28] Torture-test scripting updates for v5.13
Message-ID: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains updates to the torture-test scripting, perhaps most
notably the addition of kvm-again.sh, which allows rerunning an earlier
test without having to rebuild all the kernels.

1.	Don't rerun failed rcutorture builds.

2.	Allow 1G of memory for torture.sh kvfree testing.

3.	Provide bare-metal modprobe-based advice.

4.	Improve readability of the testid.txt file.

5.	Disable verbose torture-test output.

6.	Disable verbose torture-test output.

7.	Move build/run synchronization files into scenario directories.

8.	Use file-based protocol to mark batch's runs complete.

9.	Use "jittering" file to control jitter.sh execution.

10.	Eliminate jitter_pids file.

11.	Reverse jittering and duration parameters for jitter.sh.

12.	Abstract jitter.sh start/stop into scripts.

13.	Record TORTURE_KCONFIG_GDB_ARG in qemu-cmd.

14.	Extract kvm-test-1-run-qemu.sh from kvm-test-1-run.sh.

15.	Record jitter start/stop commands.

16.	Record kvm-test-1-run.sh and kvm-test-1-run-qemu.sh PIDs.

17.	Remove no-mpstat error message.

18.	Rename SRCU-t and SRCU-u to avoid lowercase characters.

19.	Make upper-case-only no-dot no-slash scenario names official.

20.	De-capitalize TORTURE_SUITE.

21.	Create a "batches" file for build reuse.

22.	Add kvm-again.sh to rerun a previous torture-test.

23.	Add --duration argument to kvm-again.sh.

24.	Make kvm-transform.sh update jitter commands.

25.	Make TORTURE_TRUST_MAKE available in kvm-again.sh environment.

26.	Print proper vmlinux path for kvm-again.sh runs.

27.	Consolidate qemu-cmd duration editing into kvm-transform.sh.

28.	Fix kvm.sh --datestamp regex check.

						Thanx, Paul

------------------------------------------------------------------------

 bin/cpus2use.sh                   |    1 
 bin/jitter.sh                     |   16 +-
 bin/jitterstart.sh                |   37 ++++++
 bin/jitterstop.sh                 |   23 +++
 bin/kvm-again.sh                  |  213 +++++++++++++++++++++++++++++++++-
 bin/kvm-recheck.sh                |    2 
 bin/kvm-test-1-run-batch.sh       |   67 ++++++++++
 bin/kvm-test-1-run-qemu.sh        |  178 ++++++++++++++++++++++++++++-
 bin/kvm-test-1-run.sh             |  232 +++++++++++---------------------------
 bin/kvm-transform.sh              |   60 ++++++++-
 bin/kvm.sh                        |  114 +++++++++++-------
 bin/torture.sh                    |    2 
 configs/rcu/CFLIST                |    4 
 configs/rcu/SRCU-U                |    1 
 configs/rcuscale/ver_functions.sh |    2 
 configs/refscale/ver_functions.sh |    2 
 16 files changed, 715 insertions(+), 239 deletions(-)
