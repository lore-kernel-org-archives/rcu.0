Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356815383F;
	Wed, 25 Sep 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266507; cv=none; b=WiVeDkTQIpfsucBHZbsAT5pHB80Ox/d9VHL00Mi3v5ssGH7m6oRMFhEfsMF/8y7ySKlP9FRwTul6KICRe4WVkMekCPa2nKxmzyzu7mAQtHvqFKZvPJmnkXb09cmkiB7AVayZoecDKaUTGycJH44D/R0zOX6F9bXLjUeLnIj13Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266507; c=relaxed/simple;
	bh=suCNrxQSzJkrAwGBhKIIJzKCKfoECn9gNkh0FL+q5xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpWX3zVxMiyBqPs064gk81SDwxF5K+gE3IWHEJVchGrU6WmldOs7IyXkgkgn14aMQMc1d3kF0t3WI2i7jIBI7fbMTbKgnD3O9koNwkUh5jJy6+Xdrphcetl0KbFYStSBF/tHACKM+lFfEgS/N8iRVVIhZ+9C61szXbK4/n2aqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpOy0jCz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpOy0jCz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68C3C4CEC7;
	Wed, 25 Sep 2024 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266507;
	bh=suCNrxQSzJkrAwGBhKIIJzKCKfoECn9gNkh0FL+q5xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bpOy0jCzpyfRVqV+aI8/G2PRp1LTxY2+lJ85bgUMTAvik+eLek4FF27NI6FRfXDMq
	 kQX/V4rH2W2CvT78UN1Rzvoj75MBJkX2Q2VKrOK5D21kOqOaQYA6L8fCZzpoHQqqNB
	 RttA2YriSGRIaXO2pjyXLDqhOCUN1b2i2Qp1BBcG+5QIMJhB+Txg2llnjhKD4NsRbN
	 uTmlYfTiaNTYgPwOhXmKtVx1uDYdG8QAZtRgF4XviPIKCxjzjv01YZF7224ktvDwVp
	 q735X1KoAFPax8LWa/2OPeCSzZXw/xrpDvPj9ra/uBra1Vw2EafWaRswwJEVbQr0X+
	 SI9nYSZEGrUWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 077/139] rcuscale: Provide clear error when async specified without primitives
Date: Wed, 25 Sep 2024 08:08:17 -0400
Message-ID: <20240925121137.1307574-77-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 11377947b5861fa59bf77c827e1dd7c081842cc9 ]

Currently, if the rcuscale module's async module parameter is specified
for RCU implementations that do not have async primitives such as RCU
Tasks Rude (which now lacks a call_rcu_tasks_rude() function), there
will be a series of splats due to calls to a NULL pointer.  This commit
therefore warns of this situation, but switches to non-async testing.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ffdb30495e3cc..ed46d9e8c0e43 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -498,7 +498,7 @@ rcu_scale_writer(void *arg)
 			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
-		if (gp_async) {
+		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
 retry:
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
@@ -554,7 +554,7 @@ rcu_scale_writer(void *arg)
 			i++;
 		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
-	if (gp_async) {
+	if (gp_async && cur_ops->async) {
 		cur_ops->gp_barrier();
 	}
 	writer_n_durations[me] = i_max + 1;
-- 
2.43.0

