Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A142E40A
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767952; cv=none; b=Z492uQpgCfgEK62dcDY4FTumu7b6BLRLQW2N+CEMm8cVF19qgyu97IatiTIdbMHGhWNKEwHT+o67Kof+NwukRiM0WMiBfqInBiwNhaIvKAUZvZIITRIQRbB0zz01+kRnzqs3t/qf6rxvBkdKlB4XGHy6bm8b5+zfHPEbwBT9B7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767952; c=relaxed/simple;
	bh=3OlCz+laqH6rl0bpjSr713iDWvV7K05sGtsflbnXZRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9QoqhZ4bcSIcS/UjHbA6WL0YEN/yfFqbHPWdImO4Jp2HrjkByFn8JIBqPd3/zFh2mdxToWge3m5wgd7Hg6GhOU+YU3CLdhwOYHCO4El8suZ40VrXGXcpJ06MQccv9omaLxwWj+4L/p9pLZS3WxATrZLrYenZ7Kzl0Wh4yDQH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r9p54H6B; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9p54H6B"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d58efc7356so40724495ad.1
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767949; x=1789372749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+pwFM3pOh2VpEH5TcABiF5v+6kZ668JjyW4E61muF/Q=;
        b=r9p54H6BzCL6eiU5WZn0eK3f5oVJls2dtSt+S1p3oiTcKQGriZ8ILD8Be4Aa4kBdNC
         KDc/YZyA4rpE3DYx27Ou9WXFXrE1HjtyIdMwayrTsjcarz7/1LXtXDDjSIaVDXo2v5oa
         KrZ+xaxXoPmL1ub9T4B1P0+alM2CtKtTNzA/cAW9z0A06Kouh/0fHG4nojaoUoBuX/iC
         NFDulwtWS0kNR+jDfg/FDwYBdEFvN/D5w8VSD6iF8Nq1uu7hgnjw0QRd8dGNUATGSoEc
         tb+nwUZeP8LuQGtzEgfrR7KN0/5exKmYidVRLBy+gN7LfaBl0WW7alYcBJudgrmmOXPq
         OLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767949; x=1789372749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+pwFM3pOh2VpEH5TcABiF5v+6kZ668JjyW4E61muF/Q=;
        b=NABRj1ZL1MULjIwCSg99uycfY1x2FEE7absuhsDvuBWnx4KVklRlN3iS/xRR+8ZUzf
         VSEirg08IQKD9BNfF9f5LfFAyeVP4SPPcP1JRpwfvo60mgPmzEFCEk9PYvNEXQvUXgbC
         8Fo4WQDhsc8IEqaLVRCIs+/9MEa8ke+vUtLpJB/3c01Ve8CuAKJrpCbsVQtza7o7tFsq
         AxH+UEXwL/MQWHMR7XaGSiwdHP2ftuGFo3UyYEBSnH8zYCxOGriUMptb4kcMAy2Ux7hk
         yBBPOHSjTYBeqwHToF59xcbRBDbAt8my0UmNxOlxLsraRAzDIJQMKC/ntv+romKXQ9zE
         kT0g==
X-Forwarded-Encrypted: i=1; AKwUvBzI+kQTLe1IIR9W3mCqriUPj5HzJ3SvodjujfzL0sSnzMyOXoPaN7GdC1QfZz/gblEQGAc=@vger.kernel.org
X-Gm-Message-State: AFuF++l9PbNG3JII5jDdoG80OSWMRg4prRfXD3zYb+DleY96WVpHxu2L
	kCufHGc+4/eo8oWU1ZzspW6wKD7oduqOpY0fIxFh6+eGnJa0sxWjc9+6
X-Gm-Gg: AYBFou2ZBbCacdw28REhttD5bhw3L8pUbWWIHLfz2hw8IRmhzV4+kVlp400tJ65ROtD
	gjDzvd54fb9k1rCEUTgO5CQNwhP70+Y7PT7HXGvZ841HtmsslnWsBK90DzK6UqwSiqnHQGE29q0
	szE241KjVkE8LKhxYs9IYSxNmH13MGf5WH7cQHlXN2990YoEoaN3+GqGlVR1USea/1ybX7R5A9L
	AxIF83jz6QTqviBRH4lmGY5f2x7BKLJaanN3xlRxPcyKQ44mgu2tFUdxO1mUGtY9A+GUNshpk6E
	exkt9GGo16rS9ET+wCQfU6sYq8t0uMM9kQSWVXovQRcbzPKlgj45alHzt7uHrodbHpZdcp1P0UV
	HmfoH9lbKYE/s73y4OOqjBmTOec6L+X3aMG8MnJkpvd+Rk+9WhY3x3QumhV8Eu8sg6qGWSaJ+/3
	QPQLLuQcL92zkPLkDrBGop9ffE49ydzONOovRQ5N4UTurcePf9eD6GK61VcOWotwDBvFzRhcEr9
	sHAZF4=
X-Received: by 2002:a17:902:d492:b0:2d9:68b7:c324 with SMTP id d9443c01a7336-2db125cce1bmr292519975ad.3.1788767948538;
        Mon, 07 Sep 2026 00:59:08 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:59:08 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 07/13] srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
Date: Mon,  7 Sep 2026 15:58:23 +0800
Message-ID: <20260907075829.2073224-8-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907075829.2073224-1-kunwu.chan@linux.dev>
References: <20260907075829.2073224-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

The transition-to-big code path in srcu_gp_end() calls
init_srcu_struct_nodes() with GFP_KERNEL, which is illegal in the
atomic context reachable from synchronize_srcu_atomic().  Atomic SRCU
has no use for the srcu_node combining tree: it has neither callbacks
nor srcu_barrier() operations, and its grace periods are serialized
by ->srcu_atomic_gp_flag instead.

Skip this transition entirely for atomic SRCU, which is also defense
in depth against any path that might wrongly set ->srcu_size_state for
an atomic srcu_struct.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/srcutree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 01f224a56b41..74acd5645d4c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1074,8 +1074,9 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 		raw_spin_unlock_irq_rcu_node(sup);
 	}
 
-	/* Transition to big if needed. */
-	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
+	/* Transition to big if needed, but never for atomic SRCU. */
+	if (!is_atomic && ss_state != SRCU_SIZE_SMALL &&
+	    ss_state != SRCU_SIZE_BIG) {
 		if (ss_state == SRCU_SIZE_ALLOC)
 			init_srcu_struct_nodes(ssp, GFP_KERNEL);
 		else
-- 
2.43.0

