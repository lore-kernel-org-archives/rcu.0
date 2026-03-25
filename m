Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421435DA7B;
	Wed, 25 Mar 2026 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477734; cv=none; b=SHhi7swGhuvF06dOiR0tikC4lcwBqX3clUfaXxQ797pNL+XHCLZ9lmNTPmAaBY0LwEmDafj/5sbHxSFBWBH0zlFDXgmRCJ/VgFnw2szQzz+EC0S8yWqoccHjzG9JOv5rkPcyDELAVgbRqx1/xTFbai3gsLHgY+ov1NYvUXFepP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477734; c=relaxed/simple;
	bh=xAg5Pmw9F0z0rdaUjitxwPabnZd5rFsPs3FpzlmAyAw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ehKFqU7NGNneCukSPlrP/OMDrGp964D+/Yw/DtV18DyoPojf/9Oq/++oaS9GlvFmueFkrKbJu69rsOKTjgtMvLKZxSQ4yxzVRWW/pjM1d25HU7bsQsj7AoyIvbc+Ey+5OoYLmWTP/NGCZHvF6IT+t187jz5buWvXahNIFm3Mj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYBGMAVw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYBGMAVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120E4C4CEF7;
	Wed, 25 Mar 2026 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774477734;
	bh=xAg5Pmw9F0z0rdaUjitxwPabnZd5rFsPs3FpzlmAyAw=;
	h=Date:From:To:Cc:Subject:From;
	b=hYBGMAVwEH1wBd7y3CLq6bpzNdYQf25GLcQrziIFcjlwQsjz51cxObIHmZ5Wv0kw7
	 jQJwyVM9w3aDDRIEDHnYKTxa8CQMHgqp/LAifvMR2pGFrideDn3JY+WS8lUitl7fvZ
	 evxBOF/mXFsG1P2LbzvKiTKMf6/zgMXUww2QReZ4MjJe02dptADEuxy+mQWvhUWlU0
	 qBu9iCz292jewcveXyrHZ/fLMjdRD0tcmZ9ZdZ4unupUuLzC6av0qsa2AqFxoQbZFj
	 kobjU/Zo0u+ufRfRobuW5uc0Hy+R98zInvGytkbZlDRSuKt9X7pGRoqiFjPrFtgUY+
	 Z64eON04toUNQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 14CF7F40074;
	Wed, 25 Mar 2026 18:28:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 18:28:53 -0400
X-ME-Sender: <xms:pGHEaYo6M8b2UoVRgplUe3cNlLOXRvtRUR8Gi6ePyM9C3yO6WycAZg>
    <xme:pGHEabU0ShvZQh0Aol_2EbNheohRiIBA6rAJcADMV1BidFamjIz0ijlp78f1psxrZ
    DfLqDK3RnTPoPsk5Olgb1qb_kPoBY-vCrORdQAqCxfW3llkR9NeLA>
X-ME-Received: <xmr:pGHEaRHyvFDQAPeLCjm-bOpr9qGgYdplYahvpb2TFvl3GS2A0YQgEVplegg6RqfMZHJXrATejycJO4ASBeIT6DHTHdXeCjWL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehieeiucetufdoteggodetrf
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
    hrghdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pGHEaaBKYKW5XZB_d5IlnrWHYRf-y2ICO_nDzbP3sTzSQBK1b-wB0Q>
    <xmx:pGHEabzTAkCyYkniXcUF821Egq2Nz9bHtFQ4ZjSJEeDxJMIXt_qZkw>
    <xmx:pGHEaYdWPzXYIcxG3BuupNu_JD8olhpXEiYM7AAncQlR7e6PgogerA>
    <xmx:pGHEaYupk4m2cyIj9zmTj6dDU6R5GUcmbis5tsK6R7_vjSSPgtSM8A>
    <xmx:pGHEaVBRdLL9F1Bc77mKtOdgXMG_S-2evIN2iYikjZL0-jJYdxdPsLhK>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 18:28:52 -0400 (EDT)
Date: Wed, 25 Mar 2026 15:28:51 -0700
From: Boqun Feng <boqun@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf <bpf@vger.kernel.org>, Andrea Righi <arighi@nvidia.com>
Subject: [GIT PULL] RCU fixes for v7.0 (part 2)
Message-ID: <acRho9L4zA2MRuxc@tardis.local>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This is another set fixes for RCU in v7.0-rc, please pull these into
v7.0. The issue is since we replace the Tasks Trace RCU in tracing
(e.g. BPF) with SRCU, SRCU has to work in preemption disabled or
scheduler lock held contexts, which was missing in v7.0 RCU pull
request.

There is an email thread which can explain more of the context:

	https://lore.kernel.org/rcu/fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop/

Thanks a lot for the report and test from Kumar and Andrea, and Joel and
Paul for the prompt fixes!


The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.0-20260325a

for you to fetch changes up to a6fc88b22bc8d12ad52e8412c667ec0f5bf055af:

  srcu: Use irq_work to start GP in tiny SRCU (2026-03-25 09:00:05 -0700)

----------------------------------------------------------------
RCU fixes for v7.0 - Part 2

Fix a regression introduced by commit c27cea4416a3 ("rcu: Re-implement
RCU Tasks Trace in terms of SRCU-fast"): BPF contexts can run with
preemption disabled or scheduler locks held, so call_srcu() must work in
all such contexts. Fix this by converting SRCU's spinlocks to raw
spinlocks and avoiding scheduler lock acquisition in call_srcu() by
deferring to an irq_work (similar to call_rcu_tasks_generic()), for both
tree SRCU and tiny SRCU. Also fix a follow-on lockdep splat caused by
srcu_node allocation under the newly introduced raw spinlock by
deferring the allocation to grace-period worker context.

----------------------------------------------------------------

Regards,
Boqun

Boqun Feng (1):
      rcu: Use an intermediate irq_work to start process_srcu()

Joel Fernandes (1):
      srcu: Use irq_work to start GP in tiny SRCU

Paul E. McKenney (2):
      srcu: Use raw spinlocks so call_srcu() can be used under preempt_disable()
      srcu: Push srcu_node allocation to GP when non-preemptible

 include/linux/srcutiny.h |   4 +
 include/linux/srcutree.h |   9 +-
 kernel/rcu/rcu.h         |   9 ++
 kernel/rcu/srcutiny.c    |  19 ++++-
 kernel/rcu/srcutree.c    | 211 +++++++++++++++++++++++------------------------
 5 files changed, 138 insertions(+), 114 deletions(-)
