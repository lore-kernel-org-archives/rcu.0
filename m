Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262770;
	b=IfRbcgiHuI101zUK3Izt7sFmP7VKdAtM5WBoAatm+YOGUa/8ByW0c8iNDvxJAUiIg+pU
	 DGN39/bvFLPqNU/litaTAM77wdIr4Q/TpJ9OKfG1HfQjt8j7F+y+gMM1FyD5TGI0MaHgn
	 reV8P5SgGf1eVdujPk4+U36w65qABMvJiSK9mks6jMhwoP3Lb5hIyGdXu7U5ScniLgQV3
	 u33CxKQ47Z1Vg85PUKcqy6qrwKPAzQYKfCMO65y13w56cy5msSQMqTwCD5aTzuQiSNN2r
	 Hf2EW86EUJoOIJEOqNUsbMKSQo/DsQUIORKWOnPNlfXA9sc9JcQMi3ecces6x7Er5mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262770;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=uTFq/YGCWeI9DuI1v8pepBGAfTcW7/CO0/S+sak4pCk=;
	b=Ym4YuYtpwuczITa5pOvG2EIn977zonu1uzpoaXep1ugNw9hp92W+AV9KpZr2jSOITH+d
	 bti+I3khW6qJcNA4vKzgxXZ2+CTdKso3NxOFV5Wgc41ytm3nBiDwKdz+Mje3xfmOo+fLx
	 hr5zzQXzbqiSWxhP87aRMMV3qv7SRqXGMAauMa2NZzIa9YNLVdHkkOOsIvpL1t/PmC1n8
	 3V9ylNSBGnB6YCD69QTuQ+CqCN6PYUhlCYpdUaBb2PO+Sto2B3MjVo8u0iykUI43frCQJ
	 +LkroNYiZWSCt8yz+Enf6Odvk7mFbxVjb7DZpOmOlTASouJDtDuhSZG7+b3VdkRLIIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUaBcCab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB71606A31C;
	Mon,  9 Nov 2026 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUaBcCab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61D61F0089F;
	Mon,  9 Nov 2026 22:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262769;
	bh=uTFq/YGCWeI9DuI1v8pepBGAfTcW7/CO0/S+sak4pCk=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=FUaBcCabFp9bz/S/qX4sK1bELWbUe3Dl5gVmPbnl/x/hHMyIuMyh9isvb8vKm9Kcr
	 yvO1o1KQnBp6t9TN8iJ6icHqmGN65LZQxiXcM7TY9TykpDb/9se7LylPQ+F86i11Ab
	 KcYLM23lmxpmm+vl9TyyzBWf8UxJIptYyizyNjtcADyPePHZGsVQFEFq8sidZyVjbz
	 LZywpmAyTQaMYOtGMb1ytIbC/HN0ynq6CkKEsuqglyaUDyHZ4gTtUwVqDv0/DRUbDS
	 YGyB1OrfDhjHKq0NBYQFN95RVncG8RQ2a7Ntci9NS+GZIKTlWkAsutrL4+NvDOlkqs
	 IpWgVK3dYVPUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7631FCE0CC1; Mon,  9 Nov 2026 14:19:29 -0800 (PST)
Date: Mon, 9 Nov 2026 14:19:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/8] Miscellaneous RCU updates for v7.5
Message-ID: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
Reply-To: paulmck@kernel.org
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series provides miscellaneous updates for v7.5:

1.	Enable RCU_BOOST where supported.

2.	Disable RCU priority boost testing on non-TREE03 scenarios.

3.	Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan
	test, courtesy of Kunwu Chan.

4.	Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor
	test, courtesy of Kunwu Chan.

5.	Add srcua scale type, courtesy of Kunwu Chan.

6.	Consolidate per-writer arrays into struct writer_state, courtesy
	of Joel Fernandes.

7.	Print CPU that preempted stalled reader wants to run on.

8.	Document additional RCU task-stall dump information.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/stallwarn.rst                                         |   71 +++++
 b/Documentation/litmus-tests/README                                       |   19 +
 b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus |   55 ++++
 b/Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus |   52 ++++
 b/include/linux/sched.h                                                   |    2 
 b/kernel/rcu/Kconfig                                                      |   10 
 b/kernel/rcu/rcuscale.c                                                   |   41 +++
 b/kernel/rcu/tree_stall.h                                                 |   33 ++
 b/kernel/sched/core.c                                                     |   13 +
 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01                   |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02                   |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01                   |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot              |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE02                   |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot              |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE08                   |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot              |    1 
 b/tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot              |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY                |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01             |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE                |    1 
 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54              |    1 
 b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT           |    1 
 b/tools/testing/selftests/rcutorture/configs/refscale/PREEMPT             |    1 
 b/tools/testing/selftests/rcutorture/configs/refscale/TINY                |    1 
 kernel/rcu/rcuscale.c                                                     |  129 ++++------
 26 files changed, 340 insertions(+), 101 deletions(-)
