Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761441DEF7
	for <rcu@vger.kernel.org>; Mon,  7 Sep 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767958; cv=none; b=b0DNt17E7P7E9zgd0sED1/hrXDb8j41B6e/y1ArRWvzF3c9GzxFBbMrRWScEC9uF0WFCs2Sk9oKacXZy5AREHsudHe4u9BPIWWclKHafuoBVVUUbl2vTROF9zy6TfsAVj8+Ewm1DfKUMzlax4U5gBtLzoaBZtoMNLN57/LfLiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767958; c=relaxed/simple;
	bh=WMCLkI7cWCG8y30ht13Dpjq+ytj9QwWIte4gc8x98sY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/SgzBgep/JRp7dMPXUbHEaBOFuakTyT+qZSO2Z4nS/Y1YpUzqJ6a7fMQNE5NeaTLzcnUCX7na1GSpF4rxuFv5SJZt+uXOlTGAm5h/K6W2YqZq9+T81yu7DHO5IahKMx6BohxSHknJtjWJFxFkQudF2mZJ3QL9+xjGpJXObVPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iyom0FQq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyom0FQq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d91ded8174so24757135ad.1
        for <rcu@vger.kernel.org>; Mon, 07 Sep 2026 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788767956; x=1789372756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7FLjMyTZSsmtCKr44cIMaimu0UhFxFiYLpxSbsSIK34=;
        b=Iyom0FQqSB39dSrpJQF3oApuYVzSfnrHbk/WEr/sl2OxcceCefVr0buF6NFJ6wUL66
         /F3ztxzd115zx8eaVaXzxwIpXymM9YburDPaOY042jd3hm98ODAy3R9ThAeO6cSYTDJC
         eyWV0p4aUU5pTAtmB+oq9sUUXZaWW5Sp1PO3XKE1uRf5gEzd0MmBqELeLKMYufdpkQIp
         9YgWgmjaPb8GYnoaf/43g+Out8/02XXAYcFZhYPrYAgoWW2cA7VbvlNea4rH13uxm0Iy
         i+46PsPTRi1uSL/9gJu+08yZ9YZixyg9lyhTiip6DQImd1DHBdk9/MH/M0CpMWRT9ZVm
         ArSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767956; x=1789372756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7FLjMyTZSsmtCKr44cIMaimu0UhFxFiYLpxSbsSIK34=;
        b=UmYZkkX7b7O2OzXmwgPc+3nTUpuumM0VXldaJMxY0yfh6j6OxYoSyMDEBkpGEImkQp
         0nsMT3BkRgDCdQLBRAmz8B6IhQ2ykaEIVN4ZNLdDipBEk1/q82RDtArK273QvnB4s560
         YjQzvWFCb3B1Sd3tIvE7qTtx3YvH94fu78Y3tfQHCc4va12p8GFk5hXCYCYkigu3kL7s
         lDWe8J8umfS9rf9AG0FJO6J5XhiUbqDQ7CrNHAsS7t5pDx4FfQpxzrhebbjwanoNOBTi
         H1MF9NgMKJo1LAqXUGfRrzS9BvJ9UXVuZ8cCH2nGWPaT/0gP1wc8M7opY0mFxYZNYDtJ
         xrCg==
X-Forwarded-Encrypted: i=1; AKwUvBy4QxLemRsuYcYPS6oYaIp/SO+JnQQeu/g+2FT3V90w1w5Uv4+hK0wFrp37t6cLdMHppcA=@vger.kernel.org
X-Gm-Message-State: AFuF++nJMWEaqmd6NwHRlbG4k97XPGOcx+n+ojoinI54vKQ1dW4lX4sY
	aas3fBEjhFsOna7me97740wujcO4iMd+b0ZNbx92PyNJuspa6Ryt3jiQ
X-Gm-Gg: AYBFou3aeQdGbn/i50qUYX+7O+Z2xH1ZjA+iI41LTQeT7YbF7mth/8tdDZ0wCACmSBk
	+eulc+z89lIjrRoniMcLUUOEg6ocR1KltK/Jkb6JHbmKCD8UtvlShcpb8G4W9br0Jd+bjhI3rnp
	1NsyY49bKKR11wa6axAIpSPqsVXLWmsj+/QL/LeejHCjr+jbTeytZy3mK9RNUq/Vv5iLLzOiBgV
	6ei1+RoAuZsJXyIhZl1zOqfYGcX34vqMD7jVamTZ/t6NgDpVH3UKsp9J4BDEcqPyv3dXa50g1s5
	1ZIFz9Nd9bfQWONKq1IoUV7ZE6N7a9Z+ArvsqPItgTtYDdkEnpkm2FIV1GJK1oaaYxmGWWc9sjC
	lxrmdyEvPJB2adNrtfJ6QTB3uCPJSgdQrJ/8abmpjmawc4cI+Fr6ZxcRMn6trTrZ91QC2tY8DRF
	7PAW5owv46q3q6EBRouMFVH0EeghFEZXr8IIirhmA3NDsG7lijhmafjkFMFZHmn9B8naFwskRm4
	9h6kjw=
X-Received: by 2002:a17:903:94e:b0:2db:4bae:1ece with SMTP id d9443c01a7336-2db4bae2044mr85147475ad.3.1788767956089;
        Mon, 07 Sep 2026 00:59:16 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm40945595ad.79.2026.09.07.00.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 00:59:15 -0700 (PDT)
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
Subject: [PATCH 09/13] rcutorture: Disable srcu_expedite_current() for atomic SRCU
Date: Mon,  7 Sep 2026 15:58:25 +0800
Message-ID: <20260907075829.2073224-10-kunwu.chan@linux.dev>
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

srcu_expedite_current() is now forbidden for atomic SRCU, so null out
->exp_current in srcu_torture_init_forbidden_apis().

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a9672fe88cbc..d795e07a12ad 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -721,6 +721,7 @@ static void srcu_torture_init_forbidden_apis(void)
 	cur_ops->call = NULL;
 	cur_ops->cb_barrier = NULL;
 	cur_ops->deferred_free = NULL;
+	cur_ops->exp_current = NULL;
 	cur_ops->start_gp_poll = NULL;
 }
 
-- 
2.43.0

