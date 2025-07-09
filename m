Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2228DF0F;
	Wed,  9 Jul 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057898; cv=none; b=KLMjZKPZqjhRUuohLwpXOGfnyh1JwkLfyEkH8pmlrpBBfBjhClzTxFseGM9TrTbqnPtjqd8Nc1MxTdVe9w0Zkj2Cw3Y6feIvZwPCKx9Tmv3mDI0XVVdt+g3ZCUnP3c5uLlhWw3egXeW9C+c8QXnXLTPiWJ0ZWXp7FrJT1U+au1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057898; c=relaxed/simple;
	bh=IODYamKuFI4vzQc+69jKnLqKZtPjcOd4AnnZ16xKPsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NhZKadMXdci3wfU1odR3lqoarPLs26uJky/PUBWVgNEAnTcdIAtv/ptyms4KdvqvZXSC4OHEbtL8HbiSix29VLu5WCcptfj6pbBToGIDUWQ0eAmjGPoNyQw+kl50L7FIH/1xeSxPKes9Q3Vv+ztFrtv4DOhx6UtzXJdqORZCZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsSV+uXB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsSV+uXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DF3C4CEEF;
	Wed,  9 Jul 2025 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057898;
	bh=IODYamKuFI4vzQc+69jKnLqKZtPjcOd4AnnZ16xKPsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsSV+uXBdRhRqzI2Zq+b+4HDkCargZMHZQKtZzZb4Rk2v+Sow16siye9qkNU3ZJvV
	 XF3Qnqkqylu81W2/If0UnE6sgf0gPOGzqiMUbRg32DZBE9RnBHDp0ll+9Rw76GjcQu
	 VUfs4DTtzk1eTlkzN2WX3ekHRa9S+7YM2rGM5C9kKXwZPNFOAAYT+uXulMdMhtODKZ
	 qYy0ldH+n7OlRDcIX2TtIuBlvw1kbWrvCHGLeGyvkonF4sCG9ZlUShf7mD0kXbIDHt
	 neKLJhy7lqFpAM35fG+vTZXUFrslD/+lIkoT2+CpwzxW48NJkj2NHggDXpxH/Q29nj
	 2A35kz9OrB2FA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 05/13] torture: Default --no-clocksourcewd on arm64
Date: Wed,  9 Jul 2025 16:14:06 +0530
Message-Id: <20250709104414.15618-6-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
References: <20250709104414.15618-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Because arm64 does not support CONFIG_CLOCKSOURCE_WATCHDOG=n kernels,
--do-clocksourcewd gets Kconfig errors.  This commit therefore makes
--do-no-clocksourcewd be the default on arm64.

Note that arm64 users can still specify --do-clocksourcewd in order to
override this default.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 584d57b48036..25847042e30e 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -64,7 +64,7 @@ do_normal=yes
 explicit_normal=no
 do_kasan=yes
 do_kcsan=no
-do_clocksourcewd=yes
+do_clocksourcewd="${ifnotaarch64}"
 do_rt=yes
 do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n auto-avoided
 do_srcu_lockdep=yes
@@ -145,7 +145,7 @@ do
 		explicit_normal=no
 		do_kasan=yes
 		do_kcsan=yes
-		do_clocksourcewd=yes
+		do_clocksourcewd="${ifnotaarch64}"
 		do_srcu_lockdep=yes
 		;;
 	--do-allmodconfig|--do-no-allmodconfig|--no-allmodconfig)
-- 
2.40.1

