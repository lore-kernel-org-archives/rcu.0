Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0402DA76A;
	Fri, 31 Jul 2026 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459838; cv=none; b=NzaDCX+dWpHf1eDXcH4I1mkxCZV+6PBQ1CkSnKRJHfQvzECFJ38chNjobl1P2ZQx+sbfIuJ8H7FHVXNLJtd8JemBjmIbbn3bIato/886h8bdGqQr5KZa0s8rekk/9wZMLa7VWPhQt50ZQztea0ZxuBbMHjo4Ro7YMirYztxd5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459838; c=relaxed/simple;
	bh=jyaOtiY5y0c2zQa65iNbuw93aXeasMfU1gyJaiRBOCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f4r2xtzCpL1o6i1WV3nfhn/HJ3fGdGMd1qQjvWYTHq2EQwOz912DcXz7z9iMXmsTh3rqXDYEyQQdbO0wD01PCsGE2+7X/c4mCL+bFNCER7m4EHabL5iBIdxjPHpLEhiWbGMmiOA7mijaJ0wTtQZ8EQ/9UB+/gFcpvPLG3i5lp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GExjILEv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GExjILEv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925691F000E9;
	Fri, 31 Jul 2026 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459835;
	bh=vIehJtjJHTgGQZiWLNsDM6bK3mbeS98riJRnRvBjNCM=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=GExjILEvjyCW+X2fFo5brkGanKXbz1UPbXw6HDxhcMsk4ADogRtsZpPx46Rhb/FBQ
	 UXnUo7DtYYMADWbtfM3A1TvxfjgCLwCW+vzwbWPbOmb9V7l23L8xpwH1PIVrMhF3fo
	 zSqUw4P/BDKg9ocUTB6+OuLcuRx8wfQRJ2DK0RYzZC5ycltyxVYd2llsLNU8u383CH
	 IF/gpMcjNp5OWwnFQEsDHZ31k4521h8UOTAayRBam8knQFEa51nBLfBl6Brr4F/oXt
	 TeagryyyiOZCT+UkezmFYOZgd9/YkT2HlvyM8SJ7/E+vv8KL6ohe1e+Pqg3SVwNR9H
	 onwXtL2J7O0CA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 563E8CE0F69; Thu, 30 Jul 2026 18:03:55 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:03:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/10] RCU Tasks updates for v7.3
Message-ID: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
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

This series provides RCU Tasks updates for v7.3:

1.	TASKS_TRACE_RCU doesn't need IRQ_WORK.

2.	Remove unused struct rcu_tasks's->n_ipis_fails variables,
	courtesy of Zqiang.

3.	Dump rcu tasks status when the boot-test failed, courtesy
	of Zqiang.

4.	Apply READ_ONCE() and WRITE_ONCE() to fix data race.

5.	Remove smp_mb() in rcu_spawn_tasks_kthread_generic(), courtesy
	of Zqiang.

6.	Update comments in call_rcu_tasks_generic(), courtesy of Zqiang.

7.	Dump rtpcp->lazy_timer status in
	show_rcu_tasks_generic_gp_kthread(), courtesy of Zqiang.

8.	Fix IRQ read lock/unlock data race.

9.	Rename tasks_rcu_exit_srcu_stall_timer to
	tasks_rcu_exit_stall_timer, courtesy of Zqiang.

10.	Fix some comments for call_rcu_tasks() and call_rcu_tasks_rude(),
	courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate_trace.h |   10 +++++++-
 b/kernel/rcu/Kconfig             |    1 
 b/kernel/rcu/tasks.h             |    6 +----
 include/linux/rcupdate_trace.h   |   10 +++++---
 kernel/rcu/tasks.h               |   44 ++++++++++++++++++++++++---------------
 5 files changed, 44 insertions(+), 27 deletions(-)
