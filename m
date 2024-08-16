Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520313D262;
	Fri, 16 Aug 2024 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791088; cv=none; b=njT51DcpWMDnIFfjhm0uUZapJqKgCzYfy0+qmGCndWyXDiaXvQwA4MMKJzEJ39VqPf1GTOl9TSatDSsJ+hC8lGDLSzO39xie4w44LS2Mbi2kIjvJEihmBziDI2w11Uf98xJJ/7N+TWnJ/W9bWLQCTf/26DsM2xU0k6oQBmcLXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791088; c=relaxed/simple;
	bh=b29osK1yWSOJhUzqZLlk591XC5cm6F2NYvSY/YEC+vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwvMYO4zo/uuS/Aek2nidzieqSKDWXHr6eMrXPjx1nPCjKHm78KDgIb3y43oiU5VlryVZAsDIbnW98rGNoaQELwCGidROCCRL8cd+Mnlh2nWLFrZK+MaLZbNjwf2F4spTlOnLsxrk+SKPlQFmaBw0B8wWAV9EUTEGoNh9Wx2saE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrFemkGJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrFemkGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF1EC4AF0B;
	Fri, 16 Aug 2024 06:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791088;
	bh=b29osK1yWSOJhUzqZLlk591XC5cm6F2NYvSY/YEC+vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrFemkGJ/ewJ9jeE5VyKL5WOTd7hAfd7SW2GgI7m6spjBlVJ8+ah8suIhD9mR3mGS
	 fpr9AimFacbiwcIQIW3mcSSxinG7FvloAdM06UinFOlcUbKMQS8HAxhhmkrJtO7urQ
	 CKp6FXra9B9gXyHKBYZW5U+W2lPEBy+7OxXy0G8+uS/ixi3epTbCVBH78uyjPdasGq
	 dcdiLUjNLFqngyDyxw7XJ2v+mU9ytGwhyC6nGWrfARP6WPFD+6RgEjPG0ML8Guy3HV
	 Fxd9j62QoKJl22nIanpdpl+FAYgFdeYMcwyzj1MO/mTBIJUL9LccgdgGUKqmvgIMek
	 MK2aj841qDdiA==
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
Subject: [PATCH rcu 09/12] rcu: Provide rcu_barrier_cb_is_done() to check rcu_barrier() CBs
Date: Fri, 16 Aug 2024 12:19:18 +0530
Message-Id: <20240816064921.57645-9-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816064730.GA56949@neeraj.linux>
References: <20240816064730.GA56949@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit provides a rcu_barrier_cb_is_done() function that returns
true if the *rcu_barrier*() callback passed in is done.  This will be
used when printing grace-period debugging information.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 38238e595a61..caaed27e476b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -255,6 +255,11 @@ static inline void debug_rcu_head_callback(struct rcu_head *rhp)
 		kmem_dump_obj(rhp);
 }
 
+static inline bool rcu_barrier_cb_is_done(struct rcu_head *rhp)
+{
+	return rhp->next == rhp;
+}
+
 extern int rcu_cpu_stall_suppress_at_boot;
 
 static inline bool rcu_stall_is_suppressed_at_boot(void)
-- 
2.40.1

