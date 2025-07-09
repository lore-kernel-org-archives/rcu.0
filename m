Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB310280308;
	Wed,  9 Jul 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057892; cv=none; b=JSCIvRuQT2ZsgOouCkOaD0flBETQwL0535+MZLJtdEcU9cn7jyzqvmnknIfO1P/HIDpqQF0pUq03zG8OhxHMJhYULJdVB39dTIldXwLqZY6WAyqRIwjXZbt8/Fi+1sjr5NWxKt1nryDrefWss5pVz3RyxJuyIUu7vyT2/wnkmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057892; c=relaxed/simple;
	bh=ZCcCZHZ2XLb2dCNU6DwQHYve2tKc6/BsJwstIn4SwOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCXZSF+oxbiyZR3FIaLyDouX7DcNw5an+wbGSMTR8tlTLa8XBXhS5uadSjPilxK4x5M3Gugd7i6LlZnzqGGsKI5WpzHDcbggsNtjLwPk6ZSXaDNGtJbE3NgCDdMMfd8sefG8x4agK0hMAsrQk1ikBS0/rwO8dqrUR5Ntb34KFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DisIMYPg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DisIMYPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D56EC4CEF4;
	Wed,  9 Jul 2025 10:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057892;
	bh=ZCcCZHZ2XLb2dCNU6DwQHYve2tKc6/BsJwstIn4SwOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DisIMYPg6OLuMsPDhyzeT6gX0bRAMZwsK0C9s/7h4yQ3EpOJGx+OA4nIU6yAVgyRm
	 tLxO11uThUH0z4GwwtnMEVvMtJjJC/ynxzRVEx+nNooSTlzjGZekoFcWsT69DuZ7+L
	 3/KclJi8fU5JM6WGMkVIf4DDZXzl0DC0iy0di062EZtflMr8y0hAKPKlPUT3uce17T
	 suV0E99fuoV6TPC+Y6qysW/f9gNflQoUbpN+57/qmLkFBahz8wkkiekGvvBmkgrDZE
	 dlTS/lceuUgQJuW4W5CBJ/eZxB8E/GAe9I61IsXpHcBNSkAxhz3fzy7DWJR8WElVLb
	 u0AnTXaXJGyrw==
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
Subject: [PATCH rcu 04/13] torture: Default --no-rcutasksflavors on arm64
Date: Wed,  9 Jul 2025 16:14:05 +0530
Message-Id: <20250709104414.15618-5-neeraj.upadhyay@kernel.org>
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

Because arm64 does not support CONFIG_SMP=n kernels, --do-rcutasksflavors
gets Kconfig errors when running the TINY01 rcutorture scenario.
This commit therefore makes --no-rcutasksflavors be the default on
arm64.  Once kvm.sh automatically deselects CONFIG_SMP=n rcutorture
scenarios on arm64, the two lines marked "FIXME" can be changed back
from "${ifnotaarch64}" to "yes".

Note that arm64 users can still specify --do-rcutasksflavors in order
to override this default.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 53f61f278fd7..584d57b48036 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -30,6 +30,15 @@ then
 	VERBOSE_BATCH_CPUS=0
 fi
 
+# Machine architecture?  ("uname -p" is said to be less portable.)1
+thisarch="`uname -m`"
+if test "${thisarch}" = aarch64
+then
+	ifnotaarch64=no
+else
+	ifnotaarch64=yes
+fi
+
 # Configurations/scenarios.
 configs_rcutorture=
 configs_locktorture=
@@ -57,7 +66,7 @@ do_kasan=yes
 do_kcsan=no
 do_clocksourcewd=yes
 do_rt=yes
-do_rcutasksflavors=yes
+do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n auto-avoided
 do_srcu_lockdep=yes
 do_rcu_rust=no
 
@@ -124,7 +133,7 @@ do
 		;;
 	--do-all|--doall)
 		do_allmodconfig=yes
-		do_rcutasksflavor=yes
+		do_rcutasksflavors="${ifnotaarch64}" # FIXME: Back to "yes" when SMP=n auto-avoided
 		do_rcutorture=yes
 		do_locktorture=yes
 		do_scftorture=yes
-- 
2.40.1

