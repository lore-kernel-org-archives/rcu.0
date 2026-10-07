Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30B3B8D7B;
	Wed,  7 Oct 2026 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407043; cv=none; b=by47r2rs0gTRUri57sIBGBBwJgio8vQYnjcp37sPI1ytHC33yqnyKoAgy479bPrLwuKDt0TNXTcn3Xl2qV4OvrbEZ5avThCZ9ljT1e3cZvN15MdO3ndWNF5ogUFgDl6Xim2YuVk6tZ5lzV5WCCS2MZ58ZZqUcfrYZVxKGk610II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407043; c=relaxed/simple;
	bh=AwocqbOL6RvUCuJ+C9nxRUt8pj7Oy4xDXehIsc9IyMg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m53vfvUHxzGIjY696Og9jKrSHpzmGqFsAHyin+wR//ulYjn+/Y7OxDXmzYPPx4f89t1vgTKhpivtCaK0PzK7djK30U8YIfoH0+pi3TCwIJdOMA8G/ytWs8JCQc0lSFJT6R9L/d961foamPV4jAWoaw9YTYKLMLulAlpZ26XXyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXRHyTcL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXRHyTcL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856FE1F00893;
	Wed,  7 Oct 2026 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407042;
	bh=z00JDNuVlW7ZADmqoiRqosEpafug+NQNPSQOamOzknw=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=aXRHyTcLJ2znEFteux7jrcahnJh9dG35/t3K+si0mQ8/rEtMQWSxwByRgJztqkwqi
	 8PgUSE4YuCmAb8o/V/eKkXQit+aFUDJRshdJIKXB3wIFUVMmVpWfpojmyjEybfnnJH
	 VbP4vJh1uzbkaAnR4/K+0YbdtHCpZl52TfI1pC4xPXAm0L5itxrr5YE1pnJfE7zCN2
	 T5Kz5y0tO1xSMoaZVkNyLQL8x4dSbdMLHltb0SpPpuS51SFwkPrMk1+tBMqZmLinuv
	 qqN7pQ/Jc+g8CNj2PatHtgvU2UbJuY6TsZn5PdWcVWyV97mk7tgWt4ubGWf8ybZ6NB
	 26blJJNZxXodQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 328B5CE0D79; Wed,  7 Oct 2026 14:04:02 -0700 (PDT)
Date: Wed, 7 Oct 2026 14:04:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/8] Torture-test updates for v7.4
Message-ID: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
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

This series adds some torture-test updates:

1.	Fix divide-by-zero with fwd_progress_div=1, courtesy of Kunwu
	Chan.

2.	Synchronously wait for all rcu_torture_irq() callbacks to
	complete, courtesy of Zqiang.

3.	Allow specifying alternative ssh command to kvm-remote.sh.

4.	Fix kvm-again.sh re-run failure on ppc64, courtesy of Zhouyi Zhou.

5.	Add atomic SRCU lockdep support, courtesy of Kunwu Chan.

6.	Wire atomic SRCU into srcu_lockdep.sh, courtesy of Kunwu Chan.

7.	Fix double nerrs count in srcu_lockdep.sh, courtesy of Kunwu Chan.

8.	Add atomic SRCU cross-CPU IRQ context mismatch test, courtesy
	of Kunwu Chan.

Changes since v1:
https://lore.kernel.org/all/860880d0-fb46-4039-a47c-33dd42a215d1@paulmck-laptop/

o	Add patches 4-8.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcutorture.c                                |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-again.sh    |   11 +
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh   |   22 ++
 b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh |   39 +++++
 kernel/rcu/rcutorture.c                                  |  113 ++++++++++++++-
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh   |   38 ++++-
 6 files changed, 211 insertions(+), 14 deletions(-)
