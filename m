Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4F30F927;
	Sat, 19 Sep 2026 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778241; cv=none; b=DLQQuXcXG1goslAEDx7zCqxvFvLZtEdFzb0l19pS3Ldy+sRkOGANukj8IV4Ad4dYY6K5N0w8SO1gtioIG07VQ1i4S76qOnPRbG4qf85SUiN/irjE1l2Qjt0mbQf0cWChoCkO+gLiy9WmurXTes1IeqNLuRGyytMtYB6o5GuPowg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778241; c=relaxed/simple;
	bh=FmqJrAZgf83uWhr/O2RrdoQyz5q7T6Z9BbrpOHP6EgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZE6qqDR4BL+nriNaXw/S92WkaBQ4uC9dH1nPbe+UAZop4cULQRdVvekl9LEFbnnFo5dJN5gi/ugsFYi+XvudEOc7KLdfv/mzpkDjZ1BIrWDAN/z4CJRiAzNsq+DzKm31q3C0SCbskyD6XYZhNHO0PTnDV1KU3Et0mLa26uDCiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAJhZJ+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAJhZJ+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9D01F000FF;
	Sat, 19 Sep 2026 00:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778239;
	bh=G4eCcOJO+aKSpFNAvfrukSyyzmqc1ax8rCz74+sYbfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PAJhZJ+5keQU68Wf1+43UBBr7N+5AOJwYI5xuw/q0feHxBBwAiMU/k6/AmALMNr9t
	 4Bv7+MPoAVY8CQEZKW5Clg0xCwsCtHMzHlH8bHDGqaSco0IqtleQMNDijdfFFU4hO/
	 nuAP/UQppMfw8JJZ22/I5pBqplJW4fUT8lF67bTMDYQQ19+6I57xLI3YP0J2IEmM5f
	 05oh6+L59xvaNpHwHX9NINFF64KxpjQg79jvHyQFkyuZzNTWY6CxA2znUuJm715HXT
	 xEyY3StHaJmsmb6JtJwRglAXpiI20gKkMucv2wD/3eDJgrSn7V/tdGEizOI69H5wyM
	 1wStLxyc0S3XQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7C83CCE1775; Fri, 18 Sep 2026 17:37:19 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/3] rcutorture: Fix divide-by-zero with fwd_progress_div=1
Date: Fri, 18 Sep 2026 17:37:15 -0700
Message-Id: <20260919003717.3134738-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <860880d0-fb46-4039-a47c-33dd42a215d1@paulmck-laptop>
References: <860880d0-fb46-4039-a47c-33dd42a215d1@paulmck-laptop>
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
index 182d47975efd..79807475b672 100644
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

