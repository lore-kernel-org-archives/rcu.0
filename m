Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0E1A6820;
	Sat, 19 Sep 2026 00:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777732; cv=none; b=eZjvKolLFtRTajD0wu531n0fndfjlpe9glYNwOpX3fe35tdmdI275npST9AxNkI2qJfZ9/Qj3D5KGJd7BUms/IzKcdsbbjrK2gtQU5onO8E5tLMXlhSf2hOQG4a1iducpsvKrS8q1paoy5o8n9BEWgUlTTibvmi1PPkq2dk0lXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777732; c=relaxed/simple;
	bh=4+7bB1JEJSCjlPrSvfmw+wM70mjBaQYN6C5E0BgT+V8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C1aS9lIwobf7KWShpR/MwZTRYlbGW+ZhXZOu27nH9jUY1jCoNsWqR2yHyx8ekJ+SXP/OLX3aqYyMN6k/quoXpjDga9tkBKdbgQlA7GbM//2IGSyeWQvFmFtuINswxmCaFTmzT2IgMn2XxgcLhOlI9RMch6ihEiuHneqg+/ublaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGtwozRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGtwozRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727BC1F000FF;
	Sat, 19 Sep 2026 00:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777731;
	bh=liTVGDWlvTrLkJeJGF1OTeub1iYUwJ40uxnM3WV6mXI=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=FGtwozRV+emtIWUK8ePGpiovvpMwlqUN5C0NHEI+fqlWkUvBZiw5rFoz6whbVYLVU
	 XlUYkcN7/eqcQW4TMeIalxVyArsjErbKvhbApOCGhTgRKtWarGn6xvNPMrGYxYNtjt
	 5tMC2MmuF1IcI+smMM176Oht5r+pL/OI34N6Ly8R2lo5iziV+VCjdjOKe8nZ48x3tr
	 0m6KNVkL0PFdhmmxzbVVThZxW4/gDayCVldOKrvIWkIN6PG5RSHki7mXx5f1yFWqsB
	 XD/s+hATdWDyDC0YtiQ6RUppC+lhekzq/E3UhYC0SFth6Wmy1s5MV/fM38nysPrM6l
	 a2zkImdA5vl5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3659DCE1775; Fri, 18 Sep 2026 17:28:51 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:28:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/9] Miscellaneous RCU updates for v7.4
Message-ID: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
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

This series provides miscellaneous RCU updates for v7.4:

1.	Update stallwarn.rst based on RCU Tasks Trace as SRCU.

2.	fix shrink budget underflow in lazy_rcu_shrink_scan, courtesy
	of Longlong Xia.

3.	Don't panic on already-ended RCU CPU stalls.

4.	Add running and boosted indications to RCU task stall dump.

5.	Fix typo "upto" in comment, courtesy of Hemanth Selam.

6.	Drop the private tick-internal.h include from tree.c, courtesy
	of Bradley Morgan.

7.	Make userspace barrier hook drain kvfree_rcu work, courtesy of
	Matthias Goergens.

8.	Fix the rcuread_is_dead reference in rcuref_read() kernel-doc,
	courtesy of Karl Mehltretter.

9.	Disable callback contend/collapse messages by default.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |    7 +++++
 b/Documentation/RCU/stallwarn.rst                 |   22 ++++++----------
 b/Documentation/admin-guide/kernel-parameters.txt |    9 ++++--
 b/include/linux/rcuref.h                          |    2 -
 b/kernel/rcu/srcutree.c                           |    2 -
 b/kernel/rcu/tasks.h                              |   15 ++++++++---
 b/kernel/rcu/tree.c                               |    1 
 b/kernel/rcu/tree_exp.h                           |    2 -
 b/kernel/rcu/tree_nocb.h                          |    3 --
 b/kernel/rcu/tree_stall.h                         |   12 ++++++--
 kernel/rcu/tree.c                                 |   30 ++++++++++++++--------
 kernel/rcu/tree_stall.h                           |   23 +++++++++++++++-
 12 files changed, 88 insertions(+), 40 deletions(-)
