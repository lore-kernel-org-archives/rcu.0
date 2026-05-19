Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790023B19BC
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225664; cv=none; b=H2ynl3ArKFphurBTLW0OgfOsqHbem9KUgynuI4/IhetYS+Y9qVdVUB5eFB5nox1j9WC6k6IU+p0KBIeJ/u0iRnV/C7H4I0xKvouTi7bYiTBjZUM0ed8U5UuexSqIZCyDAlmbT7INgx7AfZR9s3qu8QAdwUFX1uYs4ISyoTCcBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225664; c=relaxed/simple;
	bh=EAk1WrxePPAx7h3Z5Qlgoa9GYJf172cLd2Aela9HjQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ez8URwSeuA/sYPJiqhc9axJWOsB59EyWdSU74IZCcRpQV2Vvs9JY2v/h7MhqjgmhoDKxeWrOurAiNi2URUTPTWxVZu2iO5IJtcuWEvRzoVpUTdrDIyelwFNAiOrIccqnNLwCwIMT/NCNQhxfXS+/FZicPU4+bf34xlUWDyS16pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwOkiFY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwOkiFY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16FC1F00896;
	Tue, 19 May 2026 21:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779225663;
	bh=WrkeivS3aIITDGX/99oEuuwIA+pzCtjcVnFTD37iJUU=;
	h=Date:From:To:Cc:Subject;
	b=dwOkiFY3zKbMNJEOw5+t4yufurSzJUM69D3qV/SL74JWABaeLFliLKs6cIB8f02BB
	 IRY0RS59A8cRrsc1CAoc3MTDlX3+Nt3LBNEk9C99YXHKWOky1/auf6y5dLUhqyD96r
	 421qWbaxYevXT0muxAhW3T2R1+SSkXyGSIy6CCgoWD0683sw2cU6MFG1YemgGfxGkh
	 lqm2RE+ysuL8kOnLBHlNHPf+Vqwmue2PKf0ZE0wDNMNlLvZJeQY8JngQqWDpQ/WdhE
	 f8lTX71s6mQ1nPxaC9yX4de/2jciurrouyh4wJdjCYE+f5WWSFcgJv9e986QdpkWfB
	 NzHGP71mA8ZGA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 11BEDF40086;
	Tue, 19 May 2026 17:21:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 19 May 2026 17:21:02 -0400
X-ME-Sender: <xms:PtQMapCYXth4-YP3rrIrp-P8Ocmheeg1FP1KtmqJaBk94PweYH7P2g>
    <xme:PtQMasucmNJ0oDFalqRmqUl6evp2xSICbKbdZ2zEBMLGHAjLeuIPhq8hApQglAM34
    IWDKiQDo5frsb0RG3sqRA_oBwdS99R-iRaEKry2_mUty-JtdSnXHA>
X-ME-Received: <xmr:PtQMan-sZ3zaq1DU-Zla5IkSSn-3KriSJPYLfvkm4JOtzRKc15-Dsu8DTtv2bCW1Lf3lMmC63YIRLeSIhvdO7NuJDa4T3Z8K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedvkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeiie
    dvueeitedvudehheejieeftdfhffegtdeiudfhlefhtdetfedutdeuleeileenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvg
    hlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuhhrvgiikhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:PtQMajTLUOLUEL1zwTUy3_jEZNMR2lrvixlLPbHm4K9YgH9BKEZ90A>
    <xmx:PtQMapXQYkHmXVnBXUb9AZJpqCEULA5wh7dn4OAwg2Qym_RdejOq7g>
    <xmx:PtQMal8ttV7SD02CWLF6iAFdTNNuTaN_GP9y4KZCYzmnZGN3wm3egA>
    <xmx:PtQMap08N5InUvC3jMngxLluUgacrwL0YbUdnpvbk-9r7tL5p-5uEQ>
    <xmx:PtQMaqfx6m9pnNoXtWTr-eqUzBVeRDYrLVrulWYZR5hdUG3sdLji5q7a>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 17:21:01 -0400 (EDT)
Date: Tue, 19 May 2026 14:21:00 -0700
From: Boqun Feng <boqun@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
	Samir <samir@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [GIT PULL] RCU fixes for v7.1
Message-ID: <agzUPJ24ENDu37bS@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this fix into v7.1. The issue was introduced by a previous
fix PR rather than the v7.1 RCU merge window pull request, hence I'm
sending this "fix-on-fix" PR. The issue is because queuing a work on a
never-online CPU won't get the work callback executed, hence SRCU needs
to avoid doing that.

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.1-20260519a

for you to fetch changes up to 593889c401426004bd0ea0f6d4fcece728b03420:

  srcu: Don't queue workqueue handlers to never-online CPUs (2026-05-18 12:27:18 -0700)

----------------------------------------------------------------
RCU fixes for v7.1

Fix a regression introduced by commit 61bbcfb50514 ("srcu: Push
srcu_node allocation to GP when non-preemptible"): SRCU may queue works
on CPUs that are "possible" but never have been online. In such a case,
the work callbacks may not be executed until the corresponding CPU gets
online, and as the callbacks accumulates, workqueue lockups will fire.
Fix this by avoiding queuing works on CPUs that have never been online.
-----BEGIN PGP SIGNATURE-----

iQFhBAABCABLFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmoMy/EbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMCwzERxib3F1bkBrZXJuZWwub3JnAAoJEEl56MO1B/q4
lT8H/RlNu00LC24b0JxPYRBZJz3TSM2WlnGJQ+5LXSQgk2ecqzoTzwDE7oC3naPC
QDkwGpSif8Y5OKaEnlVavtDcHdNa824mKrgRo/nXkk5fqrrMMubHOHe5Y0fwy5z5
upPoEvEs0XtbW4Mm6lI4uRw+qvIH16+Ud9SMrfZMwLRGaO8axBXi3rijUtfAMRGv
xBFqJX15Z/ixWkA6aHGuM1fI4WdApUen4/W3oUC+Ka4Lpgtt29GmIOV3n/topNQq
R8bZM9QC+7f6Vk1s49ywD9WZYa1b4Pig74XDOXn3328kulGBxVtOnOz4sXMgBmBF
ZLvJ4xXy8+u1eM0DFcSExJCCvHc=
=PyvW
-----END PGP SIGNATURE-----

Regards,
Boqun

----------------------------------------------------------------
Paul E. McKenney (1):
      srcu: Don't queue workqueue handlers to never-online CPUs

 kernel/rcu/srcutree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
