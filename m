Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F14346FA3;
	Wed,  5 Nov 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374004; cv=none; b=ZlfIJIR9ylds+pgkdi4Fb9BwgjDlL19WDrIcWoU6X9zmuKSTGOPok6UO0YFzrK+GPr+hI38lckfdSjTppGn6lQr4++B4ozbIKDW4a0Ok4nDGvDl8KjOepwrUlJ6IVGxLS/R6pufdqt2SwruLU+Rz5Ljlzq05vfMR9eSiorNWF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374004; c=relaxed/simple;
	bh=qOt3gmc4S/dnhc4uiVgFSWjZIhjAb7Cb7CIR0Pi8QmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+jtOpBvOl7BqPwstrw3bm1OGzZwCmTEvRhrd2teSDvtoKuZrRvfyQ4tROHKD15XJbh9cK0mWBKVIn6Zvz9Ix0bdXWTXRuxBVuK1gYaD42BnVnIZ2tjwxgh+YCG9zBfjy27G6YA2U+SsH3d6VrOsGa/8KaJQ1LPAb+mHdO8EuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu2hfnyM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu2hfnyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23531C19422;
	Wed,  5 Nov 2025 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762374004;
	bh=qOt3gmc4S/dnhc4uiVgFSWjZIhjAb7Cb7CIR0Pi8QmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qu2hfnyMw1sE1BD8LNBlbmzPvM+AKRQ4csQ+HscFuM9dfNEj5P7L0ZSZXRB51KHwQ
	 VWTc00CS5zZPDWheNa0VWSRCm2Lby8quvxqoSlqixAU0xLlGWv4adf9ZsXaSmt+txz
	 O6UYanC7twNsJmS9uOhWdE+Kuxy0cd0ufVEbtxZwvDNLka56ld4Ql/ywEQiaW5EPpK
	 sFAy8nP8Xyl2fqsXEAKo0XVtorw9mrnoq7YKu9YqD392SeEQAeef5w4FijKjKlVMiN
	 aT1OlbIql1CLbJDBAlSO3oT6XprT4lCowsh4QDQ9j1KoGWX2cpB0Q2a811Rt2ZKeNm
	 pNkTkXV5grFEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1756CE0EBB; Wed,  5 Nov 2025 12:20:02 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 5/5] rcutorture: Remove redundant rcutorture_one_extend() from rcu_torture_one_read()
Date: Wed,  5 Nov 2025 12:20:00 -0800
Message-Id: <20251105202000.2700370-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>
References: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit removes a harmless but potentially confusing invocation of
rcutorture_one_extend() within rcu_torture_one_read().  The immediately
preceding call to rcu_torture_one_read_start() already does this cleanup,
and the other call to rcu_torture_one_read_start() already relies on this.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 72619e5e8549..318bea62ed3e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2384,10 +2384,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	newstate = rcutorture_extend_mask(rtors.readstate, trsp);
 	WARN_ON_ONCE(newstate & RCUTORTURE_RDR_UPDOWN);
 	rcutorture_one_extend(&rtors.readstate, newstate, trsp, rtors.rtrsp++);
-	if (!rcu_torture_one_read_start(&rtors, trsp, myid)) {
-		rcutorture_one_extend(&rtors.readstate, 0, trsp, rtors.rtrsp);
+	if (!rcu_torture_one_read_start(&rtors, trsp, myid))
 		return false;
-	}
 	rtors.rtrsp = rcutorture_loop_extend(&rtors.readstate, trsp, rtors.rtrsp);
 	rcu_torture_one_read_end(&rtors, trsp);
 	return true;
-- 
2.40.1

