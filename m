Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47B1CD0C;
	Sat, 16 Aug 2025 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302507; cv=none; b=dPcXHQYF5aiimUDbu9YaspQJaKsNOWoxdwNWv0pmcrdIGRA8t/bMUp4vNdyNEw/MjE9HwgxIkQoc16ebXxaV3y10FEh54cjiso6R2bYpIW6gY4TY4PtvcgM77M+4db1N2GIM21I9JJTPUabjAaw3nCtzGAin99cPe0MVnEVRL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302507; c=relaxed/simple;
	bh=koM5B3TOcnXeXdxE6Ak3avu0G5587Dgk7UrmUzSqrVM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aTM8QsBWSpFLpHXH8CNSp58m58LO1NIzzymgQt2Do2Js0IlmRIVWsN1j2KeooibfRuhoNejFtVRpDd8JZUrziZ7FKvo9g6r0jN4Az6ldZgvsZsN3PEH9JRiZT6DMiQj72/tQc+3TGGFuAtl1Ge5VE9NIGf57j/1bRmrd7brp7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYgrgecG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYgrgecG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08D6C4CEEB;
	Sat, 16 Aug 2025 00:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755302506;
	bh=koM5B3TOcnXeXdxE6Ak3avu0G5587Dgk7UrmUzSqrVM=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=nYgrgecGzf1kDftUy4YlG1EIBNOm+5dYm6Hu0quUTVaMD2tgYTlKv3hb4J4fb2pJh
	 DgonMqbUKp374SEMioA6OjOUe2MY6xtsvm4o5mDXkFkyC/uOZAQ2oq+AA3BcGNXJCU
	 mFbWUtxSIGrUtdVoipVsc/DK7DP6gI54WigFDVldhOLAdIBDpNETEj/3x8x79Q9FAj
	 Lv73pU1gtzO5uHD6WNJ8rsfc9YisPzyv8R8OOI8VUXZTmJK+MSsshf/pBHC/bbjNC2
	 e1Dl5WH6cRtVz4561DzMbVp2Udrn6g3ZiUMVXcbRUNlXV3B33OOX/85kO8zP8kHHP9
	 DYLuWXfDBSmYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5E2BCE0B2D; Fri, 15 Aug 2025 17:01:45 -0700 (PDT)
Date: Fri, 15 Aug 2025 17:01:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH 0/3] Miscellaneous RCU updates for v6.18
Message-ID: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>
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

This series contains miscellaneous RCU updates for v6.18:

1.	Document that rcu_barrier() hurries lazy callbacks.

2.	Remove local_irq_save/restore() in
	rcu_preempt_deferred_qs_handler(), courtesy of Zqiang.

3.	move list_for_each_rcu() to where it belongs, courtesy of Andy
	Shevchenko.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/list.h     |   10 ----------
 include/linux/rculist.h  |   10 ++++++++++
 kernel/cgroup/dmem.c     |    1 +
 kernel/rcu/tree.c        |    5 +++++
 kernel/rcu/tree_plugin.h |    5 +----
 5 files changed, 17 insertions(+), 14 deletions(-)
