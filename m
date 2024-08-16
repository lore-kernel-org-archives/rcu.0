Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E775B839F7;
	Fri, 16 Aug 2024 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791741; cv=none; b=o1NKG7PdItk1LHat1SSKp19ZZWT/vQzvLbCi0RFQTdF8hwJ1lVMj24dLkEdB2EGW+xlBhpos3iY3JTDOktBJ8vt0A9du6rrCr2O7KifNkcDWOPiD8gPMwRku2qosit6AcvDQOEmd1KS4la202a26CB8p6Coxjl7dgeMoIBmpXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791741; c=relaxed/simple;
	bh=+SmpOx31OFvmrHooPIFDQgw7GagWUYKrd+OHPyWAFa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QB1ITpCSMYlz3haANswLULfTGhfo8hrG/bvefBwhRktKJwb8T1Jv0EunDzs4R9QyH3kza7UIYINsE+kR9W6bb/HCyxs5iY8WfZzIS/PvTJXZzS1MSuqL/T7eIo7QzIPie8WL3Lfp4HVIA8PKGCo9fwrEQipR9i8EznhupksBq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0y39v3X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0y39v3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08CCC32782;
	Fri, 16 Aug 2024 07:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791740;
	bh=+SmpOx31OFvmrHooPIFDQgw7GagWUYKrd+OHPyWAFa0=;
	h=Date:From:To:Cc:Subject:From;
	b=d0y39v3Xg6f0P8ACi3TK628UdrDADjiHlcIdoErpiH0JIpl6BukQq/AvdrJPhaO+A
	 lmbY0FPDXOGPyxu3zxMl3wWQNvTTQFg/XFvnkxDLrU9hilZylMRLOIq8Ok51AyPPHb
	 gG/SkltSzfopxA2OZEKUNnPMwm7yRzkDIdpgT50JWqac0AfghVwKiepX/vBJiZeIt4
	 TForixzpYTCE/yWviBY7xFIYcWvvTI6kVpEpa4QeaEAWmeeRiQWzLid82r/dBIi3jr
	 jmx+knbFUPt8KyNF5ODeMeZWK6ed4K3RkWBrZkYeld9geRCHIRXLRUK/P7w+NdPZBr
	 Vaf65+qDiiISQ==
Date: Fri, 16 Aug 2024 12:32:09 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, christophe.jaillet@wanadoo.fr
Subject: [PATCH rcu 00/14] RCU scaling tests updates for v6.12
Message-ID: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Following are the rcuscale and refscale updates for v6.12:

1.      Add TINY scenario, courtesy of Paul E. McKenney.

2.      Optimize process_durations(), courtesy of Christophe JAILLET.

3.      Save a few lines with whitespace-only change, courtesy of
        Paul E. McKenney.

4.      Dump stacks of stalled rcu_scale_writer() instances,
        courtesy of Paul E. McKenney.

5.      Dump grace-period statistics when rcu_scale_writer() stalls,
        courtesy of Paul E. McKenney.

6.      Mark callbacks not currently participating in barrier operation,
        courtesy of Paul E. McKenney.

7.      Print detailed grace-period and barrier diagnostics, courtesy of
        Paul E. McKenney.

8.      Provide clear error when async specified without primitives,
        courtesy of Paul E. McKenney.

9.      Make all writer tasks report upon hang, courtesy of Paul E. McKenney.

10.     Make rcu_scale_writer() tolerate repeated GFP_KERNEL failure,
        courtesy of Paul E. McKenney.

11.     Use special allocator for rcu_scale_writer(), courtesy of
        Paul E. McKenney.

12.     NULL out top-level pointers to heap memory, courtesy of
        Paul E. McKenney.

13.     Count outstanding callbacks per-task rather than per-CPU,
        courtesy of Paul E. McKenney.

14.     Constify struct ref_scale_ops, courtesy of Christophe JAILLET.


Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=rcu_scaling_tests.15.08.24a
(rebased on top of rcu.tasks.14.08.24a due to commit dependency)



- Neeraj

------------------------------------------------------------------------

 kernel/rcu/rcuscale.c                         | 212 +++++++++++++++---
 kernel/rcu/refscale.c                         |  67 +++---
 kernel/rcu/tree.c                             |   3 +
 .../rcutorture/configs/refscale/TINY          |  20 ++
 4 files changed, 245 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/refscale/TINY
