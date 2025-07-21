Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C712DFA25;
	Mon, 21 Jul 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115068; cv=none; b=Jm/NKpxhdDSOOz+4lfbJ4zzTreSu439Jj2dadmQjCBky9FbdqnwyETvyZgu2vQA4WTLKd34fGzjH3dQ+Psra2ZT29+1A6sLbBq5lhGVD02UJBpfgYQFpEKtkA7ora2h8smdAgLFfANlMy/ZuX4+LkTJzHyrF8LLQzeA+U683WII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115068; c=relaxed/simple;
	bh=IWjiSW3/DTK6Yt8PRmUSRaihI8KjJDrKXIUweHjoyIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=awCkjIDNFkPhC0wzpIaB5jTv3ZMaIj+mXpbuhaY4gt6c2V7eL5s2xUQhof8mF6DT6y2m8znEMM6qjBCstohFiHoa/hQCQm6Ujmj0FG8CVyxzIImvV4dvaJhxGReQVlTcOBpCefLb/qneajJnYCBigO0o2Ewx9fBgsSGeVwajKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciuw9+2Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciuw9+2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4895C4CEED;
	Mon, 21 Jul 2025 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115067;
	bh=IWjiSW3/DTK6Yt8PRmUSRaihI8KjJDrKXIUweHjoyIU=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=ciuw9+2YkTIoMVP9/uDd2X2+a4U4bTYeynfvD6sHdNi+Kav/ssKZjLeNPMlp9m1hY
	 JhylsGdzwphDJfiaJXNAYmDRwjx+e+WPdPjju+CsASvXw3e3E6alF/xGtsY+RYTyK+
	 A9awQvp2PKmwdbrQGbbaOlH0ZcIar5PV/DmNY/1khctO/Pe76C2thSy2lJjI9b8/zz
	 vezusGW0/jBOE+8ZfK+TYsAlgcfGgfg8hXHds81K4QSlccAwjLrU45ypKd8sWtuiT3
	 O9Tgt3YiQZcvztJDCEyUS42yEl5/tzMnABW5i6hwLt1KLOsglNAWuBdQutNMW6RjnO
	 PEjsfGb0ilqXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 634CBCE0C41; Mon, 21 Jul 2025 09:24:27 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:24:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v3 0/4] Switch __DECLARE_TRACE() to notrace variant of
 SRCU-fast
Message-ID: <7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop>
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

This is version 3 of a patch series creating a new notrace variant of
SRCU-fast and introducing it to the __DECLARE_TRACE() in place of the
current preemption disabling.  This change enable preemption of BPF
programs attached to tracepoints, as is required for runtime use of BPF
in real-time systems.

1.	Move rcu_is_watching() checks to srcu_read_{,un}lock_fast().

2.	Add srcu_read_lock_fast_notrace() and
	srcu_read_unlock_fast_notrace().

3.	Add guards for notrace variants of SRCU-fast readers.

4.	Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast.

Changes since v2:

o	Posting standalone as opposed to a reply.

	https://lore.kernel.org/all/3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop/

Changes since RFC version:

o	RFC patch 6/4 has been pulled into the shared RCU tree:
	e88c632a8698 ("srcu: Add guards for SRCU-fast readers")

o	RFC patch 5/4 (which removed the now-unnecessary special boot-time
	avoidance of SRCU) has been folded into patch 4/4 shown above,
	as suggested by Steven Rostedt.

	https://lore.kernel.org/all/bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop/

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h       |    4 ++++
 b/include/linux/srcutree.h   |    2 --
 b/include/linux/tracepoint.h |    6 ++++--
 b/kernel/tracepoint.c        |   21 ++++++++++++++++++++-
 include/linux/srcu.h         |   30 ++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 5 deletions(-)
