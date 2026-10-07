Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98E7374A08;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407050; cv=none; b=NJN4sOfKbMHGGjwiP+x97r6B0Y92+by/UThGgGqlQOid3klvhVGWfRX7KR1oanMDPj9T/PKmjgMM71AAQtBQgREQb+9G6UF7PYCcq/bq+IK0iLKHsYyfp4GpheYxJtpvJJyJw/blxL/5m3R7leMNYF63dMhI9hNGYPj+BR5qEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407050; c=relaxed/simple;
	bh=WtMjVXboO3SA/QrwmQvp6WzTsW+TZtghOId6pS7D2Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OdVLX5vH72vUt8UVA8GaBNcMk6PaDIfL8uykiMP5Lv6lHq4zy3YNhnrjXL+pp7tSx0doVkKkMPne1X9+IkFU+/rIpXFPKxvnd6pBAKMKbTzzlFhK/kxM5P+AGLN23njww8Y7uOEqqsSa4pAJAwgrNhAgvoObw0ZPH9UrHexqpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFVMBgOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFVMBgOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC441F00893;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407049;
	bh=t+wcEBMEjxLX0pabaMBPIBCJDpnYqEbIdFDm8n5HC1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFVMBgOoYm6XT5A0PCy4+rwNI2fWHkHMHV/IgUMmn+KJLSNbU5OVBlv/HhJKOaY7M
	 FCQANPX05EAEq7YPd9zect0iViOtIqfHKKZoAeuF7zdesn0B4bs5ZPuaGmWPHcaqqZ
	 vkI9tF+6N+ixkFoqN9L2R+6DhqPL11xpVFKol61Htk0QT+wHMvZ1cl2iAEYsZ8JfgZ
	 03Qor4ov6e5s6TIYeE8vY0iBko7mcvWR+oXh22tLPQ0rICFNn5HoNybFSvArb78mxP
	 NQBwPyuSyPiyAa/hRnjTJz8fSXHTxiyCaYAfmY5I6iIHKnXHHVOOgrG6MNTeD83tEw
	 P0k/l/KPyPUgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F736CE0D79; Wed,  7 Oct 2026 14:04:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 1/8] rcutorture: Fix divide-by-zero with fwd_progress_div=1
Date: Wed,  7 Oct 2026 14:04:01 -0700
Message-Id: <20261007210408.1983713-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
References: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

When fwd_progress_div=1, the forward-progress test computes:
  sd4 = (sd + div - 1) / div = sd
  dur = sd4 + torture_random(&trs) % (sd - sd4) = sd4 + % 0

The modulo operation with a zero divisor triggers an integer
division by zero (undefined behavior at the C level, #DE trap on x86),
causing a kernel Oops and panic. On x86_64, this manifests as:

  rcu_torture_fwd_prog_nr: Starting forward-progress test 0
  Oops: divide error: 0000 [#1] SMP PTI
  RIP: 0010:rcu_torture_fwd_prog+0x90b/0x1160
  R12: 0000000000000000

The existing guard only handles non-positive values. However,
fwd_progress_div=1 also makes the random range empty because
sd4 == sd.

Change the guard to reject values below 2. The forward-progress test
only reaches this calculation when stall_dur() is positive, so
sd = stall_dur() + 1 >= 2. For fwd_progress_div >= 2, sd4 < sd,
ensuring that sd - sd4 is at least 1.

Keep the existing fallback to the default value of 4 for invalid
values.

Verified with QEMU/KVM: a 138-second run with fwd_progress_div=1
completed 81 forward-progress test cycles without a crash.

Fixes: 1b27291b1ea4f ("rcutorture: Add forward-progress tests for RCU grace periods")
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 182d47975efd1..79807475b6724 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4024,7 +4024,7 @@ static int __init rcu_torture_fwd_prog_init(void)
 	}
 	if (fwd_progress_holdoff <= 0)
 		fwd_progress_holdoff = 1;
-	if (fwd_progress_div <= 0)
+	if (fwd_progress_div < 2)
 		fwd_progress_div = 4;
 	rfp = kzalloc_objs(*rfp, fwd_progress);
 	fwd_prog_tasks = kzalloc_objs(*fwd_prog_tasks, fwd_progress);
-- 
2.40.1

