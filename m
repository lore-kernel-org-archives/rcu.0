Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C128E5F3;
	Wed,  9 Jul 2025 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057933; cv=none; b=VPF0S1oz2MXc29hzD81CEL7WdeilOgqQ5VejiT9IsXwVS4Yv/b+FiYjdIf4Bxj7DRD/yVo1HdjqKcTRQrJw0VuagPdnNmj4Hx2NmxYRIZ4s1H99goenJFPV5l5qknHGDymUwnO8jaAD0KASL0mdkD2BzEFcZDiszlmcxv4I3SOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057933; c=relaxed/simple;
	bh=BMRJHXYdM2np+yVHsQ7FShkZ408nmLSDifr9IbnYoy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elGcG/DJmPXiF6HeEA+luUEMu6Yd9JYXYvamxtdZYjkt7B97ReHfYNLNJGmVSe5iDdef5QfsWjUzOcduvbV9itumaUHpkykzEJJ/ddYQr92HxZ2EubY8r2udjKxenLqaSqbW5x3J0YaPRxhBePBEyPNjCNikPPATJ4MRxBCVUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK3arXuK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK3arXuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B96C4CEF4;
	Wed,  9 Jul 2025 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057932;
	bh=BMRJHXYdM2np+yVHsQ7FShkZ408nmLSDifr9IbnYoy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BK3arXuK0MX9gT7GYky1/17ylKMySIs9wovvu/qw0D5JBc7I/Rp9/TwrnmoPCnb/w
	 d9iHNPUaCHJMMdZl436LEm6vAKM5QypK5tDh/Xf4wbaaxskNMFQDRfDKYcizYZNdas
	 efaDaMJvnBzp6TexsOBRB6B0RYObSh5lVfapDGLuNkQR4LNf95JKXRUcReyGsrNCUq
	 SZf/ZJXp2Qd67QZ6GI27lj535uaLMGv2wPth2wc64QegvF6A7QhQuat1140u2HGRE0
	 X54GQUIdlVrYj83Hg4F2fbJBIAaCXZvjgG+ww7qItQ4wGxFA/iLtUDEEZqDJrFgPAO
	 uqVwwuZMxE0Cw==
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
Subject: [PATCH rcu 11/13] torture: Add "ERROR" diagnostic for testing kernel-build output
Date: Wed,  9 Jul 2025 16:14:12 +0530
Message-Id: <20250709104414.15618-12-neeraj.upadhyay@kernel.org>
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

Some recent kernel-build failures have featured "ERROR", so this commit
adds it to the list checked by kvm-build.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 11f8d232b0ee..3edfd064ef81 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -44,7 +44,7 @@ fi
 ncpus="`getconf _NPROCESSORS_ONLN`"
 make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
-if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | grep -E -q "Stop|Error|error:|warning:" || grep -E -q "Stop|Error|error:" < $resdir/Make.out
+if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | grep -E -q "Stop|ERROR|Error|error:|warning:" || grep -E -q "Stop|ERROR|Error|error:" < $resdir/Make.out
 then
 	echo Kernel build error
 	grep -E "Stop|Error|error:|warning:" < $resdir/Make.out
-- 
2.40.1

