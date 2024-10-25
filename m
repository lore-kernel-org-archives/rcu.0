Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07831B0F24
	for <rcu@vger.kernel.org>; Fri, 25 Oct 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840011; cv=none; b=HjJ4p1qN1wtx0VHW8qek+TRXhnQDJLGfD2l8mSUexBBeu3o3IikA6oghqyTKh/fV4ls0fQ+yMwi7VI/T4nVgY1oQmS6+II9WVORetP4X2PMkTc61N6kNlMuuy5QhdrlRTk/esl3l5pPKKvyUbaadrQEfiFipY/P5pGUCs3prhxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840011; c=relaxed/simple;
	bh=rkQE7YIpEQbUrEPfHWGa3mK7WoBXUnnaqE0WUW6yzPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kY54ezCc2/cvctAHOWo6RdTGW8vlxyVvzX/TSsQd1CkydcJ62myq581Belc7NjDvVW6DdiQrJ95w+h/ExTPdW83AgsXTnGd9eD1WugdvV5JN8Jx30mAnia3FKqGitHqXpAYCcQLc1iW2px/iCojIKu7n054nPjKFPsCRloDSR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IXhttkxu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IXhttkxu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so17458095e9.1
        for <rcu@vger.kernel.org>; Fri, 25 Oct 2024 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729840008; x=1730444808; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIsqbAvxya9NETYgH6mSG74loRrqRLi0pQc/bZmvIDA=;
        b=IXhttkxul7XVo2rO8BjBmrq8qXNTxWajrr5BUT7qCtxzd7VjDp6LztsYukorOKr+KI
         T3KktEDCecf/soOzkpRkazbp6En5Gu3Ke+fU6+sRhrM4hBK3SME/gY3Isy/WwAdRvqjY
         QmGXnnK5OuNSpYPvFbeF3rrFMlINShqECQG80neIrN/Hh3vjbFcGC+XSQW7vdti3twcg
         RNyE53UdTRjiU69Q4Q9BjPIne7WrfvENMv4G/hHZb7D5y9iFeaxJlQ8Qi0t7V+ttoIng
         ziWZPMRe8jSAR29e+aYDtgETDptXhTjuAUHKZOXN+/hwZF6o3SpiE8s6guuwK3o/Ashw
         kcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729840008; x=1730444808;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIsqbAvxya9NETYgH6mSG74loRrqRLi0pQc/bZmvIDA=;
        b=l5+1MUa76qmLikzAq+1wiKkCGITj07mttQqJdN9qt8tU2Rbu4qi30EjI9epXKde9Ln
         5EPDxknbEbViK4Hr/6mfbKl/dY3be/mPQ39X63vvATQ9MMc0rJn45pw9S9YlbA+0tmvl
         cz7DzSAKzkR0EPKOL5FbgkDg1Oa69aNyBsZ8zmCDD/Pt+j9Xg8tCJ7o6gXdtgc73T1Wq
         D+OdHGxqcJEWtBgF2l14U9SE3Qh7GsK+GHpOQs5hedKKP1+4q68HgGtmfSkEAMSTFhwS
         fHyhXsQ8oqJPzUqaf8iThspxj6ga7bF9dBLDYpsm0pKHw4LNqEdaYJ9nhIW0+Y/yQTvI
         xiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgj9vE4Gu8QMvKY7tRlsD2a5AaIVjjw8cBeQAVJvbfXazF6rtL/AXPp6CfJoOH9ithApM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw39uIp96kYnBLGO5j9Sp0W9s2gbgJBrK3YOa5Lscao5wzOiFRd
	ch5WmUqrHxIMEuxeFQSO+lCZOA08EKQVxJSefjz0Kbqn61UZIMpj4ePppruSwww=
X-Google-Smtp-Source: AGHT+IFDxpEXBGCkffse7fkCSwVB2T/xPt5joroOVn7BJWc3mEQhF1RGjY6fvVprtingP48ezETMtQ==
X-Received: by 2002:a05:600c:314d:b0:431:58bc:ad5e with SMTP id 5b1f17b1804b1-4318419a826mr71700265e9.28.1729840008063;
        Fri, 25 Oct 2024 00:06:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058bb4724sm757578f8f.115.2024.10.25.00.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:06:47 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:06:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] rcu: Unlock correctly in rcu_dump_cpu_stacks()
Message-ID: <b3b2a438-92d8-4b63-a71e-ad3a155b96d4@stanley.mountain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The unlock needs to be outside the } close curly braces for this if
statement.  Otherwise it leads to a deadlock.

Fixes: 744e87210b1a ("rcu: Finer-grained grace-period-end checks in rcu_dump_cpu_stacks()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 kernel/rcu/tree_stall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 8994391b95c7..925fcdad5dea 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -357,8 +357,8 @@ static void rcu_dump_cpu_stacks(unsigned long gp_seq)
 					pr_err("Offline CPU %d blocking current GP.\n", cpu);
 				else
 					dump_cpu_task(cpu);
-			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			}
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 		printk_deferred_exit();
 	}
-- 
2.45.2

