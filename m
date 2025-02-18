Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802A1C6FF8;
	Tue, 18 Feb 2025 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857563; cv=none; b=NwdWO331r0SbICQEmuO59e33fCiKK8JwFpGc89yWv8JgqmKkjnWHxyH+HW9coioDoi3dSMB5OF5siiGnUR+mtWYPN6+ofSEFsZDcJTSMPNcFFBgGTBEuWMGnlvKtFmxTCUsKqMbi4Mtol9YY4aTTmiL0GXuUwQGL22rknvsPwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857563; c=relaxed/simple;
	bh=3vFd1mN8dxuIO0lNwxRqYwG2R9ldYvt17FcLNexC85w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u1SKtIW656mY7iUU63FiQ4+hj3cGVWlbzRlX8sy0rYGqHTlUZMylOCm7uxBPwxrAWXYfMfAmWT4TmWY/AQJ82Boci3JFNC1C6w5EnB6jRTsYDVXh5vm7lzlyer21WqBAUKCAawOKQQoVF/Mpu6f0/dmNQQUbwBk+FiUSFeTvTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vib4qMPA; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vib4qMPA"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6df83fd01cbso24898656d6.2;
        Mon, 17 Feb 2025 21:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857561; x=1740462361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d+SA0W0F3ElkDDFf84vDj9xLEft1xrgSsYntfglUP4A=;
        b=Vib4qMPAulC3mFqZNW1rGW0vI8GYa85IiPPIU9nmq8JVldo+/6EAxcv8OAXszoQacB
         Fe29M86poQIddu6/9+Av1+ctUyOcrmE7y1llt8QdOui0K6/P7r04YQT48IqgfnhIH3Kf
         7+nBPBG8vxah/2VyREgQqHMlAgGU9Fwx1U/4RqYOnWxlkPJACY3NFJkw3htXLEZr1edO
         cwEjfsgGQm8n6dpk4jNXvO2whio6aix72mLg+/4k5Ya0pNo8UtnkAdEiNFyCgoAjdGFx
         ZL1+kUcL1ajuKfbE4cYTtzVBFW2pb0XiKQiBtWvzTg9jVmlXzTkgh9WZul6rA9OUK4M5
         d/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857561; x=1740462361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+SA0W0F3ElkDDFf84vDj9xLEft1xrgSsYntfglUP4A=;
        b=tWNyUQAqPy0dOG5u6WszfreyotMdN7VhRaBTuEm0EIWNuTxX6k3Mw5qwEFtYxs7lh2
         kH0grrECy7yG2bwU9CCZpowN2wkRaxZbVSXIlx0h7bu3h7w2/DfAU7VreFqrY3LaVsTP
         XQEZsRGlebOsf01H7KSJYPoAmjkjkb/+arJe6MrbYk5ZoQnYCm78mPXMv7sEzPS6O+EP
         HcTPDYhlw92xlSUSGqKdkW6sG9BiumQwZctrEG4lVgUGAAOzv8Ubc9e0KfC18/zz58H8
         bWQXx6zv02dG57vHWEPh1ok8zetpjlxHQz+lY1viPubLTPRi41U8FOo2fnuQLpa9RSpz
         lwZw==
X-Forwarded-Encrypted: i=1; AJvYcCWP9sN7klLWey1MwdG06AcxtnqkAnmplaam34G46hwOV6049M1T6I9QFpo7enrJt0zEkYfmbpfjny6nqUUQ@vger.kernel.org, AJvYcCXM0xJ9cW+GsAlsHtwiMmF3YbjU0TZ5s6wrra3W6xYgqe7wuOd/oFskzIiYRnKTzbSgBvkFYtiN5js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+RwKrkzjJtZm9yIk7V61jQfr1VsxIZoNFYMFn6y4ireamY8mm
	dSbvLZ3Xi2NKHUVsZuDLwk2ORWPVmy6UM7T5bODHFX7N3dVE+C7LWWKuHQ==
X-Gm-Gg: ASbGncugPHqXNHZsswJBc+VWtckFhgpSFejkeHcDnRBQZPL/lnQjd6qGY+ATIF1qBEo
	1//lRrFqdGVTUyzxUgUVVoFySAwSnf+5fVCxsXQUS7Y/+iQtJQT1WQpYR5Fg7x0cIFuIMrHK3SG
	er1nhKExnn4TRP1j2RSoxtilIEQokAIIqN6LEMj4m7gXslHR0FhCbZcsmQ8wLAd7Fo2yHmz3qIw
	netjDXqFkYt0m42cs2HZZuq4q6ZExK6N5YS1T6jdd8D+kZC1bTV4xz+WyQDzVc9fmnXXGmjnIB0
	uaUit3n9K9YZq5hJZg+mROTRxJ2S6HqCbrMYfkwkY0zOCpvU5lugI76u3icW1ksh9XxMR1UBLCp
	CTOvV1Q==
X-Google-Smtp-Source: AGHT+IH1Npth3Qcqe1DSEFjRrh0txsuwa7zTkMhckGnpeSZQim+JRJAhujp5DQfMimEWJfyHjuE2UQ==
X-Received: by 2002:a05:6214:300e:b0:6e4:2d22:a566 with SMTP id 6a1803df08f44-6e66cccf032mr159363476d6.12.1739857560678;
        Mon, 17 Feb 2025 21:46:00 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fcbef8d6sm8480841cf.56.2025.02.17.21.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:46:00 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id A79541200043;
	Tue, 18 Feb 2025 00:45:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 18 Feb 2025 00:45:59 -0500
X-ME-Sender: <xms:lx60ZxrCTpa1ePl1Q1hKsWr9sxh4SeN3XtBdkJ_Xh94v28HO8Wh6qQ>
    <xme:lx60Zzod2oUUCgM-02eWsrQbYSmyRWp4TK3rp1XaUl94029HkvSwFbe-RuwAPh3c3
    WPrL0a7h6tc_k6sAA>
X-ME-Received: <xmr:lx60Z-Pl-CgApRlGdPxZy3uC_ueFRgcvP3qm8NWZM-CsbyMlEJKjr5OCEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrd
    huphgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjohgv
    lhhfvghrnhgrnhguvghsrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshhhtrhhiph
    hlvghtthdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprhgtphhtthhopehroh
    hsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:lx60Z84_qxxGn5vipQ6Eym1TBqcA9i5ZqyueMsJpvTPoaBeVPWF4Og>
    <xmx:lx60Zw4DacLRwRoDHTukbEfs2B0Axx62t9KEAuUwTjlC_Momv7dWvw>
    <xmx:lx60Z0h9Q5Wnv-90M8y4dXJVxrKFWJYEB5UBFFGZpeT-A-i0DHk94g>
    <xmx:lx60Zy6ZSJH1dxFrj0PAVxdNfprh1VICjlQlC2LpYfMFz5YwOvLrRw>
    <xmx:lx60Z3JZoTiW4hcDKSbVKXr_mRKsij7gFwwsjzhUzF9AlI0iqnjPn04D>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 00:45:59 -0500 (EST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH rcu 4/7] srcu: Point call_srcu() to call_rcu() for detailed memory ordering
Date: Mon, 17 Feb 2025 21:45:44 -0800
Message-Id: <20250218054547.7364-5-boqun.feng@gmail.com>
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

This commit causes the call_srcu() kernel-doc header to reference that
of call_rcu() for detailed memory-ordering guarantees.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/srcutree.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b83c74c4dcc0..f87a9fb6d6bb 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1398,8 +1398,12 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
  * read-side critical sections are delimited by srcu_read_lock() and
  * srcu_read_unlock(), and may be nested.
  *
- * The callback will be invoked from process context, but must nevertheless
- * be fast and must not block.
+ * The callback will be invoked from process context, but with bh
+ * disabled.  The callback function must therefore be fast and must
+ * not block.
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
  */
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 	       rcu_callback_t func)
-- 
2.39.5 (Apple Git-154)

