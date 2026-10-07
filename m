Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729C411F9F;
	Wed,  7 Oct 2026 21:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407051; cv=none; b=aegcFSMyZhCYwIbAoBm70Fvfyybn5INIsbLekAQk6C5jxNSCv8YHZZTw/0RtMqJEyRIXhBey3RdGU6N3/lAEM7h8BHMbGsvJIler31KZV3hXqcH5kQQll4V95awwHi+e05eOCgF8eib5osS0w+d7nPs2PjEvM69Z9glbc8L+ZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407051; c=relaxed/simple;
	bh=pWp5JbnYYpt64L1wGXymLGY9t0chYN2RvBc6rHJQzhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtdIOTuHZb6h90EPhezPlebLkvgLP6VU/+/le8nvLHFysXCY2kpgpl+WSSFSRD9poowUWxDSG6J3MSNt2VcJJq96jQaFESd8OzeGcQnGwCsfsTkTrZXvJSMBg/2LbkexmP2ZhRqll2WX96Q8b7v2RP0ElV+9GFfP6rmkPnbq+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmJhHPZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmJhHPZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D786C1F008A0;
	Wed,  7 Oct 2026 21:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407049;
	bh=ECYm3BBMedbNXUWfWZ6kwF4nXV9MDEYykiWwhcoVANY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BmJhHPZ1F03H2Ui0nyj96LApbySPWXGYhqOPjrYeJ9gQT+hbtnS0BUFDRn1lLllHQ
	 IRHJcdShZgzx8mIawJeTgu/jyHWd6qe60VANd+iFumD0r660NC4hny4WKSoqdgmTJa
	 u5/BfaWjFKaX8APw1FwCrjxBlY9Tu59n/iM649dq/sBb2huB9E8ME6ttqVJlqVqexJ
	 UbtY7G5EKzh3fKBZ8b3DgecfG8845mBQAWEPWy3DHc9NFBJEHG6PU7o9BoHo2/SLj3
	 vT+m/rTcGKulh3HVNxqqJgoYqIJy1O5mqowLdPWolJq9ZYLOuQCYYSFeJavS8ilNeJ
	 kxBlk3BhMn8qw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5FF4FCE272D; Wed,  7 Oct 2026 14:04:09 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 7/8] selftests/rcutorture: Fix double nerrs count in srcu_lockdep.sh
Date: Wed,  7 Oct 2026 14:04:07 -0700
Message-Id: <20261007210408.1983713-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
References: <f9cb7abd-db60-43f6-9392-27fe29abb75b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

When CONFIG_PROVE_LOCKING is missing, the deadlock-detection loop
and the mixed-SRCU-readers section each increment nerrs once in
the configuration check and again in the common error path,
counting the same error twice.

Remove the stray increments so that each error advances nerrs
by one.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 72791499dd96b..3acaffe52c784 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -56,7 +56,6 @@ do
 			if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
 			then
 				echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
-				nerrs=$((nerrs+1))
 				err=1
 			fi
 			if test "$d" -ne 0 && test "$ret" -eq 0
@@ -126,7 +125,6 @@ do
 	if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
 	then
 		echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
-		nerrs=$((nerrs+1))
 		err=1
 	fi
 	if test "$val" = 0xf && test "$ret" -eq 0
-- 
2.40.1

