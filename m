Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A61F0E59;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263324; cv=none; b=LK701Sh4EUFP8jjSGj0Cxw0o5LvKo0QszvSEa0Zh/pdhjEx3kMTolsuAr0wP+Lzs+csJ4CUXhQ8oF8D2mvzeG++6mAmLle+eV52/SN0REmGxHCVc49Xx+IfMwl/CKOOi3A59NDuXuXgWvMtFCLrh3Up4qtk/4hDZsCdCjcvhE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263324; c=relaxed/simple;
	bh=ZRe9gmGigZTtDUOXJcPosvXihRop9WipO7viDyFl96A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9uhLcH9lSXKwsLBbjaIQii/jN4zQeJ7piImiuniezuNzoVFEww2TSm+hRERE3Atw7BTgg6jB50l3dGlzsX4Ca1Isw+LQKnTaq6vRa26NukU/6wQCGCf7cCbuPkDNBukJv/Mzj/0/gUAfGHyLrz1c+mjRslKhtiLiWuqVaKwSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCjwO4L3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCjwO4L3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6A8C4CEE3;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263324;
	bh=ZRe9gmGigZTtDUOXJcPosvXihRop9WipO7viDyFl96A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCjwO4L3jjrg03MEd1pcWMVFefc/nP7i0W3lPmweevKBzGgvONoBJ+xmMd7rYUjoT
	 if2jMO31rD8vHjAQcuDUg9zXn7XNo/7pKLVUxQvFbr3lhJHh65+A8hMgZjTCOBm/Ds
	 UKvK1ASMeBCi6RrUz1tvY9JWDvga0NHo6d5NlTqtB7lfsaMV3llzQHTtDsv/E5yVA6
	 8z4KjX427ohyKEuiFBv8deMUYLov2NLCIsWa7gBGrL3Xe9dxr5K4ZLZzm/aVPYRHsB
	 mBkrR9+R4rgf9cNMmtl4rhK1maH7JzV/e9sN5yii8GRIURgovDCK3KFWFHdYOrKiCi
	 cvLsSd1gTceXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BB84CE37E9; Thu, 30 Jan 2025 10:55:23 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 9/9] rcutorture: Make scenario TREE07 build CONFIG_PREEMPT_LAZY=y
Date: Thu, 30 Jan 2025 10:55:22 -0800
Message-Id: <20250130185522.1652093-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
References: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit tests lazy preemption by causing the TREE07 rcutorture
scenario to build its kernel with CONFIG_PREEMPT_LAZY=y.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE07 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07 b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
index d30922d8c883..352393bc5c56 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07
@@ -1,7 +1,8 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT_LAZY=y
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
 #CHECK#CONFIG_TREE_RCU=y
-- 
2.40.1

