Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E02442E8;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737059076; cv=none; b=XwT67D/aCZjcf0h9BJPdGead35+33GZV7Lzjcz5z4c3aq3MVdB4kXrh8YL2Qbs7e/6dclJCzIoXKayGKWyF/FpPzPUpzWL4kVdq0Y2Zw6IZJHOEG2jANEsbZAiMrXxsoWoQhg1Pk1b/QQsKjXnd9A21z5/SuydqbBaXMCrB2z30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737059076; c=relaxed/simple;
	bh=+whrCwaWWhgiIOPTij1X6AFm0+bMFyBVvN6NvAiWHDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htiBIUrUW1ucI4z81PWUZPUoILuKFJoJjL3k0cc/ynmxBqaSOuUEr6IybQWv6I1LNhKeMIIDjHWZ9pg4MK4xwk9PZnCuz6Qmy1s1lrApPp1WfrMHUC4u9F5TbHVs7vn11ZP2GJWuwXq8a8mMzA0MEuNV6HGk+36/GXSzDLfCQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3kXoJfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3kXoJfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFF1C4CEEE;
	Thu, 16 Jan 2025 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737059076;
	bh=+whrCwaWWhgiIOPTij1X6AFm0+bMFyBVvN6NvAiWHDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3kXoJfKH+8AGFAK9XzmXBVX4dUEtVNlRZWca29hP3FqEwjWrGnQHZTQrzeF6o2n4
	 Y9PEJdjKB3Ze0IHkM/eRZc8s5hu/d6/IRDCzIsakC2Nu5G+KNIjKnyXcEqmRrdnP/T
	 F1q0QjgtTe9FdporlDwZmFrdcFeCABKyWuHxdDzKO+MZ+JV0LrCifOrNf209yrIive
	 wqU1VRTii2OQf6ZWFlgiRSj4WKNCBf0HOY/iBuET2i6hB09JXZGmM75X5hu0BVqyMD
	 Q68HHctdCQ7MHcfMQxiLtMlK9uDB5SBzR9/249qoamX41TeXGtoP4QjEy/0XoYsKFq
	 ChjJyNPbLgPFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B7679CE37D8; Thu, 16 Jan 2025 12:24:35 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/11] torture: Make SRCU lockdep testing use srcu_read_lock_nmisafe()
Date: Thu, 16 Jan 2025 12:24:34 -0800
Message-Id: <20250116202434.3783613-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
References: <c4864e07-93b8-4bc9-80fd-62b00a64e329@paulmck-laptop>
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
index 2e63ef009d593..2db12c5cad9c6 100755
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

