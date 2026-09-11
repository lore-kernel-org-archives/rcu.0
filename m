Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC349DBA8
	for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143052; cv=none; b=jpSvZey5INLl9Qq3Ab8zzMDznmjveZd9iMOf+x8ibHJIqCOouiGF4hqGnCKLru6eIPzfhjHOrMkPbrDFHF3rSiRhz79sEv6poByB5H+TWoeUskGwDQ+SknSQtG1LQhexmk/wNv9qQbF60JOCLVMKh9rmDvjSLR7zyxc8rxqNTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143052; c=relaxed/simple;
	bh=vIUJ6WCC40ZhDzscPwqF9HgcJE/QKSKO2ELm3aI9oE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r0q5AAnLiZmHvD39g8gEarFZLjKgTNQ9QbZjNcimNim+FmLkMQgtHOY1TCfgxU4MsWKX7NqSyepAYptykQYFpkttPp3JdEL4h0C2t3XzOkqCWWqPH3kcsBdOZcLIEtdgNFBEtLD0yCio8r69f4T3ofSBe6N/Y8qzy7PObPwk24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYcCZJ7R; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYcCZJ7R"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1141058a91.0
        for <rcu@vger.kernel.org>; Fri, 11 Sep 2026 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789143050; x=1789747850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8qHku/lkcMyCUoex8XaxjopWRu7Z+oJaV2o4dRNVD6k=;
        b=RYcCZJ7RkRuP7ETlxBZjxrRzZhe0uotpInOEdm+VB5R//Qk+8b+h77ujKKMKTxx8GU
         U2gPVnlvQrWrtxa63BCo1F44H4mgwz0lZcoY+1c2huwjQs0MeVZdNcT4fi/rYBzu/iqz
         0MseUkwe0ezWQk7JP6Z1kDozfWpIbXXIpxA4JCvGRAldj4TF/PLfWFqLBpQmgwtjcnJK
         6ztFO2vo4d6wSHyFkG1esul85aZh2akFGWqrkzCAHwRzYoiI9mAfIXZ2bwZHbagWBAJM
         1F1b7hUBpieBjzFOHAy+lGIxtlZ2LkUN24777YJGZDkMPX+vjqRY3x+gbUdMif/2H7sV
         WbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143050; x=1789747850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8qHku/lkcMyCUoex8XaxjopWRu7Z+oJaV2o4dRNVD6k=;
        b=U398FHKeE7S33chXli5TsDlC1jR3YvaAlqb4U+XkMOXYalGph3yg755TL8coPA8fJn
         4RheHShGv6AHpb5ILVKlJJz/qAE70f3RcNdGPuRdEXJDpsRDKZM6MiBJ8rbGH/dFz6qW
         Nm7BoYg2vQy91jq6gZOUzfeYGoC+iI49BrN0ujuEB/M/cq8JvXt/2ZKAeHts+ofiVe/b
         VHLAAUFQVflwE6yMjnPjYK+1I0Qb/Kwtxs2JpeuZX4gc0LOhvLIAnbKPwlW7iMAvZRLW
         LDh5twmuYhUrWCg1lnTr//wByBUeZY8J+xpSFgLEOFYBCP01EE7hfU81iLMhLhGDw0A6
         QhRw==
X-Forwarded-Encrypted: i=1; AKwUvBwFGVRpXI1A4ufDupW8IsjNkd4AA3wmrNBygPIyuUXM0fKgBz71nIf9mDIhziRouea/lZI=@vger.kernel.org
X-Gm-Message-State: AFuF++n04Y+6bMILy9KYOd6rGEH2R+ufBbkzD3qsj14tqLNcstjsB5V5
	bxudTJDZVZheGGVV467lRrq4FtwWceU2RDAB8ghx2pu3Egj8TMTkX66IoAcqVQ==
X-Gm-Gg: AYBFou32yiOE+ECYzIphS79UtGC71OuDaq0lAnkA69D9yJNvhWI43p2odf4KPwsOoc1
	mt8YuCt2TpvCeM6DLKQ6wDBHrlRWzfb0iwYncft1f58dEMTyeVEvueFMHGmo1m8LvJidqrd78mS
	zFKPjkLPXM31b8oNjgNOqvMl6o58RqjbOELeP9p3VIInpJUyiNT2MOeWNNnyKkYBCm/4J5dxQbt
	zQpEslYDuzr8tjuyXFe6q1IrZA899krsdyUfWJpjirfJAS0CFHxkbjt4enFtPOlZ1jb3Lpy+k8k
	b7Rjp1++W+O3f6wiuttinv5030hp4xpD8VVqfw9vttY0vHjgDMxAl+qS8plsDnSNPCKvH+WNn1T
	ErYnuT9AyRSEIWH52b2trecCTIzLaPS3G9f7+h2WKpXp11DcxRrD46yw+cuC+QcTQ8GCMSCI61y
	nK4084/pkAPqnXTOtC+ByOmW5Mb47oYwKz7q8su64r+GNpiXe+RkwEkE9F86WRaPtCrp1dYaxVz
	QAmqZLN3/n3ygy926c=
X-Received: by 2002:a17:90b:1d44:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-39d9c234a8emr8446766a91.13.1789143050047;
        Fri, 11 Sep 2026 09:10:50 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d6b08sm5966320a91.8.2026.09.11.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:10:49 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	jiangshanlai@gmail.com,
	josh@joshtriplett.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH] srcutiny: Add lockdep and early-boot checks to synchronize_srcu_atomic()
Date: Sat, 12 Sep 2026 00:09:13 +0800
Message-ID: <20260911160913.2859713-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the RCU_LOCKDEP_WARN and early-boot check that the Tree version
gained, srcu_lock_sync() was already present.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/srcutiny.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 99f8bfd98b04..76411562366f 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -361,6 +361,12 @@ void synchronize_srcu_atomic(struct srcu_struct *ssp)
 
 	srcu_lock_sync(&ssp->dep_map);
 
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp),
+			 "Illegal synchronize_srcu_atomic() in same-type SRCU read-side critical section");
+
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return;
+
 	if (IS_ENABLED(CONFIG_PREEMPTION))
 		synchronize_rcu(); // Needed for RCU Tasks Trace to imply RCU grace period.
 				   // And in Tiny RCU, it is near zero cost and doesn't block.
-- 
2.43.0

