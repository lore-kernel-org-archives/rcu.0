Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3A21147A;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=Y/+3+Q/Voe9nsE+A04WTthPMVc0qvws3V+dKfMx9OZvhyYh03VK6RJaaogyHqz3NmIogX3Rzs6ROsahCU3tSrJMWnjM9j89UbhSgL6gBbR0flDzkDh465aEGTlU+e5vrQJocNS/dTZuuZ5jraiwH2qKJV4fH4gU9jBrpoJrodvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=Vh4wzubR/QtoBshTTizJkq+P2DARWdEyUI69hQkMTBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hs2rjcz0A+suksNxOdpdGKuvsrRBY46NBQGeVF4+/3PFRscPkmkGsqKdu0hqAZz0urWPwkfNzjYSIXRI4dIVakRPJuNovx7pGguySsMTSjNz8s9qZj1cbiExWpfIbSotR1JZ5kzdxUQFEULZLNU+EI/rPDch6lCD+7vVJ/QI1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAZWfzDl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAZWfzDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3A8C4CEE3;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=Vh4wzubR/QtoBshTTizJkq+P2DARWdEyUI69hQkMTBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAZWfzDlx9XqGP2MZAs/PVSmmSlCInk7DRFxrzRAshxvFO40l53Ga7rwM9F0+OX6L
	 31mtC2NTwkt1UL1clcU+TnqLLDPMJY/0RceA7wgViPP4nRFikfybxLtzdyhJb909ci
	 bGUg8zy2uc3gl72Ufs4cZVX98rU3jxD+DOxdhj94is0dO7ItwwJ/i9OGDgxHQbEteI
	 jgoc2c+S2eVc5QLKE3ncB7Grc2FMw6BDNpqCNrFMaUdlvM05nsRhk5dI5+kE1AwM3n
	 Xi4WE1TkFBFFsvWb9aujLmeKP1B07E73Y2E263oIHmHUaABiZJHfhq84GMNm8Cf35X
	 AxYLSveNLiAoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 274BECE09EE; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 02/12] rcutorture: Make srcu_lockdep.sh check reader-conflict handling
Date: Mon, 31 Mar 2025 14:03:04 -0700
Message-Id: <20250331210314.590622-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
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

