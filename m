Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4963A451F
	for <rcu@vger.kernel.org>; Thu, 10 Sep 2026 04:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013681; cv=none; b=IC2biFd5OH71jHeK6KOgyUHV0lRj+2pHs7ZLv0lk/p3Ybd/RE9AMa6NGsWolScwvFocZbEEHLqx1weZtg8zOs5h3VfdwulncafdRuOz1/dytqJAuaiIZ1kU6SIFUvflcHeNDPY87EiGM95WIfVgjLk9X6qj6Ts5HrStVCPzewxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013681; c=relaxed/simple;
	bh=S6Q8iTTI0AR4jZVr4beCsVhRfm/G5hTDYV+GbdTaCbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIYO6ZvzH5St1Ufp6zk4lWQUoYtWxF/MwT/x0mFYmjGMCMufdyNx9PouxBaXhKho3ObdXhzciIDkeLZyInCW/i6QrLioD01s2PLt4OADgQRH3lC+7NJl9RNthvRV16dRbv7lrrpDomCD8J9T0JfGdMXDipHH2iiZ7y1XG/QUrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5EvOzQG; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5EvOzQG"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25187so460572b3a.2
        for <rcu@vger.kernel.org>; Wed, 09 Sep 2026 21:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789013678; x=1789618478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pBHlDeFtR9R/kfv9cflPbv5Eb5RRc7n7ypcv3mdlfb0=;
        b=J5EvOzQGUVozpHX6M9eei74ST20jD4aSYWh6cqyrllsibyQAo1Bm6vxFQC6McxCrRm
         3QVH+rqEcXBi3aG7BvkVRb7bxINsoC8q+opIzRDrKCgBHyIZGuhL5inL74nd0NnSz+dB
         vf4i6unnIjooKesdY0s/UngJPJs/fNL+2CXySk3Fg0mCVuic8Bbn48ljWgyBmMPkidsU
         SNrYluJvdYx2qbkrguy5sRV89iYR6j/qHQP67n9XNM6Kl+VQXNa4uGin0etXoEbOZCXo
         MwPT3UV195AMNAIJD2yvbxunx+LZMFZU+XZEsX4OGJpCH1toNkhicuxgJhbww+o2wdHQ
         +Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789013678; x=1789618478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBHlDeFtR9R/kfv9cflPbv5Eb5RRc7n7ypcv3mdlfb0=;
        b=j2oGyBajoZivGipNu63mPauFVp/MP6AJxco7XKKlRiNzqgHIN/c+PQhXc7byQtLa3v
         5+hxIet5q780XDbS6uuwODI983ikkqqPgV8ybElVgU2a4et5QAHbqIR8sAlZDwSq0s45
         4HzSih54FnoDDboKCqrAOcIIYJjCsOgrRKfbw0op4eo0s49f0zChO2HSEqH88MsG1Ou+
         9F/WZduT9ifNzJs8Db++1xnN6fU9//ohHNx+1OWyWpqo9sqHATEXTKw+KqvFAGCazz9o
         L5Zi31HmA/C90JJSx08O6tNqV3jVsUztfeLwG0ovtbj8u7anEzkXqj5N2dpNEe7QHPPO
         ucWw==
X-Gm-Message-State: AFuF++nmlEhSD83swC43d1/LZMOMMRAg3iYRW5oSQfHKfYqhQQR8yU4X
	AKM98S+vJxT3X2E+WYn/XVkGIE4G3GkUgGbFpF3I7PSjUhS9N12da2UV
X-Gm-Gg: AYBFou14age6+MGp7eFMaanLLblBgxD2xjW79L6CXDqQI+fy/HaEKw4r7bJgeNmKbR5
	jYMn/cw/mdLmauA8Zp80aEgGSP10+b068mp78OhcurZQ1GMXFb77jx0G414lZyNJm80IdPLvoFW
	IA0en7aoyjBlt+KJ/ssdTjgFKI+thWz4Y8Cf4EpLsUX/V95KCawsv9xOUPTVt7YvHm+7QmcsCTZ
	FTcopJizyb1kbr5MjyKsq4E/8mjJ74t3tmLTkNFmFtFg3QFpKgJXijBsp4RBNaK3kDlGyfcT8+z
	ayafPQFMrNWHi5a4mDm3FsHyS0R0Wy1Y/UhX2yFzSQUmVWI/40TNwM/aKozesMprIx0PTs871qs
	yyYOe5Nf94dX8t+e2rB3pac+aAm4d40HK0rJ2JW3gCz7DRYKdGy3e+XjTLZ6Q48KERpFLaGjnGF
	1H5wTDOcAW0+XVuAxucVUaBw7X7rPaSDUdMYn305f/u9koCRNPy9ryu8eZ2LLRlJmll6U/L3HwW
	fNNP8jlnkq/U+QrFQ==
X-Received: by 2002:a05:6a00:aa85:b0:857:7384:b5fa with SMTP id d2e1a72fcca58-86948928444mr4650612b3a.22.1789013677382;
        Wed, 09 Sep 2026 21:14:37 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-868c7a9e789sm1364304b3a.3.2026.09.09.21.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 21:14:36 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Cc: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH] srcutree: Skip torture to-big transition for atomic SRCU
Date: Thu, 10 Sep 2026 12:14:27 +0800
Message-ID: <20260910041427.3579817-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Atomic SRCU does not use the srcu_node combining tree.  Exclude it
from the SRCU_SIZING_IS_TORTURE() transition in
srcu_torture_stats_print().

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d462102c6bb6..99d11fb4123a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2421,7 +2421,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 		}
 		pr_cont(" T(%ld,%ld)\n", s0, s1);
 	}
-	if (SRCU_SIZING_IS_TORTURE())
+	if (SRCU_SIZING_IS_TORTURE() && ssp->srcu_reader_flavor != SRCU_READ_FLAVOR_ATOMIC)
 		srcu_transition_to_big(ssp);
 }
 EXPORT_SYMBOL_GPL(srcu_torture_stats_print);
-- 
2.43.0

