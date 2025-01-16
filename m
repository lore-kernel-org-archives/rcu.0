Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B581727;
	Thu, 16 Jan 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058401; cv=none; b=QSCoHlVf6fJrkJUjzfYqzqarV9F8/5w7y4ofFp9zh0E0Kz3YL5AqcZWFz/FpRq/lQFbd0+zEakPZmo7qoCAb7KhCocCyyMW+pJpcvvNw2HpWIDfXq7HtwSCu+juLOccFprln9YBHkzS+aBsxGSdH2kaybi33oidKdiQ3UeEocCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058401; c=relaxed/simple;
	bh=6doBI3jCYwjRVRXMu8ExzjvUMbJ5eKIUXDGGJ+c8/6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rJczm0YsUQUw2LVKNZ7Eqi5+X5YZU2+FXi1y7rgmRsGRTV/N7Y9fY6mFaqUAkgWhXCXi0sM1jbd12u4ITtmR1lsYk7bNy5ZaGIij7qB1XsNvVfXOlyfS/nZ0naXHEpf+moL9tebK0WbX1w4lhULheTf0O+VHOmiwMpp0IW0gAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI7ZYW+O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI7ZYW+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7A9C4CED6;
	Thu, 16 Jan 2025 20:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058400;
	bh=6doBI3jCYwjRVRXMu8ExzjvUMbJ5eKIUXDGGJ+c8/6g=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=DI7ZYW+OXpGkqf9xS/LuFgqNQS9B3pw3UjLM1zLnMbcrKnRKoqC7RWCsUo2otDl0U
	 L3k6wBur5WFLub/uWbw3C0te6xiTl07IqienDViKbof/kNogo36ftDQxFtt3Lp0Aeh
	 C/rJayF94ug3P6TUFTuRTkKjDoWhdjH+t+9Nf2QIVSj0hK/w0jIopFeJYdgZRiUJOG
	 vh3cwnckyDjOVdzJOuWLwqX+E7ujL3UJSlp1kdmWlvJw2s2nfmvfu6dX8nCMxwXzaf
	 GLQPtAVCy8GkJpPXg9OPGrmOUGtyyIDuqaOnCskPLxhwQsHM4wm2A96JQMyHp4OGSc
	 guy8Yzhp2x8XA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2D382CE12BE; Thu, 16 Jan 2025 12:13:20 -0800 (PST)
Date: Thu, 16 Jan 2025 12:13:20 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/9] Lazy-preemption-related updates
Message-ID: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
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

This series makes adjustments to RCU to better handle lazy preemption:

1.	fix header guard for rcu_all_qs(), courtesy of Ankur Arora.

2.	rename PREEMPT_AUTO to PREEMPT_LAZY, courtesy of Ankur Arora.

3.	update __cond_resched comment about RCU quiescent states,
	courtesy of Ankur Arora.

4.	handle unstable rdp in rcu_read_unlock_strict(), courtesy of
	Ankur Arora.

5.	handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y,
	courtesy of Ankur Arora.

6.	provide quiescent states, courtesy of Ankur Arora.

7.	limit PREEMPT_RCU configurations, courtesy of Ankur Arora.

8.	Make scenario TREE10 build CONFIG_PREEMPT_LAZY=y.

9.	Make scenario TREE07 build CONFIG_PREEMPT_LAZY=y.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h                              |    2 -
 b/include/linux/rcutree.h                               |    2 -
 b/include/linux/srcutiny.h                              |    2 -
 b/kernel/rcu/Kconfig                                    |    2 -
 b/kernel/rcu/srcutiny.c                                 |   14 +++----
 b/kernel/rcu/tree_plugin.h                              |   11 +++++
 b/kernel/sched/core.c                                   |    4 +-
 b/kernel/trace/trace_osnoise.c                          |   32 +++++++---------
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07 |    3 +
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE10 |    3 +
 kernel/rcu/Kconfig                                      |    2 -
 kernel/rcu/tree_plugin.h                                |   11 +++--
 12 files changed, 51 insertions(+), 37 deletions(-)
