Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4010243872;
	Thu, 16 Jan 2025 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059070; cv=none; b=HdVFACbRBHyfNivSLrWW6/dlezNcdb1UTpIbziKf6J3bWQua6dTOjwHmojO0hPXxvUXf8bEAICtMF7wzmxTyMorSDYVyYKTYgV1iER65GpZf1/M0rr7l2X8JprZo3AqeFNNM86hEr1DtBlSShSuF3Kj+Sor808uozJayhqNxLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059070; c=relaxed/simple;
	bh=WcOS5gWzoc094sJoHfDvFinkwW49ozr6CBa7+UXBAhw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QEfoaAThKjXd4dE2/opIBuqw0yx3YOmpHkcb+SmPE7WvqIU12JUtx5QjEkC2kiVR7pcjTCCH6v6XjK8GrqL+FVm97Lte5axMbbr0ZEt+U99KAssNOXllxXtXCel1FP3trgJuXOcuc4nfzy11l3iFKEbBEm/VFRBbZuhBYEu1J8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sf7M1pEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sf7M1pEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63419C4CED6;
	Thu, 16 Jan 2025 20:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059069;
	bh=WcOS5gWzoc094sJoHfDvFinkwW49ozr6CBa7+UXBAhw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=Sf7M1pEhCofFLqU141EL8WPHk22HbSsaGZsDGkTsmLJQn1eeEmiBqgdQhFoSxeP61
	 f/gjv9omSb+/9tqwWOpq+8mP0b9Dbw3kGbDCBAOxHhxrQt/wuT1p5ZyA/7hg0qPtzf
	 c963+Mm8fVem+nrxZ2VNqQJgBogS9thC8DBE+rKeepc6YxbMJPe88V9KZFRPQKZoOE
	 USq9fSdjYpfuR7Hk7S3pJsa7Miwkf1U6ZmsH2UUFqO2RWUK9CrjldCyIUZ2BVxTlTn
	 L8Jbz9xbBYTYTNLdRQBr6CHiUm/b9SL55auSg53T9e5wesA/LZwbXrjeFS4fV5LpCq
	 FinifWZ6KcnCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F1FCDCE13C4; Thu, 16 Jan 2025 12:24:28 -0800 (PST)
Date: Thu, 16 Jan 2025 12:24:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/11] Torture-test updates
Message-ID: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
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

This series contains torture-test updates:

1.	Add get_torture_init_jiffies() for test-start time.

2.	Add a test_boost_holdoff module parameter.

3.	Include grace-period sequence numbers in failure/close-call.

4.	Expand failure/close-call grace-period output.

5.	Trace expedited grace-period numbers in hexadecimal.

6.	Add ftrace-compatible timestamp to GP# failure/close-call output.

7.	Make cur_ops->format_gp_seqs take buffer length.

8.	Move RCU_TORTURE_TEST_{CHK_RDR_STATE,LOG_CPU} to bool.

9.	Complain when invalid SRCU reader_flavor is specified.

10.	Add FORCE_NEED_SRCU_NMI_SAFE Kconfig for testing.

11.	Make SRCU lockdep testing use srcu_read_lock_nmisafe().

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt        |    5 +
 b/include/linux/torture.h                                |    1 
 b/include/trace/events/rcu.h                             |    2 
 b/kernel/rcu/Kconfig                                     |   11 ++
 b/kernel/rcu/Kconfig.debug                               |   14 +++
 b/kernel/rcu/rcu.h                                       |    2 
 b/kernel/rcu/rcutorture.c                                |   19 +++-
 b/kernel/rcu/tiny.c                                      |   14 +++
 b/kernel/rcu/tree.c                                      |   20 ++++
 b/kernel/torture.c                                       |   12 ++
 b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh |    2 
 kernel/rcu/Kconfig.debug                                 |    4 
 kernel/rcu/rcu.h                                         |    6 -
 kernel/rcu/rcutorture.c                                  |   64 ++++++++++++---
 kernel/rcu/tiny.c                                        |   12 +-
 kernel/rcu/tree.c                                        |   22 ++---
 16 files changed, 173 insertions(+), 37 deletions(-)
