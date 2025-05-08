Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554422FF4C;
	Thu,  8 May 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747753; cv=none; b=mqWff8zkvCEBW/xZebpu5rz8fFwCgE58LDw/Xu7JRgIVD856EBbsIr4YGUEqbNj25qWYL2utQYyNz+OIC0oMYXEeJCaXNOURKHNnGdGTXWZqyaHSZxB1cSsPP5/RU2oeYXuJoVbxIJg9RQ6FWuR2PVWB4D6kibUkE7CYmXrGVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747753; c=relaxed/simple;
	bh=AXbdvbhnhQJc2Vt4aBypgEAuD+IUYP3v+j6U5ZNRkMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVKVzNW7fYIwEZsn2WlmmkY33aF5mnVoXKf2aQYXEsWV9Duotsn5ccgGg0x9ByRukbvUnaSDv23wHf2Whm/rc/YfCfp8qSpbdWGUlAN+4O/2apxp73c6TQIarB5qBxFqceRQdgWfgfEB8VW9KJ3+0GefyljgPmjgw1WPpYH8PIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9Bv20uA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9Bv20uA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E3C4CEED;
	Thu,  8 May 2025 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747753;
	bh=AXbdvbhnhQJc2Vt4aBypgEAuD+IUYP3v+j6U5ZNRkMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9Bv20uA1jdWwdjcX3Gn9YaMZTWfEcwAD19ooiJq3rMjC1JloCJ9b61oiCTJH6hMW
	 bfwJXfloeE3BIUjDj4uELWtDivqP7NB+8dtebzMVHBeFMnHszMlGI39HQfQgXb3DTP
	 v6CM7vRyw4CwvWaIYABjt74Yc2N+fp1A3GVkY8SSHz92zm3p8VQVRI55Jd8JLhm9Qj
	 QpmjFAZE9Q0tojXwn255eN2UqcLWYGXV7vXmIGGDuyUzpOPzmRE79ifrTebZQ/wZ9q
	 t9mXwDtJjMHytbbHPWSixYfCCVD8toYZU5/mSFT9v927Um/obXZwabnBk7HEyrzlDE
	 nJ4zxenk2NuAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0D9D0CE11D3; Thu,  8 May 2025 16:42:33 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/3] rcutorture: Reduce TREE01 CPU overcommit
Date: Thu,  8 May 2025 16:42:29 -0700
Message-Id: <20250508234230.1996554-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
References: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TREE01.boot nr_cpus kernel boot parameter has been set to 43 for
more than seven years, but it can cause RCU CPU stall warnings on arm64,
most of the time involving the stop-machine subsystem.  This should
not be too surprising, given that this causes 43 vCPUs to spin with
interrupts disabled when there are only eight physical CPUs.

The point of this CPU overcommit is to test the ability of expedited RCU
grace period initialization to handle races with incoming CPUs that have
never previously been online.  But limiting to 17 CPUs instead of 43
allows time for this code to be exercised, and eliminates (or at least
greatly reduces) the incidence of RCU CPU stall warnings on arm64.

So this commit therefore sets nr_cpus=17 in TREE01.boot.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
index 40af3df0f397f..1cc5b47dde282 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
@@ -1,4 +1,4 @@
-maxcpus=8 nr_cpus=43
+maxcpus=8 nr_cpus=17
 rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
-- 
2.40.1

