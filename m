Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33E226D1F;
	Thu,  8 May 2025 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747743; cv=none; b=TuAWcMBjq+LyzbGdp4WXl/iEM4DT6RC01e07RKeo4sDzhDN/zkZh4QT3/XKJm+V08kMemF79kqnI0CwpYklv2R5MIVMBnbGbkLvzHM1b+CCtlQGC2nYhKy1EdpSA7OVoPsbLFVoyO3tkKZci8Of1VXwEpGRaCDN6WE6pPpgJ2/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747743; c=relaxed/simple;
	bh=Q3j3Y4xw7S4ia+wnONYW2EEV29BaZCbBzImhzNQrnKI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nhrCZtC5mfY2SVFw01bgEvDwrux0yDWObX9rgqfxRT6cA1dZh0nYBVhaYfL77fhMygCkHSXYirh+wQHf4QG8SLncJhaozk/8CFFGii8n0vqlMGjYD4HQT1XY811X5PuVIE3Q3Yn2F6zP1reJjb2dbpk+SIT1i2LxlNtw7CNBLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+xRi2WZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+xRi2WZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436ECC4CEE7;
	Thu,  8 May 2025 23:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747743;
	bh=Q3j3Y4xw7S4ia+wnONYW2EEV29BaZCbBzImhzNQrnKI=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=P+xRi2WZaH6dfSWH+ZmpsEKHKl36JGZBiw3vOnxFtgpuxOUBiKwXnWoYBW9FCDBHc
	 eOf4B8WLPMc04b8c/M7albeXP3b3WOjIyFv4NvvDiTl4b4tLNj3xKqExPTO5gbNb7A
	 5jsGWF6sKPs4bFpiXrJECZOq7npaD5JKZf2BjznZhrLn6MuexTGbuz5uwaI/uKjFQj
	 aN2gkkRkyWBi9ReCEzFtFcZsaI5yJrrxGNxJ5diYblk5tEnqaiBeczyfwa4stSTYU0
	 10LWJOkeDweKOPSMUbYxlbg4Jv71pP2mSORU1MePXUxgSNz8uX+BZVLg05xWhHAVIF
	 OBAR9R6NnbyZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D98B4CE11A4; Thu,  8 May 2025 16:42:22 -0700 (PDT)
Date: Thu, 8 May 2025 16:42:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/3] Make rcutorture safe(r) for arm64
Message-ID: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
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

This series makes a few small updates to make rcutorture run better
on arm64 servers.  Remaining issues include TREE07 .config issues
that are addressed by Mark Rutland's porting of PREEMPT_LAZY to arm64
and by upcoming work to handle the fact that arm64 kernels cannot be
built with CONFIG_SMP=n.  In the meantime, the CONFIG_SMP=n issue can
be worked around by explictly specifying the TREE01, TREE02, TREE03,
TREE04, TREE05, TREE07, SRCU-L, SRCU-N, SRCU-P, TASKS01, TASKS03, RUDE01,
TRACE01, and TRACE02 scenarios, preferably in a script.  (But if you
want typing practice, don't let me stand in your way!)

1.	Check for "Call trace:" as well as "Call Trace:".

2.	Reduce TREE01 CPU overcommit.

3.	Remove MAXSMP and CPUMASK_OFFSTACK from TREE01.

						Thanx, Paul

------------------------------------------------------------------------

 bin/console-badness.sh  |    2 +-
 bin/parse-console.sh    |    2 +-
 configs/rcu/TREE01      |    2 --
 configs/rcu/TREE01.boot |    2 +-
 4 files changed, 3 insertions(+), 5 deletions(-)
