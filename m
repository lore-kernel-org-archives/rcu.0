Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531019;
	b=CNnfHTM/+fRAx5a1Z8i9D3/1mNc0IVUJbYF6BJ9sfAbK3oHK+3UtTGIqWlT4qSP9lpLJ
	 icS7dGN7hPwZAyvrDWlyCYq8CCTatL9yClXMU3CRjZVPSm0TsYWWziG0vKcA0W4wohhrq
	 HtGr+WYYofHa6qRaaijdRxXJfF8Zr/K/FlF+ZPDOOVzfpg16Y0iL2lGxty8/mI8mqJLxt
	 9PTa3aBO721j+X6X088aOkv7n9uIhX2l428fCS8HmBYyMtLfAV/bgvlq1Y6DER/wnHSut
	 CM1Rr3nZlH3giAD7mb0mRi5gVp9LGFEjmMOuxkrjo4wYqkclOrJo4t0WwQy7Hs/xX9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531019;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7ZmKcqsMpy85I94YannztR/IPmjRGxBaTOg6gJoGc1M=;
	b=d5ZFMptlz0uLhh9du/aHsVAoNAedO1LW3GJfJyfeTH73BSZXEmqh4Jck6n9Aai5OYanQ
	 oQ6HvoPSnf4q6TEKxYE0vwa1rmve4DfwHV9BJsR9y5WteU3MARZK2mRy6HsGytDu8seq+
	 NPnWFh0erplsd5SAqbfMg9fYLVTyjHr1QwCYxmtj6FAEYTvtKXMXKwxzX+LfyXEo7Gc+f
	 cuoPYJtE4LjnHRLaXydOPoL69RZVcXijA6alwbT0iRjIOboVXE7X5q72coG+cOCXmd2cW
	 1zJRTtpLng64sEICUIYI24vUezuBTIlvLJBLPlT0zwO0EgUV5lns/jgjXn0z8gLsQBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtWt5Gly;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9927F606A887;
	Fri, 13 Nov 2026 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtWt5Gly
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1FE491F000C4;
	Fri, 13 Nov 2026 00:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531019;
	bh=7ZmKcqsMpy85I94YannztR/IPmjRGxBaTOg6gJoGc1M=;
	h=From:To:Cc:Subject:Date;
	b=mtWt5GlyBnn4HGSSA/sVDs3y4VDZ5hxc8XLwHzG91TgvQUmNH24EeNsDWBoJBuNcb
	 ACB+UrwokGqA5ECKKpRLAj/XsG5ORKHk40mwFCTnDvb/IGWzBQ/+/1oIPJGZN1sHaB
	 GiBNunSaknU52aB4sQox9vMKzKUPfH5m5WHSgSkpXmmw1TF6Tx92mLa+4lAp3um1qd
	 lBdpFD4q5i7dC+v2XHZIVRGF2y3N30cgG6g/Rz/GbRCHx1NJZAT2R70cXk5lf+uDNM
	 ut9qmIklfTrdrgb5Fn9zfmGCtIgdWl0GngigAnfqBWxv/KAQcTIpiJTaNO22v1EJAg
	 nF683G1RiGtLw==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org
Subject: [PATCH for-v7.5 00/11] RCU debug patches for v7.5
Date: Thu, 12 Nov 2026 19:50:02 -0500
Message-ID: <20261113005017.2772440-1-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series has the RCU debug patches for the v7.5 merge window.

Kunwu Chan (10):
  srcu: Record callback registration stack for KASAN
  srcutiny: Record callback registration stack for KASAN
  rcu: Record callback registration stack for Tiny RCU
  srcu: Validate callback arguments
  rcu: Validate callback arguments in Tiny RCU
  rcu-tasks: Validate callback arguments
  srcu: Detect duplicate callback enqueue at registration
  srcutiny: Detect duplicate callback enqueue
  rcu-tasks: Detect duplicate callback enqueue
  rcu: Improve duplicate callback diagnostics

Paul E. McKenney (1):
  rcu: Print CPU that preempted stalled reader wants to run on

 include/linux/sched.h   |  2 ++
 kernel/rcu/srcutiny.c   | 34 ++++++++++++++++++++++++++++++++++
 kernel/rcu/srcutree.c   | 36 ++++++++++++++++++++++++++++++------
 kernel/rcu/tasks.h      | 30 ++++++++++++++++++++++++++++++
 kernel/rcu/tiny.c       | 11 +++++++++++
 kernel/rcu/tree.c       |  9 +++++++--
 kernel/rcu/tree_stall.h | 33 +++++++++++++++++++++++++++------
 kernel/sched/core.c     | 13 +++++++++++++
 8 files changed, 154 insertions(+), 14 deletions(-)

-- 
2.54.0

