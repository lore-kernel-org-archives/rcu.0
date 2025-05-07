Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207F23370A;
	Wed,  7 May 2025 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617185; cv=none; b=R5KvOerMlXpY5qWsE1ORqziy7xCvrNXfgeUMWqQmA1ZFJQVdI/MHzC9/0D0WhxXEn5riSwESgswwQ3tVGgJIgqbULyMlUUiPqs51DtBkuF11dgKIty/ydjyH19N7Ci9Hkuou/W3L4Guh8UnJiuBhIEotjY0eKDTEtT2lg3AhhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617185; c=relaxed/simple;
	bh=Rg++7QAp1aiqx0WuxF07uC25E9a3F78je1UmaJeV6co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M971mS7He9uTggVkgujT6LBAD2v7dUbWwuin9N7kbnfu8PsJfK5JAInzsfO6TL1yujhh97CYsddkC57SrPe4Nmw0hZbn5f+XTKGCsSfSsJyCa2v8AP9T7GqZpo/u91aULfuTvOMV3irn4qE2cRPfS88x+pm2Yu7TAv8PuB1Qlwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D542s4tE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D542s4tE"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7396f13b750so7970047b3a.1;
        Wed, 07 May 2025 04:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746617183; x=1747221983; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ow8fVAyAhZ+6GF6kboqlHs4aRvukS9EKChsENbfruFA=;
        b=D542s4tER3FYWDtlM86Y+buZ00df6joKDXhOEtppYeb/bGcBLw2Sv/xCXpV5n42pUL
         LKFgVzNPsb35fXqZKkY1kWNyKxwNtBLfhUajOJENt6NBSBfoWTCt+6LFXLmBhZdr/Shk
         ZalzrWi8pYg9XK6eifALltKyTGENIgBq/zzKh0GIweOUzLE7wdP4uyz5lWMtE4WaaV4q
         y/5wQC+g8+IKKJ69Ybch+S1Pe0uqRp0d9fKUrsAHEnxVs03YV/kqonrktp7jNOBNTE/h
         FrGlkOFwYxkrjNsC3vGyifDsBMgtg/9SYQkOH72QZ9bVKKvzBao3ww8tdYD3yMr73MFc
         Lf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746617183; x=1747221983;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ow8fVAyAhZ+6GF6kboqlHs4aRvukS9EKChsENbfruFA=;
        b=lePoRJgatw9i7dOpJaztLKnQH8jRCupA4D/sb2w4jACJs0otaSz72N8PKEg+AiFJZb
         A6/vr8fpJe8rOOASTYc6+sle0qA1N2LEece78f7hGptdfImZhpfAyB1s6kNblSRrqo5h
         b1PPXKe/T8kL2d3NVKwbsPKShiLXmm8eASS875iCiXAqXAihHhaFJwgOBTsmGCGZ4wMA
         /OGTPGl4Ub9iZxi4sVjmXFaml0NaITVdhbReBUkD87IoU+PF7/HQJ1xkMANgQ6xjheY1
         q60fXRLw44ax9n5wcYdsT7HS2ak9y8NNAt/HYa+b0oykY7GvFkmQgqH+TzsTzqZHUOjW
         xQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeTR8Q9ovlXg1s5RdlUMs+uwPoQGhrqfOWo1QKpM85OIpBXZ1HTtKvQeZJaD+HVrCFYLAv5YsjJqKZsS4=@vger.kernel.org, AJvYcCXfqNDuAWJ9MHCu8iZHHf/vobXmmwGXmxQa3v9hnoAjz9wETkqoEpU0xU9W9QmXkm+pEWMh@vger.kernel.org
X-Gm-Message-State: AOJu0YynfVFqM8ScGUucPnbOmRWZF0WacxT3BYoVJwYmIMxHxaWj/4ff
	PLFSkuGDOBXJT9QfoX5o+xLcFIOgLjGwR4cdHwWWPzLOAWaRDjmR
X-Gm-Gg: ASbGncuaYfaM8YmEEOOEFWXo6Yv2jMlkAHrp1nEk7Lm6ND38lDVl1ds9zZPfizxS+YQ
	qnf9qO1fYKNUTBK0LcTtpg6L+8WA69S854Ykn/CovPahWtlZb8E+vtFvpHBdJxmEMYcjv18PFMR
	j7zHZSxCG8wqF5CwjUQBEoFXVo4R3XkAtJXSCZxgK/PMeCY54xOyiHyhY/zUYrk7b5oHX92mdGN
	/TEeV4Gcn/SClUPJR89n6BOTn11pVyr/0sLtNILo/UQ//8XIO9nWlrucATo8/7PUAe59gbOVgrn
	vjFZzYeA+s09EIuKgOh9exmuweIqHEla7gNWfRMXqLHg5XQbAgpsZChvkACtnasZZ01DbpmPNA=
	=
X-Google-Smtp-Source: AGHT+IEgVZlmNeNzpIb8J0H7aZ9IguyvrIqis9+HwejM2OlIJttzvZgHgroFKftyPxYLrsuwS556jg==
X-Received: by 2002:a05:6a21:3298:b0:1f5:8748:76b0 with SMTP id adf61e73a8af0-2148d88baaamr4849121637.29.1746617183452;
        Wed, 07 May 2025 04:26:23 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740590610desm11184898b3a.146.2025.05.07.04.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 04:26:23 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	urezki@gmail.com,
	boqun.feng@gmail.com
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread pointer access
Date: Wed,  7 May 2025 19:26:05 +0800
Message-Id: <20250507112605.20910-3-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
References: <20250507112605.20910-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

In the preparation stage of CPU online, if the corresponding
the rdp's->nocb_cb_kthread does not exist, will be created,
there is a situation where the rdp's rcuop kthreads creation fails,
and then de-offload this CPU's rdp, does not assign this CPU's
rdp->nocb_cb_kthread pointer, but this rdp's->nocb_gp_rdp and
rdp's->rdp_gp->nocb_gp_kthread is still valid.

This will cause the subsequent re-offload operation of this offline
CPU, which will pass the conditional check and the kthread_unpark()
will access invalid rdp's->nocb_cb_kthread pointer.

This commit therefore use rdp's->nocb_gp_kthread instead of
rdp_gp's->nocb_gp_kthread for safety check.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/tree_nocb.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 1596812f7f12..6679140bb0b5 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1146,7 +1146,6 @@ static bool rcu_nocb_rdp_offload_wait_cond(struct rcu_data *rdp)
 static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 {
 	int wake_gp;
-	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(cpu_online(rdp->cpu));
 	/*
@@ -1156,7 +1155,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 	if (!rdp->nocb_gp_rdp)
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
+	if (WARN_ON_ONCE(!rdp->nocb_gp_kthread))
 		return -EINVAL;
 
 	pr_info("Offloading %d\n", rdp->cpu);
@@ -1166,7 +1165,7 @@ static int rcu_nocb_rdp_offload(struct rcu_data *rdp)
 
 	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
 	if (wake_gp)
-		wake_up_process(rdp_gp->nocb_gp_kthread);
+		wake_up_process(rdp->nocb_gp_kthread);
 
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_nocb_rdp_offload_wait_cond(rdp));
-- 
2.17.1

