Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2922626
	for <rcu@vger.kernel.org>; Mon, 15 Jul 2024 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721085818; cv=none; b=MDYLBn1kKGzP8NhnuJBjNthE0ZCIZAqpV0dibyDxTx0Qoh21O5bpEqxvBw+pV+t4NvP0ypsTYR0IYn7Cf9Dw1SOqBmhDBkwwe5F2MKzmM0wrI6D3832fcVzB43/RkEoY+kQEmPJRqfYrryg5snGGb6DKXJjzIHH0P9L3RIotx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721085818; c=relaxed/simple;
	bh=mLGeYgfVLdJTHYhB3UH2HQV1E/f4gL1jscHpJLBYOKQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Yr0UmobdtI6Aa7XHI9xB6KHxTuOuKzYAU2VeSjzyjknxCfttxNldLDsE0lGc/wuCfCZ8p2FFqXi1NhJ8DgeMqOcvEwua8MaCXsbVOCGzoR20DewCmzHvPNREd3cjtPhS9X7i8rWnIr81Js96PM/BFMJWOo3OxuHOHchQzJXH6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgc1OlwV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgc1OlwV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc2a194750so14763345ad.1
        for <rcu@vger.kernel.org>; Mon, 15 Jul 2024 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721085817; x=1721690617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4AJsTFteGvK6sYtVAbebNVMI4QP/ZWKFNrk/iwLd4M=;
        b=Fgc1OlwVKmPoXzDVI/LPIkG/nKPcbZbTc2Wqr66jOl762UbAXShsMTx6hd9Ntkpk0n
         teHhkpFB6Uufw7RThl5PxfO1qZcpfl8KeYZ6f7fOmJrk8G7pwQgmA+XbUkTkpwEl1rKN
         RFEDg016jqL7BAYiMi24hfN7Y8h5Tk2B/K4hZ/l4zZqxnAqV6OEl7DaR8bp6BmtUS6QS
         7oCtQ8NFKAQSE9xhm26j8GrqMCnJ2lTHNK3Q4mmZN8GwLie7LCrWazKXuO736fLNe7RE
         JU515SIIwwWcMbm+ptJ98ufOZXpnPnkN+xAMwgJfRc911i5QqHGLJbqeoND4jNIeUWHZ
         mzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721085817; x=1721690617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4AJsTFteGvK6sYtVAbebNVMI4QP/ZWKFNrk/iwLd4M=;
        b=bnT5CK3+ijQA4axk3lQaVYvzHTDZLD7JUUp9rJEjz+3tSL4QOSRkz+d/+g4gx95Ey3
         pqgLji9NBLSOyQWdDT9zM2W6irODu5D1TtndP3Uc7MhiuGNxJuBAAnjLAEFJKA1dS4L2
         cplI6ld/5bHnLvITrRyyYVhL3ngs/F4ru7B/a/jzHNm7cs9HALoH6K7ehx+w0fQd3q3v
         egYv/8oE6KgsNuvxFM4aiBw+yK0h95umPKNbYjh22fpJfCzLwKRZ3IgLw8k49hvIF5Fw
         zypRvDqfGEfWfpyPBd1VqITMkKMSgfXGrs8jCHoKwDGT67Qs8vVvdYMbvSef6+v1VI/Z
         26wA==
X-Forwarded-Encrypted: i=1; AJvYcCV5CNe6nZDreYv6cpu7yS9UphVTFiyRh/NwBxOAP6k0kHo6FBGEZ/FEiPp0xtSzzTlgJ4lvG/YMHNNVBf1Oz3lpRoVZ
X-Gm-Message-State: AOJu0YyVSHV0Ialxyd/dwkblIVlJgvBwM8Q1DUPQ7pqWjUbLC4bHek7w
	hl/+4PXgjW6nN8QvaLGpExvl7yQpUTwtGtsNdx+3QseTnm1+hzoF
X-Google-Smtp-Source: AGHT+IEzqoNXFfiP6yh/5t5ZiJQruTnbPXw+WocfT8lHhjJhLtnoleroYX5xXMqfKbeDBAdnUP83ew==
X-Received: by 2002:a17:903:2d2:b0:1fb:3d7:1cfc with SMTP id d9443c01a7336-1fc3d935cebmr3047785ad.20.1721085816738;
        Mon, 15 Jul 2024 16:23:36 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc384ecsm46204335ad.208.2024.07.15.16.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 16:23:36 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: Neeraj.Upadhyay@kernel.org,
	paulmck@kernel.org,
	rcu@vger.kernel.org
Subject: [PATCH v2] srcu: faster gp seq wrap-around
Date: Mon, 15 Jul 2024 16:23:24 -0700
Message-ID: <20240715232324.52384-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using a higher value for the initial gp sequence counters allows for
wrapping to occur faster. It can help with surfacing any issues that may
be happening as a result of the wrap around.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/rcu/srcutree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index bc4b58b0204e..907c4a484503 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -30,6 +30,9 @@
 #include "rcu.h"
 #include "rcu_segcblist.h"
 
+/* Start with a gp sequence value that allows wrapping to occur faster. */
+#define SRCU_GP_SEQ_INITIAL_VAL ((0UL - 100UL) << RCU_SEQ_CTR_SHIFT)
+
 /* Holdoff in nanoseconds for auto-expediting. */
 #define DEFAULT_SRCU_EXP_HOLDOFF (25 * 1000)
 static ulong exp_holdoff = DEFAULT_SRCU_EXP_HOLDOFF;
@@ -247,7 +250,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
-	ssp->srcu_sup->srcu_gp_seq = 0;
+	ssp->srcu_sup->srcu_gp_seq = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_barrier_seq = 0;
 	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
@@ -258,7 +261,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	if (!ssp->sda)
 		goto err_free_sup;
 	init_srcu_struct_data(ssp);
-	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
+	ssp->srcu_sup->srcu_gp_seq_needed_exp = SRCU_GP_SEQ_INITIAL_VAL;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC))
@@ -266,7 +269,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 	}
 	ssp->srcu_sup->srcu_ssp = ssp;
-	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
+	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed,
+			SRCU_GP_SEQ_INITIAL_VAL); /* Init done. */
 	return 0;
 
 err_free_sda:
-- 
2.45.2

