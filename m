Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB62F549E;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191395; cv=none; b=t57SqAPePZMu3sOkVRAGVY7X9ioi9xo6hClbV8HW0xJMhT6C7aDa9DTnGpZpROkd2OsFhMm1Ddrvnddtu5C3uMZ/kHJQe93x0CrTeaEUVHI59LW1cWdM2Pe4DB9klFxqTxBVLyu02aq12999g1CwdzXI4UE6RqxvJYQiXyQQRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191395; c=relaxed/simple;
	bh=iZgfujpyduVegeZVrLnoIiFFN0/XbNGUGBJBpNQfD5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xkj7clmEeQiHhZDp+lN6v0oXyN8OYRo8lvTsRaWL58opjSP75L9dXgE0hlaKXa8MJmylW5KKqJaF+R2ItXBbOCcKwyVXjBJuh03Kc23+kUwlvHspLYQOfZ5Iut8V7vbp3gJ98ENnbAE/3d+K0/LpDijU2GM8qZpyTIvis/fRaOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLJcsvaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLJcsvaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A55FC4CEFA;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191395;
	bh=iZgfujpyduVegeZVrLnoIiFFN0/XbNGUGBJBpNQfD5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLJcsvaZVN0eyoWgosOfeYKFYKnKUK3zfCzhEvOags3xR50Rznsz8h7F4tXyCa9Dd
	 7yvQeTD6WFxweMu+8flOtn31OIyOzfvz2UzLgEqCptDP3ft1echMit9YF9VqGn7tKI
	 G8jqeT2bDi5ZGAbf/Ov20mHChPclD+o/9IZ3HgtAEVVKLr2JofieCx0OtvCuw/Uvfi
	 XVE+iRosJAelQ0Pz1IBWrcoKzh1EjEWhTzaINcMAnXKw8CA8XwurPPC7RDQ1UQtXbu
	 Qeka/JByhB0zq+0cqLMLtycoGRO+TiaUaDWpQ9znVefyeZWIG4wP+88a+dJxQ0QFWf
	 eowIZ7gXIXPnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DF007CE1109; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 08/11] rcutorture: Use kcalloc() instead of kzalloc()
Date: Thu, 18 Sep 2025 03:29:49 -0700
Message-Id: <20250918102952.2593045-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qianfeng Rong <rongqianfeng@vivo.com>

Use kcalloc() in rcu_torture_writer() to gain built-in overflow protection,
making memory allocation safer when calculating allocation size compared to
explicit multiplication.

Change sizeof(ulo[0]) and sizeof(rgo[0]) to sizeof(*ulo) and sizeof(*rgo),
as this is more consistent with coding conventions.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b8a684459381f2..29fe3c01312f60 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1572,12 +1572,12 @@ rcu_torture_writer(void *arg)
 		return 0;
 	}
 	if (cur_ops->poll_active > 0) {
-		ulo = kzalloc(cur_ops->poll_active * sizeof(ulo[0]), GFP_KERNEL);
+		ulo = kcalloc(cur_ops->poll_active, sizeof(*ulo), GFP_KERNEL);
 		if (!WARN_ON(!ulo))
 			ulo_size = cur_ops->poll_active;
 	}
 	if (cur_ops->poll_active_full > 0) {
-		rgo = kzalloc(cur_ops->poll_active_full * sizeof(rgo[0]), GFP_KERNEL);
+		rgo = kcalloc(cur_ops->poll_active_full, sizeof(*rgo), GFP_KERNEL);
 		if (!WARN_ON(!rgo))
 			rgo_size = cur_ops->poll_active_full;
 	}
-- 
2.40.1

