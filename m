Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81FA2236F0;
	Mon, 29 Dec 2025 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035456; cv=none; b=JHrY0DjcxjonXd3FDeE4CZF74+YsS+d3Dpp9nGIodiVWsvQofPuHMe+QcOmgoE9vQaYFZTHW0av2xVO9gYPJD2f0RXUl4fHPujuNJFFUK3DRcaFu1H8JSxN7EQz5D6ck0hcHlNhEeHXUsG+Jmew3qw9Kmmd3I4RPCcMmJbJ/B5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035456; c=relaxed/simple;
	bh=rgGdwE17c3qQE80WxxtNFlMUUyaNRfH3KQGS/shxEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PbInUO8GV2FoKN5jo5W7htOyKwfUh34FUiFMi81lLgdSh3tFt3sv+Pu4P5htPnPvAoHO8FEVCenLeynPBkfmAsPUL2tjqs2poAsNnvEwmItKwvqSZNp93ZE4V7jrGK3JT8d4gKlijavgNU1OUO95RPupKn573pwLXil2L3OhWvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaNk8zEx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaNk8zEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CABC4CEF7;
	Mon, 29 Dec 2025 19:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035456;
	bh=rgGdwE17c3qQE80WxxtNFlMUUyaNRfH3KQGS/shxEnQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=uaNk8zExCDSq0idpbqtia7W83w5q8USC1GKNzLvmeEZsB53BcW/fn7CaXc4xUc7Ml
	 n6aI8T0UsYJgGMv4fc0cpCEy0b11L9djWeMd+BQ0kd2b0p3C0WBNh+uBi453rphiIO
	 82Yzt49tzE6m+9ept8H15mmBVbXcp75mqD2sdiEPCmlakIoxt2nIqzNv2my3WWXSoI
	 R9wtxfY9hXPi+D1eA/VnBBrpDYh+k1psiz60iAirWTCj4VpNSlNBO+AWpLjCWsMNW+
	 EFUmI7L8A42Fw9uslHpTLiK/PmK4zeVuvNpyp6OSEpJoCACM36oxXjANd+bJWlx3Jx
	 uF3rh8JsXfGzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F35C9CE0C97; Mon, 29 Dec 2025 11:10:55 -0800 (PST)
Date: Mon, 29 Dec 2025 11:10:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v4 0/9] Implement RCU Tasks Trace in terms of SRCU for
 post-v4.19
Message-ID: <b206b083-f611-43b6-993f-78ddbe315813@paulmck-laptop>
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

This v4 patch series re-implements RCU Tasks Trace in terms of SRCU-fast,
reducing the size of the Linux-kernel RCU implementation by several
hundred lines of code.  The patches are as follows:

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

Changes since v3:

o	Rebase onto v6.19-rc1.

o	Wait for arm64 per-CPU variable speedups to reach mainline.

https://lore.kernel.org/all/a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop/#r

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
 b/scripts/checkpatch.pl                                  |    4 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 |    1 
 include/linux/rcupdate_trace.h                           |   81 +
 include/linux/sched.h                                    |    5 
 kernel/rcu/Kconfig                                       |   25 
 kernel/rcu/rcutorture.c                                  |    1 
 kernel/rcu/tasks.h                                       |  121 --
 21 files changed, 219 insertions(+), 869 deletions(-)
