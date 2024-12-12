Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB318FDAE;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=SfzAmXsZN2gnc2PbWjV9Evq99vpt/lmJSPwUFW+vlKB1GvnaRaj5f45qgtmbJFHg+5ZjO83VkGjkArfO+ubCd+BJvdo6UpoTD5v8dEsfBs6cWbarhjOccejcg0I8xkS89+t8IIEY9B6BkZ7vOGqmANN4gRWt+rXiU285I2yvVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=adrjhc2ILHgU48wVpxpLwqAyC/ZoOex7BnPn/Un6C5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcYTE3mBv8rC58ffe3pvVljlOUgAf85kVwSenr3CWWkDm9tt1BZV5+xn70l+tPbgC9UCx9W8Y1olU6ILftGEbFs3PDObioL9U48RozKZ8UNZpEIGhCeJJPMUhz1k/x+22azSshfU5Vh/X6lSWAWn6z3xWwisjflwMNdw9sqaF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqAM9maM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqAM9maM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A949C4CEE2;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=adrjhc2ILHgU48wVpxpLwqAyC/ZoOex7BnPn/Un6C5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqAM9maMtgdw/iWHO9uplPO19rCifURb+ZFX+vgqWIlxHmjArDass905WAndJpBLT
	 33X4BSLWG908H+ggzo/dokp23ipi5Ad3CFisTGvzDB/U+7WDQOq/Y2bCOWrJKwj6PU
	 AIOJnEL7QhRSrN+7mdQf7e4feKTfcXuvjFjuWXUg42loXStBhz2XIDmJaVZLkCB99o
	 1rnsFM6UEsF/AFRTtKFz4vbr6dNaNLwcLbnH8LSznpfeuyuTjIq2K/jqE1CWoeTFgX
	 9LWwyIJVef0x3IpIkmlCCp3gWL974A5V03jl7EHykIuZUkkA8Z6lOyC0TKnT3+eDMC
	 WH41bf6MO8QvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2303CE0FF1; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/18] rcutorture: Add ->cond_sync_exp_full function to rcu_ops structure
Date: Thu, 12 Dec 2024 10:49:45 -0800
Message-Id: <20241212184957.2127441-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_ops structure currently lacks a ->cond_sync_exp_full function,
which prevents testign of conditional full-state polled grace periods.
This commit therefore adds them, enabling testing this option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6067f2740247d..658ac46581d81 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -577,6 +577,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.start_gp_poll_exp_full	= start_poll_synchronize_rcu_expedited_full,
 	.poll_gp_state_exp	= poll_state_synchronize_rcu,
 	.cond_sync_exp		= cond_synchronize_rcu_expedited,
+	.cond_sync_exp_full	= cond_synchronize_rcu_expedited_full,
 	.call			= call_rcu_hurry,
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
-- 
2.40.1

