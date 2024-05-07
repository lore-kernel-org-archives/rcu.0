Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E315DBCC;
	Tue,  7 May 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074553; cv=none; b=BEBhY4SdqgLZlcgDwKCgnDGb4crfuCV6IjBHW3pnsEhtG+pkvcJ7IGo/eno2qBngEZOKDeNjdICMvCezi9zMM9pSG7dMTyZY2hST32thHQFU77+fTqSO69//9VckwU7xWEfVFTHrySltGHycIKGug1dlOe2k0Lut8uNcAcPVEtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074553; c=relaxed/simple;
	bh=CQi6omiuMOIdje2fZYB1jOQAZbYXL+rdG54y+ely1xA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2bHyvibTl9XZB+Ct6bjjkKfQuoYrwrzBaUJQOs9FzQkmuzP+ny3PZJz2pfMHz/XXzVHS56toX8hMHqijzESqim2x2aXnP5tdeFJe5LfuIgdSylAMzJIZKyKI/FKwum9UrjL9s0AopsfQx5BTsh7lVheqn8H6ucBWqYg+aiEcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3+BwMt4; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3+BwMt4"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e3e18c240fso8454661fa.0;
        Tue, 07 May 2024 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074550; x=1715679350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNkYNx/ZpQTIkDY1eBLed5ZhKwlCgOHBgpZcacIwxtE=;
        b=M3+BwMt4pyRqxhOgICZ8yIM+IWmXsOm6eki6C1CEBJfF6mhgpkq5gHv+lxj5y5aFPx
         ajIQG/eWNzEv/k2M+lrY1PMsXe+TNEga77yK4rgFQbd4+dkT0V50IWLRjlGVU017Iuvu
         4xQLEkZym7xGpq3vsk84h0aFkXNHtFi+z/Nrxk5l68BYC4Uk2FUy+u7CwwfovzXwe6Y1
         XEGEWP01Qgr+meDHon1+37OvpClJWTgbxJqyPXSU+L/Ud9Bqx1B6mZIipcEv3k5gPYUW
         2ZLkElpc2Srq9ekOBFighDD6zohEMKH4vu4/oENv8reR25zft048QGvaJTsJ3FiweR0X
         YKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074550; x=1715679350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNkYNx/ZpQTIkDY1eBLed5ZhKwlCgOHBgpZcacIwxtE=;
        b=ee/iwwbdK2xklxJ7+E0kVGMXt+sMGOqcy+farzfagS7KdIBp5PMqqVoWkLjsxzlOIB
         4ZhXbXR+1X11o3Ns6pMzuEPC2DJLJfpALF/iATYQjmjxJ4On9QSizGHZApQjH3FG+dq9
         N+t+Oc7obnOgE1qGHYQukccJWgAF5TnrwpnmjMmqBJhfBW0Uq+HCdqP7s9FYoeOFkb9v
         xmDMyql9etG91vmQWP9GxZHA9YBtt0Pczzt/hgyShLN0kQdYtNj4Wf9RK6UEDIzAD42F
         tjGVaQfem2d0pXbgI8Xmz37jS3owSjv6dGdXx8Bck3fzGTwzEOvhSe8RbyKnH+kf9YXi
         yMKg==
X-Forwarded-Encrypted: i=1; AJvYcCUo/7Qh+qDXDb0gbvqmdWoyz+ZN/oyQBBF21CnaE/jKGYcoIvKPYA5vMoLLSxLbVFBtNraic8NQ2cIB8I2Ng+uGKzz3X/TSqEuiovc2
X-Gm-Message-State: AOJu0Yx2MIejIPPVkoiUyLBh302rmcqNA5UuIMjrjOt4EGWU7EN1iKi6
	Y3Tsn+VuC08wum82HEVrSWMMsfc9eN9/8spbCOwySOVjbAN2TRfB
X-Google-Smtp-Source: AGHT+IGO43ycIxjLnUJmQ9JIjfUAooDLvQqcbcp/oHvUpwF20pPOHY6XSusd2tislsuzjFBkmC4/EQ==
X-Received: by 2002:a2e:8e74:0:b0:2da:36be:1b4a with SMTP id t20-20020a2e8e74000000b002da36be1b4amr9300341ljk.19.1715074550355;
        Tue, 07 May 2024 02:35:50 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:49 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 18/48] rcu: Make TINY_RCU depend on !PREEMPT_RCU rather than !PREEMPTION
Date: Tue,  7 May 2024 11:35:00 +0200
Message-Id: <20240507093530.3043-19-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Right now, TINY_RCU depends on (!PREEMPTION && !SMP), which has served the
kernel well for many years due to the fact that PREEMPT_RCU is normally
a synonym for PREEMPTION.  But with the advent of lazy preemption,
it will be possible to have non-preemptible RCU in a preemptible kernel,
so that kernels could be built with PREEMPT_RCU=n and PREEMPTION=y.

This commit therefore makes TINY_RCU depend on (!PREEMPT_RCU && !SMP),
thus allowing for a non-preemptible RCU in preemptible kernels.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index e7d2dd267593..7dca0138260c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -31,7 +31,7 @@ config PREEMPT_RCU
 
 config TINY_RCU
 	bool
-	default y if !PREEMPTION && !SMP
+	default y if !PREEMPT_RCU && !SMP
 	help
 	  This option selects the RCU implementation that is
 	  designed for UP systems from which real-time response
-- 
2.39.2

