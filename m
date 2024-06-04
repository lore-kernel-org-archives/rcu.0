Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F112DDAF;
	Tue,  4 Jun 2024 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540007; cv=none; b=uEcScCfbXarn9frEj7Qs6wF9X861GEnOKkf5UuKErRXqT/4yMyEP2jTLvEsSL2i70FsBPghE0o5w+EpUEXlx8K4FNGWsNf2uQlUIpmLU+KK/ApNuq+oleYVCHwaCvMWHfA4l6ej2uoQ5dtQezzfnu+r788fXWuKLJzR3PVE7iRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540007; c=relaxed/simple;
	bh=E5pBkIsLmuX2paxbz4CuZ2YfFtII+0ihcCURK98EYug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MAV8yYh5EEtXLfVvLZbc1QVGHG9853YAo4CWgKIIq8+UBPT0n9a7KgqN3gA/GiCYNFxA3SMtrBazXGrv+VDUKekMS3RviZtf/UZOz37rSZ0s0oxjcZuZFLe1y7ka+izCIlF1+gUDbIfmBnMhK8SAVbEiSsvuzjUwnv6Qvdzb+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQ4OPaNa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQ4OPaNa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2C6C2BBFC;
	Tue,  4 Jun 2024 22:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540006;
	bh=E5pBkIsLmuX2paxbz4CuZ2YfFtII+0ihcCURK98EYug=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=kQ4OPaNa4AVyjY7DorzFZXU4Oabx1igVsi5ETYvDDDFJn2OWiKTM6ydd2fqHEMiCP
	 WK6pul7AUUQLKGbPUteLm4/cYenme/fd+ov5HRpbFdJCdvpAx5EhlvTmpEhMtM8kUQ
	 ZkpcH8jUseO3IIXUw3X7qQhuHijmRUzj5f8Vx6lm0SB/ul1pcz/DfeWYL9scKoT6bB
	 SzeeqoGUQr3fyX5i37uvKPecu40yVsPvmk9Hg4WVlxTooDm58J93m3rs1TL/hHPb+k
	 sFsyrfGP4oncJCKsZpn4ggF/gXzHTIvifIqyImD0IxWkwushIWcfCgdooFaFKf7Pxt
	 GtqwOQXmBJ/Vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A386CE3ED6; Tue,  4 Jun 2024 15:26:46 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:26:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/6] Grace-period memory-barrier adjustments for v6.11
Message-ID: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
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

This series removes redundant memory barriers from the grace-period
code paths:

1.	Remove full ordering on second EQS snapshot, courtesy of Frederic
	Weisbecker.

2.	Remove superfluous full memory barrier upon first EQS snapshot,
	courtesy of Frederic Weisbecker.

3.	rcu/exp: Remove superfluous full memory barrier upon first EQS
	snapshot, courtesy of Frederic Weisbecker.

4.	Remove full memory barrier on boot time eqs sanity check,
	courtesy of Frederic Weisbecker.

5.	Remove full memory barrier on RCU stall printout, courtesy of
	Frederic Weisbecker.

6.	rcu/exp: Remove redundant full memory barrier at the end of GP,
	courtesy of Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst |    6 +--
 b/kernel/rcu/tree.c                                                     |    2 -
 b/kernel/rcu/tree_exp.h                                                 |    8 +++-
 b/kernel/rcu/tree_stall.h                                               |    4 +-
 kernel/rcu/tree.c                                                       |   19 +++-------
 kernel/rcu/tree_exp.h                                                   |    8 +++-
 6 files changed, 26 insertions(+), 21 deletions(-)
