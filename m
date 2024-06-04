Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507528DC7;
	Tue,  4 Jun 2024 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540497; cv=none; b=REXxAbli1p+XtDfnWqhp5oXwTsOsfkFLHIuvRBd8ueRHhWq/tp3IIHiw2g2yTyEYlGIc91Jq7xxMojNhzW4caPaNuXxFtCfuBJzybiPonq7gU0TcyaBpq5rIed4n+vjycNjeSA+sMe8QK7EUVxAHTB9MwllFxUzJelXpS459vy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540497; c=relaxed/simple;
	bh=8nlsMakZOD41byG7zmL3ZeTqvoduyu8PHT5Tek+AnS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KoU7DyhE4x2ZSAFV0xek4y2S7fYsjBWqbdMblVNL2mI+QHLeU5AgBtj3tsxhuJkesfqLjCKXMhU36jjZQXwDiZIY/9mIUqSpMnaND4HsQhsuWgH5jN1QOENGSKCv8kHTp1W+Wp+QHMxAWiPl5CIMUvqcuf+ztyvfAQg1Fh3IBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fF4cU6OF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fF4cU6OF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A96AC2BBFC;
	Tue,  4 Jun 2024 22:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540497;
	bh=8nlsMakZOD41byG7zmL3ZeTqvoduyu8PHT5Tek+AnS4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=fF4cU6OFuKUyTt5UBJt3jIOxHc0tbsn41XmgUxe85LV3w6+tk+3pCzzkxwnKaeMTF
	 Xhv5BT1S6gZas1c3Y0wQJTe42K3F7e9agKdpE6mJ1JrRX+G/YogJq1Gg/y60wYLvHw
	 OgtDoz8Xqa0343np3jTqAf0UZKPPzXq2Uj3HhVQVnGg8chPBfAHhKuedRPE20Jm7sP
	 e10YtYC2VXaiJYUUYA+gMTn9QcvLXyZN/apWQCooKuL77fJCm7LoqoWhZEEb09LKYu
	 PiIZWYGAVgHH5M9144Hi3ohDvNeQqX67MyNWuBpB5RiZlfNKXUne5vuENHFoilkErW
	 NAvgGYQJLRhJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9434ACE3ED6; Tue,  4 Jun 2024 15:34:56 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:34:56 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/2] RCU Tasks updates for v6.11
Message-ID: <e3f5a71d-09ca-4882-a7f1-5680ad28c8c0@paulmck-laptop>
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

This series provides fixes for RCU Tasks:

1.	Revert "rcu-tasks: Fix synchronize_rcu_tasks() VS
	zap_pid_ns_processes()", courtesy of Frederic Weisbecker.

2.	Fix stale task snaphot for Tasks Trace, courtesy of Frederic
	Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    2 --
 b/kernel/pid_namespace.c   |   17 -----------------
 b/kernel/rcu/tasks.h       |   16 +++-------------
 b/kernel/sched/core.c      |   14 +++++++-------
 kernel/rcu/tasks.h         |   10 ++++++++++
 5 files changed, 20 insertions(+), 39 deletions(-)
