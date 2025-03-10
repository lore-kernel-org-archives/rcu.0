Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA9233D89;
	Mon, 10 Mar 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741631892; cv=none; b=Y2A8vS+azGcA1vEf+GAL7ak2j9iJznJwKdhNbwYWdl7yin+tr5ChyVU2eyBw685yACU0dOfww+jXsKf0YiaTv5gWxrBus2aijzEBhkf3JidSC9voBWH12zICFM9fmMJ5rToMmlccBv5tVFpCR/jmxo3MaHCtNkTQtFnoDm/QPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741631892; c=relaxed/simple;
	bh=Vh4wzubR/QtoBshTTizJkq+P2DARWdEyUI69hQkMTBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/YPnSXhh3udKnJQAVzVu++jPc/drtDAPrHOHcRLx1YZbiGbii1eJKvF0ltD96kYH3tyf4TjVRBJqGvzLmvbHau0HzG4QGB/hF8fr7eSXmIACjFW/C1N2nzIK5eNc7oRzjG8Ki8ut3SriYXT6+6sNPo3WEhqm0XGKDETB3vEjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIqZxU0+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIqZxU0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB252C4CEEC;
	Mon, 10 Mar 2025 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741631892;
	bh=Vh4wzubR/QtoBshTTizJkq+P2DARWdEyUI69hQkMTBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIqZxU0+NmS41KTNQVcszhGvzIkJ/3r2qDeO3gIgrJi7s8GE5voOo68A4eiq5gW3C
	 PO/SOFQccUXXqjvR2OmYC84/CMOcd429ovhjVy2mlqb+mQefD9gudfXelCjlhOokfD
	 lx1L4jB14j+v7IqaJLBTAZffrZxr2gUKd6vkoZZQtpcp1m+G8mxIizoPYaDWurjvYq
	 TEm/2o70WiqyISkzMWzcybYUddv2hAHQKHeClK8stAqKNyCY9mkDQQoVCot8xQI6cG
	 fcNToPt3pqqz4mQMTeS8Y0FZiPHCOm/ov4XFKfgZ8OtbcKaWiKMxU45zeU4fOBaa+l
	 Hf7L6MGZgWalA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90F72CE07A0; Mon, 10 Mar 2025 11:38:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/9] rcutorture: Make srcu_lockdep.sh check reader-conflict handling
Date: Mon, 10 Mar 2025 11:38:02 -0700
Message-Id: <20250310183809.3576320-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
References: <4bf081c8-9299-4ee3-b337-d5b751cef6be@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mixing different flavors of RCU readers is forbidden, for example, you
should not use srcu_read_lock() and srcu_read_lock_nmisafe() on the same
srcu_struct structure.  There are checks for this, but these checks are
not tested on a regular basis.  This commit therefore adds such tests
to srcu_lockdep.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/srcu_lockdep.sh  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index b94f6d3445c6c..208be7d09a612 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -79,6 +79,37 @@ do
 	done
 done
 
+# Test lockdep-enabled testing of mixed SRCU readers.
+for val in 0x1 0xf
+do
+	err=
+	tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.reader_flavor=$val" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
+	ret=$?
+	mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
+	if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
+	then
+		echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
+		nerrs=$((nerrs+1))
+		err=1
+	fi
+	if test "$val" -eq 0xf && test "$ret" -eq 0
+	then
+		err=1
+		echo -n Unexpected success for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+	fi
+	if test "$val" -eq 0x1 && test "$ret" -ne 0
+	then
+		err=1
+		echo -n Unexpected failure for > "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+	fi
+	if test -n "$err"
+	then
+		grep "rcu_torture_init_srcu_lockdep: test_srcu_lockdep = " "$RCUTORTURE/res/$ds/$val/SRCU-P/console.log" | sed -e 's/^.*rcu_torture_init_srcu_lockdep://' >> "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+		cat "$RCUTORTURE/res/$ds/$val/kvm.sh.err"
+		nerrs=$((nerrs+1))
+	fi
+done
+
 # Set up exit code.
 if test "$nerrs" -ne 0
 then
-- 
2.40.1

