Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE31BCA05;
	Tue, 18 Feb 2025 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857560; cv=none; b=eD7o54Qrd7rf7DBOgOh3h0AU3kacOSXrsukkP0oaUmBWo3LoCHD9y6/x4Pgj9Pa6wIT21bRLVFKSpHzROG6w3gjd9qB5gDE59ctz0FOVlpEjvjmDyAgSiaZdn99tftbRCTkmdRKvwAWkkthUi22531POVn2//7XhpQa/GSn8IWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857560; c=relaxed/simple;
	bh=znV6q1mDaneWscKdbKWsvN/ldpVZ+IT+N039qxOFjVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YX+uTe8h9kVODJa5ZY0BlxLHDq7JG6NPX2P265TP1KS50fy3is40dIz7NpT7ExlqYqPSb7tiHiDKIxu42nmV1ykasaptHISGlx220o4MO19aUvGFwkuLmNlG4JdlqOPImcZv39iSE49RBamsXNnmKB+6geeVSeWOyeegK1lUpzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXrhr5oy; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXrhr5oy"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so44320776d6.1;
        Mon, 17 Feb 2025 21:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857557; x=1740462357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Vf753JDhe8z6or4Q4Z8/1KFw/b1u1ALZFWVEgBrHYI=;
        b=JXrhr5oyKU0Mhd0TK+DTvOD4fh6ZtxBtty965znP2YR89xfNnUB8Cd/A4iEp1dIRjA
         /qD2PXy23jJcdTfjvGgIUwge3+EPaSDANvBCJYPpnxmJWExSPxKHyD3Jgqkdb6ZBJFbp
         6XQqcv/b+LnmSjnMa6zRWljee8HOJAw0hl0fVl2pvn1RMUUM1KX7MCE17MLtluYjVJsI
         POZJMB3DqLG/X+15mvUqqF6uHXRvf0iehLC4S07eoKMcjZo3Genp24Ot/V5zyvggIpgY
         fsrf4EwAoDPd64J9vTWYN63VuTbtI9iL7JW5+omGNhRSf6XpE6LlUyrn/3uRxLwhzYkz
         yeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857557; x=1740462357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Vf753JDhe8z6or4Q4Z8/1KFw/b1u1ALZFWVEgBrHYI=;
        b=WSx+vg6P9ZEusC9OPjf/nvutsgPIbcIDVY9BouVrskti4dzAbNYIeENqcLvobmgptB
         ZHuhJJTcEsFA+vlZdPSZosrMFTeXUXmWTVD/timeWEAZ4Ix/rqx38NwHoP9QGgFG/J2B
         vwNvcz9HTQzF2ppR/V/9rjJVKLKHRYRv34noRq5RiNUb8unVrE6DANLsCpp5J1kJQZvT
         K6GRRoi7RpTB1kIqnWAMrIGNukInzFqTlhXc7JS1CB/P5UgZqiqnkib4d8knIPnZfGgE
         fgHWka4A4C4aMLeqAuKAO6KV/QiAT6CMO+CzJKlakbUJzG7vKMK5AUgh/FScgGJLt5vl
         mpbA==
X-Forwarded-Encrypted: i=1; AJvYcCUx0tzTQhWETw5fXu9CLJX8uXGWBNKk30nmKdQ7rykr/Ix0V2+gwbt6DY3ud1sb/SDe1F9KT45AN4ui3TJY@vger.kernel.org, AJvYcCVWr9Xzo9kSt5lXBwCVUOj0s6JCnXbS1hEgdu4BuKFd78dWPq19DUC36x/sLRInIKhLTXmaAB08Zww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVgFd9oULb0ssWVoKzqBd9zF5VxYfKOw7h/LaTKjx2hhT8lLx
	lN/hnT7HP402ofhXDQ9uRYnIsvyp3oxXVdM5JYlncTlati1NKRUz
X-Gm-Gg: ASbGncs8kffiYfbx6tOGCEIaY9DTAJP6yxqJSlw3GjcIeL3dkAscCHBam7jYg0lroqw
	uSaEQBZxz+qT27mDFq5oM3ihnbuwEIVVX4MRBwXfhYFDZpdqW+f96U1lkOlhiicPkIho6FFrpRM
	A42XLWs6C96t0yRzRMAWiG4MC+Yv/6s2648ZTp+odMZOxZ1Ulimq9nP1fapslcmM5nkN1OtsopJ
	kSEgg58/pU/3wQxnVlBvBfOaONbAm7BrGOrBqVvjWZctObBEAOX1+NgbFcnp2FmOs5+OxU+UXIu
	cxM7TfoWjsSH9hZhkImlvhYiSJK/b424qHpnrBTrfpiFFZmAriN9vJWWB7lIs3TqR4UdCQiBJC0
	BevIHUg==
X-Google-Smtp-Source: AGHT+IGIisUG3omfsORc+ODA3bDfKzM5YZqfS2TJ+KRKxOHtisbBRQGfzfSfCbUyiKU+SfpmUtXRiA==
X-Received: by 2002:a05:6214:f2d:b0:6e6:668a:a27d with SMTP id 6a1803df08f44-6e66ccc41acmr207712506d6.16.1739857557541;
        Mon, 17 Feb 2025 21:45:57 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c86e878sm621169385a.94.2025.02.17.21.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:45:57 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id AE8951200043;
	Tue, 18 Feb 2025 00:45:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 18 Feb 2025 00:45:56 -0500
X-ME-Sender: <xms:lB60ZxnrsAkjLRagHYKLyiqpNaMwEnqcZz-yyJz20b7207gb-mPh1g>
    <xme:lB60Z82rjsRgUvOIuuSB7OyfgMwLYD26M5gI55WCPBPZy9oIyRFC1RjpCKRkZcgdU
    _qt1XxdkQ9Qs3TmGg>
X-ME-Received: <xmr:lB60Z3qsdf30C7j0C0JTFxB6OcUGuGck50Ez5GxAjuB_iXQENhJvIygU6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedujedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:lB60Zxl4a7Uk29lnXTAjOA0DB3TusJybgH5t-uZaIfSCooL9HC52Yg>
    <xmx:lB60Z_1c-G01QP0UrW0yVIY8KF7z6fQXJNYIYoOQ02Uz64xdS3avVg>
    <xmx:lB60ZwuCbZY9ZxHUIelMLJ8AGYIAT41uFdfkusrrrDbJCBnXdGCmhA>
    <xmx:lB60ZzXSN05Cilabutw1Kvhnj5l7cLZZXU9TEXON7yf1ibO7epxiaA>
    <xmx:lB60Z23rLDzKRVK12LFLMErlDX-xbqVPVACY4syGNqW60DT-laM5QOR7>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 00:45:56 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH rcu 2/7] docs: Improve discussion of this_cpu_ptr(), add raw_cpu_ptr()
Date: Mon, 17 Feb 2025 21:45:42 -0800
Message-Id: <20250218054547.7364-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250218054547.7364-1-boqun.feng@gmail.com>
References: <20250218054547.7364-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Most of the this_cpu_*() operations may be used in preemptible code,
but not this_cpu_ptr(), and for good reasons.  Therefore, better explain
the reasons and call out raw_cpu_ptr() as an alternative in certain very
special cases.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: <linux-doc@vger.kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 Documentation/core-api/this_cpu_ops.rst | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/this_cpu_ops.rst b/Documentation/core-api/this_cpu_ops.rst
index 91acbcf30e9b..533ac5dd5750 100644
--- a/Documentation/core-api/this_cpu_ops.rst
+++ b/Documentation/core-api/this_cpu_ops.rst
@@ -138,12 +138,22 @@ get_cpu/put_cpu sequence requires. No processor number is
 available. Instead, the offset of the local per cpu area is simply
 added to the per cpu offset.
 
-Note that this operation is usually used in a code segment when
-preemption has been disabled. The pointer is then used to
-access local per cpu data in a critical section. When preemption
-is re-enabled this pointer is usually no longer useful since it may
-no longer point to per cpu data of the current processor.
-
+Note that this operation can only be used in code segments where
+smp_processor_id() may be used, for example, where preemption has been
+disabled. The pointer is then used to access local per cpu data in a
+critical section. When preemption is re-enabled this pointer is usually
+no longer useful since it may no longer point to per cpu data of the
+current processor.
+
+The special cases where it makes sense to obtain a per-CPU pointer in
+preemptible code are addressed by raw_cpu_ptr(), but such use cases need
+to handle cases where two different CPUs are accessing the same per cpu
+variable, which might well be that of a third CPU.  These use cases are
+typically performance optimizations.  For example, SRCU implements a pair
+of counters as a pair of per-CPU variables, and rcu_read_lock_nmisafe()
+uses raw_cpu_ptr() to get a pointer to some CPU's counter, and uses
+atomic_inc_long() to handle migration between the raw_cpu_ptr() and
+the atomic_inc_long().
 
 Per cpu variables and offsets
 -----------------------------
-- 
2.39.5 (Apple Git-154)

