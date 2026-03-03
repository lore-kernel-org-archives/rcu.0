Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A23750DD;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581839; cv=none; b=X4KLf50bEyV0kZaXYRtNHsKgPSbTY0EcKP7jlbN55OfszGp/OGXYyrOVR4ExtiSxgSgNAqC7JIoxSybncIcOET7CJam7Xlzn1bByAzVksTta2QqgP5wLHEAdBQaHzKKqP5hPQxMwLOjVWIpATPTgZNowj3Sk3uT3BF1bOY0wxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581839; c=relaxed/simple;
	bh=jE1bUAMMD8K+kde9GOcsEF0e368b5WdVOEyr+RwU+Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARKz2NU59RXn3VgaoC5vIzV9xOUdwzA4M3ONoFWUbn1e0GHEtSoNnJncnzafC/ztnza5Qpstkt2382cvAlsfYWYkHmjAyNYLRcq64Bu1IZJLDbu+oBzYWD0Uu/n2zAHs6F7lVJfZ9gI29n6btx+m72Rmp/687VHo+a7KnVzz+Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHrBF/HZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHrBF/HZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CE6C2BCB4;
	Tue,  3 Mar 2026 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772581839;
	bh=jE1bUAMMD8K+kde9GOcsEF0e368b5WdVOEyr+RwU+Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MHrBF/HZvwcwIIu7POime9yZpZfmCSV8JJEP14Uv2Wi3oIjy2yd+8eBredfsbgkHA
	 /aHdvw4+uvtxNawsJ+lPl23jelIYoP9O+HI6HUVyWuPM0fpqHFAwliwT7E0lSTvOG0
	 pNvoyTRi93Y8z+S1Ccejbem4/juQ1ANH9YfCjIUvod1VDOC2J0UYxGwSjqEtDsjPH0
	 8dDTLC5sDCMyFdBEgrRNRvLV/625CG5WCBWSagh+nOEnXJbqFHWFsoiqdRT0Jif+ok
	 buwEXPliopz8M6UycMB4+wQd9AHQYNirLqs67hOENGaE4l4qUFFZDzRBMGfjTHFlMY
	 KIKSDruMKrukg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EE4D4CE0EE2; Tue,  3 Mar 2026 15:50:38 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 06/11] rcutorture: Fix numeric "test" comparison in srcu_lockdep.sh
Date: Tue,  3 Mar 2026 15:50:32 -0800
Message-Id: <20260303235037.1967017-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
References: <50d2bb98-c912-4ba6-a723-4a4aed506fdf@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit switches from "-eq" to "=" to handle the non-numeric
comparisons in srcu_lockdep.sh.  While in the area, adjust SRCU flavor
to improve coverage.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 208be7d09a612..4e98c697def48 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -50,7 +50,7 @@ do
 		do
 			err=
 			val=$((d*1000+t*10+c))
-			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x2" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x4" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
 			ret=$?
 			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
 			if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
@@ -92,12 +92,12 @@ do
 		nerrs=$((nerrs+1))
 		err=1
 	fi
-	if test "$val" -eq 0xf && test "$ret" -eq 0
+	if test "$val" = 0xf && test "$ret" -eq 0
 	then
 		err=1
 		echo -n Unexpected success for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
 	fi
-	if test "$val" -eq 0x1 && test "$ret" -ne 0
+	if test "$val" = 0x1 && test "$ret" -ne 0
 	then
 		err=1
 		echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
-- 
2.40.1

