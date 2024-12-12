Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D21189903;
	Thu, 12 Dec 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029392; cv=none; b=lva65pVkwC0BIjmvAvbk37h8lutwIvb/1nthhUJFxBWrpdwWWOpEhSKY+XpAFw/HOU38uVi6NicMM4PDUdGzqLv/pHYfDh2CVTOw474Aokqeg39/XmShv6fpduq+Z+orKtTKDnqZD+fSqlvybiKC5z95xzyRdYk3t0hgCJ1yQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029392; c=relaxed/simple;
	bh=FK401vEreRjy5CAgEWzkuhPz9za8Nr8XSeGPbytYco8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DFV24dLEHlGCjFO28rKX6XcyWvnjVOjTD1E4CF42NWdOhYLJ0coa4zGTOVjdZW4gWhju1T+s/OFRxlbP3U3Dzr9kI9X8INKoFZSS7g/52+3fBZ9JuJRf1uqXVpRYgNLkea71jtFRBJBRt9vc9g7mAUuGhl0HhJhcnN409DKtL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbuRYqah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbuRYqah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5329C4CECE;
	Thu, 12 Dec 2024 18:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029391;
	bh=FK401vEreRjy5CAgEWzkuhPz9za8Nr8XSeGPbytYco8=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=bbuRYqahHwVzvWUUZbCd3H3mNfpgSF3/AtaEp42Cu/lefqv30bRKICLGnoXftplXN
	 080FhKd2Pi13hYHWBrZfaAuSddzlzt7tvJsicQQFCcxECpDefUZY2nOUCVOJ0I/jbY
	 rjIhQB6GfSyy5zh2s+/QMl0/BxgytwbYyvBU/+Woj+PIcOT867kP46nI773U7XWIUc
	 46Z3mHboG8aXjoli3+4EBGpIxW7SDY+569Naoh4XSzAHSWATFlWI8G5QHHWR5IqI3j
	 1/HhdoS1axTDOjKL7PTiKvGwBOMgd6mGE////n7SZDlHHBfso78a9pQ9LJKd6o3Alo
	 Y1XOLUvlY65zw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4E77ECE0F53; Thu, 12 Dec 2024 10:49:51 -0800 (PST)
Date: Thu, 12 Dec 2024 10:49:51 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/18] RCU torture-test updates for v6.14
Message-ID: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
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

This series contains rcutorture updates:

1.	Add dowarn argument to torture_sched_setaffinity().

2.	Add random real-time preemption.

3.	Make the TREE03 scenario do preemption.

4.	Decorate failing reader segments with CPU ID.

5.	Use finer-grained timeouts for rcu_torture_writer() polling.

6.	Add ->cond_sync_exp_full function to rcu_ops structure.

7.	Check preemption for failing reader.

8.	Decorate failing reader segments with last CPU ID.

9.	Add full read-side contexts to "busted" torture type.

10.	Pretty-print rcutorture reader segments.

11.	Make rcutorture_one_extend() check reader state.

12.	Ignore attempts to test preemption and forward progress.

13.	Add documentation for recent conditional and polled APIs.

14.	Add parameters to control polled/conditional wait interval.

15.	Add preempt_count() to rcutorture_one_extend_check() diagnostics.

16.	Read CPU ID for decoration protected by both reader types.

17.	Add per-reader-segment preemption diagnostics.

18.	Use symbols for SRCU reader flavors.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt              |   74 ++
 b/Documentation/admin-guide/kernel-parameters.txt            |   16 
 b/include/linux/rcupdate_wait.h                              |   11 
 b/include/linux/srcu.h                                       |    6 
 b/include/linux/srcutree.h                                   |    6 
 b/include/linux/torture.h                                    |    2 
 b/kernel/locking/locktorture.c                               |    6 
 b/kernel/rcu/Kconfig.debug                                   |   15 
 b/kernel/rcu/rcutorture.c                                    |    2 
 b/kernel/rcu/update.c                                        |    4 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot |    1 
 kernel/rcu/Kconfig.debug                                     |   16 
 kernel/rcu/rcutorture.c                                      |  279 ++++++++---
 13 files changed, 363 insertions(+), 75 deletions(-)
