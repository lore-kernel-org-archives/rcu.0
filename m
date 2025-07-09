Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C828DF4B;
	Wed,  9 Jul 2025 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057875; cv=none; b=r5d3SRH4tqA0exsrEIzUHibVvSmDNDVqHs0VhL2EvjL1TICYEtFCH0nFh48tMM0whaWKiihV2XrOuraHnAs374f6lp3ORC6YWYkJbaNHrcEb0YIVgIR5qNIVrle6OQY1iKUAE5vIzWbMAzq9Mw8gqaH8j9w1qRL9PGJGG24Mlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057875; c=relaxed/simple;
	bh=3lnTerRRwuwPEVBl53yo4RT7+xh8WcZiy31uwNMOleQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VEU40HVc071YmljtUfWZwRDWqSC/ivoIm/WgzYzNQw1mcYXI+HwKj9jdTHZpm7vpMMEGd4V1oEkS+WSrCLQLtmRDVCjBAxxb0wNLzBsXI/hbdEcTA53RtnLQ9qx5iruDrtrZ6tNNqDyAZZMr2XaPXYWWC0VyOLqpruL3X3hj0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKiSqlTE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKiSqlTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A48DC4CEF5;
	Wed,  9 Jul 2025 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057875;
	bh=3lnTerRRwuwPEVBl53yo4RT7+xh8WcZiy31uwNMOleQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKiSqlTE4OUp8ScMz2fKkHb6R7PaGn7AhF1dchBMxSd2yJ4nyuKadgA4nSSWxGxU8
	 rfgX7gyGLdpGbL9Mv/H0ZiZaKtGxTyqxlzP0MwNKOGi2lPaa6GBlr2eQ7VFIgkAmCi
	 ZcH2HiS0NiltvbqEVe+z3uHn/Dc/oERasFmGCHt3Xe4u9r9hDSKhYc0VqWVBWSCzyv
	 mfhUWarjuY9QUjSCA0aGj0pE9gO9KVS2QEX7okVtz4+Tb93TsR2ltQp1GOHK1BAokd
	 FY3LF6IL4HmBL39+H7eKl1RA5FlVbGtWQmKLi84jtLPBRbWEdLaWNhWUhDEKXqdw9A
	 haCjkIqrHqdzg==
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
Subject: [PATCH rcu 01/13] torture: Suppress torture.sh "Zero time" messages for disabled tests
Date: Wed,  9 Jul 2025 16:14:02 +0530
Message-Id: <20250709104414.15618-2-neeraj.upadhyay@kernel.org>
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

The torture.sh script prints " --- Zero time for locktorture, disabling"
when the --duration parameter is too short to allow the test to run
even when locktorture has been disabled, for example, via --do-none.
The same is true for scftorture and rcutorture.

This commit therefore suppresses this message when the corresponding
test has been disabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e03fdaca89b3..c518de296871 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -274,7 +274,7 @@ then
 	configs_rcutorture=CFLIST
 fi
 duration_rcutorture=$((duration_base*duration_rcutorture_frac/10))
-if test "$duration_rcutorture" -eq 0
+if test "$duration_rcutorture" -eq 0 && test "$do_locktorture" = "yes"
 then
 	echo " --- Zero time for rcutorture, disabling" | tee -a $T/log
 	do_rcutorture=no
@@ -286,7 +286,7 @@ then
 	configs_locktorture=CFLIST
 fi
 duration_locktorture=$((duration_base*duration_locktorture_frac/10))
-if test "$duration_locktorture" -eq 0
+if test "$duration_locktorture" -eq 0 && test "$do_locktorture" = "yes"
 then
 	echo " --- Zero time for locktorture, disabling" | tee -a $T/log
 	do_locktorture=no
@@ -298,7 +298,7 @@ then
 	configs_scftorture=CFLIST
 fi
 duration_scftorture=$((duration_base*duration_scftorture_frac/10))
-if test "$duration_scftorture" -eq 0
+if test "$duration_scftorture" -eq 0 && test "$do_scftorture" = "yes"
 then
 	echo " --- Zero time for scftorture, disabling" | tee -a $T/log
 	do_scftorture=no
-- 
2.40.1

