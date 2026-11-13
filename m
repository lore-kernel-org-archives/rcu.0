Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531069;
	b=OqqbtsCuimjcdk7htnZpeBHrXgbsmFHu37c3GpqetTgQKO7arBcPr1V4ayxJ5BD1jsPv
	 LdfHbP2km+3AEgzyPBEDWFsU+fURQJrxIt4TWazOzuMrXObtiavFdnN/The3JblZ0U7tr
	 bXrpgg07qUTjO/0wCe4CBDP3i6PcKgvYfzhSZtGe76L7axjLwJviDnQB1DfHli7qLnAle
	 afq8ZhJx4PRpf7B09EAeyJcmiDW0STRlrO/5B/gfIScKOI4si3s3PGcCMK7SzO+MHfgO9
	 3tzGzA5uj6kAHR12r+RpR/ligt3iwuPozDXPQCKk02L0SMM3wf61CbIKPhVFUExC2FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6zon4C8xuEHM1l07Uv6dG5ZxmH32dZUu1C3ZfqHVXzE=;
	b=veWG6RcHVNbssq6qmNIq74Yv5p0TaWawVgCTgpX5wPrChMY0gl8Su8scMoMTE4zTuAg7
	 /6MqZhR0AsPnpfxBaGpqyxBJT+bDTyfxrWx+3GTLTxcW4hNsyDApglkCAdtuYyXWTfj7m
	 n9/j1W/K0COzsQjKVdTZIc09DYWQOS4d2u1sJDDCxjkKD7fTK6IdqqcyaUA1LMLOxzfio
	 +jwXZkhJSA8qZMDlD9CIXn+IdbgBMnvu3s5BRzHwCFbRl5146jYyr3yQB6q+jL/tV0U9T
	 Bz964rETPwdCxH83x9dMtZ9GAY3uWoCrXlTVsHjdSuzCiBEiyv942NQRG3XW8vTfD7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idOwze6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 62B6660A6F6D;
	Fri, 13 Nov 2026 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idOwze6X
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A9DD01F000C4;
	Fri, 13 Nov 2026 00:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531069;
	bh=6zon4C8xuEHM1l07Uv6dG5ZxmH32dZUu1C3ZfqHVXzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idOwze6Xm7o+sTQS3OcP45QSIDmaGH50ECOtaCGb1YtOPEdyTTPl0TAicxGb32Fcj
	 5gY313c6kagEUP5D1kXALezCC+Dp7RO81OzNrEUot73GEjPg5ExPyHn3VEdwKdSTQL
	 S+hZj2v20EdUoKE5JDEhEopq/mbtB2PZCWuWSmTYz7pQ2AZl9Id2I3wjRTSyiQ/7pF
	 GXCq0cA/hD85yHTUa97/pdIeQsA4VSiNPrTPEU6INsU/r5Vkfnk66CTQ49sHMrK036
	 CxbhB6/xK/+gjvxLLapB0E3UudtblN0Tmhsyc1Y0LFZXG6H83RoUaxf75mQDuPtYIL
	 isnJuJKpI27Ow==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH for-v7.5 3/5] doc: Document atomic SRCU in Design/Requirements/Requirements.rst
Date: Thu, 12 Nov 2026 19:50:52 -0500
Message-ID: <20261113005056.2793983-4-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005056.2793983-1-jfern@kernel.org>
References: <20261113005056.2793983-1-jfern@kernel.org>
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

Atomic SRCU (srcu_read_lock_atomic(), srcu_read_unlock_atomic(),
synchronize_srcu_atomic(), init_srcu_struct_atomic(), and friends)
added readers that do not sleep or block, plus an update side that spins
rather than sleeping.

These are missing from Requirements.rst. Add them.

Signed-off-by: Joel Fernandes <jfern@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8101fe6229d5..d43668595872 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2686,11 +2686,13 @@ The `SRCU API
 <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
 includes srcu_read_lock(), srcu_read_unlock(),
 srcu_dereference(), srcu_dereference_check(), synchronize_srcu(),
-synchronize_srcu_expedited(), call_srcu(), srcu_barrier(),
-and srcu_read_lock_held(). It also includes DEFINE_SRCU(),
-DEFINE_STATIC_SRCU(), DEFINE_SRCU_FAST(), DEFINE_STATIC_SRCU_FAST(),
-init_srcu_struct(), and init_srcu_struct_fast() APIs for defining and
-initializing ``srcu_struct`` structures.
+synchronize_srcu_expedited(), synchronize_srcu_atomic(), call_srcu(),
+srcu_barrier(), and srcu_read_lock_held(). It also includes
+DEFINE_SRCU(), DEFINE_STATIC_SRCU(), DEFINE_SRCU_FAST(),
+DEFINE_STATIC_SRCU_FAST(), DEFINE_SRCU_ATOMIC(),
+DEFINE_STATIC_SRCU_ATOMIC(), init_srcu_struct(),
+init_srcu_struct_fast(), and init_srcu_struct_atomic() APIs for
+defining and initializing ``srcu_struct`` structures.
 
 More recently, the SRCU API has added polling interfaces:
 
@@ -2710,6 +2712,22 @@ certain types of buffer-cache algorithms having multi-stage age-out
 mechanisms.  The idea is that by the time the block has aged completely
 from the cache, an SRCU grace period will be very likely to have elapsed.
 
+A more recent addition to the SRCU API is the atomic flavor:
+srcu_read_lock_atomic(), srcu_read_unlock_atomic(), and
+synchronize_srcu_atomic(). An atomic-SRCU reader runs with preemption
+disabled, must invoke srcu_read_lock_atomic() and
+srcu_read_unlock_atomic() on the same CPU from the same context, and
+must never sleep nor block on anything that might itself depend on
+memory allocation, which allows synchronize_srcu_atomic() to spin
+rather than sleep while waiting for pre-existing readers. This
+requires that all other SRCU usage be excluded from a given atomic
+``srcu_struct`` structure: every reader must use
+srcu_read_lock_atomic() and srcu_read_unlock_atomic() rather than
+srcu_read_lock() or any other SRCU reader flavor, and the structure
+must not be passed to call_srcu(), synchronize_srcu(),
+synchronize_srcu_expedited(), start_poll_synchronize_srcu(),
+srcu_barrier(), or srcu_expedite_current().
+
 Tasks RCU
 ~~~~~~~~~
 
-- 
2.54.0

