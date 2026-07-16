Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC402BDC2F;
	Thu, 16 Jul 2026 00:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161516; cv=none; b=ETbAcNZvyPAxbwsyY+nw6u7TTkLr393/5ep6GZKAgLzsJwYFmRCd9s2CJKZIpCmjMA8haTQ0CwNC+hyH+gldM0gTm6nQYEFz3V1LQ/G7bUO9KAwTIh073ITAIYik9wTHJWI/74m1VAfHgZZXLKMKLzlIVS6aqI/gQPyDvxDj4to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161516; c=relaxed/simple;
	bh=tWGH2YfS0CY+qoGb6q5u9CbVbm4MaYbt62kB4XIh6l8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eB71R68mobQ6lkcEJhrABhmKs4KZTZQ22LKq02ZhczTdfFaMAyAxpIYgGeG7ojISDv5NlW4j3WJEQFdo5JE2T8yqsjSORhjgjWEMG3UU3Qx7/21fEzFSvzEXC2PzP4ousnwYGdGOJOSM2bWyDsMG+1wRZv1/3LfUhL7YXOE3lCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfTG5v5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfTG5v5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC68F1F000E9;
	Thu, 16 Jul 2026 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161514;
	bh=k3zFmpnhcb/ge83iWoGHYgIRgOQ5dsOSQyprFEhV+yc=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=AfTG5v5qW1UAVEfPVssQ77KbKP41FKSG4IVh+/TKZqhnJB+wZdkJzCmsHfA82i5z+
	 HkFoHjC5PccvLx5RI4rxeGZdWjOPYgFHYkiYHpBvCzve/2ajLFFEbQgHtVnJUJFnYq
	 +3Y13SEpWq85JjitEP4oAVDIIZBQpkAAg80Q+X+totMCbVoB8UpxRn0b/PjKScV3nM
	 HY2odZH6t82Or7qc38kquqIrE4x6jNHdFDGzR0IJvQA+yq2cQzO3Sc/BUdDutey6qi
	 zsq17Wv2cexPHDq/1ZwN6zEfWN6nOzZPmUnz+V9f/HtQb7ZvEnMQ9m+pN5wZJ2Jkaz
	 NZJJZUHFuwgIA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84421CE0569; Wed, 15 Jul 2026 17:25:14 -0700 (PDT)
Date: Wed, 15 Jul 2026 17:25:14 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/11] RCU torture-test updates for v7.3
Message-ID: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
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

This series contains torture-test updates for v7.3:

1.	Abstract reader-segment dump into rcu_torture_dump_read_segs().

2.	Check for immediate deboosting at reader end.

3.	Make srcu_read_delay() check for disabled interrupts.

4.	Test RCU readers from hardware interrupt handlers.

5.	Use cpumask_next_wrap() in rcu_torture_preempt().

6.	Use task_state_to_char() for task-state reporting, courtesy of
	Kunwu Chan.

7.	Add nwriters module parameter.

8.	Add a stall_only module parameter.

9.	Test RCU Tasks Trace GP implying RCU GP.

10.	Make RCU Tasks Trace track Reader Batches.

11.	Use this_cpu_inc() for rcu_torture_count[] and
	rcu_torture_batch[].

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |    9 +
 b/Documentation/admin-guide/kernel-parameters.txt |    5 
 b/include/linux/rcupdate_trace.h                  |    3 
 b/kernel/rcu/rcu.h                                |    7 
 b/kernel/rcu/rcutorture.c                         |  148 +++++++++---------
 b/kernel/rcu/tasks.h                              |    6 
 b/kernel/rcu/tree_plugin.h                        |   32 +++-
 kernel/rcu/rcutorture.c                           |  172 ++++++++++++++++++----
 8 files changed, 282 insertions(+), 100 deletions(-)
