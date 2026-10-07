Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9237DEA8;
	Wed,  7 Oct 2026 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405904; cv=none; b=OboxU3fbR1ewrern0PFY6u5ji3oQJtysD97uMUeBzvjsnYfbsfYe+W8fhlnTjrqereMikLUzg7Wg3OZ6wCqtAD5QAfLpp1JHvd1F5SMmSiZ2WDT6HrxDrt6W7/HsKN8TQ5spivJcmqp3FAxx9tLay4G7H/HqbQSKfROefYBrbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405904; c=relaxed/simple;
	bh=N3+nWEgxtcfiIiUwZhUc5izpXeRqDTFuURJx+9f8Eus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cjUs5MYhl3SdQhjqvYhIyC0ZEEN9ZkGLSadx3xNbIqS19QMfLvZMh+8NNqp9XsEqh1qQ2pVFgj4FvzbeB2+UeelZNWVJhfx2rQBrdxQ9r/nTQ5C2VzCsckrEunUHGKHIKIkWCIHZbv2T3FGjcU7xYiYIwr2hHeyJ3zOVJKnbuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TC+MzKa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TC+MzKa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3C31F000FF;
	Wed,  7 Oct 2026 20:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405903;
	bh=BRawPLi7IhriJG9LEf4ROYinnxMjkk458OuwTHyTWt8=;
	h=Date:From:To:Cc:Subject:Reply-To;
	b=TC+MzKa0RzdAeanrcLgTafqlMQSApM1iZPxi/7aQcjM1kZ2BNZ3FPsCRYu8VmY4uR
	 ogex/SBhsA3bpnIVquwqV3B2+sVa/XfECLDpFcnMnU+XvVB6qqq1Fa9ikJ7SAIsLlc
	 6V6MBd9rYitYsNNaHsxgh7eI824TGrSsyOwu59GbZ8dYvQQ1pNBkoUeuypRbV4/tQW
	 WTtbBkVINh2OaCOctM3jXpue61sQBDxym7qozovv2P+3d8mn5BKjDMH2K6huKkiXBT
	 k5s7zCZwAlnhPsEw9HkcLFZyul8u8MNxnKAE6bX/TLpuCZ54Ll6lBbipV6/HGSuVJB
	 o3W+rWFaMBYiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 93F73CE0D79; Wed,  7 Oct 2026 13:45:02 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:45:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/10] Miscellaneous RCU updates for v7.4
Message-ID: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
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

This series provides miscellaneous RCU updates for v7.4:

1.	Update stallwarn.rst based on RCU Tasks Trace as SRCU.

2.	fix shrink budget underflow in lazy_rcu_shrink_scan, courtesy
	of Longlong Xia.

3.	Don't panic on already-ended RCU CPU stalls.

4.	Add running and boosted indications to RCU task stall dump.

5.	Fix typo "upto" in comment, courtesy of Hemanth Selam.

6.	Drop the private tick-internal.h include from tree.c, courtesy
	of Bradley Morgan.

7.	Make userspace barrier hook drain kvfree_rcu work, courtesy of
	Matthias Goergens.

8.	Fix the rcuread_is_dead reference in rcuref_read() kernel-doc,
	courtesy of Karl Mehltretter.

9.	Disable callback contend/collapse messages by default.

10.	Drop the address space qualifier from the dereference macros,
	courtesy of Ricardo Ribalda.

Changes since v1:
https://lore.kernel.org/all/7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop/

o	Add patch 10.

o	Add tags.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt   |    7 +++++
 b/Documentation/RCU/stallwarn.rst                 |   22 ++++++----------
 b/Documentation/admin-guide/kernel-parameters.txt |    9 ++++--
 b/include/linux/compiler.h                        |   17 ++++++++++++
 b/include/linux/rcupdate.h                        |   10 +++----
 b/include/linux/rcuref.h                          |    2 -
 b/kernel/rcu/srcutree.c                           |    2 -
 b/kernel/rcu/tasks.h                              |   15 ++++++++---
 b/kernel/rcu/tree.c                               |    1 
 b/kernel/rcu/tree_exp.h                           |    2 -
 b/kernel/rcu/tree_nocb.h                          |    3 --
 b/kernel/rcu/tree_plugin.h                        |    2 -
 b/kernel/rcu/tree_stall.h                         |   12 ++++++--
 kernel/rcu/tree.c                                 |   30 ++++++++++++++--------
 kernel/rcu/tree_stall.h                           |   24 ++++++++++++++++-
 15 files changed, 111 insertions(+), 47 deletions(-)
