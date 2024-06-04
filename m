Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654AB14D439;
	Tue,  4 Jun 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540595; cv=none; b=OxlXw03aIYlYgc4NiYQrhoosbcYMDHTvjgsOJDp5O2d2+ETPxc0AknQSB9v+LS40OmgEGG8MiZUFephdLVNKtJETXUHyFS1hK/GikIv0XNbDtWI3JySCreNBjkt/nCb5/NzBkFSjG7hKy4nSoj4L8cWIDs3UomrJarBpuEaM4/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540595; c=relaxed/simple;
	bh=3W1hLX3CDpcxFpIRjKB9LG1doeFsN5iCPTpoG6MXxYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rrd9ivCrBQigqOr4CGxYBe4hXjQQxFKQrEuDQ3aQixq0sVe33K7ciBiUcDmfEeUp3RAwMeM6MQCw/6UK7xb1jx3dIkJeZxW/1O1uaOjU54N2VpIhgJl80++FK5SeCngIROuntxFLa6lwzEs7bvltGzOZYHzghHSqO83mY6Egg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laGrPfry; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laGrPfry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429D1C4AF07;
	Tue,  4 Jun 2024 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540595;
	bh=3W1hLX3CDpcxFpIRjKB9LG1doeFsN5iCPTpoG6MXxYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laGrPfry+NoKRkhCtXFlV7rexL+lJdX+qFMm6Aqd2wpb1eHc4g7LZbh3D4g4HMPfB
	 oYB/CrbXxcK77v4TuWd/2am9tNpJotqOdPaZABoYmXxipwyK383HdDXylqXEEMDdgE
	 VfrkKKlu/Ndle6RFR//qbeFwCZ3EVVc01jLCpNfQ4T1ZOze+uFVlF0Kzo56AlVGE3u
	 SlOGQ+j3IHhfr6exRiy/TwvWIU2YiCB9UtjFJvfFGNk0FrZZLQTgNnzpYKnt6F5M7F
	 dSQydJKPDw/Ue+BJ3NAO2LUciZdW1Zt1kZWo36cYLreyQgeSaAZG3UfPFZ66qSJ5gt
	 6jy4beKCEQXOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E2CCACE3F26; Tue,  4 Jun 2024 15:36:34 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] rcutorture: Add missing MODULE_DESCRIPTION() macros
Date: Tue,  4 Jun 2024 15:36:32 -0700
Message-Id: <20240604223633.2371664-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
References: <e14ba19e-53aa-4ec1-b58d-6444ffec07c6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Fix the following 'make W=1' warnings:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcutorture.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcuscale.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/refscale.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c   | 1 +
 kernel/rcu/rcutorture.c | 1 +
 kernel/rcu/refscale.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 8db4fedaaa1eb..b53a9e8f5904f 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -42,6 +42,7 @@
 
 #include "rcu.h"
 
+MODULE_DESCRIPTION("Read-Copy Update module-based scalability-test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index cafe047d046e8..08bf7c669dd3d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -51,6 +51,7 @@
 
 #include "rcu.h"
 
+MODULE_DESCRIPTION("Read-Copy Update module-based torture test facility");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com> and Josh Triplett <josh@joshtriplett.org>");
 
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 2c2648a3ad306..f4ea5b1ec068a 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -63,6 +63,7 @@ do {											\
 
 #define SCALEOUT_ERRSTRING(s, x...) pr_alert("%s" SCALE_FLAG "!!! " s "\n", scale_type, ## x)
 
+MODULE_DESCRIPTION("Scalability test for object reference mechanisms");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
 
-- 
2.40.1

