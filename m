Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858292;
	b=vT4c+cAoh3dHe8nT28O/5at2qr7vExfYpzL8aLdnn5s7nSURTv6klWa8qLLmdp3dEJBV
	 ROUOMozY8nn3GAkveY5kBra4OyYNH5yBTHA1e2mFi0vnS/MmqqAdfAU0CgAa/JLA6StuV
	 oUHy/DTPeG4Z5pAQtreBjo37zpP7NGu2BbKInxQFqbSU27xJpVkez17IH4pNDI5PznJLJ
	 phzdHiY2R/sw80bpTWVKeqIeqMLmOIYG4DEYiWsaySS9j3LciLOaxuKcJZ5u9SlkI8aBZ
	 2ozTFdIcB8ZQ79Dxek8YXW30i3wVDNe3HlSPwb/WYRc7SpV4UIfh6pnK1eyNsyxOyLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858292;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A4Fd1+OlYOIGOj1EDmwH1YVB8RAzz3C7cwSG1xL1pDk=;
	b=m/S04OLOrz+pOkimE9mF0h7rND6Pp3Dft3NLKRJbtnM3dOavbErJVQyPNvoIQjLSHj28
	 BZv8EZBJtqNgxTdrFwjTECpZ9m7owPGA03cTRCcdX1MK7ecyMX2xT5UQj+SHkpETJV12Z
	 kWDxNGObNWwrIxGpwnDW1d4f2DNA6Ef/sXO1OoC62kpa6SQFcQb1mnU0v+aki3DSvp1DQ
	 JvtOVbjz+Nu87Ae+AFEWz4ick6Cz+7AEtuFYzP1vsBqV8pKUP9bp+qLwjtoHOOZWu4jJt
	 /u+0LFn+16bcSTfzXC75oIYq8bYyuXnjjMFG/Emic7N/8rI/l2djIQqNLX3SzzPPZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z2/oQvFC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 66CAC606A336;
	Mon, 16 Nov 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2/oQvFC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AC11C1F000C5;
	Mon, 16 Nov 2026 19:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858292;
	bh=A4Fd1+OlYOIGOj1EDmwH1YVB8RAzz3C7cwSG1xL1pDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z2/oQvFCiTxNYuqTnvhX0Pi8wPgviI5VQ4IMB0yZV7Asx2dElg8HOGc3ZBVoo6GKG
	 w8+5KcRTXj+HkRgMccn3+U/B0HIrtOLvG2af9Xq79IstwBXp+J4cGUAWNKo8wVkxzt
	 uQf84opAh3efNM9bypvRzIWnTslO3QuKpCCGjdTsBnF1izONcBRXcT46e8I8XNWgQI
	 4Q8p2e9Oe1NR/MqXhRRY6wDfntsxxIP/e0X4IKHrcdBvPdmrXfAaPCBV/hp0SkAPee
	 yfhWkEHQg1RnbGmPp69CXkYlZZz5NEIa2/+23M3O4TK4PzCfuqb1C6/cAaa7RPFsst
	 3VWdbBYIRguNw==
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
Subject: [PATCH v2 7/7] rcutorture: Make BUSTED-BOOST disable RCU priority boosting
Date: Mon, 16 Nov 2026 14:44:38 -0500
Message-ID: <20261116194438.306618-8-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116194438.306618-1-jfern@kernel.org>
References: <20261116194438.306618-1-jfern@kernel.org>
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
scenario passed.  Boot it with rcutree.boost_disable=1 so that it again
exercises rcutorture's ability to detect missing priority boosting.

Testing: kvm.sh --configs BUSTED-BOOST --duration 10 now ends FAILURE,
with 81 of 84 boost intervals reporting:

	rcu_torture_boost boosting failed
	Boost inversion: reader got only 203 of 2000 ms CPU in 4003 jiffies

Without the parameter the same scenario passed with no boost failures.

Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
index 84f6bb98ce99..5aa92357958a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
@@ -6,3 +6,4 @@ rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
 rcutree.use_softirq=0
+rcutree.boost_disable=1
-- 
2.54.0

