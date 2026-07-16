Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8061E5B9A;
	Thu, 16 Jul 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161095; cv=none; b=skefnvULof4Z11rvU6tvnIzyf3qZ4dhCujnib9y8bCey+bjpWm/POipeLo+WeNOjhnUdfwhQAy5iaI0xcPlc7pI1Ov9E57tm9L2qftguaDJFhOHeYy2bYY2rfGyY4XjLCz50DJwQjnjp4YYGcs4Wt85CTTgRBeD5UGs+WPAc4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161095; c=relaxed/simple;
	bh=woD7Az2kWlV9PTw7pihphtuKL4FPWPYj4HN0zS+xMec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BsKSVuiwWKQ2Y4sdwybKyEXYMRX4BD95ZRMnOuG9je6Ooz0Bu+mMpCg9+L+3aww0c4kVDH+ntMKY0UEMhzWF7J+uu7OkWx1qOTXZfoK7QM6YxTwSsumfcdcLmjha+2JWmnL7NO/bMsVgUUN45E1VWuD0FjpGm2X9s/gchB33Q58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl67WNAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl67WNAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7638C1F01559;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=SFxIxkKLFyMdSx2whKbiwqYFPjCjFGvqgtrJbBlbYeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jl67WNAgUA1KE0EMqag8knVPJejl16SD3w8fWjdf00B3aowHc2AfvchHFsdn6RnLF
	 D5m5xTOxrBoUjJjIhYsihI4EhFv9eR90aKHTjyWwv8MecY8Tr5GJmY8TqT2Ujo2op2
	 y3fVtNloCw0Oms7NQsCHXIHZvfo0GDQHL8CRfCN/vSLhDMXwDNBsDfUm5fuvIDJ3C/
	 aqBm6/z13k5nzsCggzccwPN5AKRRfg8zCvLyl59cweJEtyPXDGna/iVUoFAiWNvGme
	 nEImEeOhy+f2ygLcLW5dI1AK0PTQywdoTH+ue1T2ol3RSDzuUzSipHEcJdw2CYU37E
	 RHy0bVt95iuhA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 32302CE0D3B; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 06/24] hazptrtorture: Enable system-independent CPU overcommit
Date: Wed, 15 Jul 2026 17:17:51 -0700
Message-Id: <20260716001809.11084-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit interprets negative values of the nreaders module parameter
as a number of readers per CPU, so that hazptrtorture.nreaders=-5 would
spawn five hazard-pointer reader kthreads per CPU.  As CPUs go offline,
a number of readers determined by the overcommit are idled, so that
again when hazptrtorture.nreaders=-5, five readers would be idled for
each offline CPU.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/hazptrtorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 4dd31104779fe8..21a72667554fe0 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -362,7 +362,7 @@ static int hazptr_torture_reader(void *arg)
 	struct hazptr_torture *htp;
 	unsigned long lastsleep = jiffies;
 	long myid = (long)arg;
-	int mynumonline = myid;
+	int mynumonline = myid % nr_cpu_ids;
 	int pipe_count;
 	DEFINE_TORTURE_RANDOM(rand);
 
@@ -623,7 +623,7 @@ static int __init hazptr_torture_init(void)
 	if (nreaders >= 0) {
 		nrealreaders = nreaders;
 	} else {
-		nrealreaders = num_online_cpus() - 2 - nreaders;
+		nrealreaders = num_online_cpus() * -nreaders;
 		if (nrealreaders <= 0)
 			nrealreaders = 1;
 	}
-- 
2.40.1

