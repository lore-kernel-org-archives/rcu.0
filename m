Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453717A2E8;
	Mon, 10 Mar 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631883; cv=none; b=bTz2lSvyZ4XYqY3VPQX9m+kpf+Ed5hOS5qw5cmOXS6jiSuCo7AOLr0n4aAWDtqXdJ738UxHEUmnjU6M8fG4LEMC9WvSzM9DqRUktsruuYb8zQi3RJ11DwARRbBTMrrhsJcllyAClPkfBrxebvsuY4OXIKeEQkvBPoF+qx5blFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631883; c=relaxed/simple;
	bh=LVB/LqaahZ8gGbPqHcZJ5mQIkiJOmxQolT0W/AYlvZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nTe1WGIUmuEDSNg7QQcpLywB0bDQ77573L8GfE8b7KG8vXeMDOQbgynUYqneW18Oh8WC7qWFmAlaA6jG2ot/PFPTBkkoUxZxtibpPai7D2T6XJNdfhxdqw76MSs+CuuxcntI/q0RsAeDEdnx9PAU68R6XfVzAHfrRg1SvXtUdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQpdnkA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQpdnkA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CE2C4CEEC;
	Mon, 10 Mar 2025 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631882;
	bh=LVB/LqaahZ8gGbPqHcZJ5mQIkiJOmxQolT0W/AYlvZs=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=rQpdnkA7yyTigYWe7XQTYKESp7rRfhfcgobb/yUGEsPaCUp28CwgFsd9kwIsgz+O7
	 yeVcVh271D6h1LkAfjCZ053X24C10cSw+hTdanUE7b2589IdadYI68aETIN2KMcgwC
	 uM8iSnw3FIIkcoY/zWFtlZRg2PtoSh7VcPv07dAW5FxAcmhSx1yzd4XfBflHXik4pi
	 KyNABGQ8HPk/aP5oj0jqGSXGncjVsbIrGzHr4VEMBp2ug4VWcnky6KGMRIUu6QXQ4P
	 utDZRw5GxCzes6N57+67Odz83kNIHJPgFuIaXznMytn8hBaHREsIA9GeByFYhQFfUJ
	 LlNwRp+auGyzg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63B67CE079A; Mon, 10 Mar 2025 11:38:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:38:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/9] RCU torture-test changes for v6.16
Message-ID: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
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

The following series improves testing of SRCU-fast and SRCU up/down:

1.	Make srcu_lockdep.sh check kernel Kconfig.

2.	Make srcu_lockdep.sh check reader-conflict handling.

3.	Split out beginning and end from rcu_torture_one_read().

4.	Make torture.sh --do-rt use CONFIG_PREEMPT_RT.

5.	Add tests for SRCU up/down reader primitives.

6.	Pull rcu_torture_updown() loop body into new function.

7.	Comment invocations of tick_dep_set_task().

8.	Complain if an ->up_read() is delayed more than 10 seconds.

9.	Check for ->up_read() without matching ->down_read().

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                                |  124 ++++--
 b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh |   11 
 b/tools/testing/selftests/rcutorture/bin/torture.sh      |   12 
 kernel/rcu/rcutorture.c                                  |  297 ++++++++++++---
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh   |   31 +
 5 files changed, 383 insertions(+), 92 deletions(-)
