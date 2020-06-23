Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEE6C433DF
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B8C2075A
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872653;
	bh=xEt5aOB7pqhhf2Hy4IEmUPEWm6spZT7oV0603FSswZg=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=JJiF7eVMd+MucEX4g/+q0ReIJcDHNjLH4kN5lC7V6I2POoo3hdgtPyZqXeltUG7XC
	 YblJw7cP9WX5AYGTECLIpCru4cBKzVfWZHJytJuogVYp0m8YvoHhsTgTDJXJ9ci7R9
	 6QVXsUk3j5Gwg0zpEqbF4dJcdzMStyRxXs4uaxsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgFWAhd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbgFWAhc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C2720738;
        Tue, 23 Jun 2020 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872652;
        bh=xEt5aOB7pqhhf2Hy4IEmUPEWm6spZT7oV0603FSswZg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=uPCKkuMU24ek8MKjZDgxI8qDTSR7Nn4k5ijn5efqMvUM8XxBqH6pmQkBjMkaHNjfJ
         0qFYghMJlE3ZinuzfFjq0oZcPGv7GAzgAF6awKbFHUSosbzhqgvegvydopVN9xTtjZ
         ad8rZJk+7YO/cZeJX9GKJ7n8tSe2ZQ9IZsCsvPvw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CA4E2352306A; Mon, 22 Jun 2020 17:37:31 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:37:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/23] Torture-test updates for v5.9
Message-ID: <20200623003731.GA26717@paulmck-ThinkPad-P72>
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

This series provides torture-test updates:

1.	 Remove qemu dependency on EFI firmware.

2.	Add script to smoke-test commits in a branch.

3.	Use true and false to assign to bool variables, courtesy of Zou Wei.

4.	Add races with task-exit processing.

5.	Set configfile variable to current scenario.

6.	Handle non-statistic bang-string error messages.

7.	NULL rcu_torture_current earlier in cleanup code.

8.	Remove whitespace from identify_qemu_vcpus output.

9.	Add --allcpus argument to the kvm.sh script.

10.	rcu/rcutorture: Replace 0 with false, courtesy of Jules Irenge.

11.	Create qemu-cmd in --buildonly runs.

12.	Add a stop-run capability.

13.	Abstract out console-log error detection.

14.	Check for unwatched readers.

15.	Pass --kmake-arg to all make invocations, courtesy of Marco Elver.

16.	Correctly summarize build-only runs.

17.	Improve diagnostic for KCSAN-incapable compilers.

18.	Add more tracing crib notes to kvm.sh.

19.	Add kvm-tranform.sh script for qemu-cmd files.

20.	Dump ftrace at shutdown only if requested.

21.	Avoid duplicate specification of qemu command.

22.	Remove obsolete "cd $KVM".

23.	Remove KCSAN stubs.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt              |   21 +
 include/linux/torture.h                                      |    5 
 kernel/locking/locktorture.c                                 |   14 -
 kernel/rcu/rcutorture.c                                      |  130 +++++++++--
 kernel/torture.c                                             |    6 
 tools/testing/selftests/rcutorture/bin/configinit.sh         |    4 
 tools/testing/selftests/rcutorture/bin/console-badness.sh    |   16 +
 tools/testing/selftests/rcutorture/bin/functions.sh          |   23 +
 tools/testing/selftests/rcutorture/bin/jitter.sh             |    6 
 tools/testing/selftests/rcutorture/bin/kvm-build.sh          |    6 
 tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh |  108 +++++++++
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh        |   20 +
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh     |   27 +-
 tools/testing/selftests/rcutorture/bin/kvm-transform.sh      |   51 ++++
 tools/testing/selftests/rcutorture/bin/kvm.sh                |   10 
 tools/testing/selftests/rcutorture/bin/parse-console.sh      |   23 +
 16 files changed, 419 insertions(+), 51 deletions(-)
