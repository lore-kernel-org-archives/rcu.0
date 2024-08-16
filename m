Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4178C7F;
	Fri, 16 Aug 2024 04:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723783217; cv=none; b=UElgKUQZ8XYejqfYJONQFz6y7Dv/ikCdSJilmVRz4a+HkCamEJe9NQN175wS8gpeIUHNNCSteV+QqCEi2wAtc/sgQpFZSp2MXmcfLJ5R6Fu6HfDc8Kjb1eET92piNgOJdOr/m+Xz4UrMlyRMXUt2XtYtx/taGKfnZGd8DzzM2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723783217; c=relaxed/simple;
	bh=Hm+00HyEo0NUhcopTYyewIN1gBN8VeHMjOGtWEtmn+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpJRtpUeJGNG4PmEqJSBKDpWftKa3+8eq4Oluz4d4sMQNka07AcEpRJltzme2icavuWXH8UqPKVLz6/Qo7jRFwVL2QbqTPhLqNVhLO6bPDzided7TpEy/kw+7XS53XRF+FqhHrqDEKMbCDu9FZxXZNmSryEu7Nnmlx5IuvlxGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nk33G0lY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nk33G0lY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C706FC4AF0F;
	Fri, 16 Aug 2024 04:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723783216;
	bh=Hm+00HyEo0NUhcopTYyewIN1gBN8VeHMjOGtWEtmn+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nk33G0lY9gQjk/vtyj3QlMfl2o3aPhX7CXOBrPpbNloWYwkabivJjm5QFzO+L2ahO
	 Qpt5WShIRKJsUpfxsYEJvrK1EapfX9p65jzbVnuFyGY4+hc+eXirAHa52tH7tVy3Ah
	 Ie9o+ZTAp+oxKlUOt7sXZBeGR0ta2/cUB7OQgZ0xPSc+L6SMB0tyG7m+A3eGLnnxqy
	 Mh9LxtPLxKFA8JojoJyspGyrG7o27nvHT1InFbE1z1cxCzT5XyrOXevIhBzcZ87Cbg
	 v+mBCKAVbF2xKJ3E56pAwV4z6V51FugnF7fm+Y39JdbV4AJcM2LXqbyIH8Mbnp73+g
	 2WOmNRNg/gFuw==
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
	frederic@kernel.org,
	mingo@kernel.org,
	peterz@infradead.org,
	leobras@redhat.com,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	tglx@linutronix.de
Subject: [PATCH rcu 4/4] smp: print only local CPU info when sched_clock goes backward
Date: Fri, 16 Aug 2024 10:09:17 +0530
Message-Id: <20240816043917.26537-4-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816043600.GA25206@neeraj.linux>
References: <20240816043600.GA25206@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

About 40% of all csd_lock warnings observed in our fleet appear to
be due to sched_clock() going backward in time (usually only a little
bit), resulting in ts0 being larger than ts2.

When the local CPU is at fault, we should print out a message reflecting
that, rather than trying to get the remote CPU's stack trace.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index b484ee6dcaf6..f25e20617b7e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -254,6 +254,14 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 		   csd_lock_timeout_ns == 0))
 		return false;
 
+	if (ts0 > ts2) {
+		/* Our own sched_clock went backward; don't blame another CPU. */
+		ts_delta = ts0 - ts2;
+		pr_alert("sched_clock on CPU %d went backward by %llu ns\n", raw_smp_processor_id(), ts_delta);
+		*ts1 = ts2;
+		return false;
+	}
+
 	firsttime = !*bug_id;
 	if (firsttime)
 		*bug_id = atomic_inc_return(&csd_bug_count);
-- 
2.40.1

