Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEF146599;
	Tue,  4 Jun 2024 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540099; cv=none; b=LtkKvmu8Cgu4VDVZO82FT7RxI2nzx6qetPGGYl11wmeC3OX8s2jbJ+65Hp4oVrtyObm5KnxhW0WJ5nXlnMfYPy9XsG7uuuGwunBXQtKeXqlCSa1lrgnMTv1f0J5CCchqnA4p0nOQVuAGqgox4pkvnTTcLeuI+21a50MRc9IUbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540099; c=relaxed/simple;
	bh=76Gc/g9GD1ntDHfw01bT6c8btnEVs2sKXCci2YlnED4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MX3ZOEEn52atxXvWGXv3/kZceg7bvTY0vOQMsmnuxW0p9NbzmWzd9C26s/3UuRUy5npVXkXGAO0zo/3o/fgTpoCyheHNcmuSaRPo9dnHM/LT96VDs3giADwtOY8iW3OR5SonpwzxpAuMo824HQ+LoMxHSYf7eaJMo0qwxqS3UI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiw0BstA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiw0BstA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F807C2BBFC;
	Tue,  4 Jun 2024 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540099;
	bh=76Gc/g9GD1ntDHfw01bT6c8btnEVs2sKXCci2YlnED4=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=jiw0BstAgQzgLy4/+9itabar+lcgM2tm9VhdY9t4Nbkk7tf2zg8uW6eiRcs3gzAfL
	 /7ip2v1FHs9R3Eids4Rd3mWNW/u3LMBFrpZJWV5MERtfHYwnULJgHF5RPv9YbMdrPU
	 8Ve+SxL3hACKqRjKapAnUuf67xGOp4PsXUCWbLqk4XSgtnRJSaSePY8PpmUcnBaTBG
	 ck8uPeKKzxNx4Lh0Gmet2jaSZviR2CKcCIxdDbMR7uRo/LY+LVffBdV2Oc5sVBlQVO
	 07iZp6RxT7ZTNPuwSwf9Q6tyH9OPeDPxgLCWalmG2/1u9HbsKZ3dB2kKM9tCFvSTd7
	 hj+/bhGuRKbdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 44A6FCE3ED6; Tue,  4 Jun 2024 15:28:19 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:28:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/4] Callback-offloading patches for v6.11
Message-ID: <f750378b-1eaf-4d22-80c3-a6a086c79702@paulmck-laptop>
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

The following series updates RCU's callback offloading:

1.	Fix segcblist state machine comments about bypass,
	courtesy of Frederic Weisbecker.

2.	Fix segcblist state machine stale comments about timers,
	courtesy of Frederic Weisbecker.

3.	Use kthread parking instead of ad-hoc implementation,
	courtesy of Frederic Weisbecker.

4.	Remove buggy bypass lock contention mitigation,
	courtesy of Frederic Weisbecker.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcu_segcblist.h |    7 +-
 b/kernel/rcu/tree.h             |    1 
 b/kernel/rcu/tree_nocb.h        |  115 +++++++++++-----------------------------
 b/kernel/rcu/tree_plugin.h      |    4 -
 include/linux/rcu_segcblist.h   |   87 +++++++++++++-----------------
 kernel/rcu/tree_nocb.h          |   32 ++---------
 6 files changed, 83 insertions(+), 163 deletions(-)
