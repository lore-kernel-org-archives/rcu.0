Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE371F190C;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263886; cv=none; b=gvntSTSCmqEdC9EdMbB5wUfrld/kEOzXruFOYipCfM0IcTlQnzX6XcWBDdaQpQ5kuKQnEkHBZ0QaEuKuQPV4FBtog6CehOaEj7kHj4uE9gxNbsJHEUkR+OFSAyilW+aLTrEM1yW46rMvDe7mbWNP3pFVgXNf7VpkXpawMX0I0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263886; c=relaxed/simple;
	bh=qWy23sdot+6jzLOaPUQ6jGvq/sF+BsF6S1c+JbBI/OY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqjrMn95vO1ukMX/iCkDSCI2wzgKtFOwMPcjMR45bwkssKNV1kfpYr2CHI0ijLNCe9y7tS0Ckx8JLv+w8z6gth/LXY8NoBrKBpZdYIt7U+u2W9MAycYHZD01/bagSbAgTyYq+aDKY1n+mfxVKfKrOZ9pLeWEv76pIl+DsOSxd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7YxiKNl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7YxiKNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116D3C4CEE5;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263886;
	bh=qWy23sdot+6jzLOaPUQ6jGvq/sF+BsF6S1c+JbBI/OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7YxiKNlMi/S6j9dPVwYrq57DhVAUDWROqXqHdHmU76r1Lno/2J47m5nLnoHp0fJa
	 b8bvprOelOWFny45E0Kn/WHWufO2EWN5dK6ZDjFOFOUUHkn8nvgma88uLnDWnZpLKA
	 Cz0Df3U0wJWzFOHttBYR0gaxFnfaGhLPl76Zq3ztdcmtgeWdqJD8yhUvwOPCRkqduS
	 y38X7yrefdPYcmeKPQqdB8fzKOtTgfzJVwT6ZbGZPydO6csryHAHLGhVxLhO4AZR83
	 v5sQpjoq47NwKZHaP7eqgXVR+oDQT+UTYn9dhGUHvLXe+CGVZssFHIAvpR6JdLPHM/
	 k7UgfR8/HBxOw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8BE75CE37E9; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 09/11] rcutorture: Complain when invalid SRCU reader_flavor is specified
Date: Thu, 30 Jan 2025 11:04:42 -0800
Message-Id: <20250130190444.1652700-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
References: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, rcutorture ignores reader_flavor bits that are not in the
SRCU_READ_FLAVOR_ALL bitmask, which could confuse rcutorture users into
believing buggy patches had been fully tested.  This commit therefore
produces a splat in this case.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2e6e8664e403..36bc8d1332d4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -690,6 +690,8 @@ static int srcu_torture_read_lock(void)
 	struct srcu_ctr __percpu *scp;
 	int ret = 0;
 
+	WARN_ON_ONCE(reader_flavor & ~SRCU_READ_FLAVOR_ALL);
+
 	if ((reader_flavor & SRCU_READ_FLAVOR_NORMAL) || !(reader_flavor & SRCU_READ_FLAVOR_ALL)) {
 		idx = srcu_read_lock(srcu_ctlp);
 		WARN_ON_ONCE(idx & ~0x1);
-- 
2.40.1

