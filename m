Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DE3C661D;
	Thu,  7 May 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173032; cv=none; b=t3SEnxd9aF/vF1PaFjFaNhOPxk7J2PRmiK7bHg+/as4lPrIh4BhjrzMNJR13JhNFNGFm1dpVYpTBAXxCaSVo8fv2MUFBRGjyOS0eFp58iUwwsRbbpAOC2OkHIzj7rOKbDWKsLYiNNzK/6oewg4jMfRewDv7wfZVsuFY1I48J0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173032; c=relaxed/simple;
	bh=fjyrw8jM09vOQmrVZ4pSiRBMzwlus/4BVWkDHv51bLw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hySdWSn9LD/NjAW9YCTneheSsoJhaosm7WLpXQ3aykqOC0fvRDsHlmuFBgKx7Ug7QnjZevUCxmkKYrwNMJICvS0+0cZnMG+upp6LiIs68X/Jle20fykz0FNLANtG6O1O6l6gBYuRH+bw/a7jnvTBitWbzurR3AFGdAPQMJLazLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiBDm/uU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiBDm/uU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD1CC2BCB2;
	Thu,  7 May 2026 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778173031;
	bh=fjyrw8jM09vOQmrVZ4pSiRBMzwlus/4BVWkDHv51bLw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=MiBDm/uUhDiULzYaSGFq5W4NYapiS9pfY7F6q68/ptIB//ClFd6T9/xgXRAyEh4dC
	 eoRyzN0jozXqlqegstOCzbXUMFZXe8QoTVi97qyAitixpTJBX1FixzaI552NGxr58y
	 LaCSNDDuvc5n0fptXM9W3Rn/LbeIG3I2797Kko45xF+kCWAfDUwSAfOkXgc42i66Mv
	 Tohfc25yjE3Z9b2fxpLuPOyCr1c7lLrWgYBgmmCfn1oVlm84qv/zVGX8KTMXlBetRZ
	 FABnlQgozOn97vK6eAsdyw25CQWHEDa7uEyHiu/thHpCFnY6jRK3j+6Ur23Pi8fdpa
	 m4FzloPJ4pODQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 768E4CE0863; Thu,  7 May 2026 09:57:11 -0700 (PDT)
Date: Thu, 7 May 2026 09:57:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/4] Torture-test updates for v7.2
Message-ID: <1e506157-35a8-4ea9-8bb6-cfe899d81e6e@paulmck-laptop>
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

This series contains torture-test updates for v7.2:

1.	Fully test lazy RCU.

2.	Add torture_sched_set_normal() for user-specified nice values.

3.	Improve kvm-series.sh header comment.

4.	Allow "norm" abbreviation for "normal".

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/torture.h                              |    1 
 b/kernel/rcu/rcu.h                                     |    7 
 b/kernel/rcu/rcutorture.c                              |   21 +-
 b/kernel/rcu/tree_plugin.h                             |   32 +++
 b/kernel/torture.c                                     |   16 +
 b/tools/testing/selftests/rcutorture/bin/kvm-series.sh |   11 -
 b/tools/testing/selftests/rcutorture/bin/torture.sh    |    2 
 kernel/rcu/rcutorture.c                                |  160 +++++++++--------
 8 files changed, 168 insertions(+), 82 deletions(-)
