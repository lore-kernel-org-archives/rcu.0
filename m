Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492B31F9B5;
	Sat, 19 Sep 2026 00:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778163; cv=none; b=oLAnKzmetpMq/Az/Eqxp+zo/cL3i6+ytoNec9NPuD/R9jBhNiWRsay7ONovlUJN7KQzXoQovCXoiQbjnaujV0svPnf8JbchZvKFF7/2ydddpdJE0k8pmt9q6I8Ij5UsQrPBGqu4iP/FOiFkSrunJXkzQK/EeVrtzPEe6Y47ZT1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778163; c=relaxed/simple;
	bh=ZsSFubY/1L7lg3TeE4B8iu4Ois91YjljlBfCXZY8n0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJ+/HAbRfiRUg0WxIbY2axfwRvJiSzncfgwnODLqben1sWvtKY409927n0ok1CL/ApKB5j5kYVyTiyROfJB8rJPLUACA5DD8Hc4TiLPIccUWUiiEazL2Fgey78nlMzmkvhRKSb/WGa29JH+9TGM9zhDHpRFtPL4IS2TkW6h5/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHGX2Ulj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHGX2Ulj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A701F00901;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=OlEdJvExr6Bd5YARe+Zza8eTz6C/rx+OO/RH2C3YfI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GHGX2Uljq6/9JQw5C0MgFwjxjbFrGeLknOICZL5vUbSfR1ssk4t/iInWukCyEig1O
	 pfqX2Jpg1Q5W5J4kVhxOkw8PQ1n/RWqFFFq6Dr/y7BXZQyCKM6JuP6IOf5NR1xQeaQ
	 t14pGeBf5sOU0Gc8IKg8LE/MurUiwkbx5+mas5gMIzvkSRzpAn0ZJvl/4BgbSHCYpj
	 070tP2XnksziJ/UbDW6r/C8eV2J/3KGkxaU+E1BkKIH+MxCnZRH5+R6wfZvNfck4UQ
	 YoSjgwr4BJFYZHDA1e1hIr5ET5qb7rDNDZAHrlNbwWd09YhfuNaNe3ZwFJfZxxCdrO
	 EbOaamuwcyQdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2888CE1DD5; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 19/19] srcutree: Skip torture to-big transition for atomic SRCU
Date: Fri, 18 Sep 2026 17:35:21 -0700
Message-Id: <20260919003521.3134552-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Atomic SRCU does not use the srcu_node combining tree. Exclude it
from the SRCU_SIZING_IS_TORTURE() transition in
srcu_torture_stats_print(), and warn if such a transition is requested.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6a05bd8a6f39..6e37d53b412e 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2422,8 +2422,10 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		}
 		pr_cont(" T(%ld,%ld)\n", s0, s1);
 	}
-	if (SRCU_SIZING_IS_TORTURE())
-		srcu_transition_to_big(ssp);
+	if (SRCU_SIZING_IS_TORTURE()) {
+		if (!WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
+			srcu_transition_to_big(ssp);
+	}
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
 
-- 
2.40.1

