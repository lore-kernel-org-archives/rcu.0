Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886CF36A02F;
	Sat,  7 Mar 2026 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772906720; cv=none; b=QLBLUd2A0HIJ3cY8TapiWjqWI2C+TMq5d3VQBPBP7n7416a9lEVLvWbdeC8CN6FhCPN7ok8+rDYSUwR/XSU+Nf8KlFrCH9267uEuxDhxa4kreZEc3otGrWdOf/KfdImhQ+wZEG7Vdjx+hCKGJpiG9b3FsTHyPYNmZm0X6sII/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772906720; c=relaxed/simple;
	bh=jpk9u+pxRBXT72tLng1b4+HJ8DuOZZ/GJ9on8jrHuoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bYqgqHsCqq6NZNZc9AIORduSfsvzda6q3kZFhyocrY+cljDqyfJ54418m8+UGvp5MBcdGkcx2E4MAvmM9SJJgW9ycEC7a73m6Pbeks/YZMZtTdRBuZA8CPPpR9HpyVvAmteCrE1hpqYf4fmXcceoIZBzX967H5sEzSkttuhbDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhCkXRWy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhCkXRWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4022C2BCAF;
	Sat,  7 Mar 2026 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772906720;
	bh=jpk9u+pxRBXT72tLng1b4+HJ8DuOZZ/GJ9on8jrHuoA=;
	h=Date:From:To:Cc:Subject:From;
	b=mhCkXRWygDHODEx8zcGbNr6gdHrs8xB6EkRKyA4fta1w6PfryYaCxRu+LBpr3ngbx
	 wbbe5x0MnvT6A5+PLlBSbh7/g1KOdHRupFOtOoeE1YrGrOkdYEdShRuC9KPdabVrcs
	 FDqBptKndGvkcv7xmLAOrfZ3vcrC5NcV9zZCQzfQMBOgax5itwbrKbjNnydmbZmkOn
	 RVlBTbBCqN7B4KIuSmtuXtfF8JX6pyZ4+AyCq6cStNzpoRpHkBbZGJ/A1WZJUkiEJU
	 nGs8zDRzyL7EDsqqK88+aufrC3Qm0BkszzmYPqFppsumWSoKo8RXcjjimcUUXu9lsP
	 PsK+zeplOqUiw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id E031DF40068;
	Sat,  7 Mar 2026 13:05:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sat, 07 Mar 2026 13:05:18 -0500
X-ME-Sender: <xms:3misaZFTWhP70JFAe5wafGJXLUWqnG2OgBmzSTwq_9n5tF8wI9lakA>
    <xme:3misaclgro5gkRKIE5Y9xsa9M7u60ahPNlY_PXe0LE7VrEO-xBys_dDp3QNUR57nc
    Do0OeMFPAqzZDEVHETcNZS5tFIcFd1QjmuAUNC8Hszxm92Gsmo>
X-ME-Received: <xmr:3misaUcPzumyf5n2DVU3qw7Uh_3srgKZv3HV-p3qibiUr1wQvJHpY2i3i5HSh_H2jWU-XdNWbGqResUa8fRmY_kE77NkNL9p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeiie
    dvueeitedvudehheejieeftdfhffegtdeiudfhlefhtdetfedutdeuleeileenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrhhnvg
    hlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    ohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuhhrvgiikhhise
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:3misaSEez0yDkk_Falj9fXKKRBROYqRGE2cMX_iENiCHj0P96p4Pag>
    <xmx:3misaSiVeP3Fp_U2Bh4pkrH0d7ey9yRSIY9S0XJCETSgrixIk6TZ8g>
    <xmx:3misae3cajA4kVRvm7t59Di0Xm63vva7xVTZ3eNQDJuk9vCZYlC3Aw>
    <xmx:3misaVc4ypjES6cYPqM3G4CRh7AZkzq5OnGd7maFU3mLUNGkZnDkPQ>
    <xmx:3misaUxkmlFd8YwtRh98DIJZTEAfkBPfqJZ0ysecHWmBnay9KSOkfw02>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Mar 2026 13:05:18 -0500 (EST)
Date: Sat, 7 Mar 2026 10:05:17 -0800
From: Boqun Feng <boqun@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [GIT PULL] RCU fixes for v7.0
Message-ID: <aaxo3f8V-IM8WGpf@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these RCU fixes into v7.0. The issue is that some
pre-defined scenarios in RCU torture tests have not adjusted the recent
PREEMPT_LAZY kconfig changes. I could have found it if I ran rcutorture
against linux-next, will do that next time. Thankfully Paul found and
fixed it quickly ;-)

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.0-20260307a

for you to fetch changes up to 78c2ce0fd6ddb6c87aaa56b0d49c70e17df21e6d:

  scftorture: Update due to x86 not supporting none/voluntary preemption (2026-03-05 13:11:10 -0800)

----------------------------------------------------------------
RCU fixes for v7.0

Fix a regression in RCU torture test pre-defined scenarios caused by
commit 7dadeaa6e851 ("sched: Further restrict the preemption modes")
which limits PREEMPT_NONE to architectures that do not support
preemption at all and PREEMPT_VOLUNTARY to those architectures that do
not yet have PREEMPT_LAZY support. Since major architectures (e.g. x86
and arm64) no longer support CONFIG_PREEMPT_NONE and
CONFIG_PREEMPT_VOLUNTARY, using them in rcutorture, rcuscale, refscale,
and scftorture pre-defined scenarios causes config checking errors.
Hence switch these kconfigs to PREEMPT_LAZY.
-----BEGIN PGP SIGNATURE-----

iQFFBAABCAAvFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmmsZu0RHGJvcXVuQGtl
cm5lbC5vcmcACgkQSXnow7UH+rgNWwgAn1bIWDIWQR9CkRQ0grhdO+pPfLusbVg/
Y7H3SsdEX03meSunA/IVGejP6Qbanuab9nyHdv3WxxowpCGYBaLFPvklSfcBWYeZ
4lxi6Fj+2rrzvOnQ54Pk5i4v5VayxEo12XBIgx6HDV7+5LgWk0gU0LpWPUhEWYYR
z/zJ/XbcLr8e9tZVwAWZj/ShLUH301razC2SaR/OlS93zqRG9Sd251Knjqq/lEwI
T6RZfhT2Wz3bgqU3QcjxDWw5dhB0/Y9wKoJjx4bB9m8lnSt+o96gH40TO+lnllnS
T4OHjqK1J1fUXNLzQufyfKKAiwi/LBBc9H4pe4tiLFxg0fg5s21flQ==
=NBys
-----END PGP SIGNATURE-----

Regards,
Boqun

----------------------------------------------------------------
Paul E. McKenney (4):
      rcutorture: Update due to x86 not supporting none/voluntary preemption
      rcuscale: Update due to x86 not supporting none/voluntary preemption
      refscale: Update due to x86 not supporting none/voluntary preemption
      scftorture: Update due to x86 not supporting none/voluntary preemption

 tools/testing/selftests/rcutorture/configs/rcu/SRCU-N         | 4 +++-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-T         | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/SRCU-U         | 4 ++--
 tools/testing/selftests/rcutorture/configs/rcu/TASKS02        | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TINY01         | 4 ++--
 tools/testing/selftests/rcutorture/configs/rcu/TINY02         | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01        | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE04         | 4 +++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE05         | 4 +++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE06         | 5 ++++-
 tools/testing/selftests/rcutorture/configs/rcu/TREE10         | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TRIVIAL        | 4 +++-
 tools/testing/selftests/rcutorture/configs/rcuscale/TINY      | 3 ++-
 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01   | 3 ++-
 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT | 3 ++-
 tools/testing/selftests/rcutorture/configs/refscale/TINY      | 3 ++-
 tools/testing/selftests/rcutorture/configs/scf/NOPREEMPT      | 3 ++-
 17 files changed, 39 insertions(+), 18 deletions(-)
