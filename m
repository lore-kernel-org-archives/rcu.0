Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D8E2D23BC;
	Thu,  7 May 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172654; cv=none; b=ayyXYySU2QVfT/huRzaJJDf8A4xh0Ho3fQBGKBZThvBrx+GZ7emDuHtcmIv7JHWh5Vrb1Ot2s6fNbnbsD0ES03K+cWYAy5PJQfN1trGKIlt3rLqGfEuLW6z+Er95tJ9uPQLbYyvlSUfXsVCf8zHVBF3DQ0BYgcuF1oT0rpzXaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172654; c=relaxed/simple;
	bh=P4gCRhS0yugD3yTyeEShI7IEIHxqhCnyGRyX9BrMEWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SJtYBdVIqpprtxIkaJFkw4LkfFY+VD04wUyvJ3rJHX3wQj2v/C+447GAOvd+vPH/5TmTrhWeLKinGM1urAkb25MUBPft52qmg2n66tI0+qpEM0sZUOqU74M+w/HD9H1ZYc2v1uDg+aI5PDsIR8PLVZy391vJHcvkKuUnd8AI7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4h1WW0T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4h1WW0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88D7C2BCB2;
	Thu,  7 May 2026 16:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778172653;
	bh=P4gCRhS0yugD3yTyeEShI7IEIHxqhCnyGRyX9BrMEWM=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=t4h1WW0TM5MbWGCeyxM9GAwJtgsu4QuxGre/xxi1PaDj2YH7O02O9p/yfrJ88bILq
	 XJ87Ni9+ws9XPQLRMdB/e9WrP5ed9mwkwqIdVSg9O8twktjySLMwdgUVfCU0FSqbH4
	 h9+KhwEjO1Odkxv0H9wsIMW4IBzPLUYfa9CyMLv+k1fO6mOUlcs61KVP9ReUj2SKWs
	 RqnFArlC3t898AgXJ02A978DRaogrMPzpZQGjJ7yaBoupYhhuL0vnVvWa8yVPOHaaW
	 1ABwh6lyZsH6sQ/uK8gQGNDt7jDI0kNAMG08ZSVvrzA7zK1uXbT0G16TbmQ/Ek+dvp
	 dSgVBPE07EgcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 68B25CE0863; Thu,  7 May 2026 09:50:53 -0700 (PDT)
Date: Thu, 7 May 2026 09:50:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH RFC 0/4] Hazard-pointer torture test
Message-ID: <5bfe6ac9-432e-43b8-8290-59ca249b0f80@paulmck-laptop>
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

This RFC series is the beginnings of a hazard-pointer torture-test module.

1.	Add a hazptrtorture.c torture test.

2.	Add testing of on-stack hazptr_ctx structures.

3.	Add microsecond-scale sleep in readers.

4.	Enable system-independent CPU overcommit.

Future extensions include cross-kthread and cross-context hazard-pointer
acquisition/release, along with who knows what all else.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/torture.h                                            |    2 
 b/kernel/rcu/Kconfig.debug                                           |   12 
 b/kernel/rcu/Makefile                                                |    1 
 b/kernel/rcu/hazptrtorture.c                                         |  684 ++++++++++
 b/kernel/rcu/update.c                                                |    3 
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                      |    6 
 b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST           |    2 
 b/tools/testing/selftests/rcutorture/configs/hazptr/CFcommon         |    2 
 b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT        |   17 
 b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT.boot   |    1 
 b/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT          |   14 
 b/tools/testing/selftests/rcutorture/configs/hazptr/ver_functions.sh |   40 
 kernel/rcu/hazptrtorture.c                                           |   55 
 13 files changed, 823 insertions(+), 16 deletions(-)
