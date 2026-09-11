Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B0403B11
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789111330; cv=none; b=O1+kccKYm6xy9GSBH1oqeQwLqcAt4+qXAIt8CwQ4yxG6uaeaKlfxV2gf34O/kk420wMkA5YjC7irIdY5nvh78/1JNMC3NGfbJaLE8uP8OkrCZo++3MOYOwVz15ruTaa2Bz+lZ7sAVHd+DItrJwGiZmUDwtsqmZ98v4qCC4GbJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789111330; c=relaxed/simple;
	bh=lFzg1MXITlP0YPhhoCXm2dI0efV/qs7X58nFUlpexRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsnlP2D8MkMu7xPlfIPRzFgjMnGtC4R9W5bkPjQVbc4p9ykDgH/JAG04/YTw2RbIUqgx5uCzlxcpffOM0cQlNiTHPZCxOGemUHHk96b+RZiTaeRehdQLufg9aYgg6xgBmhXzSwA46j8cLivF5SV7rHAW5woZzVhotlV4Po7iJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0OYgPIl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0OYgPIl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d8f265cbe6so5733595ad.0
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789111318; x=1789716118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jzIySDJIl2DBofVkPAxMDaItjAN5Njq5eDX0RMJ2Xb4=;
        b=G0OYgPIlJmiX+wwhGdJSRzlmiSBEf2FA9CYiOcz97B/TzQDhnNpAWBndbxrmVCxYPK
         eVZ8Eu+fPOMpr8cGWiXgMedUwqJD1ZmSVUQ1RWSM3kMy3zOwLL1eSzOR5RmExxoFENR1
         yM5IXq6kX+4YDKZWc0UBy093p4WxbLa8UFuq5onTh7P+ITxhow+GtTlAk6M+MqjVt3Dy
         rDcvMKrbpa8fiZXXmgJ3VjjoYRnw+NutKx91vx1LXI2S0fezXXgzKa6z2w0Hc3kbAVJj
         WH/erH9naNoPuXCjBqtJfXQ4PbyMnNgePodqBQhAJ8U7s1sQLdvMqoCTieqpOj/aSaRd
         ts9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789111318; x=1789716118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jzIySDJIl2DBofVkPAxMDaItjAN5Njq5eDX0RMJ2Xb4=;
        b=MxNA5Pbr4pch5t6k3gVUOGe/vBZs/fYa/nbIcqc1TqW0mOCrf93/iiVeHlon6ZkorQ
         coxpS6LFjfF6ETcmtWhX9VzNGV0Y4q6D/MQ5Ccuj/yZ85vzSH/F+b5VPWukhiZW5kfZq
         z5ho1Cq1QLrtRFzk79e2Yw5XvnA8Wjc4pP6EXxiEdBWrOMyVgaLTTOuF5vJUve5bwIIp
         f0K4HXWax7l75ZsptgR8Ax7csjxsf0ji3Wgy0UMWbdJfqvAkPOf1MnppLzjGnX9+z4fL
         6rrI658LZpL4MCQoo4ASOqUGHr5Yv0R1X1Lj3V4mLhu6DC0jquwoiFFMoJyGvQZ6edFw
         PZiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf5v8/ow5MjD/wn4ztctSRoLYub11xDLjmA2c2fBU/Ks20WxvOQoRw0HNTwGzpA79lsMs=@vger.kernel.org
X-Gm-Message-State: AFuF++k0Q69zXzz0Sk9junVWuA//EYlwEUDxALJ9YrhOlk1CEcKzTDRS
	7aK+lmQCxrKG+1VbKF9HNBQwQB4hrzbvyOVLwusZwYJdGPL14g5KFPpa
X-Gm-Gg: AYBFou3MeAZYOL3jFyZ0qkAoHLjwLYOHggTYOpcvqgzF/p4Eg1LR7t+BT16ebnmb5Eb
	ZEbuSaX0/mYiiqq9JtZFp6Ipf3fRBT3dDRviZ/SrOsfCODtED3dfKuyhwzO7TuM75ry3Tn3vf6M
	NBuN9aVOZ9Ec/SaVArN05cKGzSzrhvybCCLPbgfYzEuYShLEib/jvJkfuM5MJ/ZvRCX1DWZq974
	fYFB4+z6MhsMDITo6J5E1vpzZG39F5S+b+cna+cOv+tdmVeDQs+uCXmdKY6OAxHMetJCcGP2nKc
	9MAJZvHKfwKMm7v3RF4j2maOuTNJBKmtQfV76MKUps96qN1NswNNwtCzv5HS23a7RTbbN8duGZO
	1RlZooA/Qe3p/N9iXHyDXtV0hFgq7osKlwDWUzETBtTTo6HHRjCOR7GbsEJklBWKNVjPV5T+Jbv
	wxrmfvSj2bX90DplQ8zbIJt/7b+SfwOIlNmg4lcHojufPftSknp002YjtshwECJFt8sk/xPyr6b
	/IUHRTXurxuVSdK6IxE4Etk01Pb
X-Received: by 2002:a17:903:46d0:b0:2ca:660:b1d with SMTP id d9443c01a7336-2dd2a347a88mr58895465ad.11.1789111317511;
        Fri, 11 Sep 2026 00:21:57 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cca26b2sm7245945ad.4.2026.09.11.00.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 00:21:56 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v3] srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
Date: Fri, 11 Sep 2026 15:21:25 +0800
Message-ID: <20260911072125.2268530-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomic SRCU must remain in the small size state. Warn if this
invariant is violated and avoid transitioning to big in that case.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
Changes since v2:
- Also prevent the transition when the atomic SRCU size-state
  invariant is violated, per Paul McKenney's suggestion.
-v2: https://lore.kernel.org/rcu/20260910084629.3695383-1-kunwu.chan@gmail.com/

Changes since v1:
- Drop the !is_atomic guard from v1 and add WARN_ON_ONCE() instead,
  per Paul McKenney's suggestion.
- v1: https://lore.kernel.org/rcu/20260907075829.2073224-8-kunwu.chan@linux.dev/
---
 kernel/rcu/srcutree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 84c022ec8e09..07db4e459b30 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1073,8 +1073,11 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 		raw_spin_unlock_irq_rcu_node(sup);
 	}
 
-	/* Transition to big if needed. */
-	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
+	/* Transition to big if needed, but never for atomic SRCU. */
+	if (ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC &&
+	    ss_state != SRCU_SIZE_SMALL) {
+		WARN_ON_ONCE(1);
+	} else if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
 		if (ss_state == SRCU_SIZE_ALLOC)
 			init_srcu_struct_nodes(ssp, GFP_KERNEL);
 		else
-- 
2.43.0

