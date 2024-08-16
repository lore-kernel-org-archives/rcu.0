Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB17132117;
	Fri, 16 Aug 2024 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791851; cv=none; b=Qsb++ECBXW3SpkTDioifA7ObQ5lIMrgVNsV51bzoViyHaghwSU0I/GP4eJV7xGZXEXt3n8YT5bKev40DBvAB93kRusowK1Ekmpy02IVVCyHKQixdaG0v+oXPJV3F4iT45tewinIMkw7R8NTfCVEfpPm79hGfr0+wasVy43LqGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791851; c=relaxed/simple;
	bh=JlWfWfOshVrjXO5oIEB2X3rEfPtzchaaADjnIcIzEFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q822B4Lzt6ZTp74WZsvnumM7fAELZefymk7UI7Na6CzzQMUOB5aULxJ+rHh+a1TegDA3uhK+uA63rMVCQbvauQDizZbZSqqikRAPc2XQhy+3AYyue4IyLZZt5+BiZ0UROMhseVL0BxqGOftZ0SZfG/YVnwTZbK4bwpSyLwWlRYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKxhLb1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKxhLb1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B94C4AF0E;
	Fri, 16 Aug 2024 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791850;
	bh=JlWfWfOshVrjXO5oIEB2X3rEfPtzchaaADjnIcIzEFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKxhLb1MY75/OZAGComEnwRS/pBf3jgL8bSzOGUDa3prPQPZ75ELbgohuZmkekMtF
	 8+Z/kQLolrRA8FOj/Y6KbdoR1Yb38MXsnij00tmV5i6oDRiOaFCiE2PCAEYrkXnzwf
	 54eMY26vl2xr2VqCoTGcIxvMjZ4U+6xXaAqU3m8W92aNf2zeXuj7mVzSikjtwHIOhC
	 i0QHXQjKnylX7W9Gw3jSdmjLDBF1sXIVP8a6OfyxWxb32vgG0g1zT7QPD3gT+SP/7F
	 dE0kA9ZFYJkjS+sX3KaPvraDbCMv5HoKd2lOY72iV8GaaO0cFq5xGn91P1r4JZTHdm
	 J4UO/XrivHi+w==
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
Subject: [PATCH rcu 03/14] rcuscale: Save a few lines with whitespace-only change
Date: Fri, 16 Aug 2024 12:32:45 +0530
Message-Id: <20240816070256.60993-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This whitespace-only commit fuses a few lines of code, taking advantage
of the newish 100-character-per-line limit to save a few lines of code.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index d534d4ec2314..3269dd9c639f 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -1015,13 +1015,9 @@ rcu_scale_init(void)
 	}
 	while (atomic_read(&n_rcu_scale_reader_started) < nrealreaders)
 		schedule_timeout_uninterruptible(1);
-	writer_tasks = kcalloc(nrealwriters, sizeof(reader_tasks[0]),
-			       GFP_KERNEL);
-	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations),
-				   GFP_KERNEL);
-	writer_n_durations =
-		kcalloc(nrealwriters, sizeof(*writer_n_durations),
-			GFP_KERNEL);
+	writer_tasks = kcalloc(nrealwriters, sizeof(reader_tasks[0]), GFP_KERNEL);
+	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations), GFP_KERNEL);
+	writer_n_durations = kcalloc(nrealwriters, sizeof(*writer_n_durations), GFP_KERNEL);
 	if (!writer_tasks || !writer_durations || !writer_n_durations) {
 		SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
-- 
2.40.1

