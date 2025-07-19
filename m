Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502AC13FEE;
	Sat, 19 Jul 2025 00:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752884899; cv=none; b=G2KXXsuELqzfhZIRJe9bKOuUtGFfUrWCavwU8okEAEiv0A+pghBsWuae0Yju1NUUHlMxzWheKMXY2y6zmBCjDiB6ngjXhZGDHqQ2oBOWLggEC9pUtmVklySjh93AyQOE4LPakl1NT4VFkoAEThAcQj8TH5LOYIn9ISzwcg83Btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752884899; c=relaxed/simple;
	bh=BlaBOIkXVR5xoqsab95nUX5wZC2ogd2y9wiA1pKiHvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLMpA363cc5ARJmiXBNs4DPHgTmyHQNamA0BkXXLNbvNmMU0gQMyc8cbEepBuLDYOU8ND5uXa/dwaWH3TteM3BaX3yXNwwlBEUjPcaxrYa7gmHIIfT2HzJdV1X+QtSyBTUbQOkJsqxo4tu3aNj+q7iqQAuGCXi0fSQ96HG90h9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3yVfyRS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3yVfyRS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D9EC4CEF7;
	Sat, 19 Jul 2025 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752884898;
	bh=BlaBOIkXVR5xoqsab95nUX5wZC2ogd2y9wiA1pKiHvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3yVfyRS2ue4vgmK53aJk0P6HiMmYuA7qjTqg0ZPbFFD1mPJY7/1KLCntptvFbbH4
	 SW/olTypliXUoj+FLaRkEpCV8g6hVn52+ncXpYUV+w0Z/NOVXc4cTpH3uisvu95nSC
	 Ie2S4WqQYtwDok5oGOdrRCxjd1iATjNcguPPyt2/tW2c375ajKEdimX1J6qo8Uyo+r
	 sAkoOfzKr/Lh3+8fpJlf001DJqJBP/DYCIIdTCo90j5uH6+HhNKAo+fOBpjyN/bdZ5
	 igeXRnePlvwSH5yr4NnNPahUUEJqZXc8/LcPBwoojMh4RF5aWGoXwp8/dXQNS2b2MF
	 NPklXUqs0v1Fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 80477CE0DEB; Fri, 18 Jul 2025 17:28:18 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/4] srcu: Add guards for notrace variants of SRCU-fast readers
Date: Fri, 18 Jul 2025 17:28:16 -0700
Message-Id: <20250719002817.4121867-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop>
References: <3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the usual scoped_guard(srcu_fast_notrace, &my_srcu) and
guard(srcu_fast_notrace)(&my_srcu).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/srcu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 7a692bf8f99b9..ada65b58bc4c5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -515,4 +515,9 @@ DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
 		    srcu_read_unlock_fast(_T->lock, _T->scp),
 		    struct srcu_ctr __percpu *scp)
 
+DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
+		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
+		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),
+		    struct srcu_ctr __percpu *scp)
+
 #endif
-- 
2.40.1

