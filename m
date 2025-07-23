Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA31920DD42;
	Wed, 23 Jul 2025 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302474; cv=none; b=WWZyZ+OJGwFjbNhaRDu7abC6aKNsmmB6RGpqKq2o/UFa+34H2t0zdFmPVvCtgoZrVMTaUTCd8pocvFaHHZCnDO1AcM0zocYfP9VBd1adR88ywDNqsKfGqj2Ehl658cr/WwKAR0BIOm9wXIQJtnLFkBPnbwzn/JrKcAvsUcB+UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302474; c=relaxed/simple;
	bh=ZDJ0UddwErHUrb2PajQCNvDNDSafrN7s/hTlFFWDmR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=owViNKzlWHfrYaibMal0+r+byqF6DQMnhFWyhWTsSJ9Vh3Ew+FSnWNHL3KzcGjVoC3f2BliLx6LDBIcS7xcb8GkOrHL41a3grz9RcF0+hTMMDTOJ1a4K1K1O4AjUKO9Ctl4pTwbepvIjceGO9f8S7+gVxdqbcaTmmkJEqfzKcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO7iyyPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO7iyyPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7839EC4CEE7;
	Wed, 23 Jul 2025 20:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753302474;
	bh=ZDJ0UddwErHUrb2PajQCNvDNDSafrN7s/hTlFFWDmR4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=AO7iyyPwZp4oYGUIKxGRTziPM5XcOeALxcbZIzVPdrRKDzULIb1vwzCIzppsVI6PF
	 evzRavTvxxNQGMDTShh7dcCOuPiPND8U8qQd4Xo3++O0zR3EwHo1o3bXCH3/uV/miC
	 6x1VDJbhf2XeSuVBh/WfamQAFvfhae4Hl81TLXydNgZrkaWrvWfzQ1e4okLknQ5A2X
	 NCail7r0i/RRWXtSsRnPo66PMtIEng7H6vOCgOdk2x8QiZrtCcaly5B7HIAbDXA3mO
	 87MBTnvJj6sTMxaG9dPfLtkwbRzyokMNMy49WpIpAqkHokTKifzZWphy7ZX7HgrKGz
	 tC3r/YFRDG1VA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0A192CE08DF; Wed, 23 Jul 2025 13:27:54 -0700 (PDT)
Date: Wed, 23 Jul 2025 13:27:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/6] Switch __DECLARE_TRACE() to new notrace variant of
 SRCU-fast
Message-ID: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
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

This is version 4 of a patch series creating a new notrace variant of
SRCU-fast and introducing it to the __DECLARE_TRACE() in place of the
current preemption disabling.  This change enable preemption of BPF
programs attached to tracepoints, as is required for runtime use of BPF
in real-time systems.

This triggers continues to trigger a kernel test robot report of a
"using smp_processor_id() in preemptible" splat.  I looked for issues
with explicit preemption disabling, and, not finding any, will next turn
my attention to accesses to per-CPU variables.  Any and all insights
are welcome.

1.	Move rcu_is_watching() checks to srcu_read_{,un}lock_fast().

2.	Add srcu_read_lock_fast_notrace() and
	srcu_read_unlock_fast_notrace().

3.	Add guards for notrace variants of SRCU-fast readers.

4.	Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.

5.	Document __srcu_read_{,un}lock_fast() implicit RCU readers.

6.	Document srcu_flip() memory-barrier D relation to SRCU-fast.

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

 b/include/linux/srcu.h       |    4 +++
 b/include/linux/srcutree.h   |    2 -
 b/include/linux/tracepoint.h |    6 +++--
 b/kernel/rcu/srcutree.c      |   10 +++++++++
 b/kernel/tracepoint.c        |   21 ++++++++++++++++++-
 include/linux/srcu.h         |   35 ++++++++++++++++++++++++++++++--
 include/linux/srcutree.h     |   47 +++++++++++++++++++++++++++----------------
 7 files changed, 101 insertions(+), 24 deletions(-)
