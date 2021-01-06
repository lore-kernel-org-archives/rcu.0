Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF807C433E0
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9573F23120
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbhAFR02 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:26:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbhAFR02 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:26:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 904E923120;
        Wed,  6 Jan 2021 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953947;
        bh=4HmOLBsUYP9E055pH2bhMEoPGh4H1q6GjxZeSZYqljg=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=fr5cVav8GLKjZtGmvPz/mPiXBpfV4IEs76iFcVrTZGnh+WR0OBgK9CKhCkW9hwYqC
         qkWHLtFea4fnu5kOoUTLqlbL7Duqo+IF+ySQtg/mlx3eaL7NifQpR10BUVuRkVx1Q2
         uSUtPWTCe8uyG3/lXCBlUD+23Y2lYlyN+xeb1sunlJ6i9URqiUUJsxNFncsfTGmSR/
         OOEV2hpsLUV5FHA4inrjGIwGTBM25tTmEFTzTmeCC1IxHLHGfV4viGYNeFLAVQSqgE
         kzJ2WEJLyfIQwSeer2V+Wm+EE/zjYI69FhHO8p1Ltho5tcUMyyb78fTF42dj+hD71t
         ECXZyCqsSvtcA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5DAB735225EC; Wed,  6 Jan 2021 09:25:47 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:25:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/20] Torture scripting updates for v5.12
Message-ID: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series contains torture-test updates for the rcutorture scripting in
tools/testing/selftests/rcutorture.

1.	Make --kcsan specify lockdep.

2.	Make kvm.sh "--dryrun sched" summarize number of batches.

3.	Make kvm.sh "--dryrun sched" summarize number of builds.

4.	Allow kvm.sh --datestamp to specify subdirectories.

5.	Prepare for splitting qemu execution from kvm-test-1-run.sh.

6.	Add config2csv.sh script to compare torture scenarios.

7.	Make identify_qemu_vcpus() independent of local language,
	courtesy of Frederic Weisbecker.

8.	Make kvm.sh "Test Summary" date be end of test.

9.	Make kvm.sh arguments accumulate.

10.	Print run duration at end of kvm.sh execution.

11.	Make kvm.sh return failure upon build failure.

12.	Make kvm.sh include --kconfig arguments in CPU calculation.

13.	Add kvm.sh test summary to end of log file.

14.	Stop hanging on panic.

15.	Add --dryrun batches to help schedule a distributed run.

16.	s/STOP/STOP.1/ to avoid scenario collision.

17.	Simplify exit-code plumbing for kvm-recheck.sh and
	kvm-find-errors.sh.

18.	Remove "Failed to add ttynull console" false positive.

19.	Allow standalone kvm-recheck.sh run detect --trust-make.

20.	Do Kconfig analysis only once per scenario.

						Thanx, Paul

------------------------------------------------------------------------

 config2csv.sh      |   67 +++++++++++++++++++++++++++++++++
 console-badness.sh |    1 
 functions.sh       |   36 +++++++++++++++++
 kvm-find-errors.sh |    9 +++-
 kvm-recheck.sh     |    3 -
 kvm-test-1-run.sh  |   12 +++--
 kvm.sh             |  107 +++++++++++++++++++++++++++++++++++++----------------
 parse-build.sh     |    2 
 parse-console.sh   |    2 
 9 files changed, 197 insertions(+), 42 deletions(-)
