Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83725473E;
	Fri, 16 Aug 2024 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723782974; cv=none; b=MKkH3Diom/3zVD2/69Y/SdRtPPojd79qJp/caz7wihNiLJQx+L4V9nsxxIA6TBZKa8wIqcejvx940nZtIxlUjJOxoiaW0Crw0yuuIeBJZb74tVbywW/A4C742bOddXeSa7hbkQOJ8GpfBGtQsCxtLvqyYV1grhQvENDv2W9qUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723782974; c=relaxed/simple;
	bh=VJsskA24uJ2kbMlLy3UqtoBkXfKBBb4bKnuI0FPw8Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TaSAWsPhVUvMObJraD4A07L8B/pE2pYMakK4izQd77xHKI+x7GDA6WAnPLLUyuHUVT/Kq17mriJXE633Wn/jIR7v7vXgX+1gshmZZ9lsegRdhj2ZJXA1uuACIwoJJydES6Pw4QhJD9ZnwZ5hJ0c71dpqb/WTEvs1pHdQY6M76ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmFWrV5z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmFWrV5z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA8BC32782;
	Fri, 16 Aug 2024 04:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723782973;
	bh=VJsskA24uJ2kbMlLy3UqtoBkXfKBBb4bKnuI0FPw8Xw=;
	h=Date:From:To:Cc:Subject:From;
	b=MmFWrV5zRVHIofL05QTvJsZwIjSS+zgo6YcS/j/Od7H8S8iO3xg+Pibc2pOwmCL3j
	 1c1dMQiOTqCS0RwHPf3VkKGig6trQaIitGmACrB2DohcZ0Ux/+t0oeXtRyTTmUAyBy
	 6VYVXfWZLane4JUIJYEvJVkHC8L8v8G39ax/XF1ZPjnhvXeFOfmHwKdlaujiA2d2tb
	 i/qqL0ssUPcHfDr81vSN5RD0JJ50Gz0RCau9YSUnMeqshcK50ZXNm0n2QpfjGwKSIY
	 wDLCkyltaIViIZG4H4C0AgJc74u4iWj1JvkEpuqeizodjqpFzIQb0CQQ7qg/3PGxiP
	 nZORCPSaY3a9A==
Date: Fri, 16 Aug 2024 10:06:00 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
	leobras@redhat.com, imran.f.khan@oracle.com, riel@surriel.com,
	tglx@linutronix.de
Subject: [PATCH rcu 0/4] CSD-lock diagnostics updates for v6.12
Message-ID: <20240816043600.GA25206@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series adds following changes to the CSD-lock diagnostics (rebased on v6.11-rc1):

1.      Print large CSD-lock-hold time numbers as negatives, courtesy of Paul E. McKenney.

2.      Add api to provide an indication of ongoing CSD-lock stall, courtesy of Paul E. McKenney.

3.      Add a backoff mechanism for repeated CSD-lock diagnostic reports of same incident,
        courtesy of Paul E. McKenney.

4.      Print only local CPU info when sched_clock goes backward, courtesy of Rik van Riel.


As communicated earlier at [1], I will be submitting these changes as part of RCU tree,
due to dependency of RCU commit "7c72dedb0079 rcu: Summarize RCU CPU stall warnings during
CSD-lock stalls" [2] on these changes.

Git tree is at [2]

[1] https://lore.kernel.org/lkml/20240722133559.GA667117@neeraj.linux/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=rcustall.15.08.24a&id=7c72dedb0079e62c1c75dbab038332017f34a6b8
[3] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=csd.lock.15.08.24a


- Neeraj


Paul E. McKenney (3):
  locking/csd_lock: Print large numbers as negatives
  locking/csd_lock: Provide an indication of ongoing CSD-lock stall
  locking/csd-lock: Use backoff for repeated reports of same incident

Rik van Riel (1):
  smp: print only local CPU info when sched_clock goes backward

 include/linux/smp.h |  6 ++++++
 kernel/smp.c        | 38 +++++++++++++++++++++++++++++++++-----
 lib/Kconfig.debug   |  1 +
 3 files changed, 40 insertions(+), 5 deletions(-)
