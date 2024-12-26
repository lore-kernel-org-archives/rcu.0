Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8913E028;
	Thu, 26 Dec 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735255863; cv=none; b=nAf2I5mzAosvUARBABtFX7ZMN6WdNj2tXAzucG4NHTuEZXuNkuIfOvRuP/mPJ0kyh76eTl59WoqIBCdUSFLoV8dxrAeivyob5yokedqQ8LoTpD7UxL5QypHxstCWlqMkYQSkWv70ZHZplbma2slZHUeLKFBNBMePD4sS5gD9crw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735255863; c=relaxed/simple;
	bh=8xAt/rU8t0wQRAfcTW1nMCfG+8hfVa8CpWSMI4CWVkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQQcNh5GNPx2Ow7iT9P6L9RMbIMjOaaN2lnAxVPlmHvj40RPE0Rn0LM3NfNhGwWdMDswDEvuYXmlicHcoBNnWFnzhpLRA4m70sc5x5qhiWrWXfqUilADb8M5BtB9QXq2mcszAs5uv9V+1+9jYKvL1ZeoeVjiC/GrmuXYiHVpS5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSYg/3OR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSYg/3OR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF53C4CED1;
	Thu, 26 Dec 2024 23:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735255862;
	bh=8xAt/rU8t0wQRAfcTW1nMCfG+8hfVa8CpWSMI4CWVkk=;
	h=From:To:Cc:Subject:Date:From;
	b=fSYg/3ORcYWvnRMYPlHamWNsNvWhebcRHQU8Wi03DfD2ldI7CAl/qTBHWQ4yk7UBC
	 /ib5F7Q/5Ymc2d3bLmG4k3Lt8XTKCL+8aT417ZTTUC6HRke5a+vkcbKClGxYPCivea
	 NXyPaIz9Jalm+WzGJYV69f9gQLfo1piTRkirqDeaXydWG6OXxHk6hNzVzxOHskAcr4
	 0kNfTs4c/tgHytrR1r4ae5RN8fNVR7GyO7IQnKkbyGhUS4pFWtMEPNDQMNcMdXT5fn
	 uNZu2eGelKbd/EVjQw0m+8uNg7NnxjkXJWG4A0eLPENks/UXsIziGNyixxSQNrNpDy
	 cTJ3Z6Ltq+QrA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	vlad.wing@gmail.com,
	rcu@vger.kernel.org,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	urezki@gmail.com,
	qiang.zhang1211@gmail.com,
	Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 0/3 v2] hrtimer: Fix timers queued locally from offline CPUs
Date: Fri, 27 Dec 2024 00:30:49 +0100
Message-ID: <20241226233052.145450-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
was introduced to fix stalls with scheduler bandwidth timers getting
migrated while some kthreads handling CPU hotplug rely on bandwidth.

However this has introduced several other issues which used to be
confined to RCU. But not anymore as it is spreading to hotplug code
itself (https://lore.kernel.org/all/20241213203739.1519801-1-usamaarif642@gmail.com/)

Instead of introducing yet another new hackery, fix the problem in
hrtimers for everyone.

Changes since v1:

_ Fix a build issue when CONFIG_HOTPLUG_CPU=n (folded #ifdeffery by Paul)

_ Remove the unconditionaly base lock within the IPI when both nohz and
  high resolution are off. There is really nothing to do for the IPI in
  such case.

Frederic Weisbecker (3):
  hrtimers: Force migrate away hrtimers queued after
    CPUHP_AP_HRTIMERS_DYING
  rcu: Remove swake_up_one_online() bandaid
  Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"

 include/linux/hrtimer_defs.h |  1 +
 kernel/rcu/tree.c            | 34 +---------------------
 kernel/rcu/tree_exp.h        |  2 +-
 kernel/rcu/tree_nocb.h       | 10 ++-----
 kernel/time/hrtimer.c        | 55 +++++++++++++++++++++++++++++++++---
 5 files changed, 56 insertions(+), 46 deletions(-)

-- 
2.46.0

