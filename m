Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858287;
	b=sXBUR6tsGaXCFEgMxCB44YgUQZBDPdZ3sk448fA5DxLR/ZXNo98EVXPoKkR3VDlEjs1v
	 caRAtM4ejiAGbIWZ6RoIDwEqy9C0xqdhsuGK61NFUchmTm+gRTXRkHFAk4MoDNmJyNBZn
	 PB3rDVpNCoSayrqPAhE3imk8DGuOId6j3HmUdDJzsNJR6mLwgx9ZyMA+l9wFMqMRJr4j5
	 I5baqvirmP511UZ2UFx4P4msW0J8P4NIiFDEvLQ1IXRlyJ7If6AfV6IVz53Wh5nSELohM
	 WgaFnmLuGZ5U0ySb249xvJSByiKUw57TCtr1gvCxf1Z9rupZ7WfHtwvOKr+i9nYnxYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f/CulRCPCF/SsAlkZQZioPPPJA3G2WkQsAlE6EDVsds=;
	b=gqMNGL40HjVeCJefj8T0BfGpZdfUuBI7yplDkJjvSIWPR6WlA896G4/PwCV30394AI/Z
	 o53aopwnmBpAtPRbcvuY71wKLTPqScJF3+2a5Z8TOUgcigPCUBP2FD9SIicm2kcBaEwc4
	 Se2MCxbjb6Rk1/IuWhFWaEmDnIl0slshtPVu7PoWuuhxKO1JwZA8h16rNPBj+pqspR7p3
	 9zr19s8paRnbAxd2qh2Nsybe0OURC+fJ6XrzZIRatxZ3aafblyUVO+9dRciDHSYCTnGv2
	 TwJZWGc3ea8KrE68brZB0Z6A1vvRvip/qw5HVZzY4hs35vpzxtIyJU+5Gi6CNWKcZFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDtI7hP3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8FBF7606A33A;
	Mon, 16 Nov 2026 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SDtI7hP3
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E43571F00926;
	Mon, 16 Nov 2026 19:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858287;
	bh=f/CulRCPCF/SsAlkZQZioPPPJA3G2WkQsAlE6EDVsds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SDtI7hP35g8gnGwh6KBQZ27a6TaPeREvjM9chq9AeWoIKOswGcBxxivTW1BljvZ0w
	 f6vxfCqisAQRdrAWtFwyIIVxsWyTkuau1us1D25jBj6/WGaV+Pv3kn0wg/22RKUZrG
	 beMptYy9SilEvV3NDxZUXSEVYYsbUUjDxFUkLzFpeWFQI53ChaD/lDl18wCVMGELGB
	 f9NFnPULR+ixgrx5eFwGfjed2vc2P0tfKAaXhMdNxJip9n9dpg/iLt2trlYYxhcwt4
	 wg8F4JI2WgMuLyphb6gueChqwGDFeQA6IuTeVpiXR5Gk4MI0mIWS57ponCmOXrOLFg
	 TlX8bWKoqZXXw==
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
Subject: [PATCH v2 4/7] doc: Document rcutorture.test_boost_reader_ms
Date: Mon, 16 Nov 2026 14:44:35 -0500
Message-ID: <20261116194438.306618-5-jfern@kernel.org>
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

Add the new priority-boost reader CPU-time parameter to
kernel-parameters.txt.

Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 176648941aec..ac97cbd98b46 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6283,6 +6283,13 @@ Kernel parameters
 	rcutorture.test_boost_interval= [KNL]
 			Interval (s) between each boost test.
 
+	rcutorture.test_boost_reader_ms= [KNL]
+			CPU time (ms) that each boost-test reader must
+			consume within the test_boost_duration interval.
+			The reader runs in an RCU read-side critical section
+			while a real-time CPU hog tries to starve it, so it
+			can finish in time only if it is priority boosted.
+
 	rcutorture.test_no_idle_hz= [KNL]
 			Test RCU's dyntick-idle handling.  See also the
 			rcutorture.shuffle_interval parameter.
-- 
2.54.0

