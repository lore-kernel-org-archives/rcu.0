Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B16318DB2A;
	Fri, 18 Sep 2026 23:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789775995; cv=none; b=HPzPfDvC+hQp45pmLzQ2wQT+xpna6ugXcPD1Ius0gI0+kxjLY1cpPCECFqWQ6uknUbWTz0WDGC01vzbCqUl3iVmiOW6APAGYWPUKxCiVMFPgpilchcT94ChpQCH+tajtgid8WkuPlvaFAoBD647+Ju27k4lKtB+lzOlyFT2ZuJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789775995; c=relaxed/simple;
	bh=uUPo3bg41LYjl6i8gcYXwqKCVHxhJ7D3DFoymfCr/oc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pV2oFDQ5h02nL7Hz+RyL6P/6OVUJ5dHYfm9ovLZw2eDlBIWQXlho999Uj9fNsRkiGxkHDdtwTA1bjjX/QKF4Vj752l0UJeKYE/2v/UAKm4F1QUdqLspwuiElPqzB8QXSNkm0Pw6j2+sJUgDBo9bAC48DFMFs/zL1YGFozIkQEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCaOsS2Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCaOsS2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191131F000FF;
	Fri, 18 Sep 2026 23:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789775994;
	bh=hixHftmhu/BMvA0tKlvZJ9Sam55uFQBRdpxnFP5oMCU=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=kCaOsS2ZYOv8w3Yqk9RZBN2l5n7gMp9meJ25auvtTPgvNhtseAP9sCYM1pqSOP2Bp
	 +bpY0/L57ix72XpFZxbj0CDbnkRl+pIOzpEF5+Jso4t4p/OGLr7qwxnUrg2yZ7iuw2
	 TZC8sG1M0UFty60La17ybQu4cqJoVMDE1go6KFsrgexbN5WkqiL7ojNUYbykaVJe5U
	 5g8myjovNBxzwsPWdjCdJz8LtFIVi/sbv40DvIye4ovVGGAzR/okLcakhjT66SAQTn
	 18Rwhl/WARskXH74LFqNMbLuOmnvyPAOS9jZd3LNJXv3rRxuL+ZMrMd2SInc8mkCV7
	 PAl7y73DaedlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D4D73CE09DC; Fri, 18 Sep 2026 16:59:53 -0700 (PDT)
Date: Fri, 18 Sep 2026 16:59:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev, Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>, Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH RFC v3 0/28] Simple hazard-pointer implementation and torture
 tests
Message-ID: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
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

25.	Fix inverted sleep condition in do_pending kthread, courtesy of
	Bradley Morgan.

26.	Implement two-phase wildcard scan, courtesy of Mathieu Desnoyers.

27.	handle NULL address in hazptr_detach, courtesy of Mathieu
	Desnoyers.

28.	torture.sh: Add hazptr torturing.

						Thanx, Paul

Changes since RFC v2:

o	Add bug-fix patches 25-27.

o	Add patch 28 to automatically test hazptr from torture.sh.

o	Apply tags.

Changes since RFC v1:

o	Added a hazptr_detach() function to allow hazptr_acquire()
	and the corresponding hazptr_release() to be in different
	execution contexts.

o	Torture testing of execution-context migration.

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt                    |   96 +
 b/include/linux/hazptr.h                                             |  197 ++
 b/include/linux/torture.h                                            |    2 
 b/init/main.c                                                        |    2 
 b/kernel/Makefile                                                    |    2 
 b/kernel/hazptr.c                                                    |  242 +++
 b/kernel/rcu/Kconfig.debug                                           |   12 
 b/kernel/rcu/Makefile                                                |    1 
 b/kernel/rcu/hazptrtorture.c                                         |  681 ++++++++++
 b/kernel/rcu/refscale.c                                              |   43 
 b/kernel/rcu/update.c                                                |    3 
 b/kernel/sched/core.c                                                |    2 
 b/kernel/torture.c                                                   |   23 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                      |    6 
 b/tools/testing/selftests/rcutorture/bin/torture.sh                  |   26 
 b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST           |    2 
 b/tools/testing/selftests/rcutorture/configs/hazptr/CFcommon         |    2 
 b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT        |   17 
 b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot   |    1 
 b/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT          |   14 
 b/tools/testing/selftests/rcutorture/configs/hazptr/ver_functions.sh |   40 
 include/linux/hazptr.h                                               |  190 ++
 include/linux/torture.h                                              |    4 
 kernel/hazptr.c                                                      |   98 +
 kernel/rcu/Kconfig.debug                                             |   14 
 kernel/rcu/hazptrtorture.c                                           |  423 +++++-
 kernel/torture.c                                                     |   15 
 tools/testing/selftests/rcutorture/bin/kvm.sh                        |    4 
 tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT          |    2 
 tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT            |    2 
 30 files changed, 2019 insertions(+), 147 deletions(-)
