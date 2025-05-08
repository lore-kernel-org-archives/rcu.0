Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A8230BC2;
	Thu,  8 May 2025 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747753; cv=none; b=ZhBhjQzYNQO3Fcwq94/sH+MgEdBkcnp3Crwdt8moUdtlsb5BLQUkvklXot37B/2X6x5MG2uyIkn2H1VajSkwVL8ve2FzSDlUr65bN14Z0EJ2YeIsQ52MqvaPm683YswFBYZ0uUYQ87alPZ9ugcCjtcx3MireByRL8kZc+rX8rBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747753; c=relaxed/simple;
	bh=qKbpk5aA0PmCFIvSfweb7NuQ7n7KI2VncQk39HmbUNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iaynGOt/c8oRniwCjadxA0aN6raudKBgjJyREUixhn1rPy/dtjS83tyXloZwBOkrID0FC4VETFgTjs73q0RtzuMq3yPDIwCu5XQQ6gX7duKioBIvaH9N4evHIPyNGBB2sfqIYxJMTeLNVIm97x0AuJ5VN0gm4u9/fq6m7KeFUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uto1rABw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uto1rABw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F36C4CEE7;
	Thu,  8 May 2025 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747753;
	bh=qKbpk5aA0PmCFIvSfweb7NuQ7n7KI2VncQk39HmbUNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uto1rABwKs++TyHL3Kq0A4qA3EPiRIeCJmEWFhBKgZn18l3PJQaE4b529sBZLFVyl
	 64gD4cvJlZLxk7QuhSHb93cTPXiS53QSP7jQ2RUpRN+4Obp90ydRwlbn7WTqMzV8oO
	 7amDdaLcOg8qXUBkYj64g+CbqCG/T9q3sda+/Wol8kIAX+LZvxQ8DHwI7DqsF6fo07
	 RUdw/b3W1nICahiYHwyutamonPMm7sbvqKQm0ha2Qq7aCZykAeCIGWstHAxHvKRvC6
	 LJWbWNJEPcxi+ezI4HdU4FbnY0e9DefD13wwGUJb0+jUa+SKFpSNrpGJ15mkiyYtPY
	 5oijrnh1mbXvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0AEF3CE11A4; Thu,  8 May 2025 16:42:33 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 1/3] torture: Check for "Call trace:" as well as "Call Trace:"
Date: Thu,  8 May 2025 16:42:28 -0700
Message-Id: <20250508234230.1996554-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
References: <da86a280-f402-499f-a4ba-df626ca4c748@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different architectures capitalize their splats differently.  Who knew?

This commit therefore checks for both arm64 "Call trace:" and x86
"Call Trace:".

Reported-by: Joel Fernandes <joelagnelf@nvidia.com>
Closes: https://lore.kernel.org/all/553c33d8-2b51-4772-8aef-97b0163bc78e@nvidia.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/console-badness.sh | 2 +-
 tools/testing/selftests/rcutorture/bin/parse-console.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index aad51e7c0183d..991fb11306eb6 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -10,7 +10,7 @@
 #
 # Authors: Paul E. McKenney <paulmck@kernel.org>
 
-grep -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+grep -E 'Badness|WARNING:|Warn|BUG|===========|BUG: KCSAN:|Call Trace:|Call trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
 grep -v 'Warning: unable to open an initial console' |
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index b07c11cf6929d..21e6ba3615f6a 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -148,7 +148,7 @@ then
 			summary="$summary  KCSAN: $n_kcsan"
 		fi
 	fi
-	n_calltrace=`grep -c 'Call Trace:' $file`
+	n_calltrace=`grep -Ec 'Call Trace:|Call trace:' $file`
 	if test "$n_calltrace" -ne 0
 	then
 		summary="$summary  Call Traces: $n_calltrace"
-- 
2.40.1

