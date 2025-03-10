Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90B235BFB;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631892; cv=none; b=TBtqlsZ/jVEit+CTRPE6+9+/MHwxu415MNDRFvRy28gWIaq8WI8aud0BLnytFWazzNxMyQUKIStJHhU5l055PZJhKQ89b0RKwjYU1WdOzN25hgqqLqXBP2MXxSZuK6xVu7e8w6HTNRcgNEZpbBorhuzAowbjarM8nuphvx00DSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631892; c=relaxed/simple;
	bh=XGyE/kRVLYcAJNHHvwpu1f6JtOQ0/1fOq4byrIOVY8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OxsucVfkxnDxKUpIvgFYcUCWhuafKaCBk+u7/cR62w5cfLrgDpd45uruCSDPLwOLE0HFcNHf83+q27fopmDYG3vIsFQVpH0DsmTGg2Jpbzz3o4kHMS0hXLXExQU4Ty4ytxC76j26YbqjuqqLTtMf/wTbEo/RB5tB5IRxfjQxSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ncnk7M0d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ncnk7M0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EE8C4CEEE;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631892;
	bh=XGyE/kRVLYcAJNHHvwpu1f6JtOQ0/1fOq4byrIOVY8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ncnk7M0dS5KvBjxInNT6aMpPKgBYP+9CQ/G9hX3gDwSKJpeEyzw0nI7j7TJmb/Kdg
	 /p5TBgLXCGbO6UoNxkwEeWc5puODCKLGH/0RX8gmCc75CBnI+G8ZS9EngrQnksjzCk
	 LkSLirC3iloAb+YIl4F6+qOS1pMUfwRuGFzzdszLg6bDJ/UtI6wJstrRt/5sJtOKDd
	 79fzyR2vrydwmWJXSQoDq5Pls+/2VCWF0liCnbFr09q2oPWPrZpVEg7R59AfMBupuD
	 rCGA4oHvLKoMzFH34XwK3DPRsJWnTig1FjH0B3Paq0zeIzoIE7A/SP3FRsEAYyNNTl
	 KA9TThUhpR46g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A07C1CE13D4; Mon, 10 Mar 2025 11:38:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 8/9] rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
Date: Mon, 10 Mar 2025 11:38:08 -0700
Message-Id: <20250310183809.3576320-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The down/up SRCU reader testing uses an hrtimer handler to exit the SRCU
read-side critical section.  This might be delayed, and if delayed for
too long, it can prevent the rcutorture run from completing.  This commit
therefore complains if the hrtimer handler is delayed for more than
ten seconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 3042a7950fe23..fcdd6271f435c 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2438,6 +2438,7 @@ rcu_torture_reader(void *arg)
 struct rcu_torture_one_read_state_updown {
 	struct hrtimer rtorsu_hrt;
 	bool rtorsu_inuse;
+	unsigned long rtorsu_j;
 	struct torture_random_state rtorsu_trs;
 	struct rcu_torture_one_read_state rtorsu_rtors;
 };
@@ -2522,6 +2523,7 @@ static void rcu_torture_updown_one(struct rcu_torture_one_read_state_updown *rto
 		schedule_timeout_idle(HZ);
 		return;
 	}
+	rtorsup->rtorsu_j = jiffies;
 	smp_store_release(&rtorsup->rtorsu_inuse, true);
 	t = torture_random(&rtorsup->rtorsu_trs) & 0xfffff; // One per million.
 	if (t < 10 * 1000)
@@ -2544,8 +2546,10 @@ rcu_torture_updown(void *arg)
 		for (rtorsup = updownreaders; rtorsup < &updownreaders[n_up_down]; rtorsup++) {
 			if (torture_must_stop())
 				break;
-			if (smp_load_acquire(&rtorsup->rtorsu_inuse))
+			if (smp_load_acquire(&rtorsup->rtorsu_inuse)) {
+				WARN_ON_ONCE(time_after(jiffies, rtorsup->rtorsu_j + 10 * HZ));
 				continue;
+			}
 			rcu_torture_updown_one(rtorsup);
 		}
 		torture_hrtimeout_ms(1, 1000, &rcu_torture_updown_rand);
-- 
2.40.1

