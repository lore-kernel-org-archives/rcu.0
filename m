Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317913D8A4;
	Mon, 31 Mar 2025 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454973; cv=none; b=sY0qE+SJ8Kq5CO6A0JW2dODyqk87cLR50ZqQ95M2+eW3Idiwyev4uVmlCEXn+fjFJPlDfoqRGrfd3OjcgxUIkLCwCIy1e6LuQUzTje+5O0Wsx3C+Pr3QFiFAuAID+89Hc3u8TOGFliEKb1fegXzcKctxRSFB4AeccNFAfn3ufpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454973; c=relaxed/simple;
	bh=t1ETvX/5KhXpBYV8/OM2rYecAjh1T3olK3c+gBWOcd0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jy5ZbR9v9kPc2IeTchFjmxd3Vgv7OWHqX0xXGnZtp2TKLQeirYEi9hvf3KfV45fkO05asndjqGJXGa3xQ72+fK62UOIiQ3H5dOsXsIVH+pYp8B8ySiDx/e80MGMgGxqDcmKq6vBxdn5ZfaxqztaWt/f6FekkqDTyeueEQ4hea30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNmPZn29; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNmPZn29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9C4C4CEE3;
	Mon, 31 Mar 2025 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454973;
	bh=t1ETvX/5KhXpBYV8/OM2rYecAjh1T3olK3c+gBWOcd0=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=lNmPZn291Bvp1pb+Pndkuy1/FVmq+EXW5wSwT/q1weUJZ4OAfKv5LPH04XkR/R4Iz
	 vFxuB/JLdbL6JxX/ys722zeP1boJO4KAkXMtExv70CPN5pv8T1cBqiPNZM/Qk8eVXP
	 WLTWSLzxcqC3GvT5NlE53RpJ8Mj7NfDuYCWyzg+8aFtvdMrPoV5ASNS2BIw6IPNppW
	 y+km6W2NmSMb2QF69KT/qMg3yP2RnTRnZ+IdcKxN0lWz+IJ7jORn4quuSOmMUQ73tK
	 5LsxWWUTznKbzmMy+UZ+j5ntAX7644iZIxKX5/q0DlseTgFw+vhAUHFKPvq+9oKG5P
	 6XjounHTrEhow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C835CE0869; Mon, 31 Mar 2025 14:02:52 -0700 (PDT)
Date: Mon, 31 Mar 2025 14:02:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/12]
Message-ID: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
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

The following series improves testing of SRCU-fast and SRCU up/down,
deprecates SRCU-lite, enables torture.sh to skip non-debug testing,
and adds testing for Rust's RCU bindings.  The Rust RCU patch is very
much in RFC state, but I am posting it anyway for wider exposure.

1.	Make srcu_lockdep.sh check kernel Kconfig.

2.	Make srcu_lockdep.sh check reader-conflict handling.

3.	Split out beginning and end from rcu_torture_one_read().

4.	Make torture.sh --do-rt use CONFIG_PREEMPT_RT.

5.	Add tests for SRCU up/down reader primitives.

6.	Pull rcu_torture_updown() loop body into new function.

7.	Comment invocations of tick_dep_set_task().

8.	Complain if an ->up_read() is delayed more than 10 seconds.

9.	Check for ->up_read() without matching ->down_read().

10.	Deprecate srcu_read_lock_lite() and srcu_read_unlock_lite().

11.	Add --do-{,no-}normal to torture.sh.

12.	Add testing of RCU's Rust bindings to torture.sh.  (RFC)

Changes since v1:

o	Apply Z Qiang feedback.

o	Add SRCU-lite deprecation, torture.sh --do-{,no-}normal, and
	testing of RCU's Rust bindings.

https://lore.kernel.org/all/4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop/

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                                |  124 ++++--
 b/scripts/checkpatch.pl                                  |    2 
 b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh |   11 
 b/tools/testing/selftests/rcutorture/bin/torture.sh      |   12 
 kernel/rcu/rcutorture.c                                  |  298 ++++++++++++---
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh   |   31 +
 tools/testing/selftests/rcutorture/bin/torture.sh        |   75 +++
 7 files changed, 457 insertions(+), 96 deletions(-)
