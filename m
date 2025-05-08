Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317F233701;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747904; cv=none; b=HGVc7TtC5OOE8ixeXRTEmx7UNF0EMde1E8rkC3Dj6YwDQaIx1zqqWtkAzhvpQYcUf4ysqqvLWpBt6nJio9fQa4gXdIQyp7O7g0nlHqCmnjPkwCP84CFciW1EqFHHGS0FSTYBNZak/0e2xrc2crCi2L66odNzrdSEUNNJeXGNVFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747904; c=relaxed/simple;
	bh=aZVSh1sdTm/YNurWzN8SgnUsB5j4NFIIa9V88kYxZ+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9agSYtUM/vU7MxNXAp3tfgVouu3XYVRuJhTRdC/wbWGeLI4QGMINX1JzNKRh0m8riwseKds+YZwdzJhQ1D45xj4tDShvi5CrJjFLu7AWFfQ7bc3k2vZ/CQO4jc7PeHSPgRK7uRZ9UhjcvMNIne9k1a9gNAQNVeK1qDvb+PJ6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1sR/fq0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1sR/fq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0602BC4CEE7;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747904;
	bh=aZVSh1sdTm/YNurWzN8SgnUsB5j4NFIIa9V88kYxZ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1sR/fq0I3Q50GXZLCmkyR9Wb2vMv2ln/aT/gS1Ex5QDGL1+LCN+MgNC8KPmD45NN
	 zH6YDOfkdYEk8tFLr7t+PJQ1aKZKSI1vOqbOeFU63SJgKEAT7JNkN9Wduu595IXPCj
	 xWqOvHlLlVto8utkEXFUZxkJhdJlmg2WMj4owywePdgDiVNeGvrPRnKJErkq1D44FH
	 0neKWNAnIRgvzUbznJo818zu5VXwqr8tuhhdm/Rw5n9qUFtcbxaLitmV73ZKtmG+xO
	 AiKY5ziLpWuvdGOTct0ANrCM3Ub9c2ujkFJGJUiYm4wdof24ro7UYUDkRniiL/8KYd
	 xRqyUuSMdOG/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AF67ACE11A4; Thu,  8 May 2025 16:45:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 1/5] torture: Suppress torture.sh "Zero time" messages for disabled tests
Date: Thu,  8 May 2025 16:44:58 -0700
Message-Id: <20250508234502.1996788-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
References: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The torture.sh script prints " --- Zero time for locktorture, disabling"
when the --duration parameter is too short to allow the test to run
even when locktorture has been disabled, for example, via --do-none.
The same is true for scftorture and rcutorture.

This commit therefore suppresses this message when the corresponding
test has been disabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index e03fdaca89b35..c518de2968711 100755
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

