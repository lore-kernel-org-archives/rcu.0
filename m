Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9725B085;
	Thu, 16 Jul 2026 00:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161098; cv=none; b=bYunt+fibudWej43IVUl5rH3WdXigeEiD9e8Fx6gi4Bjrtn+hB4kxS3sGNOYgsu/+qWb63LdxkYCfImDE9VRXosYZVT4wyCOWxIru6cEi1pI8pz/FVdfd22sarjlvpAG97KXjAPrUfE0tVTDxN9poqRcQLBJ2CsSgLISRzd+5xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161098; c=relaxed/simple;
	bh=BjFUTrvtwU5D3BOnMP1eF/iFS9josaPdGig40fY7wWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuuVtDEjiYtKBjk61rUlDSL/LIBnFY5ZgcpFkm6cDRiy+N4WIX1rSQUIa9FoIq22mm6ZUvpQOfM/HuYadc2l8NuearoF5VQDF+FbuO5b8gwUYQw+8HCZ6BVpS9LZVvfswcOgVwVjOZ+KfiIr0mFEkOn5fuxshG2UX5MGCEBGJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaEHg55+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaEHg55+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5861F0155A;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=S2IRIOjVtcezmaUWCwimKB7xhL3Hl7qs/F5PWQvhzSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MaEHg55+NsF8rdZHexUuV1EHp7jkAFXGTIxw7b/Eu8kq/2bOnXH613theuYivcdPg
	 W6sjCXuEhL8t6HuTtnP0esPXxbbmB9lzNy97V9UPfLFz5Gp/32dAgpPKSLuOniTT7V
	 ov0Xuv00F+kVtqeWznc/4SQmb7N/NPefHiVX+/BEn58zZaFB8AqysBcCp9/dhOKp1l
	 P98MgV7dChiqw5gW37kjqGZWq22U0IVg2Pr6NOw7BquUs1kB9mLca2YL/D2y69AiTH
	 MPRhu6jkZgG7nnjAvR4edVVfwSBluZexsnIY4+rgcMMXY64NJdvyR1QaqBK7FgmhNo
	 0SIq/Y9DL9HXA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5C74BCE0F9F; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 23/24] hazptrtorture: Enable CONFIG_HAZPTR_DEBUG
Date: Wed, 15 Jul 2026 17:18:08 -0700
Message-Id: <20260716001809.11084-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit enables the CONFIG_HAZPTR_DEBUG Kconfig option in order to
more easily debug hazard-pointer handoff issues.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT | 2 ++
 tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT
index e2da430abe4d70..405941f3b50f3e 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT
@@ -15,3 +15,5 @@ CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
 CONFIG_KPROBES=n
 CONFIG_FTRACE=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT b/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT
index b8ea4364b20b7b..c5b12f3bef7429 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT
@@ -12,3 +12,5 @@ CONFIG_HIBERNATION=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
-- 
2.40.1

