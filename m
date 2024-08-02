Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42317BB7;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=EaO2StBo4fsM5udS4rjJrKFVm8gWGE69l5FtVmHX4j+aMFxkcETvjVC1uK4TAjeIlG3X5rQ9vnAstdjcG/LF054BO+esi+GSYydprOKjd7U4aAf9izQpgCMLBsuOEVhmb3jRJSS42JFdNssPOwxtV8WPuZMYpJk6agQzm7Zeh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=AEzkTPCKcNGzv5Un7TZuguhoYqpHfaG2unUtIDA5KrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSfGwciN5yq7XWr1Tw/2vVBlJuvKqfZbH6iu2QI/l2vAl7EKroXqAZDmIeXx8ulbG8xkHNL9fZ45T867NYKBRgk2vu8V5XHhKdbUl3+rixQT/be2KF1hnmDWkiS+m71XYiDVRwz/uejpDjl48XojLmjQTOAwEqT83xhyBKmxMDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEzGCdj3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEzGCdj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6564CC4AF11;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=AEzkTPCKcNGzv5Un7TZuguhoYqpHfaG2unUtIDA5KrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEzGCdj3zGWsz6VSJzTbOsaxJUwMoKotUWDArHHs2FuhtYnnF1l5Lp88f9+8nBbt6
	 P/TRaFkM5RgnTzSe9fA/JeiIIFflq9jfyZO7aVOFhGIjozs2qudAOC4Jzf70b3gCOw
	 N7o+6kDaF4uTVQhtdBRgdZVxBZterodI9/ARJ1zBohjXKfIDgYSsaQwmO9ThBDJjSA
	 fikkQcgErkv6CMrU136FHmEf615Ee+GKYl2PFxQ6HZ55VDUbqQWqpUEpAlL83V3z0h
	 YQyghbRlaen5yseQa5c0KSXuu7xwZJGEyfMq9SCiZo0jYXQSu//yS96sNPpHh3CxAE
	 YGKMbmxEYO+IQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CB57ECE0FA1; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 06/11] rcuscale: Provide clear error when async specified without primitives
Date: Thu,  1 Aug 2024 17:43:03 -0700
Message-Id: <20240802004308.4134731-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if the rcuscale module's async module parameter is specified
for RCU implementations that do not have sync primitives such as
call_rcu(), there will be a series of splats due to calls to a NULL
pointer.  This commit therefore warns of this situation, but switches
to non-async testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 933014b381ec0..315ced63ec105 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -525,7 +525,7 @@ rcu_scale_writer(void *arg)
 			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
-		if (gp_async) {
+		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
 retry:
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
@@ -597,7 +597,7 @@ rcu_scale_writer(void *arg)
 			i++;
 		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
-	if (gp_async) {
+	if (gp_async && cur_ops->async) {
 		cur_ops->gp_barrier();
 	}
 	writer_n_durations[me] = i_max + 1;
-- 
2.40.1

