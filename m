Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263984E11;
	Fri, 16 Aug 2024 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787585; cv=none; b=td2EBYTIKXmO/1TJ9ZXA6t3jRI4Znx1kc+JTWtMxyckgvY8MBuRu6Ccty4xVt3ghVJg/0kqtYZ76pT3fg3QX3gyTouBSqz82GuauAUBCrTeXVjPJXtt9fgcQyPE8vY4f3ccrTbPN0QoGcpeOmebcrVunX8MBKAIGXA9WNpNu3Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787585; c=relaxed/simple;
	bh=A06ciuKf6GsxbKLoWMdNskzKNB7/KQzPWx/YiRgRHhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4HzVILoJwmCzg3dq6rIsLFuYWG1tMlciKxPT0lTwuW8mQ0sYUq3QmPvTX7TP+90Cl01hflC2GRWap/YuxZQVtgk2+wxilG13/z9d16z0yEBCo7mFpzUlQnOS2jPGMPSHHSwjVRn8ifftpmC/CQtdel3nHoW+46h+Zo15gWPIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKOdjddM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKOdjddM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E41C4AF0E;
	Fri, 16 Aug 2024 05:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787584;
	bh=A06ciuKf6GsxbKLoWMdNskzKNB7/KQzPWx/YiRgRHhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKOdjddMzp/eZgqK6ebsFEfjBYKxQpXVauSfy1vSoVDPx8YuwNUXbfHvnv2flTGFT
	 B1BJbyKodxIEzHd2mm4uVLlc6Zhtar0vc4wwC2kqCi0bq5B1NttIduTnESgCLQv+05
	 FGteivRnYYMpgAPA0ZRQY3zaXBVR6Oa6VtOHK4PLYD6PKGDRmtV4qzc1Ffhpp/Qj8O
	 hm+Z9/HegfsqI1eHTCHohniqEsvSlpBTk2ZLYfBliE3ZZ8riFFIjGCsgm2MsDt7rui
	 eQu4Q91uXfObf0zUPGzYEogzjzSTw5KK3ZgjTu2PhNs91nyjTGYtwGC/LiTOByn+bg
	 42qXx3VEzj7jQ==
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
Subject: [PATCH rcu 2/8] rcutorture: Add SRCU ->same_gp_state and ->get_comp_state functions
Date: Fri, 16 Aug 2024 11:21:57 +0530
Message-Id: <20240816055203.43784-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
References: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit points the SRCU ->same_gp_state and ->get_comp_state fields
to same_state_synchronize_srcu() and get_completed_synchronize_srcu(),
allowing them to be tested.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 836e27250a8b..b2e6201b4569 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -736,6 +736,8 @@ static struct rcu_torture_ops srcu_ops = {
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
+	.same_gp_state	= same_state_synchronize_srcu,
+	.get_comp_state = get_completed_synchronize_srcu,
 	.get_gp_state	= srcu_torture_get_gp_state,
 	.start_gp_poll	= srcu_torture_start_gp_poll,
 	.poll_gp_state	= srcu_torture_poll_gp_state,
@@ -776,6 +778,8 @@ static struct rcu_torture_ops srcud_ops = {
 	.deferred_free	= srcu_torture_deferred_free,
 	.sync		= srcu_torture_synchronize,
 	.exp_sync	= srcu_torture_synchronize_expedited,
+	.same_gp_state	= same_state_synchronize_srcu,
+	.get_comp_state = get_completed_synchronize_srcu,
 	.get_gp_state	= srcu_torture_get_gp_state,
 	.start_gp_poll	= srcu_torture_start_gp_poll,
 	.poll_gp_state	= srcu_torture_poll_gp_state,
-- 
2.40.1

