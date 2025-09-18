Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8062773F0;
	Thu, 18 Sep 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191201; cv=none; b=IFg35i7n/u6FkXWynBhHMvXtPGNH0pzyMXycg2wxKM2+zjnj2XXP87YarmsImAYx6CT+woPk51/Kc6BZNGHSYCjkPNt85vAW7R6bsqezSvV8zjX8ckvbM8UljeEahcf6ERK4MBKvi0ijY5MelcCEaxKCPrFuhfP/8caen1utwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191201; c=relaxed/simple;
	bh=yj2eTWFg6tTTFj5zrGIcdAtT44odqMMwfL4AjM7REbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L1QxMwR2Jjz3hyfFxGLU2dWSOPrw/ANEVoYLKxdL0B5zfk70Jl4CyOiFU3vIKlmjs9lcL41Hk6dWw9K/4hOzIYrU6g1jT9OCv/gHyQwDiHTYZU3L4yTJ+WWmfPjSM93jWOWd9j7TnXA4LByjPIGgAcFDiKa/S9obs95MetxViLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azYhtVC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azYhtVC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247C2C4CEE7;
	Thu, 18 Sep 2025 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191201;
	bh=yj2eTWFg6tTTFj5zrGIcdAtT44odqMMwfL4AjM7REbM=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=azYhtVC3tOHM9gLedI+p0yEO/L3PG38x1+4v/YEc+8zvOTWJAYiU4DFIINWthjIqW
	 i5amzMnSFxW2U4Nvsx3A1/k0Sp1DIzQU5Yt7bkIqxArIVsgRpvTw0n/ymu1ytRnZKi
	 IZsC2PzgkWKWcVOSn8Bt660Z8NDDGvxmtKQhNnZ3hCcCGabK/0UDhdpXVEUaP3hIZ0
	 dCftSeM+Irv1++yEOhGgxsplXJIGwMaFLL1O1Fo0lBILI5WcrUzcpVuajF63BN2Gqu
	 RS19CXirjp534wme1zpWvxcqCNJRIS9R+YlH+HbKB/IuzMASNYCJTxFfviFDmyMjQ+
	 bEvZjkRoq0XDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9432ECE0B32; Thu, 18 Sep 2025 03:26:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 03:26:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v7 0/6] Provide RCU changes needed to switch
 __DECLARE_TRACE() to SRCU for -rt
Message-ID: <89b6f92e-2aa6-4869-ad4f-47bb3fbadfbb@paulmck-laptop>
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

This is version 7 of a patch series creating a new notrace variant of
SRCU-fast for eventual use by the __DECLARE_TRACE() macro in place of the
current preemption disabling for PREEMPT_RT kernels.  This change will
enable preemption of BPF programs attached to tracepoints in PREEMPT_RT
kernels, as is required for runtime use of BPF in real-time systems.
Non-PREEMPT_RT kernels will continue to have such BPF programs be
non-preemptible.

The patches are as follows:

1.	Move rcu_is_watching() checks to srcu_read_{,un}lock_fast().

2.	Add srcu_read_lock_fast_notrace() and
	srcu_read_unlock_fast_notrace().

3.	Add guards for notrace variants of SRCU-fast readers.

4.	Document __srcu_read_{,un}lock_fast() implicit RCU readers.

5.	Document srcu_flip() memory-barrier D relation to SRCU-fast.

6.	Remove preempt_disable/enable() in srcu_gp_start_if_needed(),
	courtesy of Zqiang.

Changes since v6:

o	Deferred the application of SRCU-fast to __DECLARE_TRACE()
	due to bugs located by the good services of kernel test robot.
	Although the current version is looking good, it needs more
	test time.

o	Added patch 6.

Changes since v5:

o	Forward-port to v6.17-rc1.

Changes since v4:

o	Remove the redundant "notrace" tags per Boqun Feng feedback.

o	Disable preemption for perf and ftrace per Steven Rostedt
	feedback, which addresses the kernel test robot reports
	provoked by earlier versions.

	https://lore.kernel.org/all/45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop/

Changes since v3:

o	Add "notrace" per Joel, Steven, and Matthew feedback.

o	Upgrade explanatory comments and add new ones per Joel feedback.

	https://lore.kernel.org/all/20250721162433.10454-1-paulmck@kernel.org/

Changes since v2:

o	Posting standalone as opposed to a reply.

	https://lore.kernel.org/all/3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop/

Changes since RFC version:

o	RFC patch 6/4 has been pulled into the shared RCU tree:
	e88c632a8698 ("srcu: Add guards for SRCU-fast readers")

o	RFC patch 5/4 (which removed the now-unnecessary special boot-time
	avoidance of SRCU) has been folded into patch 4/4 shown above,
	as suggested by Steven Rostedt.

	https://lore.kernel.org/all/bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop/

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h     |    4 +++
 b/include/linux/srcutree.h |    2 -
 b/kernel/rcu/srcutiny.c    |    4 ---
 b/kernel/rcu/srcutree.c    |   10 +++++++++
 include/linux/srcu.h       |   30 ++++++++++++++++++++++++++++
 include/linux/srcutree.h   |   47 ++++++++++++++++++++++++++++-----------------
 6 files changed, 75 insertions(+), 22 deletions(-)
