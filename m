Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2AE374E71;
	Tue,  3 Mar 2026 23:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582346; cv=none; b=ge6G5OZsUVLBFhbUnGigdq4WCyajgXqudOMgahoKVWSXZQ7LEzKXfhRyaSVJwce3GSQqHHDiBhK9RE0MiMq6xfc/dhvWGv0bGiTQEH0pKh0M7gplkeJT7Wq/1ixcCY3ArgBctaUTcACv5XDHVZNiZiLDkxa1lcWqsFyGgRzE3/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582346; c=relaxed/simple;
	bh=29HujnpIDyQeuQ4aBMq1py7s65mTBAwLmw/6N6QEet0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0X6kyyufBhkWoU81wzkQR04muSCm9Vc4m/Yo38dNvk1eYoONiKZggC5phnTQILLj8UEz83bZuOW2LXWZU8+mUHFBu+iFtNATCN7J1wRQxLxfwzHOYdRJEGJnXcQdwPf8i5gKgGzZ+Om+2pOJtEDuEgP4K9Tho3f/eIY5RSbjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCGUQUbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCGUQUbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D58EC2BCAF;
	Tue,  3 Mar 2026 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772582346;
	bh=29HujnpIDyQeuQ4aBMq1py7s65mTBAwLmw/6N6QEet0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCGUQUbkemkbjuzZGLyFsswUiwy25VkxRDYvLUdxv0lsmNYYs8Hx168rwXeqHerIl
	 1qXV8pVruwYiGEeHHEn+ngpITO58NJwH6HuPUs1gtVtvVuQg4uGy9BF07dPT3rHW5S
	 n9Lpo80mFGTPIMKpD35SFcg7UP54FwNLuG/xAQpl7LORihe53mYqhhA1ttt+V36F4t
	 /UrOWlBQbUll9y7Y85AJGMvzaWgRAxE0iHMIkpMOIPiOxhXp+OKiRz0SMds5kiwhUD
	 7aWLKDPQo/qAM8kaigQViw0D1tIpJxG+xlrRt1EZ9Cd5FGOXwSSn0JaLP0cRp+OWVj
	 OR3eoTGsLV2Tg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A5704CE0ED1; Tue,  3 Mar 2026 15:59:05 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/4] refscale: Update due to x86 not supporting none/voluntary preemption
Date: Tue,  3 Mar 2026 15:59:02 -0800
Message-Id: <20260303235903.1967409-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
References: <2011d452-3c72-432a-af77-810238e80e6a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of v7.0-rc1, architectures that support preemption, including x86 and
arm64, no longer support CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY.
Attempting to build kernels with these two Kconfig options results in
.config errors.  This commit therefore switches such refscale scenarios
to CONFIG_PREEMPT_LAZY.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT | 3 ++-
 tools/testing/selftests/rcutorture/configs/refscale/TINY      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
index 67f9d2998afd3..1f215e17cbae2 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/refscale/NOPREEMPT
@@ -1,5 +1,6 @@
 CONFIG_SMP=y
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
diff --git a/tools/testing/selftests/rcutorture/configs/refscale/TINY b/tools/testing/selftests/rcutorture/configs/refscale/TINY
index 759343980b80d..9a11b578ff344 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/TINY
+++ b/tools/testing/selftests/rcutorture/configs/refscale/TINY
@@ -1,5 +1,6 @@
 CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n
-- 
2.40.1

