Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5126D4F9;
	Tue,  3 Mar 2026 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582337; cv=none; b=DC2zFGHX5Cn51DArnEuiBAxMZWceIZmEMj4/qWUS4aDU02PovCAqrCKeEUiY1WXTqvjVjSetsebmHmQmtOB5Co/gA/NWhR4IiQ5BZ2bwdyl4g+xh126yVFip7mpycLcFP5imJbMO3ZQilwY+Ae2DBkQenot05KollIY2OJbT5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582337; c=relaxed/simple;
	bh=Fkx7dk1oetV28o1AJ3BAOAtAqATINe3ZX2yr02CWmLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VJ+scTs8O3YVcGHkqVwwvwRHhqTB0RrHH2MEvs3+OMVLuRp6LdeHMYiHyJhsGbk4GNa6SeO0uHKzQ2wvUOZeC/cX9xrSE6lamTGx3MNGD8S+mcp16mciRJTNEWh8PwkEB6kDvzEkvRusFSQy1DGMPVqj5x/O+WdqiXMFayUIyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY6KHC8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY6KHC8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492BAC116C6;
	Tue,  3 Mar 2026 23:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582337;
	bh=Fkx7dk1oetV28o1AJ3BAOAtAqATINe3ZX2yr02CWmLA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=JY6KHC8VifauP3E/QmN82L2T788T6+QFKKSir7doxdji+90J3W+gz77A5v2YFvzTf
	 gIAWu17Bm49pGxYrc3qnzxW/+3yDnXTpvQNZ9FKZN+8iBkmzPHPrwOK/ZtENfS5AnU
	 Xtwl/RBtI60ZgQ8StMotNvIkWp7Wt1rEeis5AcQRPYNI/xyhOegdeBi8raJ0GCdvlH
	 Ms/LdcYy7gvR6F6+2klqJ0E9H6hIcnjJlYYg7bplgrFEgsl2fLYr1TaMyUapcXH9Lc
	 G+E8tVZ2Rt8aUa1OTUKY/XN5rVFNVfX99PJG1DAQcV1Kp4lqNyFxIcDPH//mhA23VO
	 Khs109rsO6I4g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CB1ADCE0D66; Tue,  3 Mar 2026 15:58:56 -0800 (PST)
Date: Tue, 3 Mar 2026 15:58:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/4] rcu: Fix lazy-preemption regression in torture-test
 suites
Message-ID: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
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

As of v7.0-rc1, architectures that support preemption, including x86 and
arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
Attempting to build kernels with these two Kconfig options results in
.config errors, which causes torture-test programs such as rcutorture
to throw false-positive errors.  This series fixes this v7.0-rc1
regression by converting these scanarios from CONFIG_PREEMPT_NONE=y or
CONFIG_PREEMPT_VOLUNTARY=y to CONFIG_PREEMPT_LAZY=y.

Those maintaining architectures not supporting preemption might wish to
run rcutorture with CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_VOLUNTARY=y
because I no longer have access to any systems supporting these Kconfig
choices.

With all that said, the patches are as follows:

1.	rcutorture: Update due to x86 not supporting none/voluntary
	preemption.

2.	rcuscale: Update due to x86 not supporting none/voluntary
	preemption.

3.	refscale: Update due to x86 not supporting none/voluntary
	preemption.

4.	scftorture: Update due to x86 not supporting none/voluntary
	preemption.

						Thanx, Paul

------------------------------------------------------------------------

 rcu/SRCU-N         |    3 ++-
 rcu/SRCU-T         |    3 ++-
 rcu/SRCU-U         |    3 ++-
 rcu/TASKS02        |    3 ++-
 rcu/TINY01         |    3 ++-
 rcu/TINY02         |    3 ++-
 rcu/TRACE01        |    3 ++-
 rcu/TREE04         |    3 ++-
 rcu/TREE05         |    3 ++-
 rcu/TREE06         |    3 ++-
 rcu/TRIVIAL        |    3 ++-
 rcuscale/TINY      |    3 ++-
 rcuscale/TRACE01   |    3 ++-
 refscale/NOPREEMPT |    3 ++-
 refscale/TINY      |    3 ++-
 scf/NOPREEMPT      |    3 ++-
 16 files changed, 32 insertions(+), 16 deletions(-)
