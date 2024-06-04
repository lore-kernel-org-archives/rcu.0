Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C732AE8E;
	Tue,  4 Jun 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539829; cv=none; b=FNMGBNh1scUc2HV+1idpCbTdud1/++OlOaG0DdLD3VpXyGeP0f6KxFW7+7yqOerh1/EsS+TZi9ozq8ZdLDgU8XFyQfbewqZD45V0nMkGMiY7XmATFuenEubsqu3RbC6Z+9PdS7xvqwlWnQGUkiRKOaUEjA+mUCMcV6Q7xQkIlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539829; c=relaxed/simple;
	bh=8CZcbXy345Ty1lr7cgD+B7lcwgsZUaoQvcWhdS/iFNE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uoCTfRsszHZWHXTbu5fXqmQt07tyenchSISurXCGQhyweOl22QMrZtDN1hKUCEdoy+4BRUpFtQOq7bgXMv17bPVK5TRJAqXhV53CEFIw8pojzpJAaSS+JjWQckQDMxGurtYTlesv///798PPwFO9JPXZW2X8M8SbcbAu+UB80KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCxlgdqz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCxlgdqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCB1C2BBFC;
	Tue,  4 Jun 2024 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539828;
	bh=8CZcbXy345Ty1lr7cgD+B7lcwgsZUaoQvcWhdS/iFNE=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=tCxlgdqzMCB2++x9Siw0jo7DleBDcpGjo8hFdLOZVhbT2YNLpPzWYiBLEvVhLEVfX
	 g96VVIii55n7baaSRGTsMaZkdqvXZUO+Q8uoG2+em8YDWpjkuId7ma1GoFwBRev3EK
	 zx4dlq5pTWZ3Hi+0tQ0Y9bhU+k+6lbgU2b2quJWPzh1Rd+TPBG7zpaCxOZaCQYYVH5
	 8+/jdTeL95iYL103bJz5K922Yb6Zw4Bb7TkA2w/8+LMYR9Pl5zFYC/a6gOFRV3ZOgg
	 Mqlq3XtTaA6cj2UjO0Z14G31vBhZLWvHNEW4Sj7vVpD8kp25mxvunRwJNk65IRq7J+
	 V2wlMJj9ZECRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 83C9BCE3ED6; Tue,  4 Jun 2024 15:23:48 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:23:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/9] Miscellaneous fixes for v6.11
Message-ID: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
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

This series provides miscellaneous fixes:

1.	Add lockdep_assert_in_rcu_read_lock() and friends.

2.	Reduce synchronize_rcu() delays when all wait heads are in use,
	courtesy of Neeraj Upadhyay.

3.	rcu/tree: Reduce wake up for synchronize_rcu() common case,
	courtesy of "Joel Fernandes (Google)".

4.	Disable interrupts directly in rcu_gp_init().

5.	Disable interrupts directly in srcu_gp_end().

6.	Add rcutree.nocb_patience_delay to reduce nohz_full OS jitter.

7.	MAINTAINERS: Add Uladzislau Rezki as RCU maintainer.

8.	Eliminate lockless accesses to rcu_sync->gp_count, courtesy of
	Oleg Nesterov.

9.	Fix rcu_barrier() VS post CPUHP_TEARDOWN_CPU invocation, courtesy
	of Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt |    8 ++
 b/MAINTAINERS                                     |    1 
 b/include/linux/rcupdate.h                        |   60 +++++++++++++++++++++
 b/kernel/rcu/srcutree.c                           |    5 -
 b/kernel/rcu/sync.c                               |   12 +---
 b/kernel/rcu/tree.c                               |   40 ++++++++------
 b/kernel/rcu/tree.h                               |    1 
 b/kernel/rcu/tree_plugin.h                        |   10 +++
 kernel/rcu/tree.c                                 |   61 +++++++++++++++++-----
 9 files changed, 157 insertions(+), 41 deletions(-)
