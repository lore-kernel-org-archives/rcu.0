Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67C84D34;
	Thu, 30 Jan 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263306; cv=none; b=s8+z6sNK+actWKXtFAFE7wp3qdw2CB//qVknylV+HPxNJrMEk6/oIL3gKwzfpIyiuV5WmQQjlAzi4Ge4JxjSUGmQPcLx8sc1hKilZ7hlHBG5HEacIuxI22ncQaQ9CG18cUo0JijDdr8E4vb6qrVmpuwgOl6E1Am4WU3xZUMfTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263306; c=relaxed/simple;
	bh=+qwT0MPbAWnP5VSmEeKF7QOYVy8cIZLmTNtK+kCmOfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsFie/bf2vGj5JaOQlEC1qFd1B2HuKqAewvN0d4y/R94q+ZZAHUVJkqtvhaC+b6jkleSe7MPKpMHTtExq1J6Ae5rR6iBwWmND+Jmza6Eyy9D0uXj9Eub9+iykScZyztRKat42I8SoT8P7U/ja/4S80SHTCdd1zg+mabkU+xkpDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYdOg76O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYdOg76O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D611C4CED2;
	Thu, 30 Jan 2025 18:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263305;
	bh=+qwT0MPbAWnP5VSmEeKF7QOYVy8cIZLmTNtK+kCmOfI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DYdOg76OuVvDGAxBH1Sti/WZgxfjW5LsR4/pO8Bhh00gQLGBAoqVJVA5Jpz8re7AJ
	 tFAKdouXNvWAhD2v9dw12uRMZaLv9O975isUnQ7Zj3HHdtphuy5gSvzqWfGr8TFjJN
	 MMujwKDaRV1oa/V20eD04AV8j56srIZ1fulLVCLjUJ6jvn6D9G8wdZIeHxlIQQxlTz
	 BKnbcVo+WkOI1yKru+p9T2WL5WA0bvKCKLJxKOo5b1T3mFkLNb6MyL9DXL/iaCqPKm
	 U8oUt53nsNPl08N6yTemFdKjAtxTT6nTPKegB5LyDKKzolNs3t8psHdjhIpyzk+OIY
	 37G4Rk1HwpW5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E72CCCE37D9; Thu, 30 Jan 2025 10:55:04 -0800 (PST)
Date: Thu, 30 Jan 2025 10:55:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: Re: [PATCH rcu 0/9] Lazy-preemption-related updates
Message-ID: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>

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

Changes since v1:

o	Reword commit-log line containing only "to:" to avoid confusing
	tools that parse commit logs.

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
