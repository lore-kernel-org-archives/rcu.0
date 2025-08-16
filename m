Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2138B;
	Sat, 16 Aug 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302756; cv=none; b=XBRAPWrPzYKCfbUCMVNvsDdJ3pIl8hMt29KsOqd0+okQPMWn13u3Jif9yFHskD9c1lLngGd01KyFzu5C0ddKBcwXftFtsmZARxd+qfmaCn5sOrR2XmnALmQzqXnlnA8VEmmUIqekKAqYNnUFIeR9DB2CKpj9QWy3sjc7nl4En20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302756; c=relaxed/simple;
	bh=uHK7pPuuZEsG2XLfiehvI2Ue79EZ6+z+zL+F47ZmNEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VxMIDtTJbAPHXcLVjxljCwv5MEc+x5/YqlKd8XFtJ9NPcxatPQqaKI4r2f1J/qtHOjW7xpRH0Jp+M6eLUr8G2uiQeDgDFz9LMAIotz3PxzN+46oC2OeyyO5COxne9tIHJMNlHI4NB1dWCAaVq/MdLXNUGPaYADDHcrt5LYzQJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdsXvkxm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdsXvkxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD41FC4CEEB;
	Sat, 16 Aug 2025 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302755;
	bh=uHK7pPuuZEsG2XLfiehvI2Ue79EZ6+z+zL+F47ZmNEA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=VdsXvkxmns+xH7KrRPGiWOjr6k/6mzTcJ0i6IweTA3TTOMXSROl3LQBxg+V/lqynK
	 tBom7kmwcZiSJk8JWzbvDqDFP97kU9JO7boklQbmjCGhaw8cq6wj6zZDIOEAmfdETF
	 Z7RmP/x0QTJ5MGHUpc8O7czargtvNtgsyyvCk+I6ZnrrZp/b1Py6TVSwFy2eXYADIE
	 4TlqGDX+XUF4u7h7KYNmYdJlvEnuhZKEv3S8b0M0PFY4GGaW+FL3Du3K0I9oKIY0OF
	 QCVAWYuQrrUiQaFT3harf35jHl3WszCe11qikB6ttPlV2Q8GiHJBekV8A7ytKwRXFd
	 AVzWdivttPO3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EF296CE0B2D; Fri, 15 Aug 2025 17:05:54 -0700 (PDT)
Date: Fri, 15 Aug 2025 17:05:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v6 0/6] Switch __DECLARE_TRACE() to new notrace variant of
 SRCU-fast for v6.18
Message-ID: <b592a936-fd9e-4aef-a2af-9d40ae19511d@paulmck-laptop>
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

This is version 6 of a patch series creating a new notrace variant of
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
