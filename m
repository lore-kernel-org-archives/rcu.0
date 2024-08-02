Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D815E89;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559391; cv=none; b=m+Ll7vtZRwLqmkNM5gQUSgHqS8VyXKOBBDJZ/RaZekaDwsVgdHi6s1vvGIgPvhYd9nFFJcE1kGQ0nZDdGVqDGNn95K4DSFRlVj6hv5YgKu4lfNJek3bOOpPgzRTO7+cUMy3xQlh1QlombhuCdci4f1xnf0Tee8k3QSEGMO7HmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559391; c=relaxed/simple;
	bh=cISelkdGqljgDeI2+QcSA5s1XZGf3TYnjcH1wmM0OdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSnWYmSYpv8cmJWGzzbrfZeIM1J2GvZdZGvbyte/VUv0/htgglCViGETOlYlD1q4PRbbjrjFa4pyk89LBwVDUyZ3wwQOtUVcsalq6l7UC5eJ+FW9dlNl93x76zIkDWX2Z8WhcLqMVgYZYOimGyil+AulCPxCNz1lOkRlZ66d1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjDgN8vn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjDgN8vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08670C32786;
	Fri,  2 Aug 2024 00:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559391;
	bh=cISelkdGqljgDeI2+QcSA5s1XZGf3TYnjcH1wmM0OdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjDgN8vnv0H0AAhrda5LwUO5Kyi1T+RuOPT+grl1MdPMyG2S2Mb0EsDHMO4zftjwW
	 nu0/3oZ03SBMpbRwmS6CTXhqEVo5SXJkgr3V2nLP9PC4ixvv2g8k02QEBI6n0GmYcH
	 nYhANZM/+MPikZUyT6/0qPnUww5hB1SVtwcvix6Y/qDmAVnZICn9yGkCez5zuFRd4D
	 dR0EItufThTc083wZUa8wT7WZmMvhExThz1L0sWYi8PEpAF5Ph9DV6haYJAB3nF6Pr
	 KrsM6sOgi08GkL7D3SgVDiBIeC2wpu32Rkw6JzmFzVAWk0hvWoRHWyjLRV2CuqS+wR
	 C7eIrUoYvzgxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B6AB8CE09F8; Thu,  1 Aug 2024 17:43:10 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 01/11] rcuscale: Save a few lines with whitespace-only change
Date: Thu,  1 Aug 2024 17:42:58 -0700
Message-Id: <20240802004308.4134731-1-paulmck@kernel.org>
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

This whitespace-only commit fuses a few lines of code, taking advantage
of the newish 100-character-per-line limit to save a few lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index d534d4ec23147..3269dd9c639f7 100644
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

