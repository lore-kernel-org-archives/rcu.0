Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228F23770A
	for <rcu@vger.kernel.org>; Mon,  5 Jan 2026 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767573060; cv=none; b=bqtueXxY1eDelaw6oWvVWFO7eNGU/JDGcKVKAT29RPj6lVDRPTzmNX9nAfW0UnCndhELJPzm+2GsCdVe7v/0Pbq3U+Iq4+yl2WdOvaEohPGYXlW4YffHvpM+1v8IEkCv4HciosLeQYw7K/IU/48jwKZlXwQmSOlD79SuowFNNs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767573060; c=relaxed/simple;
	bh=4VtYblT4HVRoWu4jaDLopVPALPaC+zSFUE4twq/MOW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G922FgyoZvr6jVWXdeYlFQZlI2lNz1q5E6mhzV7JbwBxMbHnZSgdahdpbCp3pM/Zd0lBiB9JkiJ8um2xYwnuls+ZWy/IrMy+BPrNxGZoIMlbOukZOSEq2dRrLGlzUQRV0IKzcGtydWNZCTWp/+/urNlJTAeAI6rXQnp8Ek/Ic5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=X3pwuzL8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="X3pwuzL8"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso12926950a12.3
        for <rcu@vger.kernel.org>; Sun, 04 Jan 2026 16:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767573058; x=1768177858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XCOUHvaAPVBQlsZFB5UXzqWiXysSXr09nQwBmvYSu6k=;
        b=X3pwuzL8pfXYi10MKc3OzSZ0hzqxt84gp78LfQhXkVnYnqAO1x8ArggCzeQ0EB2JA5
         jzZSy95Jnxnz5m1jBXG3vRTIgvwvcDN2Vv58j47Hjtbfi8LeWV0rD6W9kSPft/ivbZt7
         9+t2R/Jr2ZNxOqe9GKF5Kb9qcdzN5qSEFsUQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767573058; x=1768177858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCOUHvaAPVBQlsZFB5UXzqWiXysSXr09nQwBmvYSu6k=;
        b=uvOgJLwpsneQAERV/kpB0LlPvj3iSEadJuCsqpLi27P2pn+5oJmktAvBlAY4kYqejA
         wMAvLGGibD01z+Cg76zvTa0Agk2Qob82jSM7Oa78jfz+qE6/sRO61j7PvrfKOl1PFVon
         GTEg9bbIel7K0zeLYeFEELEJFgV6+V2VZ0M7rpwoE9vUawRC8t1O05FI+Bg8GNOep8Xu
         ag8rg+ahitRBJdiKBRqAMJs5DfSq/Q9anMzUKjp2B7WfdJoZCGRxspR63vOXde/X109a
         ys4PasJ/UiYhGdD6E9s4qwGeGope4uqQY3FWtEBWK5uWkHWpTQHKvo8/CiYzeALitul3
         Bv5g==
X-Gm-Message-State: AOJu0Yy4LwU0NtIdyI/49OYmtJg9eKL3V0sjSKDOa9VzBbC3hAcPIpLq
	vq6hzm8KeY1fWr8CMRjfBS03KfUPVNLckVVyiWyD6pAMdtV6nIkF02Gr2QMJPIn79xc=
X-Gm-Gg: AY/fxX5Fbc5KRcRa5tmWWVfP0E3Gg6oGsDiGpN9QmtliJzPYn4xFE25TGyYWWEjIZ+4
	/1F/ql2QqtgK4grgW5u5g1kFaL6A+TZ2QSg2S8BJJQyxcSvlyv17siIVyRFcQa+zVv+/yjOsTmt
	s8lLXPw07hVVnXDbbVaCtGQjeZjeNPEs2gD5UmH0ukB6Yn9SwSZN3Ux0J6EBcXUvLZFUwRw5hXU
	sIyz/WvQ9dLiFCt4mMr5waJMAKY1grnkk1LWjj6q/0HN/86sApSFYpcGXazOr8Sn/gSa+fe2oDe
	8IOHOIYA5CPjhp+lbqq9KoaNqxBpOiFfa6PKJJ6SHGrGooey22qTliQsP4KILNrEqRxNpsEpjFf
	ANkY+ev9FPgIYBFLOQ8d5p9w9DpvskpS3kZphUMM+hFzSLDf6envmLTk1a4sx8TvHMcCeUmlnRL
	/9VzIIkM6L
X-Google-Smtp-Source: AGHT+IE9449FQ7FOHazIKXgDJtnuRLaIjG3nv4UMuI5rLRSQ8cHnSvTHqKM2sCHKw//28dbTJ7gQJA==
X-Received: by 2002:a05:7300:fb0f:b0:2b0:5b8f:1c5a with SMTP id 5a478bee46e88-2b05eca8ba2mr37694992eec.31.1767573057787;
        Sun, 04 Jan 2026 16:30:57 -0800 (PST)
Received: from localhost ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42d9esm9551321eec.11.2026.01.04.16.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 16:30:57 -0800 (PST)
From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	"nouveau @ lists . freedesktop . org" <nouveau@lists.freedesktop.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH] MAINTAINERS: Update email address for Joel Fernandes
Date: Sun,  4 Jan 2026 19:30:51 -0500
Message-Id: <20260105003051.122076-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Fernandes (NVIDIA) <joel@joelfernandes.org>

Update my email address from joelagnelf@nvidia.com to joel@joelfernandes.org,
which I will be using for community email going forward.

Signed-off-by: Joel Fernandes (NVIDIA) <joel@joelfernandes.org>
---
Boqun, could we take it through the RCU tree for 7.0? Thanks!

 .mailmap    | 1 +
 MAINTAINERS | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 84309a39d329..279f8fb223e2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -389,6 +389,7 @@ Jiri Slaby <jirislaby@kernel.org> <xslaby@fi.muni.cz>
 Jisheng Zhang <jszhang@kernel.org> <jszhang@marvell.com>
 Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@synaptics.com>
 Jishnu Prakash <quic_jprakash@quicinc.com> <jprakash@codeaurora.org>
+Joel Fernandes <joel@joelfernandes.org> <joelagnelf@nvidia.com>
 Joel Granados <joel.granados@kernel.org> <j.granados@samsung.com>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 12f49de7fe03..43bbf12e2c80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14558,7 +14558,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
-R:	Joel Fernandes <joelagnelf@nvidia.com>
+R:	Joel Fernandes (NVIDIA) <joel@joelfernandes.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 L:	lkmm@lists.linux.dev
@@ -21895,7 +21895,7 @@ READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
 M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
-M:	Joel Fernandes <joelagnelf@nvidia.com>
+M:	Joel Fernandes (NVIDIA) <joel@joelfernandes.org>
 M:	Josh Triplett <josh@joshtriplett.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
 M:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.34.1

