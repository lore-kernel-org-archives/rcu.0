Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D752BEC5A;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154354; cv=none; b=i8PICs1iwJn9imS1VArn14QZXkdJkynym/4PYpqVEd6LxvbdshhdGveH0t1rEcROuFsdDVu1LyJQOHyRbJupjZSnTmpXNQVsRzg7iQVS0C8S4AX1DgggJ5/hAMsUfIhmOZ/HuLT3N6n8xV8aWij0xSnbAoD8oQRP/ToRyR0A2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154354; c=relaxed/simple;
	bh=4N42CHjHpp9Gtd2F7Ju3LqgE+j+ayxma9PGGqCToMW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aJM1icDIjEKEBW7WxeTJXyyxNreSeP3XsfDp3ljEpyK0g9cIv2PeZ+zdFiDSNwYjTlpbymeruqYp91dzL+ECNj0bzxsI37QlP8JKk0POrpBPKI7z9p6WsBGjMURcMG5zZWvs6K4r+Qq2ImIhAQHdAGJxq+x6N8dl7+4oh0zExCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZcH/SBr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZcH/SBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A62C2BC9E;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154354;
	bh=4N42CHjHpp9Gtd2F7Ju3LqgE+j+ayxma9PGGqCToMW4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=aZcH/SBrgggviBEeef40CdneMT9dC81VyNvI5zqd3aFEjzEYX9o6mhU23t1rU7tiH
	 fo+g6gV+By24z3nO10a25n0ZvckfI27Arn75ZoOxxCU+FO6m9f3O7xDjOUnluOIulx
	 lvR/8LgC9kOnFJYK7hOw4YdxKPvIhQllZiyDYDuLoNZvTsfIFvmfBkJ9d7DvD1PN/7
	 swIQKxSLTCwx4CYnP6Fazns4MHo+G88hnsFpkvXLgPTJDpipdwVkJl0QEZ1jcuKS5+
	 on7dkl80qiIi/ENG6IUvdqN8m/iUpatYnjNxPoR/pA943zjERBPW2ZNRvr0Vn+r9x+
	 zQPNG6zGPh/gQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DD581CE16CA; Sun,  2 Nov 2025 15:06:52 -0800 (PST)
Date: Sun, 2 Nov 2025 15:06:52 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v3 RFC 0/9] Implement RCU Tasks Trace in terms of SRCU
Message-ID: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
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

This v3 patch series re-implements RCU Tasks Trace in terms of SRCU-fast,
reducing the size of the Linux-kernel RCU implementation by several
hundred lines of code.  It is deferred from the v6.19 merge window
due to performance issues on arm64, which are in the process of being
addressed:

	https://lore.kernel.org/all/aQU7l-qMKJTx4znJ@arm.com/

This series depends on the SRCU series:

https://lore.kernel.org/all/6eb0d40f-9776-412a-9ab4-2d3298ead766@paulmck-laptop

Unlike for SRCU-fast-updown, there are no straightforward workarounds,
hence the deferral.  The patches are as follows:

1.	Re-implement RCU Tasks Trace in terms of SRCU-fast.

2.	context_tracking: Remove
	rcu_task_trace_heavyweight_{enter,exit}().

3.	Clean up after the SRCU-fastification of RCU Tasks Trace.

4.	Move rcu_tasks_trace_srcu_struct out of #ifdef
	CONFIG_TASKS_RCU_GENERIC.

5.	Add noinstr-fast rcu_read_{,un}lock_tasks_trace() APIs.

6.	Update Requirements.rst for RCU Tasks Trace.

7.	Deprecate rcu_read_{,un}lock_trace().

8.	Create an rcu_tasks_trace_expedite_current() function.

9.	Test rcu_tasks_trace_expedite_current().

Changes since v2:

o	SRCU improvments not strictly related to RCU tasks trace have
	been moved out to a separate series.

o	Use the new DEFINE_SRCU_FAST().

https://lore.kernel.org/all/7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop/

Changes since v1:

o	Consolidate RCU Tasks Trace cleanup patches per Alexei Starovoitov
	feedback.  This explains the decrease from 34 patches in v1 to
	only 21 in this v2 series.

o	While consolidating, consolidate the noinstr-fast patches and the
	DEFINE_SRCU_FAST()/init_srcu_struct_fast() patches.

o	Upgrade comments per Peter Zijlstra feedback.

o	Extract Tiny SRCU bug fix into its own commit per Andrii Nakryiko
	feedback.

o	Switch srcu_expedite_current() from preempt_disable() to
	migrate_disable() for PREEMPT_RT kernels per Zqiang feedback.

o	Apply tags.

https://lore.kernel.org/all/580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop/

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/Design/Requirements/Requirements.rst |   12 
 b/Documentation/admin-guide/kernel-parameters.txt        |   15 
 b/include/linux/rcupdate.h                               |   31 
 b/include/linux/rcupdate_trace.h                         |  107 +-
 b/include/linux/sched.h                                  |    1 
 b/init/init_task.c                                       |    3 
 b/kernel/context_tracking.c                              |   20 
 b/kernel/fork.c                                          |    3 
 b/kernel/rcu/Kconfig                                     |   18 
 b/kernel/rcu/rcu.h                                       |    9 
 b/kernel/rcu/rcuscale.c                                  |    7 
 b/kernel/rcu/rcutorture.c                                |    2 
 b/kernel/rcu/tasks.h                                     |  621 ---------------
 b/scripts/checkpatch.pl                                  |    2 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 |    1 
 include/linux/rcupdate_trace.h                           |   81 +
 include/linux/sched.h                                    |    5 
 kernel/rcu/Kconfig                                       |   25 
 kernel/rcu/rcutorture.c                                  |    1 
 kernel/rcu/tasks.h                                       |  121 --
 21 files changed, 218 insertions(+), 868 deletions(-)
