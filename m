Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC631C822B;
	Fri, 23 Aug 2024 21:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447705; cv=none; b=h/2NADEa6MSxcEEa+KoRN1MVT8l/QQhYUFmFsmTgapfsVl4hY+7BqnPsbTSwx+cRkZbUzVVPV6S1kk8wd2jMLTDEwGhP3R4YJh83A7TFh2N3IjUPvG1IOkwpvL5okTy5o9zs/tv67kpMMYS943Pqq7hrYZaADTyLeqfS73FwBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447705; c=relaxed/simple;
	bh=mUH0IziPWhJ5X3zmaIyZcbFDpVMgw6WO0zCuL9ImWBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JScFMaTpnk9cZZKac4Bncn5NfsTq+rF0aeDoAG9UyclOiGFBFBLHL30m7lqZSlkasAASnaMJ0qi+puyZLDslCpYjR5oKyUN0axzk2QWtpQ1l8MhucvKDOsaEN++BepsmT3t5z5hRLIBxj0k9ptPRUv/qam2ebEOn8Ltysl1fDJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rF/sSfTC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rF/sSfTC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806CFC32786;
	Fri, 23 Aug 2024 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724447704;
	bh=mUH0IziPWhJ5X3zmaIyZcbFDpVMgw6WO0zCuL9ImWBw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=rF/sSfTCuqogAs3V5A7Baraq2/IELGzXzJaMqXi58FB6xZpuRS/Qdz/Ek7Ybow+/g
	 79f/OxNIAoAL9etrf5jhmNghhNfd0GMp0KHDsY8homuFt04xThlbt/FuREyGmbBuPx
	 y0XrK31i8/HRjIx+N1SlYFh2Wh69aRCDDDM2rf2HTvGYVQKx+bOMHjWRBcbU1KKGTN
	 6qa8z4+0GaU+TPdLa11BMqMt0mfofAPh3HR8270ZJQkBlYJXYiJBSgSSSQPpP/4xcA
	 qBP1s3kyAVZSRZ7qITpiF4TZ2Nf77HsuD6/q1POrjWDcDd9ocNO7vUCAbCmjFoiI7y
	 /sV8xf18GJIog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2C629CE0D9B; Fri, 23 Aug 2024 14:14:59 -0700 (PDT)
Date: Fri, 23 Aug 2024 14:14:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	riel@surriel.com
Subject: [PATCH rcu 0/4] Reduce lock contention during RCU CPU stall warnings
Message-ID: <415b108b-1046-4027-aa2a-c829b77f39f6@paulmck-laptop>
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

This patch series reduces lock contention during RCU CPU stall warnings,
especially on systems having slow consoles.  It does this first by
deferring printk() output, second by refraining from emitting stack
backtraces if the grace period should end partway through, and third
by using a lockless check in order to avoid ever acquiring the lock for
leaf rcu_node structures not associated with a stalled CPU.  In the case
where a given rcu_node structure is associated with multiple stalled CPUs,
the lock is also dropped and reacquired for each stalled CPU.

While in the area, get rid of a function that is no longer used.

1.	Defer printing stall-warning backtrace when holding rcu_node lock.

2.	Delete unused rcu_gp_might_be_stalled() function.

3.	Stop stall warning from dumping stacks if grace period ends.

4.	Finer-grained grace-period-end checks in rcu_dump_cpu_stacks().

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcutiny.h |    1 
 b/include/linux/rcutree.h |    1 
 b/kernel/rcu/tree_stall.h |    2 +
 kernel/rcu/tree_stall.h   |   65 +++++++++++++++-------------------------------
 4 files changed, 24 insertions(+), 45 deletions(-)
