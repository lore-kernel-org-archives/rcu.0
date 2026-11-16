Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849992;
	b=m5JnkaE86f/z3lrzyR0hnb8EYu0LxPh7Uje1m4XICBMk6gxsA1jjkT1AQauZIMHYhtZh
	 ueBtb+42+4Uducj/94ECzbHoxv+ScldJPekI4vhNELtFzWRofdg6ES6FNEl6r2BuIA0G7
	 npEGZODWlMdeKCtwtpeDEdZvcpGsQDOC59L0Q4fcnrHbrSylhSEV8sCZF9QD0bv4F4qTP
	 MJVx6yiE+0Hhlx2r+d1YfdQ4+W67riOdyNnFz3X0SIbgep2ebuTk1KpY9OEq8+S//+9Zi
	 G10KBhU/lMlBEZADuKyxihlpkyWbSyVXJ7v2PbOCiL/yaFsidaT/FPsdmshNg5ZQhXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849992;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nhLOHK/dpua/6acFbU7FUzubhaP/+1tuaiXs558a9CI=;
	b=mTi380fTWvCqUuL22fsOLbV9QH5aIoL8/R9zLpPM/3hNkCAF00KPqERAh1x5rLVccI/S
	 X/3jrne67Vs4SFlmS6ze3dAFzbWAMnXMQqX3Dc2CBfaHGLixod3dEZUbt0tedAjfRtLdn
	 5N7HHu4ZlfN9FmMokUP5Wq21MZlgGJgjv5bR+q0illTQWMQPcWxn7XgpIYzqkTJ6i7IXW
	 7SEMKXd6LvlILolFxsUCvt0A+QtEN+1mNoAEuXXK/0YlWLwfI538UQaaJ86YbMki7rAwr
	 4U/fPsHyYdCZ0mtBtoYNq29eGmOIROio1TiqcMvyZl0I6wOA/x90eaT3r202H83nodg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5s9IZ17;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52B606A332;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5s9IZ17
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A589A1F000CF;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849992;
	bh=nhLOHK/dpua/6acFbU7FUzubhaP/+1tuaiXs558a9CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f5s9IZ17z3owS2Do7e6A7hv06g0k1ATf0YSMLLjfEsEorxMTD16mpkl5wVZ6TZAbb
	 svDYb0P8RTEeD/151AwnG52/zbSLZhRh+vLKFP96FzBtX6mV0MQYeBljx0VDYxjhk2
	 PfEie6lZ2z0SjCgcfd+4Yo7UnkWziUI8ZJhVTn+nLathfA+63iVPOiEIBct+pYaQ1J
	 fT40E6Jmozl/yt1cPUpNQcyEfAMLc7EINt/RI+3787XqItnx6X0/v46YyIYOz/XLC4
	 kpXLiGjYx0RqLHrIIA075pAYg5myLB5Yj4v3NxMaqN1rqeEEk1pbPK1hkA/3xxIMUA
	 kB1b9HFoSf63g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4D5E9CE10EC; Mon, 16 Nov 2026 09:26:32 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <jfern@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/6] torture: Make kvm.sh ignore empty-string arguments
Date: Mon, 16 Nov 2026 09:26:29 -0800
Message-Id: <20261116172630.3845508-5-paulmck@kernel.org>
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

This commit makes kvm.sh ignore empty-string arguments in order to
simplify some scripting use cases of kvm.sh.  In many cases, as pointed
out by Mathieu Desnoyers, the calling script would do better to use the
bash ${:+} substitution pattern.  For an example already in torture.sh,
${qemu_args:+--qemu-args "$qemu_args"} expands to nothingness if qemu_args
is empty, but otherwise expands to a "--qemu-args " prepended to it value.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 32c3199976388..86dd5c131d226 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -271,6 +271,9 @@ do
 	--trust-make)
 		TORTURE_TRUST_MAKE="y"
 		;;
+	"")
+		# torture.sh can pass empty arguments.  Ignore them.
+		;;
 	*)
 		echo Unknown argument $1
 		usage
-- 
2.40.1

