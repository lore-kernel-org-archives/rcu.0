Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F92215073;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454996; cv=none; b=GNHT7Q1kEQdmkAe3EVUoRizTr/zpABPIkoe7m6YUFHvTwXEBn/HkAKCoEIaVuR2TiWosTKVhIfI1uCUXobyKw3QrFgcq7nGR8qT3pdaySDjhwpAhJDtfWk8/dAI1QBG8h7z2+CHAJpocuLKJz/pH2ZaBZiIZyZGhuYWcwHPu7RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454996; c=relaxed/simple;
	bh=77AYLHKjJDUAxlPSNSjE5Yx8FldJR4VJKjnY8y5KFC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mgdwFamwBlq9UTmfGmdZ60CM+O1/KunWUsRnCU6FivHgAIi+6dlZcrmKdUIiTfmKELyuCGQzh66Cb+pcxRrPs9KM0UbX87F+5iPZR/XMmV0BmvrEg1on79ZLp7jPcm8Ph4wtRi95B3Bj4rJQiuwmAmpm33LyLxH4QkeUSD25hYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slC7fkxD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slC7fkxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B86C4CEE5;
	Mon, 31 Mar 2025 21:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743454995;
	bh=77AYLHKjJDUAxlPSNSjE5Yx8FldJR4VJKjnY8y5KFC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slC7fkxDPp+7PFcG720jp6SwhBm+3ATcG0jFNAUE+luEy+OwRfgdFNAaH2x4JUc1F
	 sPmu67F93C0sLm1jWHB6SW2f1uiXt1Dx3ElIrY9/XbyUPltel150jXpO3H1kyx/FIc
	 /nqgWjwIJDmOWkd+Evl/lw7X8JiRAatKUS5oXTbFU+0n4HUJiq191M2FColzRHDDBN
	 aIR650fdt5LRdo1BWAMiUmQXsaysoTGFlBHASF+hD1bxtLaiv3m4nU0hd8eBmP1ESg
	 v2XGo/MqR85E6T5AjjWBfa+kFpR9hKKXnXyZFQ3b+D9GPwMZ3GGCj3CN2Q3ar/VQuB
	 wlHl/l9Q4UcaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 230E5CE0869; Mon, 31 Mar 2025 14:03:15 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 01/12] rcutorture: Make srcu_lockdep.sh check kernel Kconfig
Date: Mon, 31 Mar 2025 14:03:03 -0700
Message-Id: <20250331210314.590622-1-paulmck@kernel.org>
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

The srcu_lockdep.sh currently blindly trusts the rcutorture SRCU-P
scenario to build its kernel with lockdep enabled.  Of course, this
dependency might not be obvious to someone rebalancing SRCU scenarios.
This commit therefore adds code to srcu_lockdep.sh that verifies that
the .config file has lockdep enabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/srcu_lockdep.sh  | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
index 2db12c5cad9c6..b94f6d3445c6c 100755
--- a/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
+++ b/tools/testing/selftests/rcutorture/bin/srcu_lockdep.sh
@@ -39,8 +39,9 @@ do
 	shift
 done
 
-err=
 nerrs=0
+
+# Test lockdep's handling of deadlocks.
 for d in 0 1
 do
 	for t in 0 1 2
@@ -52,6 +53,12 @@ do
 			tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 5s --configs "SRCU-P" --kconfig "CONFIG_FORCE_NEED_SRCU_NMI_SAFE=y" --bootargs "rcutorture.test_srcu_lockdep=$val rcutorture.reader_flavor=0x2" --trust-make --datestamp "$ds/$val" > "$T/kvm.sh.out" 2>&1
 			ret=$?
 			mv "$T/kvm.sh.out" "$RCUTORTURE/res/$ds/$val"
+			if ! grep -q '^CONFIG_PROVE_LOCKING=y' .config
+			then
+				echo "rcu_torture_init_srcu_lockdep:Error: CONFIG_PROVE_LOCKING disabled in rcutorture SRCU-P scenario"
+				nerrs=$((nerrs+1))
+				err=1
+			fi
 			if test "$d" -ne 0 && test "$ret" -eq 0
 			then
 				err=1
@@ -71,6 +78,8 @@ do
 		done
 	done
 done
+
+# Set up exit code.
 if test "$nerrs" -ne 0
 then
 	exit 1
-- 
2.40.1

