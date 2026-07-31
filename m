Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BBC78F26;
	Fri, 31 Jul 2026 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460033; cv=none; b=cLeWTXOetPl+3bQyGasvTaJ+5M/cMsCzrROi5zoWnqrRmyWAP0tH1lRdC5Qba/Ub/N0n2SRWulO8OF8ddJngC9z+fHllBOPvrEKQmSkvdHW35vq525fJpJ58JIFSg06Je5iWVsVCEnjPlTxuzdLlYT9lgQ4PDvUt9PQPF1nArx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460033; c=relaxed/simple;
	bh=czsaTb227b1BV3REPsqww+77uisBFa+zmJ/19iuzQ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAD89WEAgwo8GrYnvI8+c+kF2ZM7hdqyrAVMq6998p8a8Qq9G8arGmwHNwvRnQMxvpmhMTFpo2hBM3GBLMKZOBAD4zt1AhOBXRYQKHbaCznJZr8IQ8PeXvrnm+cFgsK0sEJE/TYgbW3X2Lfe+8cuPCRCDiSvJrEipw/D6tQZq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtBeR7qw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtBeR7qw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056331F000E9;
	Fri, 31 Jul 2026 01:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460032;
	bh=WLkr7i/9mIfIFJYYQyUPztSsFllTNva/6MFXYfkp/zA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=YtBeR7qwhQRuhJeHSmPCiD0JcGSetB22ps1QjGqHFrY53b2ISvgCS3XLaZEvqd+8W
	 arBluIehGxbMOD4zv3WN3CHhTHlCXS8yH8ByNQpi+V83+jM1ILhKJm2tq1eWahFWlo
	 tfr5p9pmhPlKdslQ+mL9EFZYAhtbN5VyISOY8QZwMky+xhqLo+SGFQCkLJ0vOYItaj
	 ODHBA+t9Ki6W5HR8OPJgYTdfI0tI28Qw4oO2GoqvjiYV4j7CibFgE0GkQEgWZ/le/R
	 lS8m/l//4kVNl1kGTiPQHTyapQ7xiUM8N3Jcm1PF7idjxu8hrYlHYbfwMk/8gVrJMB
	 XAbNHkQg8Uo/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BF118CE0F69; Thu, 30 Jul 2026 18:07:11 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:07:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/13] RCU torture-test updates for v7.3
Message-ID: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f56c779-b900-40f9-9a24-6136fb28ddfb@paulmck-laptop>

Hello!

This series contains torture-test updates for v7.3:

1.	Abstract reader-segment dump into rcu_torture_dump_read_segs().

2.	Check for immediate deboosting at reader end.

3.	Test RCU readers from hardware interrupt handlers.

4.	Use cpumask_next_wrap() in rcu_torture_preempt().

5.	Use task_state_to_char() for task-state reporting, courtesy of
	Kunwu Chan.

6.	Add nwriters module parameter.

7.	Add a stall_only module parameter.

8.	Test RCU Tasks Trace GP implying RCU GP.

9.	Make RCU Tasks Trace track Reader Batches.

10.	Use this_cpu_inc() for rcu_torture_count[] and
	rcu_torture_batch[].

11.	Don't leak shuffle_tmp_mask when shuffler kthread fails to start,
	courtesy of Joel Fernandes.

12.	Announce declining to forward-progress test.

13.	Make {,s}rcu_read_delay() better handle forward-progress testing.

Changes since v1:

o	Added patches 12 and 13.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |    9 +
 b/Documentation/admin-guide/kernel-parameters.txt |    5 
 b/include/linux/rcupdate_trace.h                  |    3 
 b/kernel/rcu/rcu.h                                |    7 
 b/kernel/rcu/rcutorture.c                         |  148 ++++++++--------
 b/kernel/rcu/tasks.h                              |    6 
 b/kernel/rcu/tree_plugin.h                        |   37 ++++
 b/kernel/torture.c                                |    7 
 kernel/rcu/rcutorture.c                           |  196 ++++++++++++++++++----
 9 files changed, 310 insertions(+), 108 deletions(-)
