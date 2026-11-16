Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849992;
	b=PczWZeP6rsHKOmjelwdO/1ENxMPoYVoHwp+q7YDn0G/RRbACTPF9TBVkbBIKnk/mK0GT
	 nLFlG2xJwt6wvC6GGFz7a5EkZ04JwnsAbjMOQLA7oXutzgWa3dY5RYFud1As/I6C/zrfF
	 4Td9Np6JU8DYKaU+gocgfFtq25s/uiz+fM+OVL0pwkzOtycAXf5XjQll2rud6P9nW5hKw
	 OAEjbGYZF5DYeqJMlK5YClOW/KUw2qZ186lJhSZwYg+R91+spXoIeFDemaO1Q7FB3u/HT
	 vGaNwA1oMlGwE6fL73hHIZeIJYKcgWgm+Ifdcc/v8SZbzVUJhJwnhKjXXeS8+Mx5Fdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849992;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YUCKTRSSsAgWE/GL3hdaISXeQYPAwBu0PKw5Xlanm3s=;
	b=vj/wJMPK/RILtgbpx96ZTewurquzirSDievoa2Kaz6nPY22YFmIUh4fwTYEZY5x8NIdG
	 9sYvpwcDdxJQZ3FcmW3wfy/mQZZa4gvBwZFfEctFW30YvTH76sZ7PHswnZjti9tz/919+
	 lbwaIXellWpJNLfRvNa8kKijj7i6eTVxHKw3ZqI7d9bal8f6f3FCSYQ4rYN59Nn4SDRP/
	 1HJRFHxjL0NefPT4T6Tiq4JgjpYk1K6+WPmLPS8Y2MWWhD7thVv0tmoHrJM4HLlc+S6Ce
	 MAHQ+QQQszMQ5Y8Cp+7DX2daVIRJ2Yrp86kqETIVMXBIBG0lQg2o4xQ5e3xgQ2cTQtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eizhsx6o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43F606A330;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eizhsx6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F171F000D1;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849992;
	bh=YUCKTRSSsAgWE/GL3hdaISXeQYPAwBu0PKw5Xlanm3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eizhsx6onFmWOJl0ppQ8Rh33pBqdcFi/nwHoQQ0eNEb+iLecCcCO+mcHz/pjG+2+g
	 bPQB4nLP/ZmEApCJoN+dcRI/vH4KLxHtQMyidvI3dy2e1hiuWCCqYRnlXKcUYZ7CYN
	 mJdA4I+K7z4uODoTuPVwJFQ7f6VN0LyzPHiX0UGdTl1YbBiKho3xipuUto24L5VN7y
	 zg7ke3x+ftudABn4UTOjiCPlrH0orgVKF2uAvsNS49UZ/FrkVBkUOVPDWs7tpvBVis
	 On/iUYxM2fLOhaHkHWmrqLG9pFbBUft59KqhmWM+GER2zPiAeaVXDdUl37db9vikl0
	 6zkPz7puDR1sA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4AD6CCE1059; Mon, 16 Nov 2026 09:26:32 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <jfern@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 4/6] rcutorture: Make torture.sh test NMIs for RCU on x86
Date: Mon, 16 Nov 2026 09:26:28 -0800
Message-Id: <20261116172630.3845508-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
References: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds '--qemu-args "-cpu host,pmu=on"' and kernel boot
arguments "rcutorture.nmi_readers=1 rcutorture.nmi_calls=1" for
--do-rcutorture runs of torture.sh.  This ensures regular testing of
atomic RCU readers and call_rcu() updaters from NMI handlers, at least
when running on x86 systems providing PMU support.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0be8bb08c5ca0..bc842c94c4379 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -513,8 +513,15 @@ fi
 # --torture rcu
 if test "$do_rcutorture" = "yes"
 then
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
-	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "$configs_rcutorture" --trust-make
+	qemu_args=
+	if test "$ifnotaarch64" = yes
+	then
+		qemu_args="-cpu host,pmu=on"
+	fi
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.nmi_calls=1 rcutorture.nmi_readers=1"
+	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus \
+		--duration "$duration_rcutorture" --configs "$configs_rcutorture" \
+		${qemu_args:+--qemu-args "$qemu_args"} --trust-make
 fi
 
 # Test atomic SRCU across Tree SRCU (SRCU-N and SRCU-P) and Tiny SRCU
-- 
2.40.1

