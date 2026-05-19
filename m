Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C403B7777
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219934; cv=none; b=LtaO7rVXx6HzkRpzpRV+NHICOvI/BZWLTFgD1L5ju04q0xzDCqkuGYgYDHbS3GXg2O+dHdNvyqLizmWqafQptyt1NoU4wFTuZWZLaSY1jkqwoMZPypQf/fgdhoPOChkRC/D1OPXhwJI2+oqojoAOYM1p/njNNMfQPbr+f529bZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219934; c=relaxed/simple;
	bh=fWM441cbSLZxfDsFxOgkHb2BPMc6Nc/hi4JixQXl/Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhjq8yIBjuZ75Drn0oSnFOp04jA58lNDEmPhSrx3WTFmZeY99RmlHK63FiNpbK0hcoXcP6XJTXRipVqhMponD60kYcG+4QmCjcCBrc72NNqUcFnup5AFnBWAxmwg0TXBXRlNPu04Ccz0yj65R3TXIfVpdPuz005gkvNfFp0XUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIJqkqqz; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIJqkqqz"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-394095009beso35725341fa.3
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219931; x=1779824731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdtDTcHWPpFzW+rLnvoZdux37/ChPi6ZVsH5L2zj1aY=;
        b=OIJqkqqzomm21yeOsdDr//XUrJowr1vL6utkGpH8tu9TJX/TJzmunUNi2IJRdusRo1
         in5FOmFqBNjS0J4hglcPySN/hmocq6w/qhU9ooJBPJx4wB6ZfwPL9dwrUknqIWs2aJSB
         nlO4c7wPNHlyCZ1cEnf28wuzdZsd6C3x7pW64rUgk3qrxSub950VMTdruZ/juDPUcuZA
         EBsfAN4DBYdHQyTfU9yM26VY1Pq2iaZDCszzhQ2xs3Kmv/SMbptxCI7Va+3lFWPDYYb5
         hg2nPYv3jj9V6TInnAFZWhrj/Fqqq0IdN/Su85nCC7UQk7gaJ19dMQpDsmx1DQtPHdrx
         5qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219931; x=1779824731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tdtDTcHWPpFzW+rLnvoZdux37/ChPi6ZVsH5L2zj1aY=;
        b=jGWjev7Ht+BN6T9YoqDb5Uj5ImkJ0xBvvDVioKbN1zPQWxrJieKQQV6CFBLAU78lyJ
         4oG0Xvey+TgeMLepbBO0IH9yhhHm8ibUjvZap+tmLUeT0DPsuUy1KQlGYrGTux55lz+T
         zfGZa4rdRGfEQb7bH31qSbIrpeo4et08iTE9dIhra+nuLPBzDVanb81dDJdRv3WXeX3m
         dv/zGQcFfKb1gGsB8mFUIRH+bnmlajtLExFzrD64/gzQ46ww4khxvUl84zeOmEuF7oJP
         kpHpRyzmtcZfFaTXgMDnr1w7q1kIF08xZVU+ZbMAmd+2xrJDQ/lheKSXc0mCnttpl/8F
         Fb5g==
X-Gm-Message-State: AOJu0Yz+8QyXDc4hD5mf6WIWimJpu3adGHltpiboNHXrBr0V70LMqeTA
	bRO/muziIXMfkcZqgqalXlK/Q03Op5llJLR8XLMI7d2qLh11k53HaHsr
X-Gm-Gg: Acq92OEPKfF3hCy1/CbMWJywempI33iWkjszcyGvbsoDfmHVIu3ruEGqPuyKrYeI3NH
	1PbHVitXnrizot+lh9Y2QlCdiMebP2wwYSi5yPcJh4MLe/I23iTC0wl59sFsavX0RpBspNXs9RR
	dvDE3am56T3u4DvNgtQ7ZpZu9vyz4PkA9lVpG94hu1+FLK/iE2MldEkpMYb91kHjT1vhEr88T/z
	ma4tGAtc907tVi2SEGYirQgnmHkGwJgyRNo+dRM7r7zs2lIFmKl4VdShup9nAOhW7FWPrm+RHrs
	caSfV5tOADANtuu6RjhmqqpG4hu4XnbWU3GVV6XEiZj3vNAlE5PXTR/im/nF7REyQNQ45EZFkMK
	/dTzt26jvPqKe2I9bQz0TuKRqPPGJQuM9CrYksKRclLk7o6hs2z4X4viy0iPLgkts50ZXY2dVkq
	kBEgA5BBJ6H3ef3ic=
X-Received: by 2002:a2e:bd83:0:b0:38e:96b5:2f45 with SMTP id 38308e7fff4ca-39561a46984mr71465461fa.8.1779219930787;
        Tue, 19 May 2026 12:45:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:30 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v2 08/11] rcu: Simplify param_set_next_fqs_jiffies() by applying clamp_val()
Date: Tue, 19 May 2026 21:45:21 +0200
Message-ID: <20260519194524.158515-9-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces a nested ?: sequence with clamp_val().  This does
not reduce the number of lines of code, but it does simplify the line
that it modifies.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e46a5124c3eb..09f0cef5014c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -492,7 +492,7 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	int ret = kstrtoul(val, 0, &j);
 
 	if (!ret) {
-		WRITE_ONCE(*(ulong *)kp->arg, (j > HZ) ? HZ : (j ?: 1));
+		WRITE_ONCE(*(ulong *)kp->arg, clamp_val(j, 1, HZ));
 		adjust_jiffies_till_sched_qs();
 	}
 	return ret;
-- 
2.47.3

