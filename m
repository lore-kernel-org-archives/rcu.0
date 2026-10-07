Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C5414A1E;
	Wed,  7 Oct 2026 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406744; cv=none; b=gE+0dSTUtAHSbCwnLpBmG63JueoD6aUN1JhsyR5WwxgyQ1+mCHBpzdwGPoDbUIE8wR+/X7XzrPtJX3qx59BMd7nK3LVd+5iAjXhOhfr0e1fyghaomtzFVIlxsK0WD5wdII77r6J95bqwFe8GNn9WGfW4Dl40BHJI4pnZlSi3md4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406744; c=relaxed/simple;
	bh=wKyE33HxrwKl1Ni4/kIVXZMqQ4Lb1uRnBSHG9jL4KWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=enhFJv1U9GAiSU/qYVt4Jtr5sGFkNe3oEemTQJg7HpDZcwmhEon6RTBqZDzUdNijzaRPlOgTWo+Zsr0PM2W8mCona13pa4KgB3lZg9UsdOEpGlR4OQyHfP2y7Gj37AGkC9GwpC8b67A6NPdaSldFAnE3ZxO+M6vqfyrki0un8qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqUJtdKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqUJtdKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73011F000FF;
	Wed,  7 Oct 2026 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406741;
	bh=WOtFdMoTAacvdqJWG4/KPzJUD+bY66zZCYOoBmZ8CDo=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=kqUJtdKa2cCGfSZSCimwsMLv3/8uS4aNoMybcrlEiclqCU+SoDVYX9DK2/oBNgopH
	 0f7r+YSzCK13xnt19Tyc3qoATxMvzM2zLjba5ojDQp2rq7Ut7RA+AH/EaEnMeDuQf8
	 hcwaXxV5FkQNsrPCWIuMFP3JhpA66L/X2z2zlIGMGvviHH7++6nC+lBRwtx1uk882r
	 uQIOKlHEM9zjC5cUIcqtWjpZoBv8mLZ+UYqvCiYERqxVZ2bjpaFSIANIkEnFj+rvqx
	 a1nddwvw47+J3WM5EdlJrhnZCmffjQvC2RUFbMwqrP+gNAI0y1o7DZlkm/SoFKHDYg
	 xh1WoX1sYnJsw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AD12ACE0D79; Wed,  7 Oct 2026 13:59:01 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:59:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/21] Add atomic SRCU &c for v7.4
Message-ID: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
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

This series adds an atomic SRCU and some additional adjustments:

1.	Make a Tiny SRCU grace period imply an RCU grace period.

2.	Suppress srcu_advance_state() mutex_lock in atomic.

3.	Suppress to-big transition for atomic SRCU.

4.	Add an atomic Tree SRCU.

5.	Add an atomic Tiny SRCU.

6.	Add support for testing synchronize_srcu_atomic().

7.	Disable preemption across synchronize_srcu_atomic().

8.	Use IRQ_WORK_INIT_HARD for srcu's irq_work, courtesy of Sebastian
	Andrzej Siewior.

9.	Warn if Tiny SRCU readers are preempted.

10.	Explicitly note DEFINE_SRCU() needs for srcu_barrier().

11.	Add atomic-SRCU support to torture.sh, courtesy of Kunwu Chan.

12.	Add reader-free fastpath to synchronize_srcu_atomic(), courtesy
	of Kunwu Chan.

13.	Skip callback scheduling for atomic SRCU grace periods, courtesy
	of Kunwu Chan.

14.	Remove srcu_barrier() sleep for atomic SRCU, courtesy of Kunwu
	Chan.

15.	Restrict atomic-SRCU non_block annotation to task context,
	courtesy of Kunwu Chan.

16.	Make init_srcu_struct_atomic() prevent transition to big,
	courtesy of Kunwu Chan.

17.	Don't transition atomic SRCU to big in srcu_gp_end(), courtesy
	of Kunwu Chan.

18.	Skip torture to-big transition for atomic SRCU, courtesy of
	Kunwu Chan.

19.	Add lockdep and early-boot checks to synchronize_srcu_atomic(),
	courtesy of Kunwu Chan.

20.	Add lockdep and early-boot checks to synchronize_srcu_atomic(),
	courtesy of Kunwu Chan.

21.	Preserve IRQ state in synchronize_srcu_atomic() callchain,
	courtesy of Kunwu Chan.

Changes since v1:
https://lore.kernel.org/all/13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop/

o	Added patches 19-21.

o	Dropped old patch 9 in favor of an urgent RFC pull request.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h                              |   81 ++++
 b/include/linux/srcutiny.h                          |    6 
 b/include/linux/srcutree.h                          |    9 
 b/kernel/rcu/rcutorture.c                           |   46 ++
 b/kernel/rcu/srcutiny.c                             |    2 
 b/kernel/rcu/srcutree.c                             |   23 -
 b/tools/testing/selftests/rcutorture/bin/torture.sh |   24 +
 include/linux/srcu.h                                |   10 
 include/linux/srcutree.h                            |    6 
 kernel/rcu/srcutiny.c                               |   94 +++++
 kernel/rcu/srcutree.c                               |  333 ++++++++++++++++----
 11 files changed, 548 insertions(+), 86 deletions(-)
