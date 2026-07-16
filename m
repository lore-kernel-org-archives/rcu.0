Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3B22576E;
	Thu, 16 Jul 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161415; cv=none; b=uR/x6FTiIEkyZXZwmPeKrC1azZ9x/RZQfaY6PnS+SkTuViTFTKGh2ZqdiNMi3Jfv44rwJ5nFVj9WIVpsbkky+MnqtghUt1Yj1DFrkCLdQEnN1Jdu5WzI7FXYs5NXlslwCoUnNMw5DRjUqSJ8TyfZBNyr3HXEVF9/FmJzpod7l2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161415; c=relaxed/simple;
	bh=OGn7n9s3hiNbZff8adM/u8QsThpk6vOauIod2Zo2+MM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KqisYXQryxolf6hRQM+iLQLzEWYr2AT98Ul6xw9zcI9dsJoCphcSPKrracZa8fL8vWxXvp0HgOD8KRj31yAX8EIjkkzuSjMdib1VLNSGeNhS2TY+kqim8CizRKtHvJ58vAavy12s4JtAutrP5nuQL5rwv0HKGz5ErJQv/pfzHLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdtUPVzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdtUPVzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C351F000E9;
	Thu, 16 Jul 2026 00:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161414;
	bh=mi8MKQUoqmn6hvM/GtzeOVNP9jklaequTD7Viyr/e4c=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=FdtUPVzc0/BaoJu0iiYU2h4QcgrAFsP1KuiTDd5HA3vP8Sb0rkHKsLfxUnNovugun
	 MNmoLGkt7bty0pgYS+zovGidDZyFBnkO1Um/1KiTExq85ZdBm71sEnoJQyuLjbZN6a
	 a7pIXrxKOT1GzT5vWS10wVDB8vdUfQxbjI6DgPcobpd9Hg8pAarK4HNdGYQ7MhidUX
	 G/Jv3LW/YySG599wrWOtPYwxck28+Yh/vsnFv3o3tRK4iRhUmZg+IvUQj6KWOrFB+J
	 qjuIYQ8oHNfYWbJ80zk8RMyINJN64+e2rthA/6qo5IAa3dqtVjyn9qoX7t71pUT6J7
	 xA8BF7YzbRPTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 236FACE0569; Wed, 15 Jul 2026 17:23:34 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:23:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/10] Miscellaneous RCU updates for v7.3
Message-ID: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
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

This series contains miscellaneous RCU updates for v7.3:

1.	TASKS_TRACE_RCU doesn't need IRQ_WORK.

2.	Use task_state_to_char() in stall-warning prints, courtesy of
	Kunwu Chan.

3.	Mark __rcu_access_pointer() as context_unsafe().

4.	RCU: Adopt new coding style of type-aware kmalloc-family -
	part 2/2, courtesy of Manuel Ebner.

5.	Remove unused struct rcu_tasks's->n_ipis_fails variables,
	courtesy of Zqiang.

6.	Dump rcu tasks status when the boot-test failed, courtesy
	of Zqiang.

7.	RCU: Fix brackets, courtesy of Manuel Ebner.

8.	Apply READ_ONCE() and WRITE_ONCE() to fix data race.

9.	Remove smp_mb() in rcu_spawn_tasks_kthread_generic(), courtesy
	of Zqiang.

10.	Update comments in call_rcu_tasks_generic(), courtesy of Zqiang.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst |    2 -
 b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg                      |    2 -
 b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg                      |    2 -
 b/Documentation/RCU/Design/Requirements/Requirements.rst                       |    2 -
 b/Documentation/RCU/rcu_dereference.rst                                        |    4 +--
 b/include/linux/rcupdate.h                                                     |    4 +--
 b/include/linux/rcupdate_trace.h                                               |   10 ++++++--
 b/kernel/rcu/Kconfig                                                           |    1 
 b/kernel/rcu/tasks.h                                                           |    6 +----
 b/kernel/rcu/tree_stall.h                                                      |   12 +++++-----
 kernel/rcu/tasks.h                                                             |   12 ++++++++--
 11 files changed, 34 insertions(+), 23 deletions(-)
