Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8A157469
	for <rcu@vger.kernel.org>; Tue, 19 Nov 2024 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732003968; cv=none; b=UayGCvH5f6k+Z42WNNVVhfAoAlHVOzXkmWdrYPIqj3FSSGj/NlaJ20DWUFA9Y2JUw1D8N+/3Qb43x/b9Sri6kiuGVC64h2GwIALS1RbuxC3vJwWu3p5xUZ1xxpdZDze4YG+E3vyPB34YNGqpGr5N2bnJMEgrU+dfPt4/uHLse0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732003968; c=relaxed/simple;
	bh=CazBJ3n+f02EQEe3WabvUTIZI5Sq9oEfv6QvtvT6vbA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=KvcukKPZEtVVvk87oczcZtr7isbSuqh13F1RoLtE8JJwAIG0dVbMQ5UBLY4hV8VN0ATHZbuegmCViMxQUzcPZmbvys52OKcysm47mXo4eumtS6Ktl3f8y6e+Kff+wNL1xJHiVIEGXjeOnPmGki1CNID7sZSnNrQdzQSN0hOMdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jcQDDMJE; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jcQDDMJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732003959; bh=Yofk1ob8af5jPXo5+73rcYHPj7V+HmsEhFfiLt0dWX8=;
	h=From:To:Cc:Subject:Date;
	b=jcQDDMJEz1cpNONburBw68H2sX5yBNiIKb3t6/NhOgUmqk/QLEIYUFCpbStM3O/HQ
	 xT5ePp9GHltHIZBZUA5DVZi38d8UdpCUrjfG7YnEs6OXXVmgvQPxXt5O/Ct84TdzwK
	 qd/zYugjf1BySGDUHqQPpkA4S82WA/7cGJk3ULpw=
Received: from localhost.localdomain ([36.111.64.84])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 7A13668E; Tue, 19 Nov 2024 15:30:33 +0800
X-QQ-mid: xmsmtpt1732001433teosw1ykk
Message-ID: <tencent_E213C035373D59F2469A887D3D60498E6B08@qq.com>
X-QQ-XMAILINFO: M07Ulnfy3VHKFwilQDo3iluzG+2C5ojMAH/+mIMjtbLwwEgCnMb8FxZ4kXb62t
	 rRRUdGBjts0ev0T2QaFwy11sjnObRi4cAKdagmWgcn9h3cqUCu7CQhCRPU7yO4yLA5IuM44Kkg59
	 p7DRmjEuWRMSnnLf3f+enYGjmqLb02K2Ql5nR43reyCTJOHRFN5jLKmRgpg6jcQi12rjmFDAmU32
	 HaaSk/cueFkHG/ZwqNAkBQS0PBbVVZ4kPEzqRF/B6gMsS2kijdMBe8nQceVnYC5qxyyjDrwTpydK
	 7ip8B9CpPZd2PNySolicjkICUycqmTlxQwJQUocG4YcL54Xv7foodPb8AQrNe4ob38+b6/hQkslU
	 yj8CCXQbyC6iiwSZmfzKTHP87AuFy4O50S1eTUXXBqIa/Aj277qYd46wkodbIYhZkI5DQZlJgHvG
	 NS2/A4c8jjOl6NTcqMr9ssoRzhpWeTLl0/JwnRq0zcHKt/KXrvlwqwMc+oILpbb3IiS292Nh72QM
	 enbPT1Cn8DQU3V9g/SibluNqvvHf+eqhYXE3RgM9Bcr/axqjPg9A1wFmymgnsyZSRwLgu1+n574P
	 pfobog5FX09WaVvT29ukSdiqeZjHrORRkTauwHUDJTM6KIYFjtSQnN/Hjp0fOCK6wDoGoHvK9Jtx
	 XJrTwcOHMLvG5QwEQF1dli8e0sf7wtRhCS+hvrZGhb4mYZ2YL4gvf8pv4Fvzbvf6ADRBn2eEe2Cl
	 cKVPeglgQrO7/JrajjxPGoGBxGPTMLaaq6g1Kz027vWQRY6MjE5kU7EwbK476gFiK7dQkLULB+q1
	 qGyieEyiK7RKEkAgOI05fx8VoDW2gP+BOtuqfdwJC0lElJZiQAytce3igAY0UBCrYgAwMNrxOfZz
	 mVuATx9SzJ9WGhhOYVHU7+hLvstgGSpeo7rL2BgpvdMEcQdLJxaVXakrX7tQkehGkUmH/CgINrM7
	 LL4/nu0bFJrEQ2qGr1dJHqoFkKYiPeQ0coh/gaaRO2XxEGVBCuhxjIhI5Y/s638I+cMvhaX0I=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Feng Lee <379943137@qq.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Cc: rcu@vger.kernel.org,
	Feng Lee <379943137@qq.com>
Subject: [PATCH -next] srcu: Remove redundant GP sequence checks in srcu_funnel_gp_start
Date: Tue, 19 Nov 2024 15:29:49 +0800
X-OQ-MSGID: <20241119072949.2698-1-379943137@qq.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will perform GP sequence checking at the beginning of srcu_gp_start,
thus making it safe to remove duplicate GP sequence checks prior to
calling srcu_gp_start.

Signed-off-by: Feng Lee <379943137@qq.com>
---
 kernel/rcu/srcutree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5e2e53464794..cbef5674d201 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1076,7 +1076,6 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	/* If grace period not already in progress, start it. */
 	if (!WARN_ON_ONCE(rcu_seq_done(&sup->srcu_gp_seq, s)) &&
 	    rcu_seq_state(sup->srcu_gp_seq) == SRCU_STATE_IDLE) {
-		WARN_ON_ONCE(ULONG_CMP_GE(sup->srcu_gp_seq, sup->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
 
 		// And how can that list_add() in the "else" clause
-- 
2.47.0


