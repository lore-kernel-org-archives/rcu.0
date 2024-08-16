Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EB83CD2;
	Fri, 16 Aug 2024 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788872; cv=none; b=Q9IKDwB7z2iylS7bOXDTRpQWat954BQBQb+jUUNVUdbTOF1ja+yObBiGUajDHmn0yOYhYcgze2yDCkAY7ljKwC3Al9rjvWmE/e9inf1PQNG4VuxsjBaFXkBMlAih8Ftnj/aVHNAd4EQh+YYrCm44Je/kPVPLTbIryrvlFVt4URA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788872; c=relaxed/simple;
	bh=GzcF/AxsZadA5DCdyDyvjw9DG5Drn9I841sZqkPWd50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDE5Cx9eMjpaEsT2KCSYaFNnEcqFNJapnvD6CiAD5gCykv7CQD57ecOf73+Ubs3IBYCnbY5IYTqOzkSFlyCuFfj9MiGF5SBPWGOuvqgHyN0b4f57xhvSe4hO771O9pC1crMbZrl4g4UN1Ap6bkdNVJaSBqBw/sz+uNIHRVgnHAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVM0vMlr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVM0vMlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1843C32782;
	Fri, 16 Aug 2024 06:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723788870;
	bh=GzcF/AxsZadA5DCdyDyvjw9DG5Drn9I841sZqkPWd50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVM0vMlrBxaGmFXnQw58wniNmFb36Q/QZ5FW0v6E1b5dlHRWcre/dBrabKgVgf8jq
	 7YFT4pZgm+GhUo6J8ayZhRrMDLMO8yPjcWnRaji2ckA39NdcNJ1QA/h6vycpA9W5+F
	 idv19HXlBcvkhouSoFW6rA9xieWYFlr97dvIlM0iQNFzS74Ny8P3O3+0wCZjgtn7Jj
	 e1qsKM4EjhsAIgzt13g1jS44q/sdKDRK5p0gTCmUUxLG/k5B5/k/pYFf3StkfOme8E
	 KbPgs8OJaj7mE3KwTzwalxrEAvqqfRVmt4ywz/1xWjWBlVsQM49vX4TFCaWhEqcoFn
	 1QgOU29EO/wtw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 3/4] rcu: Summarize expedited RCU CPU stall warnings during CSD-lock stalls
Date: Fri, 16 Aug 2024 11:43:03 +0530
Message-Id: <20240816061304.48843-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816061050.GA46994@neeraj.linux>
References: <20240816061050.GA46994@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

During CSD-lock stalls, the additional information output by expedited
RCU CPU stall warnings is usually redundant, flooding the console for
not good reason.  However, this has been the way things work for a few
years.  This commit therefore uses rcutree.csd_lock_suppress_rcu_stall
kernel boot parameter that causes expedited RCU CPU stall warnings to
be abbreviated to a single line when there is at least one CPU that has
been stuck waiting for CSD lock for more than five seconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_exp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 17dd5169012d..d4be644afb50 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -553,6 +553,10 @@ static void synchronize_rcu_expedited_stall(unsigned long jiffies_start, unsigne
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root = rcu_get_root();
 
+	if (READ_ONCE(csd_lock_suppress_rcu_stall) && csd_lock_is_stuck()) {
+		pr_err("INFO: %s detected expedited stalls, but suppressed full report due to a stuck CSD-lock.\n", rcu_state.name);
+		return;
+	}
 	pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {", rcu_state.name);
 	ndetected = 0;
 	rcu_for_each_leaf_node(rnp) {
-- 
2.40.1

