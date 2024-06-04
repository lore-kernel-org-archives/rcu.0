Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635B1422C2;
	Tue,  4 Jun 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539448; cv=none; b=uRPCjseZDUYeKIPmIdv1piycRdXA+N9nf0UpY6eIyYl9Phz4L+zaInEpH+i7RXx99/VC/kqQfZ6mwTIOtAiGQs6NArkhIhXqaUyhOtH1PpO0d+g0IEGkOc/PeVvreY3DrCEv98byKKj7KWAJfzO6Delm3rxd8vD9Z37XN3v1mRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539448; c=relaxed/simple;
	bh=fqpNZXPwEgyr90N3bPs/G8cQ7vpf2l91LdZ7mfjML8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HK3/YGEaHvEcwPwbWOUNzlJFK9ev/JmO3cGyRtPvdRK1iwQf8dKhKNtrKnlYzmw7Uy0v6RZtwzI+TIqgx7V4ozVus3zncE+liYo8KXpUpBJG9VsycTetb/9pkzoKJ1yUlIOzwL/ZWPD+iy7CTl5OfxGUTTZMhuThTov1aPv6NJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHp6q+80; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHp6q+80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03D7C3277B;
	Tue,  4 Jun 2024 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539447;
	bh=fqpNZXPwEgyr90N3bPs/G8cQ7vpf2l91LdZ7mfjML8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHp6q+80cIgE9/mSGlWQ1iezV7lqZYXl2/1nG/x/1Gk7bILYExbdKHlarfDzc/D7F
	 sxtQLh9ABsPx8ytkCIeT2HpPIpKyaGHu+avnnhKJRS+bVUEvU1fg3XI1SYtT0o6rBG
	 G8GAB0Mj8iaaDItADCH2Lo1D9Hfx8yKeM2/0evNpZsLt6sFbm+4oR1lVQixBI9ipwq
	 byvvKgXAxxHpwAhYjRPdpGJm0wk+3rqsQlfgfCBXeuh1Y59zGkXM3g4XgrKTIMjOjY
	 odVBR0Qx3y8jXEqUEPTc9/zIAZCpxTdnCOpEdbbvevjpTJB4uqdB6tVvbYnshUc2n7
	 JMPTKUJ9d+RnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90F8ACE3F0F; Tue,  4 Jun 2024 15:17:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH torture 2/4] locktorture: Add MODULE_DESCRIPTION()
Date: Tue,  4 Jun 2024 15:17:24 -0700
Message-Id: <20240604221726.2370316-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
References: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/locktorture.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 415d81e6ce707..de95ec07e4771 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -30,6 +30,7 @@
 #include <linux/torture.h>
 #include <linux/reboot.h>
 
+MODULE_DESCRIPTION("torture test facility for locking");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
-- 
2.40.1

