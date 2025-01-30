Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2031F1922;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263886; cv=none; b=RU79It6beotJx7EU3xgsoNFMIGp9SmqJCDLm4IzogejWngsjbGRsuJKqspaZh0WIzqO4nlih7aF0810h1Nl2tCBEkmIfGP/qnwgceAvqLKE0RTc7ga15uikn65ZtbWtLTb9LYgHIQJU+we0Ts6z9C/Z7w70opxoj2zYX+1KAupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263886; c=relaxed/simple;
	bh=VszyCCDaAvuHXyR3DQ0kAWvSJ2VAo8gjm831J0qsyQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HTYCxbWiLhG6Bv16o3jgQoqv47sH5ePC5qxdlQV/QU1hw5Q2WqIyMiY+dJ9XKMPkxwBHzPnwMfpCbGhMsP0yUgnVbF17ZphEiobc09IB86xXl1WwjzIcbPg54cpqw2xhlMsT2M8QllCDl5TSnSygBIrcAhFMrS/XB29nIEl964I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8KzasM9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8KzasM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D64C4CEE9;
	Thu, 30 Jan 2025 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263886;
	bh=VszyCCDaAvuHXyR3DQ0kAWvSJ2VAo8gjm831J0qsyQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8KzasM9vnyRNG4s5uZZTDiWdD4dGfVQM8yHwKUueNAQM6MDHkD+KnsQi70rM4nq7
	 f672VKxSWOSp3pCzIW+ctxIv7R7ujjwrSJR1ewWxz1PQoTo1Grsocx9PFiUWoWSbMO
	 e0ez6LxyRQEULfjUqWHbZJ5TLXb7CWHjAiYrI8Up2QGTgGfoNB1iVwfeXyUruJW3N2
	 ZuE59JiNtGbQMlnjcGZHJ00jq8dfwsn3IQyDJ42TjYyRQn+V4AK4+qyUSV/qxCxRqw
	 4xdMn/rCSxomzEfInBDwulaprcuquV90Zl6cPIANeakYlQUePgb881+zGbYaT0HVYY
	 2L9qLd48uDDGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90EC1CE37F3; Thu, 30 Jan 2025 11:04:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 11/11] torture: Make SRCU lockdep testing use srcu_read_lock_nmisafe()
Date: Thu, 30 Jan 2025 11:04:44 -0800
Message-Id: <20250130190444.1652700-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
References: <bd22a7da-a4e0-45dc-b43c-1532af4dcfc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent experience shows that the srcu_read_lock_nmisafe() and
srcu_read_unlock_nmisafe() functions are not sufficiently tested.
This commit therefore causes the torture.sh script's SRCU lockdep testing
to use these two functions.  This will cause these two functions to
be regularly tested by several developers (myself included) who use
torture.sh as an RCU acceptance test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 2e63ef009d59..2db12c5cad9c 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -49,7 +49,7 @@ do
 		do
 			err=
 			val=$((d*1000+t*10+c))
-			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --bootargs "rcutorture.test_srcu_lockdep=$val" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x2" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
 			ret=$?
 			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
 			if test "$d" -ne 0 && test "$ret" -eq 0
-- 
2.40.1

