Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5FF2BD025;
	Wed,  9 Jul 2025 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057938; cv=none; b=c2b3zAsLUtaRB1qB2ML5UUMkTPDcS8J2xRxq34YHVZrUp/+1x52j/DNO7um7LIpsJOHnrMcMrjShvJeZCFllrwVjOFeMGbeEBkfhOBt6EUBxP/LLBEmZkv4D6lDkGyfLILczWM9Z0/3PNqFZ7IP95xehRmabYD7xzSRmyy0aRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057938; c=relaxed/simple;
	bh=4N2vq0FFgy4+9bHY0U8KNBFE3NfPooD3fHnZ8MZxjG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIV5eVtHQTxgJvSdQAgxdoclpy5UGm4fE2YYGcuMvHORWwQW8/Ym6Lv8qLVjEfz7a+Z+7FfYd+nTyTZ9PZ/Wu/Wbr9/WiZtTZ8I++iPVQ5FfoNyZKA+mFqF2Go5Gq9abkClIpaGBx3ucONiGVJ8sKvGecblCWyWYhflmYG67Tpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAxQHsVZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAxQHsVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB8AC4CEEF;
	Wed,  9 Jul 2025 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057938;
	bh=4N2vq0FFgy4+9bHY0U8KNBFE3NfPooD3fHnZ8MZxjG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAxQHsVZFqoAhfql8itxcPEO7ie5oa6f4KdHObJGXIDbRxOFH50w7KJMcFVBw3BaW
	 YGoIVwqoH5qNcfUxIYPSZV5onYWiMHTFrRExITvllwopY0szwIvD0Hmu1I8ETsNHfU
	 8klD4/5MQIXBCU1CJ7cIIIhivBDxKh2+uRE6l49+LYOMyRFBOGYJKpc8Jw/0Qxbv64
	 us7+vV3WybvoPMMa/HiRknzcrzgFytIaL5pjpEaWijb5olJRmWBeJ8P1Bos/aV2Qtp
	 nt9y+ooMqaTPkN6s7bvCuCn409JUwREt2UUjsFo0Eac0Z4BYRl9dPT+rzDCUBCrlS0
	 OrbOWnk+AM5kg==
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
Subject: [PATCH rcu 12/13] torture: Make torture.sh --allmodconfig testing fail on warnings
Date: Wed,  9 Jul 2025 16:14:13 +0530
Message-Id: <20250709104414.15618-13-neeraj.upadhyay@kernel.org>
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

Currently, the torture.sh --allmodconfig testing looks solely at the
exit code from the kernel build, and thus fails to flag many compiler
warnings.  This commit therefore checks the kernel-build output for
compiler diagnostics.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 39844d213da5..611bc03a8dc7 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -438,6 +438,10 @@ then
 		make -j$MAKE_ALLOTED_CPUS >> "$amcdir/Make.out" 2>&1
 		retcode="$?"
 		echo $retcode > "$amcdir/Make.exitcode"
+		if grep -E -q "Stop|ERROR|Error|error:|warning:" < "$amcdir/Make.out"
+		then
+			retcode=99
+		fi
 		buildphase='"make"'
 	fi
 	if test "$retcode" -eq 0
-- 
2.40.1

