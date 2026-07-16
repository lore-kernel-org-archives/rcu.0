Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816541D432D;
	Thu, 16 Jul 2026 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161085; cv=none; b=itCucroEiNHgTTXpiTZA4NWxPGbCpnWLFNHB1S7Vzm3sRB29/2C5gQHed8uF0C9ind3hBRtDEfVynbg3k6aC/mvxmjj/uPHgSSuQDZkjX95sQ45zC+GUvh1Y/cgmwLxepdEJbXgo7/1/NLgYypNz6pK2kLldJMu/U2B458DQ7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161085; c=relaxed/simple;
	bh=XD+juzLwmEXqpiZbVMEdqcD2llXJ2aOUsPoLQxPD91w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s6KfeY3VXPLDdnOUn3BiaaFFjhNCa8bHUUD//zO3Xivkt/KN6MGNS5Qka9mVCxjPS8AQv7opE+QDiZ9prqCw4oHy6VAuFLRqgha5e6jBPNduAC9R3H1bK3hYOP7QMERe4aa5WvxlhkgLelvOkOSYMij8l6SXelNuHJNSb/4rP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGZox/bY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGZox/bY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB091F000E9;
	Thu, 16 Jul 2026 00:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161084;
	bh=06xLE9KS6cAXCUqEKi58c5x/YMAOSqhpJhlZXZmSXEg=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=OGZox/bYvgBDE/9O0s9rvFg0++IMqPqvm7cRkDuW6mIrimLfqvrYdHvxNHX+J8GOy
	 HDNfaRynwtVpxlo8Qm6z3yOzuBfQMxnv5le4Jf0RqUFyZBgGNsE71wsGZdzLX0Qo76
	 ISrl47+pB1vDshVTKXpg9UUMx8MBaPlGYN4EEZ+nqRFHogVHpXf0K+kxnX4HZQ+L+L
	 8iq0Bg8N7CU4MjlQ0MnJbibN+YyrJY1ft5ZnZeGS8CpJr8+aWSH81mu5bw4e3gW/Yx
	 PTVUtHJoBd+IliYxLnsJt77CObDJaYpve9LuRQtQx6668ZGSK+EQhwFsWoMy4B17Cv
	 3s08seWT8gjUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 31CFFCE0569; Wed, 15 Jul 2026 17:18:04 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:18:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH RFC v2 0/24] Simple hazard-pointer implementation and torture
 tests
Message-ID: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains a simple hazard-pointer implementation and associated
torture tests:

1.	Implement Hazard Pointers, courtesy of Mathieu Desnoyers.

2.	Add refscale test, courtesy of Mathieu Desnoyers.

3.	Add a hazptrtorture.c torture test.

4.	Add testing of on-stack hazptr_ctx structures.

5.	Add microsecond-scale sleep in readers.

6.	Enable system-independent CPU overcommit.

7.	Add a stutter_will_wait() function.

8.	Use mnemonic local variables for context information.

9.	Split hazptr_torture_reader_tail() from hazptr_torture_reader().

10.	Add kthread to release deferred hazard pointers.

11.	Defer release of hazard pointers.

12.	Add irq_acquire to acquire hazptr from irq.

13.	Use task_state_to_char() for task-state reporting, courtesy of
	Kunwu Chan.

14.	Pass hazptr_pending to hazptr_torture_reader_tail().

15.	Add the ability to disable the writer kthread.

16.	Add irq_release to release hazptr from irq.

17.	Accumulate operation statistics.

18.	Add hazptrtorture module parameters.

19.	Permit detaching hazard pointers from contexts, courtesy of
	Mathieu Desnoyers.

20.	Detach deferred and IPIed hazard pointers, courtesy of Mathieu
	Desnoyers.

21.	Introduce CONFIG_HAZPTR_DEBUG misuse detection, courtesy of
	Mathieu Desnoyers.

22.	Fix hazptr ownership issue, courtesy of Mathieu Desnoyers.

23.	Enable CONFIG_HAZPTR_DEBUG.

24.	Upgrade kernel-doc headers.

Changes since RFC v1:

o	Added a hazptr_detach() function to allow hazptr_acquire()
	and the corresponding hazptr_release() to be in different
	execution contexts.

o	Torture testing of execution-context migration.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt                    |   96 +
 b/include/linux/hazptr.h                                             |  197 ++
 b/include/linux/torture.h                                            |    2 
 b/init/main.c                                                        |    2 
 b/kernel/Makefile                                                    |    2 
 b/kernel/hazptr.c                                                    |  242 +++
 b/kernel/rcu/Kconfig.debug                                           |   12 
 b/kernel/rcu/Makefile                                                |    1 
 b/kernel/rcu/hazptrtorture.c                                         |  682 ++++++++++
 b/kernel/rcu/refscale.c                                              |   43 
 b/kernel/rcu/update.c                                                |    3 
 b/kernel/sched/core.c                                                |    2 
 b/kernel/torture.c                                                   |   23 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                      |    6 
 b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST           |    2 
 b/tools/testing/selftests/rcutorture/configs/hazptr/CFcommon         |    2 
 b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT        |   17 
 b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot   |    1 
 b/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT          |   14 
 b/tools/testing/selftests/rcutorture/configs/hazptr/ver_functions.sh |   40 
 include/linux/hazptr.h                                               |  168 ++
 include/linux/torture.h                                              |    4 
 kernel/rcu/Kconfig.debug                                             |    9 
 kernel/rcu/hazptrtorture.c                                           |  422 +++++-
 kernel/torture.c                                                     |   15 
 tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT          |    2 
 tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT            |    2 
 27 files changed, 1897 insertions(+), 114 deletions(-)
