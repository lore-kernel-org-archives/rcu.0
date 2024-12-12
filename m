Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DEE218594;
	Thu, 12 Dec 2024 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028769; cv=none; b=jZbXw5EmS/UXZbWHZLEFLxEmHi5Kl5SDUfnbOldGCxM3mXCCkxbmYuey22kAYDdpNkyC9qr/+pRtBhDfcGiyi0krWnqqHI1l3+2i8RYEHhHcAW8OBtZD/KMuEP2aYOFst96lBWKiMzziehEeYTLoyVeB9SjqMEJHPu3XgT/eo6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028769; c=relaxed/simple;
	bh=m590/Q5h4u9oEARMO6LLrWrWq41qWEexj/rHoT8zjDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d7hbfYP0il9Gi3+NUc1pOUxS1EaRSF4rIJdOGm9kxV9iBDGcytlCreoZsf+IOD/TQuK6T5qQg9VfCztKdZgTgs6eseGqmDaJpAfbUAcbMHBvwKlj+kMUjzVM1065NjKrjtrwlEO1NFgEDw2qd3XCR2BTVuPywQevtFuf5ZfqtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIEG7CcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIEG7CcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE34FC4CECE;
	Thu, 12 Dec 2024 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734028766;
	bh=m590/Q5h4u9oEARMO6LLrWrWq41qWEexj/rHoT8zjDg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=iIEG7CcXGUOIA4D3R66C1Fm4w2GC4BgW6IbLCvTp2o8riX80onPJPogtPN00VZzcu
	 ssA2avAwrRI8LMwyU3lCtC8jxAWyOkb0hNBhdpkUjfHnLUtdWI/LBnpBqEIYoTx+A6
	 vsBt6w7Nzk2O+w+RoECQ8VDY5ty2D9m9/D+chiI6dSecps7JPbea1E+/omiv3OnS/c
	 CrTuDkv4KbqakzsRgzbVP5QYgUDW/m/VzdRfNG6KGTNtvIEbPchrGvpNX7pOxRxQbg
	 EvRZMfAbjnEtCRJws6Qpiw1pCtJh6Lkooj3RoG0StxlfAhHTwXq4FVy+WlskIk+zeT
	 74jw1JqteDM6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6860BCE0EE4; Thu, 12 Dec 2024 10:39:26 -0800 (PST)
Date: Thu, 12 Dec 2024 10:39:26 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/8] Miscellaneous fixes for v6.14
Message-ID: <928b8031-2bfe-4c90-9952-7d331e027ae3@paulmck-laptop>
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

This series contains miscellaneous fixes:

1.	Report callbacks enqueued on offline CPU blind spot, courtesy
	of Frederic Weisbecker.

2.	Make rcu_report_exp_cpu_mult() caller acquire lock.

3.	Move rcu_report_exp_rdp() setting of ->cpu_no_qs.b.exp under lock.

4.	Replace open-coded rcu_exp_need_qs() from rcu_exp_handler()
	with call.

5.	Make preemptible rcu_exp_handler() check idempotency.

6.	Add KCSAN exclusive-writer assertions for rdp->cpu_no_qs.b.exp.

7.	Add lockdep_assert_irqs_disabled() to rcu_exp_need_qs().

8.	MAINTAINERS: Update RCU git tree.

						Thanx, Paul

------------------------------------------------------------------------

 b/MAINTAINERS              |   10 ++++----
 b/kernel/rcu/tree.c        |    3 ++
 b/kernel/rcu/tree_exp.h    |   20 ++++++++++------
 b/kernel/rcu/tree_plugin.h |    1 
 kernel/rcu/tree_exp.h      |   54 ++++++++++++++++++++++++++++-----------------
 5 files changed, 56 insertions(+), 32 deletions(-)
