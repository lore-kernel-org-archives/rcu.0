Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275365;
	b=S40CLJHip91ejE3gXnZ6RPMxhvmB843TL51/tEI9xcSWcnadfhXkDXCPFg/UZyiJ9Dyb
	 RgrwvHYENMr/V+JypP1Vk2H1u683lUYNPImrFo2pIy2fI/5O7+twZ4tvX6rK0G9omaLUm
	 R29fgdTjOuALphzAfz+cCDWW8iC4qQ82Q/AHM9Up4SopyTRWxdhfaUAkCMZUGyBNcvewT
	 CLuTDS6reKBOi0DNclSX0+2e5bblqtvzUPWg4HrCkI8cATYtizRMsfTG9u6CRPsb4CBXP
	 sFGwGZPLk7YrcmDrFVF6MmyDS0IXp9HuKS6UKIRoYvuYb256DcX9aE4UZCKrZrL33ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275365;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Z3okq6kOWMyroI150hcih+Kw/W2zOxVqBWWCYspoAnY=;
	b=44q3lEwcVrSGvd9kwaWeM1IHwrfEKhWLOlEdgNfY+AQqGy/hlwxIWPgA/escFWUZp+Zf
	 6jq+luZ9sReQ3EuouRbWMti7CCFUEkPmU62s2A90Jp8bKouC07zmHb6icvQOBRywBuxxz
	 s0Yy8iTs1VV1/tl9BOxGpnAxvVrQBnNGygMBE78413PR7bMruxYAUi0PabIjk+jYytWBn
	 mM92/ne4GZpPYdcDD752lAt0QzUS44nhd37end+3khohQ14HPU7iabTsMS5H/agUW3elv
	 Y753PHf/A+BRP9iByoVH+nqzeNNBZZWRjHG32eE+vKB0aa34EAQ+miRVWkfkfUAC5tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gF3ai+yY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8FC52606A689;
	Sat, 21 Nov 2026 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gF3ai+yY
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2441F1F000C0;
	Sat, 21 Nov 2026 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795275365;
	bh=Z3okq6kOWMyroI150hcih+Kw/W2zOxVqBWWCYspoAnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gF3ai+yYrG2zSzf82jjWgd5Btqpu87m6Yj5U9TwaTNN0B70n/vuuJ8FB0RIWn0QDM
	 gmQgAv1FXrR7LImpHSoAEZYKGjjS2boQ1PM/+6R55z41ub3DA8o7MWMXqIZirOcMoI
	 VztjRK423IN5iI+Av/hITWAPKaa/+S+cUWJbSFmBK1dVU+ThgshwLvYu0zSsc/nXaH
	 QRFCcyu7lXNgj8cNooNiEdNA531mRu9nMe5Vfo9+3tjBr4Url5JPx3IPZqmPM7Ercc
	 p2OWrsNrTxtHq4mpZzWLgGqIMu66Z+KCJeSAW5RyPquRguxxo6WYc+chkAbsLzd8In
	 JtJDy3wGQMbOg==
From: Joel Fernandes <jfern@kernel.org>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 6/6] rcutorture: Make BUSTED-BOOST disable RCU priority boosting
Date: Sat, 21 Nov 2026 10:35:52 -0500
Message-ID: <20261121153552.68941-7-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121153552.68941-1-jfern@kernel.org>
References: <20261121153552.68941-1-jfern@kernel.org>
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

BUSTED-BOOST is supposed to fail because priority boosting is broken,
but boosting is now always built in for preemptible RCU, so the
scenario passed.  Boot it with rcutorture.boost_disable=1 so that it again
exercises rcutorture's ability to detect missing priority boosting.

Testing: kvm.sh --configs BUSTED-BOOST --duration 10 now ends FAILURE,
with 82 of 84 boost intervals reporting:

	rcu_torture_boost boosting failed
	Boost inversion: reader got only 203 of 2000 ms CPU in 4003 jiffies

Without the parameter the same scenario passed with no boost failures.

[ jfern: Follow the rename to rcutorture.boost_disable ]

Signed-off-by: Joel Fernandes <jfern@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
index 84f6bb98ce99..8e5b6ab533dc 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
@@ -6,3 +6,4 @@ rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
 rcutree.use_softirq=0
+rcutorture.boost_disable=1
-- 
2.54.0

