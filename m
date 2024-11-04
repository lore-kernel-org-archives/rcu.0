Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503B1BFE01;
	Mon,  4 Nov 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733162; cv=none; b=CQE/GMTHKEcbKO5Sx+g3OxYx16HMp6uBckj1lbDlBWGwSQuvsrrZndSQAU59yb9rjNgPyvN3864a194gyOWNQetL7AZrXARcshUdsi0w66NLDMtSas2sM9L369QTuQ56Foj1R8Us0cYDP95qFohyq9UC7pNnK6n5lixCxJaAQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733162; c=relaxed/simple;
	bh=SuVZ3EgcHCWXdqLs4fy1oc8yvD7iHRKwPN8tq9m/GdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2ls+ZrIxo+XieWNbey5ejkA+9Xz+mI9ycl2Mj4vv2Gf9gFrTGZyKuQcn85T6zxGVP2KvVJ2rAYylnJvEb4pNAioj1QRrXOYwDB5kyqiH6Qzka2g2VNHqBNlkyejwLufw44A27W9yD+5RedEn7fv3ABSJQfS2p/RnIwYs4w1XYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/0hTp9G; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/0hTp9G"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c9978a221so44282025ad.1;
        Mon, 04 Nov 2024 07:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730733160; x=1731337960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoCrGvvvjB5pDYUnmhcJQyc5Zc0SWHOtsLPykgGMHBo=;
        b=g/0hTp9GB+hVP3zOe20MBKNV9MDcPl0LEcCzv8pwFKDbZaO2sWadc3OcRzlr+5RiCW
         oShHlAv6EXTVmf+S7EPzKE1aQP68rVu1UJSzrrTgVifvdh/XdcAAk4N41y6w4//0i0PX
         PFjg3/IVLdtVZ+akx3ZcBn/k3ZMzy0O9rTPfQEJTH+Ww91H3O5vXzNV5dhHU4AtJMaz/
         BAJ1TGs84VLEaiTMwATaZ0HVQknkJUStTWdmUywMylsw8SootyWl2o24vG1PnRHFlFJl
         mNyW9/buSHF56eT8tPTNERWk+4g56xV6r5BE0fyc/4PJ2LNKVnUa2z4TMuL2OzKsFSSp
         e92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733160; x=1731337960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoCrGvvvjB5pDYUnmhcJQyc5Zc0SWHOtsLPykgGMHBo=;
        b=E3AVb58bJ9ewo5z2+slMoE4kkwfZIlqxX2DNJ6pxTzJh8IXD2LlK89zDZQQA28oEPJ
         +wNoFM+97EvD7LeCV5TKO1tU+jxguN0iA5Ge6RjDWzU+rN1yEpap07T7dTeWG0z+/N+2
         AbnGTYRgIvdRH7tTk/Q0O53MG4MGEYCfB9+BVE7k/OGxwCaaTvCidHnJwYNt/72niNY4
         pC3YYxXFW1Dz4flqDsOAPHaC+bXmeTUAUt0uAhoFjbGNKw1mAgW+h4L0T9h5A1Wiymgi
         wZUtq5Qk2hoX+tAZrZReG8trnqnIfVsT41/yesq69lL/xuNN2S4DpDQT9EMj9zHG7oGU
         ef6A==
X-Forwarded-Encrypted: i=1; AJvYcCUGu+laN87CDkxfXjORGfI/nGiMVli5jsuVJei1IuLTVt9j5xyMINDrHar87jxgYvxJDsI8ZFFEGPfzI2Y=@vger.kernel.org, AJvYcCXuuTLbENkqHlwZnMPrX2Z3AbM0Ott9m+aZDX4CUXSqziNfWWdrBUN6mxQqPmTjKNpBAOpt@vger.kernel.org
X-Gm-Message-State: AOJu0YxI78J8cTB3yEWOfG8pd0kqmxT6TnWeDBXAlU2dBYAHZIiiz24n
	RVKQxQlkN3cxp7VwHakNhAmVkEQ8E/awIsQ6xPtz3yYPiS6+29JE1mKWztzqQbg=
X-Google-Smtp-Source: AGHT+IFv62TOyGierxmKtgGVjWg1Hmooj77EZQ6cxujSvnwB0xb/06zqZ1CA+HKXUeoZ3jQh14Z+5A==
X-Received: by 2002:a17:902:e5d1:b0:20b:ab74:f567 with SMTP id d9443c01a7336-210c6b01b9amr415281055ad.27.1730733160108;
        Mon, 04 Nov 2024 07:12:40 -0800 (PST)
Received: from localhost.localdomain ([202.119.23.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c7560sm61787095ad.237.2024.11.04.07.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:12:39 -0800 (PST)
From: Zilin Guan <zilinguan811@gmail.com>
To: paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilinguan811@gmail.com>
Subject: [PATCH] rcu: Use READ_ONCE() for rdp->gpwrap access in __note_gp_changes()
Date: Mon,  4 Nov 2024 15:12:30 +0000
Message-Id: <20241104151230.3107133-1-zilinguan811@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function __note_gp_changes(), rdp->gpwrap is read using READ_ONCE()
in line 1307:

1307    if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
1308            WRITE_ONCE(rdp->last_sched_clock, jiffies);

while read directly in line 1305:

1305    if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) ||
	    rdp->gpwrap)
1306            WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);

In the same environment, reads in two places should have the same
protection.

Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1f883fcd918..d3e2b420dce5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1302,7 +1302,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		zero_cpu_stall_ticks(rdp);
 	}
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
-	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || rdp->gpwrap)
+	if (ULONG_CMP_LT(rdp->gp_seq_needed, rnp->gp_seq_needed) || READ_ONCE(rdp->gpwrap))
 		WRITE_ONCE(rdp->gp_seq_needed, rnp->gp_seq_needed);
 	if (IS_ENABLED(CONFIG_PROVE_RCU) && READ_ONCE(rdp->gpwrap))
 		WRITE_ONCE(rdp->last_sched_clock, jiffies);
-- 
2.34.1

