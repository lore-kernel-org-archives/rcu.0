Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CC360;
	Fri,  1 Aug 2025 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007145; cv=none; b=eeXjdgQkDO3eE/CG6lV9CsNPHb64Dwf6KFKg1ANc8UOhvFoJnJlWBNYbowGAOIEQjK+Y+Bc3RWhVkGuSq/gnXZCChezg1yEgB1sJ0jrY5hICqXq35h0xxKX0bdlAjco9P8w2+SvZ3dVivRyq9Y5d7bURmu5JCqb9Vd+TSbssHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007145; c=relaxed/simple;
	bh=3GdFhIjoHuWUzXGnXNvNOl+qvZLKmjGvD5TiuBkOfVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JBgmcK6eQW9M46LG9SkpWfS6HfzZcbKjV1VP7hvaq7TY0aGgeypD4Wmu2IIfKp6CXMiwVTCvqFrWZ5vRvr/d3F/WQwgrUg6MqoY5hbkbFdODJMmWf+8SDmK4yAoaiXVZHcy4rhAZhtJgX9VmJYm5geZwOBNR2/TCHrpLRVCDMlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkpSQqO7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkpSQqO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A093BC4CEEF;
	Fri,  1 Aug 2025 00:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754007144;
	bh=3GdFhIjoHuWUzXGnXNvNOl+qvZLKmjGvD5TiuBkOfVg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=NkpSQqO7lTYRzAOm/CKICpzEvfSCslPAahLCiJIpEpHFcwCxkNQoYk2ufinW8jsoo
	 br3QpQB6pD5NyjvLoSkhMqJHgXjda6rPayDrk2T7lV50wZqCux9XxmEDVkxoTc1C7Z
	 tEOkKHTk3dRkbhZACxgeJrlX9k0KjwPJjIXIX7BoAyaiEiLzpZgMgzTstRH+nPpFAQ
	 3Nyy4aXtuMeKyevGlKMnFtCtnCWAn2wzND+YXCg0tRYXfj+dpklHDOB1LuMn7wD6i0
	 qASBFdIf5AIkw+hWFG3lV6TdxjQNcYCuB4MsU5TWygTfLg1H3w7yRXrTVh8Ek96Hrh
	 s3IBgRqDwX64g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3CB68CE0A73; Thu, 31 Jul 2025 17:12:24 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:12:24 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v5 0/6] Switch __DECLARE_TRACE() to new notrace variant of
 SRCU-fast
Message-ID: <c8842c55-faf8-4cde-89bf-da77d91eadcb@paulmck-laptop>
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

This is version 5 of a patch series creating a new notrace variant of
SRCU-fast and introducing it to the __DECLARE_TRACE() macro in place of
the current preemption disabling.  This change enables preemption of BPF
programs attached to tracepoints, as is required for runtime use of BPF
in real-time systems.

The patches are as follows:

1.	Move rcu_is_watching() checks to srcu_read_{,un}lock_fast().

2.	Add srcu_read_lock_fast_notrace() and
	srcu_read_unlock_fast_notrace().

3.	Add guards for notrace variants of SRCU-fast readers.

4.	Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.

5.	Document __srcu_read_{,un}lock_fast() implicit RCU readers.

6.	Document srcu_flip() memory-barrier D relation to SRCU-fast.

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

 b/include/linux/srcu.h         |    4 +++
 b/include/linux/srcutree.h     |    2 -
 b/include/linux/tracepoint.h   |    6 +++--
 b/include/trace/perf.h         |    2 +
 b/include/trace/trace_events.h |    2 +
 b/kernel/rcu/srcutree.c        |   10 ++++++++
 b/kernel/tracepoint.c          |   21 +++++++++++++++++-
 include/linux/srcu.h           |   30 ++++++++++++++++++++++++++
 include/linux/srcutree.h       |   47 ++++++++++++++++++++++++++---------------
 9 files changed, 102 insertions(+), 22 deletions(-)
