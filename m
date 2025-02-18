Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8D1C07DA;
	Tue, 18 Feb 2025 05:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857561; cv=none; b=PdklZIDj9EQ7LxgdOPkLYEMruZKlPjpwI00F2Dvb8wwG6WLB38Qn0vmMMs0F+C1Fs4elZl/O0oSwPsYvz+GEFGecx7aPvkNM6roCHVQIQCzXrrmIt0T8Jn7kzt2alh6fq/B6DY7Ih9f1DoFlivS1jbKzOldu6E+1FGl3vNC9oFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857561; c=relaxed/simple;
	bh=Hhk6qN5cX2HiG95oLWWknwJOUcfQbEf5crAZtdyGlfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfdZu6xmOD7IwkC7b4+1ynk46NBlU5oniVAnTIFuWOnEMUXAqWBEZlBPDN4IGRnXkbLac/8CEmairQFrtlisQ4FWdvAY0iAaEXeyHdLY2iv7degTWvLb2PwQAOZNYmo/WSm+s/IbL5njHmpfVkdZ9ue2zdwF1xeZz7lOCiq3VyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9C531At; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9C531At"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0b0ca6742so7544785a.0;
        Mon, 17 Feb 2025 21:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857559; x=1740462359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AFj8E0Qi9rwHd4n/4onPY5cFP0jmlV+xnlSEn6nuc3c=;
        b=X9C531Aty4409JbrbfOE24ou4LRrtOUW64nnErzL1h2IuBtAzKiJdOGhjMTvkG65zE
         J0GjHP737fCNNxIeOVT0KB8pFGJswnu8/jj2T0S05ce3H96qvP/EdxE8DUQRRJc5tmhT
         d7Qu+SMCYoJAkC0AS0evwKOjXysfTzqPSOvqlENDtIZXGqYuxJ57u5hzpm6UR2BMN3I2
         yTytkVqtt0pNKLAbgUGrSR7Am2ewMrmLiNEFTlm7wKeLwve+lw21sETX3sf8CLz49PCH
         RP1BqnFMVeK6i7EwYihfJL8R5D5OXJSNevvr1niO9LymowVWq6moF+ILm1qPfmq5+s8z
         g04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857559; x=1740462359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFj8E0Qi9rwHd4n/4onPY5cFP0jmlV+xnlSEn6nuc3c=;
        b=q3Ds5cbRC0igVo+oQq+giL8QHNkNkEJxmqkuZHo/X7Io4jSonmJQQRQWaCiktQ5Yj8
         ljZ5XCTSomyVlkwYXOu+Jd4yczlb1RAqAgdQ+mxNn4trnP4McI8jckKeC8jEAwX/HRBF
         doFSF9YFsWGQt4dgixJ4KKPOZlDDOtbQsTld/vPtyJK8rJSmNH31ZwD4dr84Oe36O0PF
         J7SWl9whG9n/NNeU4IYulCZ9mk4fGcCed8Q0WEDbFhk7Ms1rBXKG00d0d2okIsOWc79C
         l75n2/YcpSQOEJCodbuqctsSSDFF8QtRuwgkCAJfJCyv+LuZDoX1YE5Q9g+ztE+1+kbk
         +siQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0WAnlupaKWVJ+i8lXose+szClGCYv1H3/qhC0X16zifx9vAS8gUTRV9BI7KToYs1zZ5ChzsoLIx0PtN/C@vger.kernel.org, AJvYcCVvip2vwfoWpRg6N/1bQcGjVxcim9QWxRYKhwEnfn2sukAomoVf6LZdzSlbdELptcBKlu5476cRLyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUFoahIK65uAkQwYJInPBz3VRYWNBsotXUpTtGUHuSkP8mbNn1
	/kuATwt4f21+cc9kHQ8vj4pVASIibBZgQDMVPqcXmG2GmYvFhbcg
X-Gm-Gg: ASbGncsjuf9uf3li7e+EoGtiazeixlZGqdPsUbNfA7w7Fg0bMWrq5mbn8mmLCF048Vp
	eUhtOz0MOUm0iSyfIRupGJ1NvwJzS0QKXmrShQQMeEw+6SbPhQXcp6A+HqYZw0TO4R+WwK8oT9N
	55QoyRcUrVaJ66+7nQF8lAPm5vP0h2IvDs83bp9IV7/5sjrQ7bJ5UYwTjPBSRGTozz32Gp5yw/M
	iiCVobN+XEVkmHeJ/OjzJd9bllAyXKeLiUMZLJAB/IWcP3SP04ZIflOr9rPC1efIb7A0n5b3Mg5
	Buq0B8w2BKG8wHbEz+dlBFfbhHOcFZm6uIwPgK77urnK9TMqyZZIpFoWRKhxWrlphhSejH4s3CZ
	fH6pJ9A==
X-Google-Smtp-Source: AGHT+IHWxpzdBnwxq8h0kCtn53UgHTkb1eFWOIWxmYVOxrW4NcSKcMcZOEzhnOTf1P+9dm5uB1CHSA==
X-Received: by 2002:a05:620a:2953:b0:7c0:9df3:a0cb with SMTP id af79cd13be357-7c09df3aa26mr971954785a.53.1739857559006;
        Mon, 17 Feb 2025 21:45:59 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c886939sm620307885a.114.2025.02.17.21.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:45:58 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2FF6E1200043;
	Tue, 18 Feb 2025 00:45:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 18 Feb 2025 00:45:58 -0500
X-ME-Sender: <xms:lh60Z07Fnpz1CcsQnRk6oXJSIe9c_-IkozhxudnDRPTU9wjSchFmWA>
    <xme:lh60Z14yvCTmkcVM7CzUvA8NZ7P_V9b_HYw2kk9YZ2zxjDsaxkcS0nDqsqq-k4XgF
    Q1tiKrObDucgR7Xqw>
X-ME-Received: <xmr:lh60Zzc-aqPSpAelp72MvwqCr805J1eGZeZKiHptfjn46hQwyy5lc6pC1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:lh60Z5JTuVk6sQL_kT1Bsou6Cv2j55x3KLpEy_wtO0c7MkU8tn9b9Q>
    <xmx:lh60Z4KF2Zfd9rCnFJ1zC9POCCJCBdODOXSaCh6SMQa3Q1j5fPS9vw>
    <xmx:lh60Z6xAT2bk3jYpfkw-KEn3kSRRqyoB-C-49fsLH8JJTl7kfjQcqQ>
    <xmx:lh60Z8KiBv0hQ63m3BElJA_f1-MaFlu2jUAqtw3ARrMQ8Czh0lZIyQ>
    <xmx:lh60Z3ZllgF14aGeFB-8e7XXGb8xnh0OINnT_FZ9eD3VoGDFl5Z-Nb1R>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 00:45:57 -0500 (EST)
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
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH rcu 3/7] rcu: Document self-propagating callbacks
Date: Mon, 17 Feb 2025 21:45:43 -0800
Message-Id: <20250218054547.7364-4-boqun.feng@gmail.com>
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

This commit documents the fact that a given RCU callback function can
repost itself.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 475f31deed14..2cd193ed854c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3107,7 +3107,7 @@ module_param(enable_rcu_lazy, bool, 0444);
  * critical sections have completed.
  *
  * Use this API instead of call_rcu() if you don't want the callback to be
- * invoked after very long periods of time, which can happen on systems without
+ * delayed for very long periods of time, which can happen on systems without
  * memory pressure and on systems which are lightly loaded or mostly idle.
  * This function will cause callbacks to be invoked sooner than later at the
  * expense of extra power. Other than that, this function is identical to, and
@@ -3138,6 +3138,12 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  * might well execute concurrently with RCU read-side critical sections
  * that started after call_rcu() was invoked.
  *
+ * It is perfectly legal to repost an RCU callback, potentially with
+ * a different callback function, from within its callback function.
+ * The specified function will be invoked after another full grace period
+ * has elapsed.  This use case is similar in form to the common practice
+ * of reposting a timer from within its own handler.
+ *
  * RCU read-side critical sections are delimited by rcu_read_lock()
  * and rcu_read_unlock(), and may be nested.  In addition, but only in
  * v5.0 and later, regions of code across which interrupts, preemption,
-- 
2.39.5 (Apple Git-154)

