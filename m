Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262782;
	b=pJPUwd7NIc02WP1adbydDKCkEnswjYVWmJz+ZJ7tyAhN3qCXGsq78LA+ptO7b2kTU2+l
	 YcWIWv7NRsna2KsWysfHAg7r7Lop5NYHgtrSX623X5lHDe/693o8SsTfkvNu/4iAT/vk7
	 w/h8ejo+6SxP0CmC2djM/lgON89dh0hOrrfI+hcSI55wdbPnYvFi5FN+mL5OO2hsQVrLA
	 8yU9p6Pe0koFmzHWom72OU/D0R2IsMpS9tSv+Qm85B13Pwo75gH8jUphG4PVsoNCd4OJC
	 UKlwq8tmMZJmxz8mzf3RCO09BdP46ZtPAdtZRIXOTQs1Zr0e8Ryh0foAlUGU0AfKxBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262782;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QS5I/bEC4hI41fEu7EUfrCSCl2fxBCHghNauEy5q40U=;
	b=3LjM/LFy5OXJrVBuxBTCEr4nJFUeWoN0vlH4N3Yy0Iy9Qqnr89MzsBBTycg3DGUZvcNx
	 DpHzKu5PkZ4gSMIbr+9YFQyQcYQktIjPd6dazx2mfKXIDw6lWN9h/PQrwqpQk7swcSo+u
	 onSK20knLHoW7HE6Mww2qiL3NILJx1FgnJQDIgNc56SVR4WjlERt1LXGndrgxoqKsK6Nx
	 dEn8t8MZI/TseITv+sF6P9k6OYXmUZecCia1JV2V8hVBszYPXkEIQ1Q70d0dcFE6rADvx
	 AO83+s2cPeWO0ykJS7vAXv93MdAjkuTU6ugRHzsDNMENS0Gnow6Y2nV4bAgvRtT5zXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF0ebzNy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E01606A32A;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aF0ebzNy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021CB1F008A6;
	Mon,  9 Nov 2026 22:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262781;
	bh=QS5I/bEC4hI41fEu7EUfrCSCl2fxBCHghNauEy5q40U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aF0ebzNy8jXqMKT5XDgQlR+fKrQGBzkZHlIUb/rXLrEztm81fYlD1+IVhPcCPzkQC
	 7ys+RnawzWfpZedwdAnxHQTzGbNEfplnd1iVAJypCN9gWakisjwEPRM8cfmlZfWdCB
	 ix+KnfFnQGYJFrYqQTU7srFbA8YyedqZruesXDOVrS1EjsZpSpiJ6B0c67ekJBNyy8
	 mmIRV5DhzoTGo/KWSmeDISm+TlgpwSSXE84w1OcR2p/pXXNrrMfifPIqwSrd5wlOcI
	 ckuDOEsLOWEgbYRWfHSbUpXbusmGxwfXsq+89V71MXIADKKQWCOvjiIoU29I1dk+lM
	 QXjZqSr6oAzkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AE653CE0DDC; Mon,  9 Nov 2026 14:19:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/8] rcutorture: Disable RCU priority boost testing on non-TREE03 scenarios
Date: Mon,  9 Nov 2026 14:19:33 -0800
Message-Id: <20261109221939.2070171-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
References: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
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

The TREE03 scenario has been configured to permit testing of RCU
priority boosting, including setting RCU kthead priorities to 2.
But now that RCU priority boosting is default for preemptible kernels,
it is now automatically tested for TREE01, TREE02, TREE08, and TREE09,
none of which have RCU kthread priorities set up for such testing.
One approach would be to set up these scenarios' kthread priorities,
but this would fail to test common-case kernels having default priorities.

This commit therefore disables the testing of RCU priority boosting
except on scenario TREE03, which is set up properly for this purpose,
though rather unrealistically.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot | 1 +
 4 files changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
index 1cc5b47dde282..73d51d869fd5e 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01.boot
@@ -6,3 +6,4 @@ rcu_nocbs=0-1,3-7
 rcutorture.nocbs_nthreads=8
 rcutorture.nocbs_toggle=1000
 rcutorture.fwd_progress=0
+rcutorture.test_boost=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
index dd914fa8f690b..f2ca5d812f3f5 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
@@ -1 +1,2 @@
 rcutorture.fwd_progress=2
+rcutorture.test_boost=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
index 94d38445d3937..41c3264f8e8cc 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
@@ -1,3 +1,4 @@
 rcupdate.rcu_self_test=1
 rcutree.rcu_fanout_exact=1
 rcu_nocbs=all
+rcutorture.test_boost=0
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot
new file mode 100644
index 0000000000000..1f52e460e14a3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE09.boot
@@ -0,0 +1 @@
+rcutorture.test_boost=0
-- 
2.40.1

