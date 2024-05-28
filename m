Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E97EEC5;
	Tue, 28 May 2024 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716865266; cv=none; b=gtLh+YURFMhuz1hRP/Ih7A6CkSu9TNDUTWW/LH0i+UsDo8XZwHMU9Of9WfjtUpq8ZeXuKPuTNl4tmRnJJkKMAf8Uz4w0Ouj0HzN2tS7k4Q5jBcCe2joWcZE87EWFZ2ro3Ej29WT4Djc8XPKZHmBj1uJB/CWf23+T+aDRb3aYIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716865266; c=relaxed/simple;
	bh=Vx4UhMTQ8zQOj+KvWVEHPxK4NooLjtptacYdGR5I/Xo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FPjZRnqnf991oUz9S6tnGrSlse5JuqOEt7eby2WCMW1FKhjNi1/OB02cCTR1t5vqAa+eN9BhGFK1rfjt/U4ruNx4x7jkRVE7XkWP4OPFb1WqzqTMxCc8dD0gurcsX+46MNeW2eYS0BddrypR2hnNFtf1mH/Eqz8yIUeFPjOXihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVZtxs2+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVZtxs2+"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-662aeb8d157so269266a12.1;
        Mon, 27 May 2024 20:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716865264; x=1717470064; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWp7WWeQU1Rlu3ZO4kjAgiMzVyjUyOqZK9Iety5tGRs=;
        b=DVZtxs2+MeT8qy8hEo0/eTNcxcqkkfz3KiOVrcgiGxm61hRrYDi+GvGRxIB1VO8rQq
         LgfPloDqziHERPeaXmOJK7WlGLwFDt9CMOUKqDmPAU+EWILgC1HeH40xCyc8Rrk5t9yU
         6TGWKb0SCbUypNpq38s51ZaqnKXc7ddqZs5yOHsCAfWk0aoqVY3QXE4xlQwV3q3jw1zS
         A/zzcYXMg2I+NLoIUXipzWMlr/DQwDbKl7Z2sHVX7QWFuzw9Arz7ZB41kxh6Lc43kK1a
         mVbklAAeikRO8PoCm6ZWUBTSADWacn+O056pVjograYd5/D24997CZ2+rJ/F3cJlZLUj
         dGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716865264; x=1717470064;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWp7WWeQU1Rlu3ZO4kjAgiMzVyjUyOqZK9Iety5tGRs=;
        b=Yqj8GrAvsKU3NlDtJOowFzmRZ9+OBrk8xFwb0+o4YkxHtZAihM23f1uHzd3EruxAhM
         LGB2wFhqfXqd7jO6f0X9o5rjHvrqya6kpHgM2T5SlijAQFriosDeADzvzQ5v+t9+KQwk
         G+KLWrzrzr2+pCItIs2BmY1Ut2cXx3WR6L37fL0/3GZDgZ5LvHJ8U/9CyJyDFpl9IvOz
         +WUJca+QU0JvbYQT9ZgDi7jFGsyZ3JgoyFVM7Mg60DAiQt3Z2C/4VaAkZ1Q3FJ9udb2o
         DMtg5mkUwOT8Uqa3AA6G5sddhXiBk0wtD2mjbwpvWOacmv4g2bY5ZbQSJ8dHIM7DQFaY
         Izxw==
X-Forwarded-Encrypted: i=1; AJvYcCU2nek2qQvsHAHu9Za47Qu9Yv+OdViM5B/54N3sPoH1zFroX59TFYkAZx6HG8Q5oWg6tMs5RW8Pg0gY4MO6FbxI6fm8HfVXYGU7UDihYiwupESvfwHNnsL0x4FNtGWb96XW
X-Gm-Message-State: AOJu0YwJPdZwtV7Ym0yR18K7CTxsLJLBjPshIgqQLgnKRN5Bxrkc9fre
	2yiRPd416MyjYwYjC4f+C5qrRdpwMyE6KI8JSaUHSqSGJCfeYFdm
X-Google-Smtp-Source: AGHT+IEv8kM/b7d6mF0KYJVJYqma2D3xqT/pFOQ1QYJTu7tFvnC79O4hUR9/O7BsT3tTrr7Il31eqA==
X-Received: by 2002:a05:6a20:394d:b0:1af:6541:8a08 with SMTP id adf61e73a8af0-1b212d081e8mr11657213637.20.1716865264398;
        Mon, 27 May 2024 20:01:04 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([117.128.58.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-701b0e7ede6sm742995b3a.126.2024.05.27.20.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 20:01:04 -0700 (PDT)
From: Zqiang <qiang.zhang1211@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	urezki@gmail.com
Cc: qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Skip debug object testing for cur_ops without ->debug_objects set
Date: Tue, 28 May 2024 11:00:54 +0800
Message-Id: <20240528030054.4525-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

This commit make rcu_test_debug_objects() early return when the
specified cur_ops not set the ->debug_objects.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 08bf7c669dd3..9b8c277ab91a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3495,8 +3495,9 @@ static void rcu_test_debug_objects(void)
 		return;
 	}
 
-	if (WARN_ON_ONCE(cur_ops->debug_objects &&
-			(!cur_ops->call || !cur_ops->cb_barrier)))
+	if (!cur_ops->debug_objects ||
+			WARN_ON_ONCE(cur_ops->debug_objects &&
+				(!cur_ops->call || !cur_ops->cb_barrier)))
 		return;
 
 	struct rcu_head *rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
-- 
2.17.1

